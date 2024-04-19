import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:klimo/components/community/teams/cubit/join_or_create_team_cubit.dart';
import 'package:klimo/components/community/teams/cubit/teams_cubit.dart';
import 'package:klimo/components/community/teams/teams_fragment.dart';

class SearchTeams extends SearchDelegate {
  final TeamsCubit teamsCubit;

  final JoinOrCreateTeamCubit joinOrCreateTeamsCubit;

  SearchTeams({
    required this.teamsCubit,
    required this.joinOrCreateTeamsCubit,
  });

  @override
  ThemeData appBarTheme(BuildContext context) {
    final ThemeData serachAppBarTheme = Theme.of(context).copyWith(
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(
            width: 0,
            style: BorderStyle.none,
          ),
        ),
      ),
    );
    return serachAppBarTheme;
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(
          value: teamsCubit,
        ),
        BlocProvider.value(
          value: joinOrCreateTeamsCubit,
        ),
      ],
      child: TeamsFragment(
        searchQuery: query,
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(
          value: teamsCubit,
        ),
        BlocProvider.value(
          value: joinOrCreateTeamsCubit,
        ),
      ],
      child: TeamsFragment(
        searchQuery: query,
      ),
    );
  }
}
