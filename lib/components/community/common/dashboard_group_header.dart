import 'package:flutter/material.dart';
import 'package:klimo/components/challenges/common/challenge_count_row.dart';
import 'package:klimo/components/challenges/common/challenge_coins_row.dart';
import 'package:klimo/components/challenges/common/challenge_emissions_row.dart';
import 'package:klimo/utils/theme.dart';

class DashboardGroupHeader extends StatelessWidget {
  final String title;
  final String? groupName;
  final String? groupInfo;
  final num? groupChallengeCounts;
  final num? groupChallengeCoins;
  final num? groupEmissionSavings;

  const DashboardGroupHeader({
    Key? key,
    required this.title,
    this.groupName,
    this.groupInfo,
    this.groupChallengeCounts,
    this.groupChallengeCoins,
    this.groupEmissionSavings,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: context
                  .textTheme()
                  .headlineMedium!
                  .copyWith(color: Palette.greySecondary),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
        if (groupName != null)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Text(
              groupName!,
              style: context.textTheme().displayLarge,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        Row(
          children: [
            if (groupEmissionSavings != null)
              ChallengeEmissionsRow(value: groupEmissionSavings),
            if (groupChallengeCoins != null)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: ChallengeCoinsRow(value: groupChallengeCoins),
              ),
            if (groupChallengeCounts != null)
              ChallengeCountRow(value: groupChallengeCounts),
          ],
        ),
        if (groupInfo != null && groupInfo!.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(
              top: 16.0,
              left: 4.0,
            ),
            child: Text(
              groupInfo!,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
      ],
    );
  }
}
