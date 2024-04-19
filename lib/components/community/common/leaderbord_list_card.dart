import 'package:flutter/material.dart';
import 'package:klimo/common/layout/klimo_card.dart';
import 'package:klimo/components/community/common/leaderboard_statistics_row.dart';
import 'package:klimo/utils/theme.dart';

class LeaderBoardListCard extends StatelessWidget {
  final String? groupName;
  final String? groupInfo;
  final num? groupChallengeCounts;
  final num? groupChallengeCoins;
  final num? groupEmissionsSavings;
  final Function()? onTap;
  final Color? borderColor;

  const LeaderBoardListCard({
    Key? key,
    this.groupName,
    this.groupInfo,
    this.groupChallengeCounts,
    this.groupChallengeCoins,
    this.groupEmissionsSavings,
    this.onTap,
    this.borderColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: KlimoCard(
        onTap: onTap,
        borderColor: borderColor,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 12.0,
            horizontal: 8.0,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (groupName != null)
                    Expanded(
                      flex: 5,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Text(
                          groupName!,
                          style: context.textTheme().headlineMedium,
                        ),
                      ),
                    ),
                  if (groupChallengeCounts != null ||
                      groupChallengeCoins != null ||
                      groupEmissionsSavings != null)
                    Expanded(
                      flex: 6,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 4.0),
                        child: LeaderbordStasticsRow(
                          countValue: groupChallengeCounts,
                          coinsValue: groupChallengeCoins,
                          emissionsValue: groupEmissionsSavings,
                        ),
                      ),
                    ),
                ],
              ),
              if (groupInfo != null && groupInfo!.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(
                    groupInfo!,
                    style: context
                        .textTheme()
                        .bodyMedium
                        ?.copyWith(color: Palette.greySecondary),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
