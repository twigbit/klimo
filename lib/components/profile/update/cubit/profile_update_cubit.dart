import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:klimo/config/analytics.dart';
import 'package:klimo/config/firebase.dart';
import 'package:klimo_datamodels/user.dart';

part 'profile_update_state.dart';

class ProfileUpdateCubit extends Cubit<ProfileUpdateState> with ErrorHandling {
  final ProfileModel initialProfile;

  ProfileUpdateCubit({ProfileModel? initialProfile})
      : initialProfile = initialProfile ?? ProfileModel(),
        super(ProfileUpdateInitial(initialProfile ?? ProfileModel()));

  save() async {
    emit(ProfileUpdateLoading(state.profile));
    try {
      await fb.userCollection<UserUpdate>().userDoc()!.upset(
            UserUpdate(
                (builder) => builder.profile = state.profile.toBuilder()),
          );
      auth.currentUser!.updateDisplayName(state.profile.name);
      if (state.profile.image?.downloadUrl != null) {
        auth.currentUser!.updatePhotoURL(state.profile.image?.downloadUrl);
      }

      // analytics

      analytics.logUpdateProfile();

      if (state.profile.zip != null) {
        analytics.setPostalCodeProperty(postalCode: state.profile.zip!);
      }

      // TEST USERS
      // properties will be set to respective values when test user is activated and to null otherwise
      analytics.setTestUserProperty(
          isActiveTestUser: state.profile.testUser != null);
      analytics.setFederalStateProperty(
          federalState: state.profile.testUser?.federalState);
      analytics.setTestUserTokenProperty(token: state.profile.testUser?.token);
      // log register event in case test user is activated
      if (state.profile.testUser != null) {
        analytics.logTestUserRegistration(
          params: {
            AnalyticsParameters.token: state.profile.testUser?.token,
            AnalyticsParameters.federalState:
                state.profile.testUser?.federalState,
          },
        );
      }

      emit(ProfileUpdateSuccess(state.profile));
    } catch (e) {
      debugPrint(e.toString());
      emit(ProfileUpdateError(state.profile, e.toString()));
    }
  }

  deleteTestUserData() async {
    // TODO discuss with Moritz
    // this might not be the proper solution and more model update related changes are needed and integrated in the builder update
    // if this might be fine still to discuss if some state should be emitted
    try {
      await fb
          .userCollection<UserUpdate>()
          .userDoc()!
          .update({'profile.testUser': FieldValue.delete()});
    } catch (error) {
      debugPrint(error.toString());
    }
  }

  updateBuilder(ProfileModelBuilder builder) async {
    emit(ProfileUpdateInitial(builder.build()));
  }
}
