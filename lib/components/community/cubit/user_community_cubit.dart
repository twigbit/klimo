import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:klimo/components/user/cubit/user_cubit.dart';
import 'package:klimo/config/firebase.dart';
import 'package:klimo/utils/loading.dart';
import 'package:klimo_datamodels/community.dart';

typedef UserCommunityState
    = Loadable<DocumentSnapshot<UserCommuntityReference>?>?;

class UserCommunityCubit extends Cubit<UserCommunityState> with ErrorHandling {
  final UserCubit _userCubit;
  StreamSubscription? _userSub;
  StreamSubscription? _communitySub;

  UserCommunityCubit(this._userCubit) : super(null) {
    _userSub = _userCubit.stream.listen((user) async {
      subscribe(user);
    });
    subscribe(_userCubit.state);
  }

  subscribe(UserState user) {
    _communitySub?.cancel();
    if (user != null && user.isLoaded) {
      final community = user.value?.data()?.context?.activeCommunity;
      if (community == null) {
        emit(Loadable.loaded(null));
      } else {
        _communitySub = community
            .type<UserCommuntityReference>()
            .snapshots()
            .listen((community) => emit(Loadable.loaded(community)));
      }
    } else {
      emit(null);
    }
  }

  Stream<String?> get communityId =>
      stream.map((event) => event?.value?.data()?.community.ref.id).distinct();

  @override
  Future<void> close() {
    _userSub?.cancel();
    _communitySub?.cancel();
    return super.close();
  }

  @override
  void onError(Object error, StackTrace stackTrace) {
    emit(null);
    super.onError(error, stackTrace);
  }
}
