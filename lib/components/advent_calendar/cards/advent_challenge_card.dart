import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:klimo/common/cubit/document_fetcher_cubit.dart';
import 'package:klimo/common/cubit/document_query_cubit.dart';
import 'package:klimo/common/layout/challenge_card_body.dart';
import 'package:klimo/common/layout/challenge_card_header.dart';
import 'package:klimo/common/layout/klimo_bottom_sheet.dart';
import 'package:klimo/common/layout/klimo_card.dart';
import 'package:klimo/components/challenges/common/single_challenge_view.dart';
import 'package:klimo/components/challenges/list/start_challenge_button.dart';
import 'package:klimo/components/community/cubit/user_community_cubit.dart';
import 'package:klimo/config/analytics.dart';
import 'package:klimo/config/constants.dart';
import 'package:klimo/config/firebase.dart';
import 'package:klimo/config/labels.dart';
import 'package:klimo/utils/localisation.dart';
import 'package:klimo_datamodels/challenges.dart';
import 'package:klimo_datamodels/community.dart';

import '../../../utils/theme.dart';

class AdventChallengeCard extends StatelessWidget {
  final String challengeRootId;

  const AdventChallengeCard({super.key, required this.challengeRootId});

  @override
  Widget build(BuildContext context) {
    UserCommuntityReference? community =
        context.read<UserCommunityCubit>().state?.value?.data()!;
    if (community == null) {
      return const Text('No Community');
    } else {
      return BlocProvider(
        create: (context) => DocumentQueryCubit<Challenge>(
          fb
              .communityCollection()
              .doc(community.community.ref.id)
              .challengeCollection<Challenge>(),
        )..load(
            queryBuilder: (b) =>
                b.limit(1).where('rootId', isEqualTo: challengeRootId)),
        child: BlocBuilder<DocumentQueryCubit<Challenge>,
            DocumentQueryState<Challenge>>(
          builder: (context, state) {
            if (state != null &&
                state.isLoaded &&
                state.value!.docs.isNotEmpty) {
              return AdventChallengeCardLayout(
                challengeSnap: state.value!.docs.first,
                onTap: (() => _openChallengeSingleView(
                      context,
                      state.value!.docs.first.reference,
                    )).logInteraction(
                  params: {
                    AnalyticsParameters.action:
                        AnalyticsValues.openAdventCalendarChallenge,
                    AnalyticsParameters.category:
                        (state.value!.docs.first.data()).category,
                    AnalyticsParameters.scope:
                        AnalyticsValues.adventsCalendarScope,
                  },
                ),
              );
            }
            return const SizedBox(width: 280);
          },
        ),
      );
    }
  }

  void _openChallengeSingleView(
    BuildContext context,
    DocumentReference<Challenge> challenge,
  ) async {
    await showKlimoModalBottomSheet(
      context: context,
      builder: (ctx) => BlocProvider(
        create: (context) =>
            DocumentFetcherCubit<Challenge>(challenge, listen: true)..load(),
        child: BlocBuilder<DocumentFetcherCubit<Challenge>,
            DocumentFetcherState<Challenge>>(
          builder: (context, state) {
            if (state.isLoaded) {
              final Challenge challenge = state.value!.data()!;
              return KlimoBottomSheet(
                  backGroundColor: Palette.adventCalendarBeige,
                  header: const KlimoBottomSheetHeader(),
                  body: SingleChallengeView(
                    category: challenge.category,
                    title: challenge.title.tr(context),
                    content: challenge.content.tr(context),
                    information: challenge.informations?.tr(context),
                    isRecurring: challenge.type == recurring,
                    coins: challenge.coins,
                    emissionSavings: challenge.emissionSavings,
                  ));
            } else {
              return const SizedBox();
            }
          },
        ),
      ),
    );
  }
}

class AdventChallengeCardLayout extends StatelessWidget {
  final DocumentSnapshot<Challenge> challengeSnap;
  final Function()? onTap;

  const AdventChallengeCardLayout({
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
            color: Palette.adventCalendarBeige,
            onTap: onTap,
            child: Padding(
              padding: const EdgeInsets.only(top: 12.0),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: ChallengeCardHeader(
                      challengeCategory: challenge.category?.tr(context) ??
                          context.localisation().general,
                      icon: Icon(
                        getSectionIcon(challenge.category),
                        size: 14,
                        color: Palette.adventCalendarRed,
                      ),
                      textColor: Palette.adventCalendarRed,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 8.0,
                      horizontal: 16.0,
                    ),
                    child: ChallengeCardBody(
                      challengeTitle: challenge.title.tr(context),
                      challengeContent: challenge.content.tr(context),
                      titleMaxLines: 1,
                      contentMaxLines: 2,
                      titleStyle: context
                          .textTheme()
                          .headlineSmall
                          ?.copyWith(color: Palette.darkGreen),
                      contentStyle: context
                          .textTheme()
                          .bodySmall
                          ?.copyWith(color: Palette.darkGreen),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: StartChallengeButton(
                      challenge: challengeSnap,
                      brightness: Brightness.light,
                      buttonBackgroundColor: Palette.adventCalendarRed,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
