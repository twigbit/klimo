import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:klimo/common/dialogs/confirmation_dialog.dart';
import 'package:klimo/common/layout/util.dart';
import 'package:klimo/components/profile/update/cubit/profile_update_cubit.dart';
import 'package:klimo/config/constants.dart';
import 'package:klimo/utils/localisation.dart';
import 'package:klimo/utils/theme.dart';
import 'package:klimo_datamodels/user.dart';

class TestUsersInfo extends StatelessWidget {
  const TestUsersInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileUpdateCubit, ProfileUpdateState>(
      builder: (context, profileState) {
        bool isTestUser = profileState.profile.testUser != null;
        bool isTestUserWithData = profileState.profile.testUser != null &&
            profileState.profile.testUser?.password != null;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Text(
                      context.localisation().profile_test_user_activate,
                      style: context.textTheme().headlineSmall,
                    ),
                  ),
                  Switch(
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    activeColor: Palette.primary,
                    value: isTestUser,
                    onChanged: (bool value) {
                      if (!value && isTestUserWithData) {
                        showDialog(
                          context: context,
                          builder: (innerContext) => ConfirmationDialog(
                            title: context
                                .localisation()
                                .profile_test_user_deactivate,
                            content: context
                                .localisation()
                                .profile_test_user_deactivate_message,
                            onConfirm: () {
                              // set data model property to null so that analytics are updated respectively when save the profile update
                              context.read<ProfileUpdateCubit>().updateBuilder(
                                  profileState.profile.toBuilder()
                                    ..testUser = null);
                              // delete testUser data from user doc in Firestore
                              context
                                  .read<ProfileUpdateCubit>()
                                  .deleteTestUserData();
                              Navigator.pop(context);
                            },
                          ),
                        );
                      } else {
                        context.read<ProfileUpdateCubit>().updateBuilder(
                            profileState.profile.toBuilder()
                              ..testUser =
                                  value ? TestUserModelBuilder() : null);
                      }
                    },
                  ),
                ],
              ),
            ),
            if (isTestUser)
              TextFormField(
                initialValue: profileState.profile.testUser?.password,
                enabled: (profileState is! ProfileUpdateLoading),
                onChanged: (String value) {
                  if (isTestUser) {
                    context.read<ProfileUpdateCubit>().updateBuilder(
                        profileState.profile.toBuilder()
                          ..testUser.password = value);
                  }
                },
                decoration: InputDecoration(
                  labelText:
                      "${context.localisation().profile_test_user_password}*",
                ),
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return context
                        .localisation()
                        .profile_test_user_password_empty;
                  } else if (value != testUsersPassword) {
                    return context
                        .localisation()
                        .profile_test_user_password_wrong;
                  } else {
                    return null;
                  }
                },
              ),
            if (isTestUser)
              TextFormField(
                initialValue: profileState.profile.testUser?.token,
                enabled: (profileState is! ProfileUpdateLoading),
                onChanged: (String value) {
                  if (isTestUser) {
                    context.read<ProfileUpdateCubit>().updateBuilder(
                        profileState.profile.toBuilder()
                          ..testUser.token = value);
                  }
                },
                decoration: InputDecoration(
                  labelText:
                      "${context.localisation().profile_test_user_token}*",
                ),
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return context
                        .localisation()
                        .profile_test_user_token_validate;
                  } else {
                    return null;
                  }
                },
              ),
            if (isTestUser)
              DropdownButtonFormField<String>(
                enableFeedback: (profileState is! ProfileUpdateLoading),
                hint: Text(
                    context.localisation().profile_test_user_federal_state),
                value: profileState.profile.testUser?.federalState,
                items: federalStates
                    .map((item) => DropdownMenuItem(
                          value: item,
                          child: Text(item),
                        ))
                    .toList(),
                menuMaxHeight: 400,
                onChanged: (String? value) {
                  if (isTestUser) {
                    context.read<ProfileUpdateCubit>().updateBuilder(
                        profileState.profile.toBuilder()
                          ..testUser.federalState = value);
                  }
                },
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return context
                        .localisation()
                        .profile_test_user_federal_state_validate;
                  } else {
                    return null;
                  }
                },
              ),
            if (isTestUser)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  "*${context.localisation().profile_mandatory_fields_hint}",
                  style: context.textTheme().bodySmall,
                ),
              ),
          ].padded(const EdgeInsets.only(bottom: 16)),
        );
      },
    );
  }
}

// avoid translation to keep grouping of test users' less complex
List<String> federalStates = [
  "",
  "Baden-Württemberg",
  "Bayern",
  "Berlin",
  "Brandenburg",
  "Bremen",
  "Hamburg",
  "Hessen",
  "Mecklenburg-Vorpommern",
  "Niedersachsen",
  "Nordrhein-Westfalen",
  "Rheinland-Pfalz",
  "Saarland",
  "Sachsen",
  "Sachsen-Anhalt",
  "Schleswig-Holstein",
  "Thüringen",
];
