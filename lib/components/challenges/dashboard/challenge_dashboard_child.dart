import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:klimo/common/layout/klimo_bottom_sheet.dart';
import 'package:klimo/components/challenges/complete/complete_challenge_row.dart';
import 'package:klimo/components/challenges/dashboard/timeframe/cubit/timeframe_cubit.dart';
import 'package:klimo/components/challenges/common/single_challenge_view.dart';
import 'package:klimo/config/constants.dart';
import 'package:klimo/utils/localisation.dart';
import 'package:klimo/utils/theme.dart';
import 'package:klimo_datamodels/challenges.dart';

import '../../../common/cubit/document_fetcher_cubit.dart';
import 'challenge_dashboard_card.dart';

class ChallengeDashboardChild extends StatelessWidget {
  final List<DocumentSnapshot<UserChallenge>> challenges;

  const ChallengeDashboardChild({Key? key, required this.challenges})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        challenges.isEmpty
            ? Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 8.0,
                ),
                child: EmptyChallenge(
                    context.localisation().challenges_view_empty_week),
              )
            : ListView.builder(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12.0,
                  vertical: 8.0,
                ),
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: challenges.length,
                itemBuilder: (BuildContext innerContext, int index) {
                  return ChallengeDashboardCard(
                    challengeSnap: challenges[index],
                    onTap: () => _openChallengeSingleView(
                      context,
                      index,
                    ),
                  );
                }),
      ],
    );
  }

  // @Emil this now seems to work as expected in initial state but it's still not fixed for the state when challenge was completed
  // in that case it again somehow seems not to calculate size of the body of the bottom sheet properly or in time and takes the maximum size of 0.9..
  // after closing it once and open again, the size is given as expected

  void _openChallengeSingleView(
    BuildContext context,
    int index,
  ) async {
    await showKlimoModalBottomSheet(
      context: context,
      builder: (ctx) => MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => DocumentFetcherCubit<UserChallenge>(
                challenges[index].reference,
                listen: true)
              ..load(),
          ),
          BlocProvider.value(
            value: context.read<TimeframeCubit>(),
          ),
        ],
        child: BlocBuilder<DocumentFetcherCubit<UserChallenge>,
            DocumentFetcherState<UserChallenge>>(
          builder: (context, state) {
            if (state.isLoaded) {
              final ChallengeRef challenge = state.value!.data()!.challenge;
              return KlimoBottomSheet(
                header: const KlimoBottomSheetHeader(),
                body: SingleChallengeView(
                  category: challenge.category,
                  title: challenge.title.tr(context),
                  content: challenge.content.tr(context),
                  information: challenge.informations?.tr(context),
                  isRecurring: challenge.type == recurring,
                  coins: challenge.coins,
                  emissionSavings: challenge.emissionSavings,
                  checkInComponent: CheckInComponent(
                    challengeSnap: state.value!,
                    showFallback: true,
                  ),
                ),
              );
            } else {
              return const SizedBox();
            }
          },
        ),
      ),
    );
  }
}

class CheckInComponent extends StatelessWidget {
  final bool showFallback;
  final DocumentSnapshot<UserChallenge> challengeSnap;
  const CheckInComponent({
    Key? key,
    required this.challengeSnap,
    this.showFallback = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var timeframeState = context.read<TimeframeCubit>().state;
    if (!timeframeState.isFuture) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 16.0, bottom: 4),
            child: Text(
              "Check In",
              style: context.textTheme().displayMedium,
            ),
          ),
          CompleteChallengeRow(
            challengeSnap: challengeSnap,
            showFallback: true,
          )
        ],
      );
    } else {
      return const SizedBox();
    }
  }
}

class EmptyChallenge extends StatelessWidget {
  final String text;

  const EmptyChallenge(this.text, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DottedBorder(
      color: Palette.primary,
      borderType: BorderType.RRect,
      strokeWidth: 2,
      radius: const Radius.circular(8),
      dashPattern: const [8, 4],
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                text,
                textAlign: TextAlign.center,
                style: context
                    .textTheme()
                    .headlineMedium
                    ?.copyWith(color: Palette.primary),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
