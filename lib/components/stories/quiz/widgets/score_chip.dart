import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../config/firebase.dart';
import '../../../../utils/theme.dart';

class ScoreChip extends StatelessWidget {
  const ScoreChip({
    super.key,
    required this.storyId,
    required this.quizId,
  });

  final String storyId;
  final String quizId;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
        stream: firestore.userCollection
            .userDoc()!
            .collection('stories')
            .doc(storyId)
            .collection('quiz')
            .doc(quizId)
            .snapshots(),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Container();
          }
          if (!snapshot.data!.exists) {
            return Container();
          }
          final isSuccess = (snapshot.data!.data() as Map)['points'] == 1;
          return Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 4.0,
                  horizontal: 12.0,
                ),
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(8),
                    ),
                    color: isSuccess ? Palette.primary : Palette.error),
                child: Row(
                  children: [
                    SizedBox(
                      height: 18,
                      child: SvgPicture.asset(
                        'assets/icons/coins.svg',
                        color: Colors.white,
                      ),
                    ),
                    StreamBuilder<DocumentSnapshot>(
                        stream: firestore.userCollection
                            .userDoc()!
                            .collection('stories')
                            .doc(storyId)
                            .snapshots(),
                        builder: (BuildContext context,
                            AsyncSnapshot<DocumentSnapshot> snapshot) {
                          if (!snapshot.hasData) {
                            return Container();
                          }
                          final points = ((snapshot.data?.data() ??
                              {'points': 0}) as Map)["points"];
                          final answers = ((snapshot.data?.data() ??
                              {'answers': 0}) as Map)["answers"];
                          0;
                          return Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Text(
                              "$points / $answers",
                              style: context
                                  .textTheme()
                                  .headlineMedium
                                  ?.copyWith(color: Colors.white),
                            ),
                          );
                        }),
                  ],
                ),
              ),
            ],
          );
        });
  }
}
