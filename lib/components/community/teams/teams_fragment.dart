import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:klimo/common/buttons/elevated_button.dart';
import 'package:klimo/utils/localisation.dart';
import 'package:klimo/utils/theme.dart';
import 'package:klimo_datamodels/community.dart';
import '../common/leaderbord_list_card.dart';
import 'cubit/join_or_create_team_cubit.dart';
import 'cubit/teams_cubit.dart';

class TeamsFragment extends StatefulWidget {
  final String? searchQuery;
  const TeamsFragment({Key? key, this.searchQuery}) : super(key: key);

  @override
  State<TeamsFragment> createState() => _TeamsFragmentState();
}

class _TeamsFragmentState extends State<TeamsFragment> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TeamsCubit, TeamsState>(
      builder: (context, teams) {
        if (teams?.isLoading ?? true) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          List<QueryDocumentSnapshot<TeamModel>>? teamsList =
              teams?.asLoaded?.value;
          teamsList = widget.searchQuery != null
              ? (teams?.asLoaded?.value)
                  ?.toList()
                  .where((team) => team
                      .data()
                      .name
                      .toLowerCase()
                      .contains(widget.searchQuery!.toLowerCase()))
                  .toList()
              : (teams?.asLoaded?.value)?.toList();
          if (teamsList?.isEmpty ?? true) {
            return Center(
              child: Text(context.localisation().community_teams_empty),
            );
          }
          return SafeArea(
            child: BlocBuilder<JoinOrCreateTeamCubit, JoinOrCreateTeamState>(
              builder: (context, state) {
                if (state is JoinOrCreateTeamLoaded) {
                  return Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: SingleChildScrollView(
                          child: ListView.builder(
                            padding: const EdgeInsets.only(
                              top: 16.0,
                              bottom: 64.0,
                            ),
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: teamsList!.length,
                            itemBuilder: (context, index) {
                              TeamModel teamModel = teamsList![index].data();

                              bool isSelected = teamsList[index].id ==
                                  state.selectedTeam?.ref.id;
                              return LeaderBoardListCard(
                                borderColor:
                                    isSelected ? Palette.primary : null,
                                groupName: teamModel.name,
                                groupInfo: teamModel.info,
                                onTap: () {
                                  context
                                      .read<JoinOrCreateTeamCubit>()
                                      .selectTeam(TeamRef.fromSnapshot(
                                          teamsList![index]));
                                },
                              );
                            },
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: ElevatedButton(
                          onPressed: state.selectedTeam != null
                              ? () async {
                                  await context
                                      .read<JoinOrCreateTeamCubit>()
                                      .joinTeam();
                                  if (!mounted) return;

                                  Navigator.pop(context);
                                  if (widget.searchQuery != null) {
                                    Navigator.pop(context);
                                  }
                                }
                              : null,
                          child: Text(context.localisation().action_save),
                        ).expanded(),
                      ),
                    ],
                  );
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          );
        }
      },
    );
  }
}
