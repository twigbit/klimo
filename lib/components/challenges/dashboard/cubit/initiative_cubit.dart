import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:klimo/utils/iterable.dart';
import 'package:klimo/components/challenges/dashboard/timeframe/cubit/timeframe_cubit.dart';
import 'package:klimo/config/firebase.dart';
import 'package:klimo/utils/loading.dart';
import 'package:klimo_datamodels/challenges.dart';
import 'package:klimo_datamodels/community.dart';

import '../../../community/cubit/user_community_cubit.dart';

typedef InitiativeState = Loadable<DocumentSnapshot<InitiativeModel>?>?;

class InitiativeCubit extends Cubit<InitiativeState> with ErrorHandling {
  final TimeframeCubit timeframeCubit;
  final UserCommunityCubit _communityCubit;
  StreamSubscription? _communitySub;
  StreamSubscription? _timeframeSub;

  InitiativeCubit(this.timeframeCubit, this._communityCubit) : super(null) {
    _timeframeSub = timeframeCubit.stream.listen((state) => load());
    _communitySub = _communityCubit.stream.listen((state) => load());
    load();
  }

  load() async {
    Timeframe timeframe = timeframeCubit.state;
    DocumentReference communityRef =
        _communityCubit.state!.value!.data()!.community.ref;
    emit(Loadable.loading());
    emit(Loadable.loaded((await communityRef
            .initiativeCollection<InitiativeModel>()
            .where('end', isGreaterThanOrEqualTo: timeframe.start)
            .get())
        .docs
        .where((element) => element.data().start.isBefore(timeframe.end))
        .safeFirst));
  }

  @override
  Future<void> close() {
    _timeframeSub?.cancel();
    _communitySub?.cancel();
    return super.close();
  }
}
