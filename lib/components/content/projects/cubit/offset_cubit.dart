import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:klimo/components/auth/cubit/auth_cubit.dart';
import 'package:klimo/config/firebase.dart';
import 'package:klimo/utils/loading.dart';
import 'package:klimo_datamodels/projects.dart';

typedef OffsetState = Loadable<List<QueryDocumentSnapshot<CarbonOffset>>>?;

class OffsetCubit extends Cubit<OffsetState> with ErrorHandling {
  final AuthCubit _authCubit;

  StreamSubscription? _authCubitSub;
  StreamSubscription? _offsetSub;

  OffsetCubit(this._authCubit) : super(null) {
    _authCubitSub = _authCubit.stream.listen(_update);
    _update(_authCubit.state);
  }

  @override
  Future<void> close() {
    _authCubitSub?.cancel();
    _offsetSub?.cancel();
    return super.close();
  }

  void _update(Loadable<User?> user) {
    _offsetSub?.cancel();
    if (user.isLoading || user.value == null) {
      emit(null);
    } else {
      _offsetSub = fb
          .userCollection()
          .doc(user.value!.uid)
          .offsetCollection<CarbonOffset>()
          .snapshots()
          .listen(
        (snap) {
          emit(Loadable.loaded(snap.docs));
        },
      );
    }
  }
}
