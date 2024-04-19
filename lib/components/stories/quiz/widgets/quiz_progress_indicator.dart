import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import '../../../../config/firebase.dart';
import '../../../../utils/theme.dart';

class QuizProgressIndicator extends StatelessWidget {
  const QuizProgressIndicator({
    super.key,
    required this.storyId,
    required this.totalNumberofQuestions,
  });

  final String storyId;
  final num totalNumberofQuestions;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
      stream: firestore.userCollection
          .userDoc()!
          .collection('stories')
          .doc(storyId)
          .snapshots(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.data!.exists) {
          final value = ((snapshot.data!.data() as Map)['answers'] /
              totalNumberofQuestions);
          return _buildIndicator(context, value);
        } else {
          return _buildIndicator(context, 0.0);
        }
      },
    );
  }

  Widget _buildIndicator(BuildContext context, double value) =>
      CircularPercentIndicator(
        radius: 26.0,
        percent: value,
        center: Text(
          "${(value * 100).toStringAsFixed(0)}%",
          style: context.textTheme().bodySmall?.copyWith(color: Colors.white),
        ),
        progressColor: Palette.secondary,
        backgroundColor: Palette.greySecondary,
      );
}
