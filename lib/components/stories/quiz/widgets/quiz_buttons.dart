import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:klimo/common/models/atoms.dart';
import 'package:klimo/config/analytics.dart';
import 'package:klimo/utils/localisation.dart';

import '../../../../common/dialogs/confirmation_dialog.dart';
import '../../../../config/firebase.dart';
import '../../../../utils/theme.dart';
import '../models/quiz.dart';

class QuizButtons extends StatefulWidget {
  const QuizButtons({
    super.key,
    required this.quiz,
    required this.storyId,
    required this.onNext,
    this.onNextButtonText,
    this.currentQuizIndex,
    required this.setCurrentQuizIndex,
    required this.controlTimeAnimation,
  });

  final QuizModel quiz;
  final String storyId;
  final VoidCallback onNext;
  final String? onNextButtonText;
  final int? currentQuizIndex;
  final void Function(int) setCurrentQuizIndex;
  final VoidCallback controlTimeAnimation;

  @override
  State<QuizButtons> createState() => _QuizButtonsState();
}

class _QuizButtonsState extends State<QuizButtons> {
  void submitAnswer(int answer) async {
    final coins = answer == 0 ? 1 : 0;
    await firestore.runTransaction(
      (t) async {
        final userDoc = firestore.userCollection.userDoc();
        if (userDoc != null) {
          t.update(
            userDoc,
            {
              // increase coins to get rewards
              'stats.coins': FieldValue.increment(coins),
              // store quiz points indepedently from coins that are also collected by challenges
              'stats.quizPoints': FieldValue.increment(coins),
            },
          );
          final storyRef = userDoc.collection('stories').doc(widget.storyId);
          t.set(
            storyRef,
            {
              'read': true,
              'points': FieldValue.increment(coins),
              'answers': FieldValue.increment(1)
            },
            SetOptions(merge: true),
          );
          t.set(
            storyRef.collection('quiz').doc(widget.quiz.id),
            {
              'answer': answer,
              'points': FieldValue.increment(coins),
            },
            SetOptions(merge: true),
          );
        }
      },
    );

    // analytics
    if (!context.mounted) return;
    analytics.logAnalyticsEvent(
      eventName: AnalyticsEvents.answerQuizQuestion,
      params: {
        AnalyticsParameters.quizQuestion: widget.quiz.question.tr(context),
        AnalyticsParameters.givenQuizAnswer:
            widget.quiz.answers[answer].tr(context),
        AnalyticsParameters.isCorrectAnswer: answer == 0 ? 1 : 0,
      },
    );
  }

  void resetAnswer() async {
    // unselect answer
    widget.setCurrentQuizIndex(-1);
    await firestore.runTransaction(
      (t) async {
        final userDoc = firestore.userCollection.userDoc();
        if (userDoc != null) {
          final storyRef = userDoc.collection('stories').doc(widget.storyId);
          // delete quiz document in stories' quiz subcollection
          t.delete(
            storyRef.collection('quiz').doc(widget.quiz.id),
          );
          t.set(
            storyRef,
            // decrease number of given answers
            {'answers': FieldValue.increment(-1)},
            SetOptions(merge: true),
          );
        }
      },
    );

    // analytics
    if (!context.mounted) return;
    analytics.logAnalyticsEvent(
      eventName: AnalyticsEvents.repeatQuizQuestion,
      params: {
        AnalyticsParameters.quizQuestion: widget.quiz.question.tr(context),
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
      stream: firestore.userCollection
          .userDoc()!
          .collection('stories')
          .doc(widget.storyId)
          .collection('quiz')
          .doc(widget.quiz.id)
          .snapshots(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }

        if ((snapshot.data!.exists)) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ElevatedButton(
                onPressed: () {
                  widget.onNext();
                  // unselect answer
                  widget.setCurrentQuizIndex(-1);
                  // forward timer animation
                  widget.controlTimeAnimation();
                },
                child: Text(widget.onNextButtonText ??
                    context.localisation().action_next),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: TextButton.icon(
                  icon: const Icon(Icons.sync),
                  label: Text(context.localisation().action_repeat),
                  onPressed: () {
                    // do not stop timer animation when answer is reset immediately after it was submitted since onSubmit handeled that already
                    if (widget.currentQuizIndex == null) {
                      widget.controlTimeAnimation();
                    }
                    showDialog(
                      context: context,
                      builder: (innerContext) => ConfirmationDialog(
                        title: context.localisation().quiz_repeat_title,
                        content: context.localisation().quiz_repeat_message,
                        onConfirm: () {
                          resetAnswer();
                          Navigator.pop(context);
                          // forward timer animation
                          widget.controlTimeAnimation();
                        },
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        } else {
          return Padding(
            padding: const EdgeInsets.only(bottom: 56.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  disabledBackgroundColor: Palette.greyPrimary),

              // activate button only with selected answer
              onPressed: widget.currentQuizIndex == null ||
                      widget.currentQuizIndex == -1
                  ? null
                  : () {
                      // stop timer animation
                      widget.controlTimeAnimation();
                      submitAnswer(widget.currentQuizIndex!);
                    },

              child: Text(context.localisation().action_confirm),
            ),
          );
        }
      },
    );
  }
}
