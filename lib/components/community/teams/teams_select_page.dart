import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:klimo/components/community/teams/search_teams.dart';
import 'package:klimo/components/community/teams/teams_fragment.dart';
import 'package:klimo/utils/localisation.dart';
import 'cubit/join_or_create_team_cubit.dart';
import 'cubit/teams_cubit.dart';

class TeamsSelectPage extends StatelessWidget {
  const TeamsSelectPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
            context.localisation().teams_select_title,
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {
                showSearch(
                  context: context,
                  delegate: SearchTeams(
                    joinOrCreateTeamsCubit:
                        BlocProvider.of<JoinOrCreateTeamCubit>(context),
                    teamsCubit: BlocProvider.of<TeamsCubit>(context),
                  ),
                );
              },
            )
          ]),
      body: const TeamsFragment(),
    );
  }
}
