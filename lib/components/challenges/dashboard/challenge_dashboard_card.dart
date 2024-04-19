import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:klimo/common/layout/klimo_card.dart';
import 'package:klimo/components/challenges/complete/complete_challenge_row.dart';
import 'package:klimo/components/challenges/dashboard/timeframe/cubit/timeframe_cubit.dart';
import 'package:klimo/utils/localisation.dart';
import 'package:klimo/utils/theme.dart';
import 'package:klimo_datamodels/challenges.dart';

import '../../../config/constants.dart';
import '../common/category_icon.dart';
import '../common/challenge_coins_row.dart';
import '../common/challenge_emissions_row.dart';

class ChallengeDashboardCard extends StatelessWidget {
  final DocumentSnapshot<UserChallenge> challengeSnap;
  final UserChallenge challenge;
  final Function()? onTap;

  ChallengeDashboardCard({Key? key, required this.challengeSnap, this.onTap})
      : challenge = challengeSnap.data()!,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    UserChallenge challenge = challengeSnap.data()!;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: KlimoCard(
        // disable on card click when check in is open
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.only(
            right: 8.0,
            left: 8.0,
            top: 8.0,
            bottom: 8.0,
          ),
          child: Column(
            children: [
              _buildCardHeader(
                  context,
                  challenge.state?.completedAt == null ||
                      challenge.state!.success!),
              if (challenge.state?.completedAt != null &&
                  challenge.state!.success!)
                _completionRow(context)
              else if (context.read<TimeframeCubit>().state.isPast)
                CompleteChallengeRow(challengeSnap: challengeSnap)
              // ask for completion state UI
            ],
          ),
        ),
      ),
    );
  }

  Widget _completionRow(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Chip(
              backgroundColor: Palette.greenBackground,
              label: Text(context.localisation().challenge_done),
              labelStyle: context.textTheme().headlineSmall?.copyWith(
                    color: Palette.primary,
                  ),
              avatar: const Icon(
                Icons.check,
                color: Palette.primary,
              ),
            ),
          ),
          Row(
            children: [
              if (challenge.challenge.emissionSavings != null)
                ChallengeEmissionsRow(
                  value: challenge.challenge.emissionSavings,
                  isOnCard: true,
                ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: ChallengeCoinsRow(
                  value: challenge.challenge.coins,
                  isOnCard: true,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  _buildCardHeader(BuildContext context, bool isAvailable) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CategoryIcon(
          category: challenge.challenge.category,
          isRecurring: challenge.challenge.type == recurring,
          isAvailable: isAvailable,
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  challenge.challenge.title.tr(context),
                  style: context.textTheme().headlineMedium?.copyWith(
                      color: isAvailable ? Palette.black : Palette.greyPrimary),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.start,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
