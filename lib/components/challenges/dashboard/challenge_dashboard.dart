import 'package:cloud_firestore/cloud_firestore.dart';
import "package:collection/collection.dart";
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:klimo/components/challenges/dashboard/challenge_dashboard_child.dart';
import 'package:klimo/components/challenges/dashboard/cubit/initiative_cubit.dart';
import 'package:klimo/components/challenges/dashboard/timeframe/cubit/timeframe_cubit.dart';
import 'package:klimo/components/community/cubit/user_community_cubit.dart';
import 'package:klimo/utils/localisation.dart';
import 'package:klimo/utils/theme.dart';
import 'package:klimo_datamodels/challenges.dart';

import '../../../common/layout/dashboard_section.dart';
import '../../../navigation/routes.dart';
import '../view/challenges_app_bar.dart';
import 'cubit/user_challenge_list_cubit.dart';

class ChallengeDashboard extends StatefulWidget {
  const ChallengeDashboard({Key? key}) : super(key: key);

  @override
  State<ChallengeDashboard> createState() => _ChallengeDashboardState();
}

class _ChallengeDashboardState extends State<ChallengeDashboard> {
  final ScrollController _controller = ScrollController(keepScrollOffset: true);

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) => InitiativeCubit(context.read<TimeframeCubit>(),
                context.read<UserCommunityCubit>()))
      ],
      child: Column(
        children: [
          const Material(
            elevation: 1,
            color: Palette.white,
            child: SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
                child: Column(
                  children: [
                    ChallengesAppBarTitle(),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: BlocBuilder<UserChallengeListCubit, UserChallengeListState>(
              builder: (context, state) {
                if (state?.value != null) {
                  var grouped =
                      groupBy<QueryDocumentSnapshot<UserChallenge>, String?>(
                          state!.value!.docs,
                          (QueryDocumentSnapshot<UserChallenge> snap) => snap
                              .data()
                              .initiative
                              ?.timeframe
                              .title
                              ?.tr(context));

                  grouped[null] ??= [];
                  var entries = grouped.entries
                      .map((entry) => entry.key != null
                          // Initiative challenges are sorted by coins
                          // will become only relevant in case we integrate some initiative
                          ? MapEntry(
                              entry.key,
                              entry.value.sortedBy(
                                  (element) => element.data().challenge.coins))
                          // TODO discuss sorting of manually chosen challenges (for now it's according to coins as well)
                          : MapEntry(
                              entry.key,
                              entry.value.sortedBy(
                                  (element) => element.data().challenge.coins)))
                      .sorted((a, b) => b.key == null ? -1 : 1);
                  return SingleChildScrollView(
                    controller: _controller,
                    child: Column(
                        children: entries.map<Widget>((e) {
                      return DashboardSection(
                          title: (e.key ?? "Challenges").toString(),
                          trailing: e.key == null &&
                                  !context.watch<TimeframeCubit>().state.isPast
                              ? Padding(
                                  padding: const EdgeInsets.only(
                                    right: 4.0,
                                    bottom: 4.0,
                                  ),
                                  child: FloatingActionButton.small(
                                    heroTag: 'hero_add_challenge',
                                    backgroundColor: Palette.primary,
                                    onPressed: () {
                                      Router.of(context)
                                          .routerDelegate
                                          .setNewRoutePath(
                                            ChallengeListRoute(
                                              context.read<
                                                  UserChallengeListCubit>(),
                                              context.read<TimeframeCubit>(),
                                              context.read<InitiativeCubit>(),
                                            ),
                                          );
                                    },
                                    child: const Icon(
                                      Icons.add,
                                      color: Palette.white,
                                    ),
                                  ),
                                )
                              : Container(),
                          child: ChallengeDashboardChild(
                              // sort here according to done state
                              challenges: e.value
                                ..sort((a, b) =>
                                    ((a.data().state?.success ?? false)
                                        ? 1
                                        : 0) -
                                    ((b.data().state?.success ?? false)
                                        ? 1
                                        : 0))));
                    }).toList()),
                  );
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
