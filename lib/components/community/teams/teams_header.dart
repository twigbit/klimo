import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:klimo/common/layout/klimo_bottom_sheet.dart';
import 'package:klimo/components/community/common/group_empty_header.dart';
import 'package:klimo/components/community/common/dashboard_group_header.dart';
import 'package:klimo/components/community/teams/cubit/join_or_create_team_cubit.dart';
import 'package:klimo/components/community/teams/cubit/users_team_cubit.dart';
import 'package:klimo/components/community/teams/teams_create_fragment.dart';
import 'package:klimo/utils/localisation.dart';

import '../../../navigation/routes.dart';

class TeamsHeader extends StatelessWidget {
  const TeamsHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UsersTeamCubit, UsersTeamState>(
      builder: (context, usersTeam) {
        if (usersTeam != null && usersTeam.isLoaded) {
          var usersTeamData = usersTeam.value?.data();

          return (usersTeam.value == null)
              ? GroupEmptyHeader(
                  title: context.localisation().community_users_team_empty,
                  primaryActionButton: ElevatedButton(
                    child: Text(context.localisation().community_teams_select),
                    onPressed: () {
                      Router.of(context).routerDelegate.setNewRoutePath(
                            SelectTeamRoute(),
                          );
                    },
                  ),
                  secondaryActionButton: TextButton(
                    child: Text(context.localisation().community_teams_create),
                    onPressed: () {
                      showKlimoModalBottomSheet(
                        context: context,
                        builder: (modalContext) {
                          return MultiBlocProvider(
                            providers: [
                              BlocProvider(
                                  create: (context) =>
                                      JoinOrCreateTeamCubit.fromContext(
                                          context)),
                            ],
                            child: KlimoBottomSheet(
                              header: KlimoBottomSheetHeader(
                                title: context
                                    .localisation()
                                    .community_teams_create,
                              ),
                              body: Padding(
                                padding: EdgeInsets.only(
                                  bottom:
                                      MediaQuery.of(context).viewPadding.bottom,
                                ),
                                child: const TeamsCreateFragment(),
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                )
              : DashboardGroupHeader(
                  title: context.localisation().community_users_team,
                  groupName: usersTeamData?.name ?? "",
                  groupInfo: usersTeamData?.info ?? "",
                  groupChallengeCounts: usersTeamData?.stats?.challenges ?? 0,
                  groupChallengeCoins: usersTeamData?.stats?.coins ?? 0,
                  groupEmissionSavings:
                      usersTeamData?.stats?.emissionSavings ?? 0,
                );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
