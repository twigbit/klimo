import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:klimo/common/cubit/document_query_cubit.dart';
import 'package:klimo/components/advent_calendar/cubit/advent_reward_cubit.dart';
import 'package:klimo/navigation/bottom_navigation/cubit/bottom_navigation_cubit.dart';
import 'package:klimo/utils/localisation.dart';
import 'package:klimo_datamodels/advent_calendar.dart';
import 'package:klimo_datamodels/rewards.dart';

import '../../../utils/theme.dart';

class AdventRewardCard extends StatelessWidget {
  final CalendarRewardModel reward;
  const AdventRewardCard({super.key, required this.reward});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AdventRewardCubit(
          context.read<DocumentQueryCubit<UserRewardModel>>(), reward.id),
      child: BlocBuilder<AdventRewardCubit, AdventRewardState>(
        builder: (context, adventsRewardState) {
          final bool isLoading =
              (adventsRewardState == null || adventsRewardState.isLoading);
          return InkWell(
            onTap: isLoading
                ? null
                : () {
                    adventsRewardState.value == true
                        ? context
                            .read<BottomNavigationCubit>()
                            .navigateToPage(4)
                        : context
                            .read<AdventRewardCubit>()
                            .redeemReward(reward.id);
                  },
            child: AdventRewardCardLayout(
              rewardAssetUrl: reward.assetUrl,
              rewardTitle: reward.title.tr(context),
              isRewardRedeemed: adventsRewardState?.value == true,
              isLoading: isLoading,
            ),
          );
        },
      ),
    );
  }
}

class AdventRewardCardLayout extends StatelessWidget {
  final String rewardAssetUrl;
  final String rewardTitle;
  final bool isRewardRedeemed;
  final bool isLoading;

  const AdventRewardCardLayout({
    super.key,
    required this.rewardAssetUrl,
    required this.rewardTitle,
    this.isRewardRedeemed = false,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Card(
          color: Palette.adventCalendarBeige,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CachedNetworkImage(
                  imageUrl: rewardAssetUrl,
                  placeholder: (context, url) =>
                      const Center(child: CircularProgressIndicator()),
                  height: 64,
                  fit: BoxFit.contain,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 12.0),
                    child: isLoading
                        ? Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: CircularProgressIndicator(),
                              ),
                              Text(
                                context
                                    .localisation()
                                    .reward_advent_calendar_card_loading,
                                textAlign: TextAlign.center,
                                style: context
                                    .textTheme()
                                    .labelMedium
                                    ?.copyWith(color: Palette.darkGreen),
                              ),
                            ],
                          )
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                isRewardRedeemed
                                    ? context
                                        .localisation()
                                        .reward_advent_calendar_card_title_redeemed
                                    : context
                                        .localisation()
                                        .reward_advent_calendar_card_title,
                                textAlign: TextAlign.center,
                                style: context
                                    .textTheme()
                                    .headlineMedium
                                    ?.copyWith(
                                        color: isRewardRedeemed
                                            ? Palette.grey
                                            : Palette.darkGreen),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Text(
                                  rewardTitle,
                                  style: context
                                      .textTheme()
                                      .bodySmall
                                      ?.copyWith(
                                          color: isRewardRedeemed
                                              ? Palette.grey
                                              : Palette.darkGreen),
                                ),
                              ),
                            ],
                          ),
                  ),
                ),
              ],
            ),
          ),
        ),
        if (!isLoading)
          Positioned(
            bottom: 12.0,
            right: 12.0,
            child: Text(
              isRewardRedeemed
                  ? context
                      .localisation()
                      .reward_advent_calendar_card_note_redeemed
                  : context.localisation().reward_advent_calendar_card_note,
              style: context
                  .textTheme()
                  .labelMedium
                  ?.copyWith(color: Palette.adventCalendarRed),
            ),
          ),
      ],
    );
  }
}
