import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:klimo/components/community/cubit/user_community_cubit.dart';
import 'package:klimo/components/user/cubit/user_cubit.dart';
import 'package:klimo/config/analytics.dart';
import 'package:klimo/config/firebase.dart';
import 'package:klimo/utils/loading.dart';
import 'package:klimo_datamodels/community.dart';
import 'package:klimo_datamodels/user.dart';

part 'join_or_create_team_state.dart';

class JoinOrCreateTeamCubit extends Cubit<JoinOrCreateTeamState>
    with ErrorHandling {
  final UserCubit userCubit;
  final UserCommunityCubit communityCubit;
  JoinOrCreateTeamCubit(
    this.userCubit,
    this.communityCubit,
  ) : super(const JoinOrCreateTeamLoaded());

  factory JoinOrCreateTeamCubit.fromContext(BuildContext context) {
    return JoinOrCreateTeamCubit(
        context.read<UserCubit>(), context.read<UserCommunityCubit>());
  }

  selectTeam(TeamRef? team) {
    assert(this.state is JoinOrCreateTeamLoaded);
    final JoinOrCreateTeamLoaded state = this.state as JoinOrCreateTeamLoaded;
    emit(state.copyWith(selectedTeam: team));
  }

  Future<void> createTeam({
    required String name,
    required String info,
    required String password,
  }) async {
    emit(CreateTeamLoading());

    TeamModel team = TeamModel((b) => b
      ..name = name
      ..info = info);
    TeamRef teamRef = TeamRef.fromModel(
        team, _userCommunityRef.data()!.community.ref.teamsCollection().doc());

    WriteBatch batch = firestore.batch();

    batch.upset<TeamModel>(teamRef.ref.type<TeamModel>(), team);
    _addUserToTeam(batch, teamRef, userCubit.userRef!);

    await batch.commit();

    // analytics
    analytics.logCreateTeam(
      params: {
        AnalyticsParameters.communityId:
            _userCommunityRef.data()!.community.ref.id,
        AnalyticsParameters.communityName:
            _userCommunityRef.data()!.community.name["de"],
        AnalyticsParameters.communityNameEN:
            _userCommunityRef.data()!.community.name["en"],
        AnalyticsParameters.departmentId:
            _userCommunityRef.data()!.department?.ref.id,
        AnalyticsParameters.departmentName:
            _userCommunityRef.data()!.department?.name["de"],
        AnalyticsParameters.departmentNameEN:
            _userCommunityRef.data()!.department?.name["en"],
        AnalyticsParameters.teamId: teamRef.ref.id,
        AnalyticsParameters.teamName: teamRef.name,
      },
    );
    emit(CreateTeamSuccess());
  }

  Future<void> joinTeam() async {
    emit(JoinTeamLoading(this.state as JoinOrCreateTeamLoaded));

    final JoinOrCreateTeamLoaded state = this.state as JoinOrCreateTeamLoaded;

    WriteBatch batch = firestore.batch();
    _addUserToTeam(batch, state.selectedTeam!, userCubit.userRef!);

    await batch.commit();
    emit(JoinTeamSuccess(state));
  }

  _addUserToTeam(WriteBatch b, TeamRef team, UserRef user) {
    // 1. add user to `users` subcollection of the provided team
    final teamUserRef = team.ref.userCollection<UserRef>().doc(user.ref.id);
    b.upset<UserRef>(teamUserRef, user);
    // 2. change teamRef in current user's [CommunityRef]
    b.upset<UserCommuntityReferenceUpdate>(
      _userCommunityRef.reference.type<UserCommuntityReferenceUpdate>(),
      UserCommuntityReferenceUpdate((b) => b.team.replace(team)),
    );

    // analytics
    analytics.setTeamProperty(teamId: team.ref.id);
    analytics.logJoinTeam(
      params: {
        AnalyticsParameters.communityId:
            _userCommunityRef.data()?.community.ref.id,
        AnalyticsParameters.communityName:
            _userCommunityRef.data()?.community.name["de"],
        AnalyticsParameters.communityNameEN:
            _userCommunityRef.data()?.community.name["en"],
        AnalyticsParameters.departmentId:
            _userCommunityRef.data()?.department?.ref.id,
        AnalyticsParameters.departmentName:
            _userCommunityRef.data()?.department?.name["de"],
        AnalyticsParameters.departmentNameEN:
            _userCommunityRef.data()?.department?.name["en"],
        AnalyticsParameters.teamId: team.ref.id,
        AnalyticsParameters.teamName: team.name,
      },
    );
  }

  DocumentSnapshot<UserCommuntityReference> get _userCommunityRef {
    final communityState = communityCubit.state;
    assert(communityState is Loaded);
    assert(communityState!.value != null);
    return communityState!.value!;
  }
}
