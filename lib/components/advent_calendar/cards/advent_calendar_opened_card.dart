import 'package:flutter/material.dart';
import 'package:klimo/components/advent_calendar/cards/advent_fact_card.dart';
import 'package:klimo/components/advent_calendar/cards/advent_reward_card.dart';
import 'package:klimo/components/advent_calendar/common/opened_card_layout.dart';
import 'package:klimo/components/content/news_card.dart';
import 'package:klimo/utils/localisation.dart';

import 'package:klimo_datamodels/advent_calendar.dart';

import '../../../config/analytics.dart';
import '../../../utils/theme.dart';
import 'advent_challenge_card.dart';

class AdventCalendarOpenedCard extends StatelessWidget {
  final AdventCalendarModel contentItem;
  final String? batchNumber;
  const AdventCalendarOpenedCard({
    Key? key,
    required this.contentItem,
    this.batchNumber,
  }) : super(key: key);

// TODO: check if this can be implemented in a better way
  Widget getCardContent(BuildContext context) {
    if (contentItem.challengeRootId != null) {
      return AdventChallengeCard(challengeRootId: contentItem.challengeRootId!);
    } else if (contentItem.article != null) {
      return NewsCard(
        article: contentItem.article!,
        actionScope: AnalyticsValues.adventsCalendarScope,
        isAdventsNews: true,
      );
    } else if (contentItem.reward != null) {
      // TODO: create Card for reward
      return AdventRewardCard(reward: contentItem.reward!);
    } else if (contentItem.fact != null) {
      final String title =
          contentItem.title != null ? contentItem.title!.tr(context) : "";
      return AdventFactCard(title: title, fact: contentItem.fact!);
    } else {
      // TODO: create default UI / content
      return Card(
        color: Palette.adventCalendarBeige,
        child: Center(
          child: Text(
            "🎄 Frohe Weihnachten 🎄",
            style: context
                .textTheme()
                .bodyMedium
                ?.copyWith(color: Palette.darkGreen),
            textAlign: TextAlign.center,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return OpenedCardLayout(
      content: getCardContent(context),
      batchNumber: batchNumber,
    );
  }
}
