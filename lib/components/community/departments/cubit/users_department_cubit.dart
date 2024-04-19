import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:klimo/components/community/cubit/user_community_cubit.dart';
import 'package:klimo/config/analytics.dart';
import 'package:klimo/config/firebase.dart';
import 'package:klimo/utils/loading.dart';
import 'package:klimo_datamodels/community.dart';

typedef UsersDepartmentState = Loadable<DocumentSnapshot<DepartmentModel>?>?;

class UsersDepartmentCubit extends Cubit<UsersDepartmentState>
    with ErrorHandling {
  final UserCommunityCubit _communityCubit;

  StreamSubscription? _communitySub;
  StreamSubscription? _usersDepartmentSubscription;

  UsersDepartmentCubit(this._communityCubit) : super(null) {
    _communitySub?.cancel();
    _communitySub = _communityCubit.stream.listen((community) async {
      subscribe(community);
    });
    subscribe(_communityCubit.state);
  }
  subscribe(UserCommunityState communityState) async {
    _usersDepartmentSubscription?.cancel();
    if (communityState != null && communityState.isLoaded) {
      DocumentReference<DepartmentModel>? usersDepartmentRef =
          communityState.value?.data()?.department?.ref.type<DepartmentModel>();

      if (usersDepartmentRef == null) {
        emit(Loadable.loaded(null));
      } else {
        _usersDepartmentSubscription = usersDepartmentRef.snapshots().listen(
            (usersDepartment) => emit(Loadable.loaded(usersDepartment)));
      }
    } else {
      emit(null);
    }
  }

  void leaveDepartment() async {
    _communityCubit.state!.value!.reference
        .type<UserCommuntityReferenceUpdate>()
        .upset(UserCommuntityReferenceUpdate(
            (b) => b..departmentFieldValue = FieldValue.delete()));

    // analytics
    analytics.setDepartmentProperty(departmentId: null);
    UserCommuntityReference? userCommunity =
        _communityCubit.state?.value?.data();

    analytics.logLeaveDepartment(
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
      },
    );
    return;
  }

  @override
  Future<void> close() {
    _communitySub?.cancel();
    _usersDepartmentSubscription?.cancel();
    return super.close();
  }

  @override
  void onError(Object error, StackTrace stackTrace) {
    // TODO report this to crashlytics
    emit(null);
    super.onError(error, stackTrace);
  }
}
