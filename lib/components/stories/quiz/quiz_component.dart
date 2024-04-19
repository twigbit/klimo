import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:klimo/common/layout/klimo_card.dart';
import 'package:klimo/common/models/atoms.dart';
import 'package:klimo/components/stories/quiz/models/quiz.dart';
import 'package:klimo/config/firebase.dart';
import 'package:klimo/utils/theme.dart';

import 'widgets/quiz_answer_card.dart';
import 'widgets/quiz_result_view.dart';

class QuizComponent extends StatefulWidget {
  const QuizComponent({
    super.key,
    required this.quiz,
    required this.storyId,
    this.currentQuizIndex,
    required this.indexLookup,
    required this.setCurrentQuizIndex,
  });

  final QuizModel quiz;
  final String storyId;
  final int? currentQuizIndex;
  final List<int> indexLookup;
  final void Function(int) setCurrentQuizIndex;

  @override
  State<QuizComponent> createState() => _QuizComponentState();
}

class _QuizComponentState extends State<QuizComponent> {
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
          return QuizResultView(
            quiz: widget.quiz,
            selectedAnswer: (snapshot.data?.data() as Map)["answer"] ?? 0,
            storyId: widget.storyId,
          );
        } else {
          return Align(
            alignment: Alignment.bottomCenter,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  KlimoCard(
                    padding: const EdgeInsets.all(12.0),
                    child: Text(
                      widget.quiz.question.tr(context),
                      style: context.textTheme().headlineMedium,
                    ),
                  ),
                  const SizedBox(height: 32.0),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: widget.quiz.answers.length,
                    itemBuilder: (context, index) {
                      final shuffledIndex = widget.indexLookup[index];
                      final answer = widget.quiz.answers[shuffledIndex];
                      final isSelected =
                          widget.currentQuizIndex == shuffledIndex;
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 6.0),
                        child: TapRegion(
                          child: QuizAnswerCard(
                            position: '${index + 1}. ',
                            isSelected: isSelected,
                            answerText: answer.tr(context),
                            onSelect: () => setState(
                              () {
                                if (isSelected) {
                                  widget.setCurrentQuizIndex(-1);
                                } else {
                                  widget.setCurrentQuizIndex(shuffledIndex);
                                }
                              },
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          );
        }
      },
    );
  }
}
