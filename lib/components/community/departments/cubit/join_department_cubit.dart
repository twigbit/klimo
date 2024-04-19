import 'package:bloc/bloc.dart';
import 'package:built_collection/built_collection.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:klimo/components/user/cubit/user_cubit.dart';
import 'package:klimo/config/analytics.dart';
import 'package:klimo/config/firebase.dart';
import 'package:klimo_datamodels/community.dart';
import 'package:klimo_datamodels/user.dart';

part 'join_department_state.dart';

class JoinDepartmentCubit extends Cubit<JoinDepartmentState>
    with ErrorHandling {
  final DocumentSnapshot<UserCommuntityReference> _userCommunity;
  final UserCubit _userCubit;

  JoinDepartmentCubit(this._userCommunity, this._userCubit)
      : super(JoinDepartmentInitial()) {
    load();
  }
  load() async {
    QuerySnapshot query = await _userCommunity
        .data()!
        .community
        .ref
        .departmentsCollection<DepartmentModel>()
        .get();
    int? currentDepartmentIndex = query.docs.indexWhere(
        (element) => element.id == _userCommunity.data()?.department?.ref.id);
    if (currentDepartmentIndex == -1) currentDepartmentIndex = null;

    emit(DepartmentsLoaded(
      BuiltList(query.docs),
      selectedIndex: currentDepartmentIndex,
    ));
    // TODO better implementation via onboarding cubit needed, this is dirty!
    if (query.docs.isEmpty) joinDepartment();
  }

  selectDepartment(int? index) {
    assert(this.state is DepartmentsLoaded);
    final DepartmentsLoaded state = this.state as DepartmentsLoaded;
    emit(state.copyWith(selectedIndex: index));
  }

  joinDepartment() async {
    // assert(this.state is DepartmentsLoaded);
    emit(JoinDepartmentLoading(this.state as DepartmentsLoaded));

    final DepartmentsLoaded state = this.state as DepartmentsLoaded;

    DepartmentRef? department = state.selectedIndex != null
        ? DepartmentRef.fromSnapshot(state.departments[state.selectedIndex!])
        : null;

    WriteBatch batch = firestore.batch();
    UserCommuntityReferenceUpdate update = UserCommuntityReferenceUpdate(
        (b) => b.department = department?.toBuilder());

    // Carefull! CommunityCubit could have changed here.
    batch.upset<UserCommuntityReferenceUpdate>(
        _userCommunity.reference.type<UserCommuntityReferenceUpdate>(), update);

    UserRef userRef = UserRef.fromSnapshot(_userCubit.state!.value!);
    if (department != null) {
      batch.upset(department.ref.userCollection<UserRef>().doc(userRef.ref.id),
          userRef);
    }
    await batch.commit();

    // analytics
    analytics.setDepartmentProperty(departmentId: department?.ref.id);
    analytics.logJoinDepartment(
      params: {
        AnalyticsParameters.communityId:
            _userCommunity.data()?.community.ref.id,
        AnalyticsParameters.communityName:
            _userCommunity.data()?.community.name['de'],
        AnalyticsParameters.communityNameEN:
            _userCommunity.data()?.community.name['en'],
        AnalyticsParameters.departmentId:
            _userCommunity.data()?.department?.ref.id,
        AnalyticsParameters.departmentName:
            _userCommunity.data()?.department?.name["de"],
        AnalyticsParameters.departmentNameEN:
            _userCommunity.data()?.department?.name["en"],
      },
    );
    emit(JoinDepartmentSuccess(state));
  }

  @override
  void onError(Object error, StackTrace stackTrace) {
    debugPrint(error.toString());
    super.onError(error, stackTrace);
  }
}
