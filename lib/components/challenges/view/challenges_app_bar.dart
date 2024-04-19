import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:klimo/components/challenges/dashboard/cubit/initiative_cubit.dart';
import 'package:klimo/components/challenges/dashboard/cubit/user_challenge_list_cubit.dart';
import 'package:klimo/components/challenges/view/update_week_view_button.dart';
import 'package:klimo/config/analytics.dart';
import 'package:klimo/config/constants.dart';
import 'package:klimo/utils/localisation.dart';
import 'package:klimo/utils/theme.dart';
import 'package:klimo_datamodels/challenges.dart';
import '../common/challenge_coins_row.dart';
import '../common/challenge_emissions_row.dart';
import '../dashboard/timeframe/cubit/timeframe_cubit.dart';

class ChallengesAppBarTitle extends StatelessWidget {
  const ChallengesAppBarTitle({Key? key}) : super(key: key);

  Color _getWeekColor(Timeframe timeframe) {
    if (timeframe.isCurrent) {
      return Palette.primary;
    } else if (timeframe.isFuture) {
      return Palette.greySecondary;
    }
    return Palette.black;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TimeframeCubit, Timeframe>(
      builder: (context, timeframe) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  "${context.localisation().challenges_view_week} ${timeframe.start.weekNumber}",
                  style: Theme.of(context)
                      .textTheme
                      .headlineMedium!
                      .copyWith(color: _getWeekColor(timeframe)),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        UpdateWeekViewButton(
                          icon: Icons.arrow_back_ios,
                          onPressed: (context.read<TimeframeCubit>().decrement)
                              .logInteraction(params: {
                            AnalyticsParameters.action:
                                AnalyticsValues.decreaseWeekView,
                            AnalyticsParameters.scope: challengesTab,
                          }),
                        ),
                        UpdateWeekViewButton(
                          icon: Icons.arrow_forward_ios,
                          onPressed: (context.read<TimeframeCubit>().increment)
                              .logInteraction(
                            params: {
                              AnalyticsParameters.action:
                                  AnalyticsValues.increaseWeekView,
                              AnalyticsParameters.scope: challengesTab,
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                TextButton(
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                    alignment: Alignment.centerRight,
                  ),
                  onPressed: context.read<TimeframeCubit>().today,
                  child: Text(context.localisation().challenges_view_today),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BlocBuilder<InitiativeCubit, InitiativeState>(
                      builder: (context, state) {
                        if (state != null &&
                            state.isLoaded &&
                            state.value != null) {
                          return Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Row(
                              children: [
                                if (state.value!.data()!.logoUrl != null)
                                  Image.network(state.value!.data()!.logoUrl!,
                                      height: 32),
                              ],
                            ),
                          );
                        }
                        return Container();
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(
                        '${DateFormat("dd.MM.yyyy").format(timeframe.start)} - ${DateFormat("dd.MM.yyyy").format(timeframe.end)}',
                        style: context
                            .textTheme()
                            .titleSmall
                            ?.copyWith(color: Palette.grey),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 4.0),
                  child: Row(
                    children: [
                      BlocBuilder<UserChallengeListCubit,
                          UserChallengeListState>(
                        builder: (context, state) {
                          if (state == null || state.isLoading) {
                            return Container();
                          }
                          return ChallengeEmissionsRow(
                              value: state.value!.docs
                                  .where((element) => element.data().isSuccess)
                                  .fold(
                                      0,
                                      (value, element) =>
                                          value! +
                                          (element
                                                  .data()
                                                  .challenge
                                                  .emissionSavings ??
                                              0)));
                        },
                      ),
                      BlocBuilder<UserChallengeListCubit,
                          UserChallengeListState>(
                        builder: (context, state) {
                          if (state == null || state.isLoading) {
                            return Container();
                          }
                          return Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: ChallengeCoinsRow(
                                value: state.value!.docs
                                    .where(
                                        (element) => element.data().isSuccess)
                                    .fold(
                                        0,
                                        (value, element) =>
                                            value! +
                                            (element.data().challenge.coins))),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}

class ChallengeAppBarActions extends StatelessWidget {
  const ChallengeAppBarActions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 16.0,
        right: 16.0,
        bottom: 16.0,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            children: [
              BlocBuilder<UserChallengeListCubit, UserChallengeListState>(
                builder: (context, state) {
                  if (state == null || state.isLoading) return Container();
                  return ChallengeEmissionsRow(
                      value: state.value!.docs
                          .where((element) => element.data().isSuccess)
                          .fold(
                              0,
                              (value, element) =>
                                  value! +
                                  (element.data().challenge.emissionSavings ??
                                      0)));
                },
              ),
              BlocBuilder<UserChallengeListCubit, UserChallengeListState>(
                builder: (context, state) {
                  if (state == null || state.isLoading) return Container();
                  return Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: ChallengeCoinsRow(
                        value: state.value!.docs
                            .where((element) => element.data().isSuccess)
                            .fold(
                                0,
                                (value, element) =>
                                    value! + (element.data().challenge.coins))),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
