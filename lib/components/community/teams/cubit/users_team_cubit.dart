import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:klimo/components/community/cubit/user_community_cubit.dart';
import 'package:klimo/config/analytics.dart';
import 'package:klimo/config/firebase.dart';
import 'package:klimo/utils/loading.dart';
import 'package:klimo_datamodels/community.dart';

typedef UsersTeamState = Loadable<DocumentSnapshot<TeamModel>?>?;

class UsersTeamCubit extends Cubit<UsersTeamState> with ErrorHandling {
  final UserCommunityCubit _communityCubit;

  StreamSubscription? _communitySub;
  StreamSubscription? _usersTeamSubscription;

  UsersTeamCubit(this._communityCubit) : super(null) {
    _communitySub?.cancel();
    _communitySub = _communityCubit.stream.listen((community) async {
      subscribe(community);
    });
    subscribe(_communityCubit.state);
  }
  subscribe(UserCommunityState communityState) async {
    _usersTeamSubscription?.cancel();
    if (communityState != null && communityState.isLoaded) {
      DocumentReference<TeamModel>? usersTeamRef =
          communityState.value?.data()?.team?.ref.type<TeamModel>();

      if (usersTeamRef == null) {
        emit(Loadable.loaded(null));
      } else {
        _usersTeamSubscription = usersTeamRef
            .snapshots()
            .listen((usersTeam) => emit(Loadable.loaded(usersTeam)));
      }
    } else {
      emit(null);
    }
  }

  void leaveTeam() async {
    _communityCubit.state!.value!.reference
        .type<UserCommuntityReferenceUpdate>()
        .upset(UserCommuntityReferenceUpdate(
            (b) => b..teamFieldValue = FieldValue.delete()));

    // analytics
    analytics.setTeamProperty(teamId: null);
    UserCommuntityReference? userCommunity =
        _communityCubit.state?.value?.data();

    analytics.logLeaveTeam(
      params: {
        AnalyticsParameters.communityId: userCommunity?.community.ref.id,
        AnalyticsParameters.communityName: userCommunity?.community.name["de"],
        AnalyticsParameters.communityNameEN:
            userCommunity?.community.name["en"],
        AnalyticsParameters.departmentId: userCommunity?.department?.ref.id,
        AnalyticsParameters.departmentName:
            userCommunity?.department?.name["de"],
        AnalyticsParameters.departmentNameEN:
            userCommunity?.department?.name["en"],
        AnalyticsParameters.teamId: userCommunity?.team?.ref.id,
        AnalyticsParameters.teamName: userCommunity?.team?.name,
      },
    );
    return;
  }

  @override
  Future<void> close() {
    _communitySub?.cancel();
    _usersTeamSubscription?.cancel();
    return super.close();
  }

  @override
  void onError(Object error, StackTrace stackTrace) {
    // TODO report this to crashlytics
    emit(null);
    super.onError(error, stackTrace);
  }
}
