import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:firebase_installations/firebase_installations.dart';
import 'package:flutter/foundation.dart';
import 'package:klimo/components/auth/cubit/sign_in_cubit.dart';
import 'package:klimo/config/firebase.dart';
import 'package:klimo/repositories/dynamiclink_repository.dart';
import 'package:klimo/utils/loading.dart';
import 'package:shared_preferences/shared_preferences.dart';

typedef AuthState = Loadable<User?>;

class AuthCubit extends Cubit<AuthState> with ErrorHandling {
  final DynamicLinkRepository dynamicLinkRepository;

  StreamSubscription? _authListener;
  StreamSubscription? _linkListener;
  bool _authenticateWithLinkPending = false;

  AuthCubit(this.dynamicLinkRepository) : super(Loadable.loading()) {
    _authListener = auth.authStateChanges().listen(firebaseUserUpdated);

    if (!kIsWeb) {
      // FIXME: handling dynamic links here in this cubit prevents the use of
      //  other non-signin dynamic links. When implementing general dynamic link
      //  handling this should be moved to the navigation / router layer.
      if (!dynamicLinkRepository.initialLinkHandled) {
        final link = dynamicLinkRepository.handleInitialLink();
        if (link != null) onDynamicLink(link);
      }
      _linkListener = links.onLink.listen(onDynamicLink);
    }
  }

  onDynamicLink(PendingDynamicLinkData data) {
    if (auth.isSignInWithEmailLink(data.link.toString())) {
      _authenticateWithLink(data.link.toString());
    }
  }

  _authenticateWithLink(String link) async {
    emit(Loadable.loading());
    _authenticateWithLinkPending = true;

    final sp = await SharedPreferences.getInstance();
    final User? user = auth.currentUser;
    final String? email = sp.getString(keySignupEmail);

    if (user?.email == null && email == null) {
      throw Exception('No associated Email Found');
    }

    await auth.signInWithEmailLink(
        email: user?.email ?? email!, emailLink: link);
    await sp.remove(keySignupEmail);
    _authenticateWithLinkPending = false;
  }

  @override
  Future<void> close() {
    _authListener?.cancel();
    _linkListener?.cancel();
    return super.close();
  }

  void firebaseUserUpdated(User? user) async {
    if (user == null && _authenticateWithLinkPending) {
      emit(Loadable.loading());
      return;
    }

    // analytics
    analytics.setUserId(id: user?.uid);
    if (user != null) {
      try {
        final firebaseInstallationId = await FirebaseInstallations.id;
        await firestore.userCollection.doc(user.uid).set({
          "firebase_installation_id": firebaseInstallationId,
        }, SetOptions(merge: true));
      } catch (e) {
        debugPrint(e.toString());
      }
    }
    emit(Loadable.loaded(user));
  }

  @override
  void onChange(Change<AuthState> change) {
    debugPrint(change.toString());
    if (change.nextState.value != null && !kIsWeb) {
      FirebaseCrashlytics.instance
          .setUserIdentifier(change.nextState.value!.uid);
    }
    super.onChange(change);
  }

  void signOut() async {
    emit(Loadable.loading());
    await auth.signOut();
  }
}

extension WithRef on User {
  DocumentReference get ref => fb.userCollection().doc(uid);
}
