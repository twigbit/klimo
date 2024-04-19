import 'package:built_collection/built_collection.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:klimo/components/challenges/dashboard/timeframe/cubit/timeframe_cubit.dart';
import 'package:klimo/components/community/cubit/user_community_cubit.dart';
import 'package:klimo/components/user/cubit/user_cubit.dart';
import 'package:klimo/config/firebase.dart';
import 'package:klimo/utils/loading.dart';
import 'package:klimo_datamodels/challenges.dart';

typedef ChallengeListState = Loadable<BuiltList<DocumentSnapshot<Challenge>>>;

class ChallengeListCubit extends Cubit<ChallengeListState> with ErrorHandling {
  final UserCubit _userCubit;
  final UserCommunityCubit _userCommunityCubit;
  final TimeframeCubit _timeframeCubit;

  ChallengeListCubit(
    this._userCubit,
    this._userCommunityCubit,
    this._timeframeCubit,
  ) : super(Loadable.loading()) {
    load();
  }

  factory ChallengeListCubit.fromContext(BuildContext context) {
    return ChallengeListCubit(
      context.read<UserCubit>(),
      context.read<UserCommunityCubit>(),
      context.read<TimeframeCubit>(),
    );
  }

  load() async {
    Query<Challenge> query = _userCommunityCubit.state!.value!
        .data()!
        .community
        .ref
        .challengeCollection<Challenge>();
    var result = await query.get();

    var excludeIds = await _loadChallengeExcludeMask();

    BuiltList<QueryDocumentSnapshot<Challenge>> snaps = result.docs
        .where((snap) => !excludeIds.contains(snap.id))
        .toBuiltList();

    emit(Loadable.loaded(snaps));
  }

  /// Returns an iterable of challenge ids that should be excluded from the
  /// challenge selection for the current timeframe
  Future<Iterable<String>> _loadChallengeExcludeMask() async {
    var filterCommunity =
        _userCommunityCubit.state!.value!.data()!.community.ref;
    var filterStart = _timeframeCubit.state.start;
    var filterEnd = _timeframeCubit.state.end;

    var query = _userCubit.state!.value!.reference
        .challengeCollection<UserChallenge>()
        .where('community.ref', isEqualTo: filterCommunity)
        .orderBy('state.startedAt') // needed for the >= filter on startedAt
        .where('state.startedAt', isGreaterThanOrEqualTo: filterStart)
        .orderBy('challenge.coins'); // needed for reusing the existing index

    var result = await query.get();

    return result.docs
        .map((s) => s.data())
        .where((d) =>
            // We only exclude challenges, that are part of an initiative
            // or challenges that I already added in this timeframe.
            d.initiative != null || !d.state!.startedAt.isAfter(filterEnd))
        .map((d) => d.challenge.ref.id);
  }
}
