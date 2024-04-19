import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:klimo/components/community/cubit/user_community_cubit.dart';
import 'package:klimo/config/firebase.dart';
import 'package:klimo/utils/loading.dart';
import 'package:klimo_datamodels/community.dart';

typedef DepartmentsState
    = Loadable<List<QueryDocumentSnapshot<DepartmentModel>>?>?;

class DepartmentsCubit extends Cubit<DepartmentsState> with ErrorHandling {
  final UserCommunityCubit communityCubit;

  StreamSubscription? _communitySub;
  StreamSubscription? _departmentsSub;

  DepartmentsCubit(this.communityCubit) : super(null) {
    _communitySub = communityCubit.stream.listen(_subscribe);
    _subscribe(communityCubit.state);
  }

  _subscribe(UserCommunityState communityState) {
    _departmentsSub?.cancel();
    if (communityState != null && communityState.isLoaded) {
      final communityRef = communityState.data();
      if (communityRef == null) {
        emit(Loadable.loaded(null));
      } else {
        _departmentsSub = communityRef.community.ref
            .departmentsCollection<DepartmentModel>()
            .snapshots()
            .listen((departments) => emit(Loadable.loaded(departments.docs)));
      }
    } else {
      emit(null);
    }
  }

  @override
  Future<void> close() {
    _departmentsSub?.cancel();
    _communitySub?.cancel();
    return super.close();
  }
}
