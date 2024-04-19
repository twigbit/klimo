import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:klimo/components/auth/cubit/auth_cubit.dart';
import 'package:klimo/config/analytics.dart';
import 'package:klimo/config/dynamic_links.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

import '../../../config/firebase.dart';
import '../util.dart';

part 'sign_in_state.dart';

const keySignupEmail = 'signup_mail';

class SignInCubit extends Cubit<SignInState> with ErrorHandling {
  SignInCubit(AuthCubit authCubit) : super(const SignInInitial());

  void signInAnonymously() async {
    emit(const SignInLoading());
    try {
      await auth.signInAnonymously();

      // analytics
      analytics.logSignIn(signInMethod: AnalyticsValues.anonymousSignIn);
      emit(SignInSuccess());
    } catch (e) {
      emit(const SignInError('Unable to sing in anonymously. Try again later'));
    }
  }

  void updateEmail(String email) {
    assert(state is SignInInitial);
    emit((state as SignInInitial).copyWith(email: email));
  }

  void reset() {
    emit(const SignInInitial());
  }

  void signInWithEmail(String languageCode) async {
    if (state is! SignInInitial) {
      throw Exception('Can only sign in from inital state');
    }
    final email = (state as SignInInitial).email;
    if (email == null) throw Exception('No email detected');

    await (await SharedPreferences.getInstance())
        .setString(keySignupEmail, email);

    emit(const SignInLoading(isEmailAuth: true));

    try {
      await auth.setLanguageCode(languageCode);
      await auth.sendSignInLinkToEmail(
        email: email,
        actionCodeSettings: DynamicLinkOptions.emailLinkSignInACS,
      );

      // analytics
      analytics.logSignIn(signInMethod: AnalyticsValues.emailSignIn);

      emit(SignInAwaitEmailConfirmation(email));
    } catch (e) {
      emit(SignInError(e.toString()));
    }
  }

  void signInWithGoogle() async {
    emit(const SignInLoading());
    try {
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      assert(googleUser != null);
      if (googleUser == null) throw Exception('Authentication Failed');

      // Obtain the auth details from the request
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Once signed in, return the UserCredential
      await auth.signInWithCredential(credential);

      // analytics
      analytics.logSignIn(signInMethod: AnalyticsValues.googleSignIn);
      emit(SignInSuccess());
    } catch (e) {
      debugPrint(e.toString());
      emit(const SignInError("Authentication Failed"));
    }
  }

  void signInWithApple() async {
    assert(Platform.isIOS);
    emit(const SignInLoading());
    try {
      // To prevent replay attacks with the credential returned from Apple, we
      // include a nonce in the credential request. When signing in with
      // Firebase, the nonce in the id token returned by Apple, is expected to
      // match the sha256 hash of `rawNonce`.
      final rawNonce = generateNonce();
      final nonce = sha256ofString(rawNonce);

      // Request credential for the currently signed in Apple account.
      final appleCredential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
        nonce: nonce,
      );

      // Create an `OAuthCredential` from the credential returned by Apple.
      final oauthCredential = OAuthProvider("apple.com").credential(
        idToken: appleCredential.identityToken,
        rawNonce: rawNonce,
      );

      // Sign in the user with Firebase. If the nonce we generated earlier does
      // not match the nonce in `appleCredential.identityToken`, sign in will fail.
      await auth.signInWithCredential(oauthCredential);

      // update Firebase users' displayname
      if (auth.currentUser?.displayName == null) {
        final displayName =
            '${appleCredential.givenName ?? ''} ${appleCredential.familyName ?? ''}';
        await auth.currentUser?.updateDisplayName(displayName);

        auth.currentUser?.reload();
      }

      // analytics
      analytics.logSignIn(signInMethod: AnalyticsValues.appleSignIn);

      emit(SignInSuccess());
    } catch (e) {
      debugPrint(e.toString());
      emit(SignInError("Authentication Failed: $e"));
    }
  }
}
