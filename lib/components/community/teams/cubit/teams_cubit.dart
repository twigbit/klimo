import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:klimo/components/community/cubit/user_community_cubit.dart';
import 'package:klimo/config/firebase.dart';
import 'package:klimo/utils/loading.dart';
import 'package:klimo_datamodels/community.dart';

typedef TeamsState = Loadable<List<QueryDocumentSnapshot<TeamModel>>?>?;

class TeamsCubit extends Cubit<TeamsState> with ErrorHandling {
  final UserCommunityCubit communityCubit;

  StreamSubscription? _communitySub;
  StreamSubscription? _teamsSub;

  TeamsCubit(this.communityCubit) : super(null) {
    _communitySub = communityCubit.stream.listen(_subscribe);
    _subscribe(communityCubit.state);
  }

  _subscribe(UserCommunityState communityState) {
    _teamsSub?.cancel();
    if (communityState != null && communityState.isLoaded) {
      final communityRef = communityState.data();
      if (communityRef == null) {
        emit(Loadable.loaded(null));
      } else {
        _teamsSub = communityRef.community.ref
            .teamsCollection<TeamModel>()
            .snapshots()
            .listen((teams) => emit(Loadable.loaded(teams.docs)));
      }
    } else {
      emit(null);
    }
  }

  @override
  Future<void> close() {
    _teamsSub?.cancel();
    _communitySub?.cancel();
    return super.close();
  }
}
