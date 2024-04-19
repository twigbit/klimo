import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:klimo/common/buttons/elevated_button.dart';
import 'package:klimo/common/dialogs/confirmation_dialog.dart';
import 'package:klimo/common/dialogs/error_snackbar.dart';
import 'package:klimo/components/images/cubit/image_upload_cubit.dart';
import 'package:klimo/components/onboarding/cubit/onboarding_cubit.dart';
import 'package:klimo/components/onboarding/onboarding_layout.dart';
import 'package:klimo/components/profile/update/cubit/profile_update_cubit.dart';
import 'package:klimo/config/analytics.dart';
import 'package:klimo/config/firebase.dart';
import 'package:klimo/utils/localisation.dart';
import 'package:klimo_datamodels/user.dart';
import '../../../config/constants.dart';
import '../../profile/profile_edit_fragment.dart';
import '../../user/cubit/user_cubit.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ProfileUpdateCubit(),
        ),
        BlocProvider(
          create: (context) => ImageUploadCubit(context.read<UserCubit>()),
        ),
      ],
      child: BlocConsumer<ImageUploadCubit, ImageUploadState>(
        listener: (context, state) {
          if (state is ImageUploadCompleted) {
            context.read<ProfileUpdateCubit>().updateBuilder(
                context.read<ProfileUpdateCubit>().state.profile.toBuilder()
                  ..image = state.image?.toBuilder());
          }
        },
        builder: (context, imageUploadState) {
          return BlocConsumer<ProfileUpdateCubit, ProfileUpdateState>(
            listener: (context, state) {
              if (state is ProfileUpdateError) {
                context.showErrorMessage(
                    "${context.localisation().action_error}: ${state.message}");
              }
              if (state is ProfileUpdateSuccess) {
                context.read<OnboardingCubit>().mapDataToState();
              }
            },
            builder: (context, profileUpdateState) {
              final bool didUpdateProfile =
                  profileUpdateState.profile != ProfileModel();
              bool isActiveTestUser =
                  profileUpdateState.profile.testUser != null;
              final String? userAccountName = auth.currentUser?.displayName;
              return OnboardingLayout(
                headerAction: !didUpdateProfile ||
                        (!isActiveTestUser &&
                            (profileUpdateState.profile.name?.isEmpty ??
                                true) &&
                            (profileUpdateState.profile.zip?.isEmpty ?? true) &&
                            (profileUpdateState.profile.bio?.isEmpty ?? true))
                    ? TextButton(
                        onPressed: () {
                          showDialog<void>(
                            context: context,
                            builder: (BuildContext dialogContext) {
                              return ConfirmationDialog(
                                title: context
                                    .localisation()
                                    .create_profile_skip_title,
                                content: context
                                    .localisation()
                                    .create_profile_skip_message,
                                onConfirm: () {
                                  Navigator.of(dialogContext).pop();
                                  context.read<ProfileUpdateCubit>().save();

                                  // analytics
                                  analytics.logOnboardingAction(
                                      action:
                                          AnalyticsValues.skipProfileCreation);
                                },
                              );
                            },
                          );
                        },
                        child: Text(context.localisation().action_skip),
                      )
                    : null,
                title: context.localisation().create_profile_title,
                progress: 5 / 7,
                decoration: profileUpdateState is ProfileUpdateLoading
                    ? OnboardingLayoutDecoration.loading
                    : null,
                primaryButton: ElevatedButton(
                  onPressed: imageUploadState is ImageUploadLoading ||
                          (!didUpdateProfile ||
                                  isActiveTestUser &&
                                      ((profileUpdateState
                                                      .profile.testUser?.password ??
                                                  '')
                                              .isEmpty ||
                                          (profileUpdateState.profile.testUser
                                                      ?.token ??
                                                  '')
                                              .isEmpty ||
                                          (profileUpdateState
                                                  .profile.testUser?.password !=
                                              testUsersPassword) ||
                                          (profileUpdateState.profile.testUser
                                                      ?.federalState ??
                                                  '')
                                              .isEmpty)) &&
                              userAccountName == null
                      ? null
                      : () {
                          // if name possibly given by Google / Apple credentials and users save at this step without editing the name, update users' profile name respectively
                          if (userAccountName != null &&
                              (profileUpdateState.profile.name ?? '').isEmpty) {
                            context.read<ProfileUpdateCubit>().updateBuilder(
                                profileUpdateState.profile.toBuilder()
                                  ..name = userAccountName);
                          }
                          context.read<ProfileUpdateCubit>().save();
                        },
                  child: Text(context.localisation().action_save),
                ).expanded(),
                child: const Padding(
                  padding: EdgeInsets.only(bottom: 32.0),
                  child: ProfileEditFragment(),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
