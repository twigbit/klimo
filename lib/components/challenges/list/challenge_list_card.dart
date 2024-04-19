import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:klimo/common/layout/challenge_card_body.dart';
import 'package:klimo/common/layout/challenge_card_header.dart';
import 'package:klimo/common/layout/klimo_card.dart';
import 'package:klimo/config/constants.dart';
import 'package:klimo/utils/localisation.dart';
import 'package:klimo_datamodels/challenges.dart';

import '../common/category_icon.dart';
import '../common/challenge_coins_row.dart';
import '../common/challenge_emissions_row.dart';
import 'start_challenge_button.dart';

class ChallengeListCard extends StatelessWidget {
  final DocumentSnapshot<Challenge> challengeSnap;
  final Function()? onTap;

  const ChallengeListCard({
    Key? key,
    required this.challengeSnap,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ChallengeBase challenge = challengeSnap.data() as ChallengeBase;
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: KlimoCard(
            onTap: onTap,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: ChallengeCardHeader(
                            challengeCategory:
                                challenge.category?.tr(context) ??
                                    "general".tr(context),
                            icon: CategoryIcon(
                              category: challenge.category,
                              isRecurring: challenge.type == recurring,
                            ),
                            trailing: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                if (challenge.emissionSavings != null)
                                  ChallengeEmissionsRow(
                                    value: challenge.emissionSavings,
                                    isOnCard: true,
                                  ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: ChallengeCoinsRow(
                                    value: challenge.coins,
                                    isOnCard: true,
                                  ),
                                ),
                              ],
                            )),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 8.0,
                          horizontal: 16.0,
                        ),
                        child: ChallengeCardBody(
                          challengeTitle: challenge.title.tr(context),
                          challengeContent: challenge.content.tr(context),
                          titleMaxLines: 2,
                          contentMaxLines: 3,
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: StartChallengeButton(
                          challenge: challengeSnap,
                          brightness: Brightness.light,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
