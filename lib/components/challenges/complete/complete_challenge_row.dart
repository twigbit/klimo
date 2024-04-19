import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:klimo/components/challenges/complete/cubit/complete_challenge_cubit.dart';
import 'package:klimo/components/challenges/dashboard/timeframe/cubit/timeframe_cubit.dart';
import 'package:klimo/utils/localisation.dart';
import 'package:klimo/utils/theme.dart';
import 'package:klimo_datamodels/challenges.dart';
import '../../community/cubit/user_community_cubit.dart';

class CompleteChallengeRow extends StatelessWidget {
  final bool showFallback;
  final DocumentSnapshot<UserChallenge> challengeSnap;
  const CompleteChallengeRow(
      {Key? key, required this.challengeSnap, this.showFallback = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    UserChallenge challenge = challengeSnap.data()!;
    return BlocProvider(
      create: (context) => CompleteChallengeCubit(
          challengeSnap, context.read<UserCommunityCubit>()),
      child: BlocBuilder<CompleteChallengeCubit, CompleteChallengeState>(
        builder: (context, state) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (challenge.state?.completedAt != null && showFallback)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    if (challenge.state!.success!)
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Chip(
                          backgroundColor: Palette.greenBackground,
                          label: Text(context.localisation().challenges_done),
                          labelStyle:
                              context.textTheme().headlineSmall?.copyWith(
                                    color: Palette.primary,
                                  ),
                          avatar: const Icon(
                            Icons.check,
                            color: Palette.primary,
                          ),
                        ),
                      )
                    else
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Chip(
                          backgroundColor: Palette.greyLight,
                          label: Text(context.localisation().challenges_undone),
                          labelStyle:
                              context.textTheme().headlineSmall?.copyWith(
                                    color: Palette.grey,
                                  ),
                          avatar: const Icon(
                            Icons.close,
                            color: Palette.grey,
                          ),
                        ),
                      ),
                    // TextButton(
                    //     onPressed: () {
                    //       context.read<CompleteChallengeCubit>().reset();
                    //     },
                    //     child: const Text('Zurücksetzten')),
                  ],
                ),
              if (challenge.state?.success == null &&
                  !context.watch<TimeframeCubit>().state.isFuture)
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Expanded(
                        child: Text(
                            context.localisation().challenge_complete_question),
                      ),
                      Row(
                        children: [
                          if (state != null && state.isLoading)
                            const CircularProgressIndicator()
                          else
                            Row(
                              children: [
                                TextButton(
                                  onPressed: () {
                                    context
                                        .read<CompleteChallengeCubit>()
                                        .complete(false);
                                  },
                                  child: Text(
                                    context
                                        .localisation()
                                        .challenge_complete_no,
                                  ),
                                ),
                                ElevatedButton.icon(
                                  onPressed: () {
                                    context
                                        .read<CompleteChallengeCubit>()
                                        .complete(true);
                                  },
                                  icon: const Icon(Icons.check),
                                  style: ElevatedButton.styleFrom(
                                      padding: const EdgeInsets.all(8),
                                      minimumSize: const Size(0, 0)),
                                  label: Text(
                                    context
                                        .localisation()
                                        .challenge_complete_yes,
                                  ),
                                ),
                              ],
                            ),
                        ],
                      ),
                    ],
                  ),
                )
            ],
          );
        },
      ),
    );
  }
}
