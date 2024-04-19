import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:klimo/utils/iterable.dart';
import 'package:klimo/components/analytics_consent/cubit/consent_cubit.dart';
import 'package:klimo/components/auth/cubit/auth_cubit.dart';
import 'package:klimo/components/calculator/calculator_repository.dart';
import 'package:klimo/components/community/cubit/user_community_cubit.dart';
import 'package:klimo/utils/loading.dart';
import 'package:klimo_datamodels/calculation_engine.dart';
import 'package:klimo_datamodels/community.dart';
import 'package:klimo_datamodels/consent.dart';
import 'package:klimo_datamodels/user.dart';

import '../../../common/cubit/document_query_cubit.dart';
import '../../../config/firebase.dart';
import '../../user/cubit/onboarding_user_cubit.dart';

part 'onboarding_state.dart';

class OnboardingCubit extends Cubit<OnboardingState> with ErrorHandling {
  final AuthCubit _authCubit;
  StreamSubscription? _authSub;
  final OnboardingUserCubit _userCubit;
  StreamSubscription? _userSub;
  final ConsentCubit _consentCubit;
  StreamSubscription? _consentSub;
  final UserCommunityCubit _communityCubit;
  StreamSubscription? _communitySub;
  final DocumentQueryCubit<DeletionRequest> _deletionRequestCubit;
  StreamSubscription? _deletionRequestSub;
  Loadable<CalculationSnapshot?> _userFootprint = Loadable.loading();
  StreamSubscription? _userFootprintSub;

  OnboardingCubit(this._authCubit, this._userCubit, this._consentCubit,
      this._communityCubit, this._deletionRequestCubit)
      : super(OnboardingInitial()) {
    _authSub = _authCubit.stream.listen((user) async {
      if (user.isLoaded) {
        _userFootprintSub?.cancel();
        if (user.value != null) {
          _userFootprintSub = CalculatorRepository(user.value!.uid)
              .lastUserCalculation
              .snapshots()
              .listen((event) async {
            _userFootprint = Loadable.loaded(event.docs.safeFirst?.data());
            emit(await mapDataToState());
          });
        } else {
          _userFootprint = Loadable.loaded(null);
        }
      }
      emit(await mapDataToState());
    });
    _userSub = _userCubit.stream
        .listen((userModel) async => emit(await mapDataToState()));
    _consentSub = _consentCubit.stream
        .listen((state) async => emit(await mapDataToState()));
    _communitySub = _communityCubit.stream
        .listen((state) async => emit(await mapDataToState()));
    _deletionRequestSub = _deletionRequestCubit.stream
        .listen((state) async => emit(await mapDataToState()));
  }

  @override
  void emit(OnboardingState? state) {
    if (state != null) super.emit(state);
  }

  Future<OnboardingState?> mapDataToState() async {
    final Loadable<User?> user = _authCubit.state;
    final Loadable<DocumentSnapshot<UserUpdate>>? userModel = _userCubit.state;
    final Loadable<ConsentModel?>? consentState = _consentCubit.state;
    final Loadable<DocumentSnapshot<UserCommuntityReference>?>? community =
        _communityCubit.state;
    final Loadable<QuerySnapshot<DeletionRequest>?>? deletionRequest =
        _deletionRequestCubit.state;

    if (user.isLoading ||
        (userModel != null && userModel.isLoading) ||
        (consentState != null && consentState.isLoading) ||
        (deletionRequest != null && deletionRequest.isLoading) ||
        (community != null && community.isLoading) ||
        (_userFootprint.isLoading)) {
      return null;
    } else if (user.value == null && state is OnboardingLoading) {
      return OnboardingStepAuth();
    } else if (deletionRequest != null &&
        deletionRequest.isLoaded &&
        deletionRequest.value!.docs.isNotEmpty) {
      return OnboardingStepDeletionRequestPending(
          deletionRequest.value!.docs.first);
    } else if (user.value == null) {
      return OnboardingStepWelcome();
    } else if (consentState != null && consentState.value == null) {
      return OnboardingStepConsent();
    } else if ((community != null && community.value?.data() == null) ||
        (userModel != null && userModel.value?.data()?.context == null)) {
      return OnboardingStepCommunity();
    } else if ((state is OnboardingStepCommunity ||
            state is OnboardingStepDepartment) &&
        community!.value!.data()!.department == null) {
      return OnboardingStepDepartment();
    } else if (userModel?.value != null &&
        userModel?.value?.data()?.profile == null) {
      return OnboardingStepProfile();
    } else if (_userFootprint.value == null) {
      return OnboardingStepFootprint();
    } else {
      return OnboardingDone();
    }
  }

  showTutorial() {
    emit(OnboardingStepTutorial());
  }

  switchComunity() {
    emit(OnboardingStepCommunity());
  }

  switchDepartment() {
    emit(OnboardingStepDepartment());
  }

  next() async {
    emit(OnboardingLoading());
    emit(await mapDataToState());
  }

  check() async {
    emit(await mapDataToState());
  }

  startFootprintCalculation() {
    assert(state is OnboardingStepFootprint);
    emit(OnboardingStepCalculatingFootprint());
  }

  @override
  void onChange(Change<OnboardingState> change) {
    super.onChange(change);
  }

  @override
  Future<void> close() {
    _authSub?.cancel();
    _userSub?.cancel();
    _consentSub?.cancel();
    _communitySub?.cancel();
    _deletionRequestSub?.cancel();
    _userFootprintSub?.cancel();
    return super.close();
  }
}
