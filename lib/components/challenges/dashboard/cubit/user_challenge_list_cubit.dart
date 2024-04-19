import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:klimo/components/challenges/dashboard/timeframe/cubit/timeframe_cubit.dart';
import 'package:klimo/components/user/cubit/user_cubit.dart';
import 'package:klimo/config/firebase.dart';
import 'package:klimo/utils/loading.dart';
import 'package:klimo_datamodels/challenges.dart';

import '../../../community/cubit/user_community_cubit.dart';

typedef UserChallengeListState = Loadable<QuerySnapshot<UserChallenge>>?;

class UserChallengeListCubit extends Cubit<UserChallengeListState>
    with ErrorHandling {
  final UserCubit _userCubit;
  final TimeframeCubit timeframeCubit;
  final UserCommunityCubit _communityCubit;
  StreamSubscription? _communitySub;
  StreamSubscription? _timeframeSub;
  StreamSubscription? _querySub;

  UserChallengeListCubit(
      this._userCubit, this.timeframeCubit, this._communityCubit)
      : super(null) {
    _timeframeSub =
        timeframeCubit.stream.listen((state) => load(timeframe: state));
    _communitySub = _communityCubit.stream.listen(
        (state) => load(communityRef: state?.value?.data()?.community.ref));
    load(timeframe: timeframeCubit.state);
  }

  load({
    Timeframe? timeframe,
    DocumentReference? communityRef,
  }) async {
    Timeframe challengeTimeframe = timeframe ?? timeframeCubit.state;
    DocumentReference userCommunityRef =
        communityRef ?? _communityCubit.state!.value!.data()!.community.ref;
    emit(Loadable.loading());
    _querySub?.cancel();
    _querySub = _userCubit.state!.value!.reference
        .challengeCollection<UserChallenge>()
        .orderBy('state.startedAt')
        .where('state.startedAt',
            isGreaterThanOrEqualTo: challengeTimeframe.start)
        .where('state.startedAt', isLessThanOrEqualTo: challengeTimeframe.end)
        .where('community.ref', isEqualTo: userCommunityRef)
        .snapshots()
        .listen((event) {
      emit(Loadable.loaded(event));
    });
  }

  @override
  Future<void> close() {
    _timeframeSub?.cancel();
    _communitySub?.cancel();
    _querySub?.cancel();
    return super.close();
  }

  @override
  void onChange(Change<UserChallengeListState?> change) {
    super.onChange(change);
  }
}
