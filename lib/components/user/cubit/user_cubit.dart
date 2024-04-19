import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:klimo/components/auth/cubit/auth_cubit.dart';
import 'package:klimo/config/firebase.dart';
import 'package:klimo/utils/loading.dart';
import 'package:klimo_datamodels/user.dart';

typedef UserState = Loadable<DocumentSnapshot<UserModel>>?;

class UserCubit extends Cubit<UserState> with ErrorHandling {
  final AuthCubit _authCubit;
  StreamSubscription? _authCubitSub;
  StreamSubscription? _userSub;

  UserModel? get user => state?.value?.data();
  UserRef? get userRef =>
      state?.value != null ? UserRef.fromSnapshot(state!.value!) : null;

  UserCubit(this._authCubit) : super(Loadable.loading()) {
    subscribe(_authCubit.state);
    _authCubitSub = _authCubit.stream.listen((user) {
      subscribe(user);
    });
  }

  subscribe(Loadable<User?> user) {
    if (user.isLoaded) {
      if (user.value == null) {
        _userSub?.cancel();
        emit(null);
      } else {
        _userSub = fb
            .userCollection<UserModel>()
            .doc(user.value!.uid)
            .snapshots()
            .listen((snap) {
          emit(Loadable.loaded(snap));
        });
      }
    }
  }

  @override
  Future<void> close() {
    _userSub?.cancel();
    _authCubitSub?.cancel();
    return super.close();
  }
}
