import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:klimo/components/auth/cubit/auth_cubit.dart';
import 'package:klimo/config/analytics.dart';
import 'package:klimo/config/firebase.dart';
import 'package:klimo/utils/loading.dart';
import 'package:klimo_datamodels/consent.dart';

class ConsentCubit extends Cubit<Loadable<ConsentModel?>?> with ErrorHandling {
  final AuthCubit _authCubit;

  StreamSubscription? _authCubitSub;
  StreamSubscription? _consentSub;

  ConsentCubit(this._authCubit) : super(null) {
    _authCubitSub = _authCubit.stream.listen(_update);
    _update(_authCubit.state);
  }

  @override
  Future<void> close() {
    _authCubitSub?.cancel();
    _consentSub?.cancel();
    return super.close();
  }

  void _update(Loadable<User?> user) {
    if (user.isLoading || user.value == null) {
      emit(null);
    } else {
      _consentSub = fb
          .userCollection()
          .doc(user.value!.uid)
          .consentCollection<ConsentModel>()
          .orderBy('timestamp', descending: true)
          .limit(1)
          .snapshots()
          .listen((snap) {
        if (snap.docs.isEmpty) {
          emit(Loadable.loaded(null));
        } else {
          emit(Loadable.loaded(snap.docs.first.data()));
        }
      });
    }
  }

  updateConsent({required bool enableAnalytics}) async {
    ConsentModel consent = ConsentModel((builder) => builder
      ..timestamp = DateTime.now()
      ..targetId = state?.value?.targetId ?? builder.targetId
      ..enableAnalytics = enableAnalytics);

    emit(Loadable.loading());
    if (_authCubit.state.value == null) {
      throw ("Cannot update consent without an authenticated user");
    }
    await fb
        .userCollection()
        .doc(_authCubit.state.value!.uid)
        .consentCollection<ConsentModel>()
        .add(consent);

    // enable analytics in dependence of user's consent
    analytics.setAnalyticsCollectionEnabled(enableAnalytics);

    // analytics
    analytics.setAnalyticsUsageProperty(isPermitted: enableAnalytics);
    analytics.setTargetGroupUserProperty(consent.targetId);
    analytics.logUpdateConsent(
      params: {
        AnalyticsParameters.value: enableAnalytics ? 1 : 0,
        AnalyticsParameters.previousValue:
            state?.asLoaded?.value?.enableAnalytics ?? false ? 1 : 0,
      },
    );
  }

  @override
  void onChange(Change<Loadable<ConsentModel?>?> change) {
    bool? enabledAnalytics = change.nextState?.value?.enableAnalytics;
    if (enabledAnalytics != null) {
      analytics.setAnalyticsCollectionEnabled(enabledAnalytics);
      if (!kIsWeb) {
        analytics.setConsent(
            adStorageConsentGranted: enabledAnalytics,
            analyticsStorageConsentGranted: enabledAnalytics);
      }
      if (!kIsWeb) {
        crashlytics.setCrashlyticsCollectionEnabled(enabledAnalytics);
      }
    }
    super.onChange(change);
  }
}
