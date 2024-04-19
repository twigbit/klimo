import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:klimo/common/dialogs/confirmation_dialog.dart';
import 'package:klimo/common/layout/logo_list.dart';
import 'package:klimo/utils/launch_url.dart';
import 'package:klimo/components/auth/cubit/auth_cubit.dart';
import 'package:klimo/components/profile/profile_edit_bottom_sheet.dart';
import 'package:klimo/components/settings/settings_row.dart';
import 'package:klimo/components/settings/settings_section_header.dart';
import 'package:klimo/config/analytics.dart';
import 'package:klimo/config/constants.dart';
import 'package:klimo/utils/localisation.dart';
import 'package:klimo/utils/theme.dart';
import 'package:klimo/navigation/routes.dart';
import 'package:klimo_datamodels/user.dart';
import 'package:share_plus/share_plus.dart';
import 'analytics_consent_switch.dart';
import 'package:klimo/common/layout/klimo_bottom_sheet.dart';
import 'package:klimo/common/images/storage_image.dart';
import 'package:klimo/components/images/cubit/image_upload_cubit.dart';
import 'package:klimo/components/profile/update/cubit/profile_update_cubit.dart';
import 'package:klimo/components/user/cubit/user_cubit.dart';
import '../../config/firebase.dart';

class DividerComponent extends StatelessWidget {
  const DividerComponent({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
      child: Divider(height: 1),
    );
  }
}

class ProfileSection extends StatelessWidget {
  const ProfileSection({Key? key}) : super(key: key);

  _openProfileEdit(BuildContext context) => showKlimoModalBottomSheet(
        context: context,
        builder: (modalContext) {
          return MultiBlocProvider(providers: [
            BlocProvider<ProfileUpdateCubit>(
              create: (context) => ProfileUpdateCubit(
                  initialProfile:
                      context.read<UserCubit>().state?.value?.data()?.profile),
            ),
            BlocProvider(
                create: (context) =>
                    ImageUploadCubit(context.read<UserCubit>()))
          ], child: const ProfileEditBottomSheet());
        },
      );

  @override
  Widget build(BuildContext context) {
    AuthState state = context.watch<AuthCubit>().state;
    if (state.value != null) {
      ProfileModel? profile =
          context.watch<UserCubit>().state?.value?.data()?.profile;
      return Column(
        children: [
          SettingsSectionHeader(
              text: context.localisation().settings_profile_headline),
          GestureDetector(
            onTap: () => _openProfileEdit(context),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 12.0,
                horizontal: 8.0,
              ),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: SizedBox(
                      height: 64,
                      width: 64,
                      child: profile?.image != null
                          ? ClipOval(
                              child: StorageImage.thumb(
                                profile!.image!,
                              ),
                            )
                          : const CircleAvatar(
                              backgroundColor: Palette.primary,
                              child: Icon(
                                Icons.person,
                                color: Palette.white,
                                size: 32,
                              )),
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          (profile?.name?.isEmpty ?? true)
                              ? context.localisation().profile_name_unknown
                              : profile!.name!,
                          style: context.textTheme().displaySmall,
                        ),
                        if (auth.currentUser?.email != null)
                          Padding(
                            padding: const EdgeInsets.only(top: 4.0),
                            child: Text(
                              "${context.localisation().profile_email}: ${auth.currentUser?.email}",
                              style: context.textTheme().bodySmall,
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          SettingsRow(
            icon: FontAwesomeIcons.edit,
            text: context.localisation().settings_profile_edit,
            onTap: () => _openProfileEdit(context),
          ),
        ],
      );
    } else {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
  }
}

class CommunitySection extends StatelessWidget {
  const CommunitySection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SettingsSectionHeader(
          text: context.localisation().settings_communities_headline,
        ),
        SettingsRow(
          icon: FontAwesomeIcons.users,
          text: context.localisation().settings_join_switch_community,
          onTap: () {
            Router.of(context).routerDelegate.setNewRoutePath(
                  SwitchCommunityRoute(),
                );
          },
        ),
        SettingsRow(
          icon: FontAwesomeIcons.commentDots,
          text: context.localisation().settings_feedback,
          onTap: () {
            openUrl(feedbackLink);
            // analytics
            analytics.logSettingsAction(action: AnalyticsValues.submitAction);
          },
        ),
        SettingsRow(
          icon: FontAwesomeIcons.handshake,
          text: context.localisation().settings_action,
          onTap: () {
            openUrl(actionLink);
            // analytics
            analytics.logSettingsAction(action: AnalyticsValues.submitAction);
          },
        ),
        SettingsRow(
          icon: FontAwesomeIcons.userFriends,
          text: context.localisation().settings_share,
          onTap: () {
            Share.share("${context.localisation().share_message} $dynamicLink");

            // analytics
            analytics.logSettingsAction(action: AnalyticsValues.inviteFriends);
          },
        ),
      ],
    );
  }
}

class GeneralSection extends StatelessWidget {
  const GeneralSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SettingsSectionHeader(
            text: context.localisation().settings_general_headline),
        SettingsRow(
          icon: FontAwesomeIcons.chalkboardTeacher,
          text: context.localisation().settings_tutorial,
          onTap: () => Router.of(context).routerDelegate.setNewRoutePath(
                TutorialRoute(),
              ),
        ),
        SettingsRow(
          icon: FontAwesomeIcons.questionCircle,
          text: context.localisation().settings_faq,
          onTap: () {
            openUrl(faqLink);
            // analytics
            analytics.logSettingsAction(action: AnalyticsValues.openFAQ);
          },
        ),
        SettingsRow(
          icon: FontAwesomeIcons.signOutAlt,
          text: context.localisation().sign_out_title,
          onTap: () => showDialog(
            context: context,
            builder: (innerContext) => ConfirmationDialog(
              title: context.localisation().sign_out_title,
              content: context.localisation().sign_out_message,
              onConfirm: () async {
                context.read<AuthCubit>().signOut();
                // analytics
                analytics.logSettingsAction(action: AnalyticsValues.signOut);
                Navigator.pop(context);
              },
            ),
          ),
        ),
      ],
    );
  }
}

class ApprovalSection extends StatelessWidget {
  const ApprovalSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SettingsSectionHeader(
            text: context.localisation().settings_approvals_headline),
        SettingsRow(
          icon: FontAwesomeIcons.book,
          text: context.localisation().settings_terms_of_use,
          onTap: () {
            openUrl(termsOfServiceLink);

            //analytics
            analytics.logSettingsAction(
                action: AnalyticsValues.openTermsOfServices);
          },
        ),
        SettingsRow(
          icon: FontAwesomeIcons.shieldAlt,
          text: context.localisation().settings_privacy_policy,
          onTap: () {
            openUrl(privacyPolicyLink);

            // analytics
            analytics.logSettingsAction(
                action: AnalyticsValues.openPrivacyPolicies);
          },
        ),
        SettingsRow(
          icon: FontAwesomeIcons.vectorSquare,
          text: context.localisation().settings_share_data,
          description: context.localisation().settings_share_data_description,
          trailing: const AnalyticsConsentSwitch(),
        ),
        SettingsRow(
          icon: Icons.delete,
          text: context.localisation().delete_account_title,
          color: Palette.error,
          onTap: () => showDialog(
            context: context,
            builder: (innerContext) => ConfirmationDialog(
              title: context.localisation().delete_account_title,
              content: context.localisation().delete_account_message,
              onConfirm: () async {
                await fb
                    .deletionRequestCollection<DeletionRequestUpdate>()
                    .doc()
                    .upset(DeletionRequestUpdate(
                      (b) => b
                        ..timestamp = FieldValue.serverTimestamp()
                        ..userRef = context.read<AuthCubit>().state.value!.ref,
                    ));

                // analytics
                analytics.logSettingsAction(
                    action: AnalyticsValues.sendAccountDeletionRequest);
              },
            ),
          ),
        ),
      ],
    );
  }
}

class MoreSection extends StatelessWidget {
  const MoreSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SettingsSectionHeader(
            text: context.localisation().settings_more_headline),
        SettingsRow(
            icon: FontAwesomeIcons.infoCircle,
            text: context.localisation().settings_about_klimo,
            onTap: () {
              openUrl(aboutUsLink);
              // analytics
              analytics.logSettingsAction(action: AnalyticsValues.openAboutUs);
            }),
        SettingsRow(
          icon: FontAwesomeIcons.envelope,
          text: context.localisation().settings_contact,
          onTap: () {
            openUrl(mailLink);

            // analytics
            analytics.logSettingsAction(
                action: AnalyticsValues.useEmailContact);
          },
        ),
        SettingsRow(
          icon: FontAwesomeIcons.instagram,
          text: 'Instagram',
          onTap: () {
            openUrl(instagramLink);
            // analytics
            analytics.logSettingsAction(action: AnalyticsValues.openInstagram);
          },
        ),
      ],
    );
  }
}

class PartnerSection extends StatelessWidget {
  const PartnerSection({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SettingsSectionHeader(text: context.localisation().settings_partner),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: LogoList(),
        ),
      ],
    );
  }
}
