import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:klimo/common/layout/util.dart';
import 'package:klimo/components/images/cubit/image_upload_cubit.dart';
import 'package:klimo/components/profile/profile_image_component.dart';
import 'package:klimo/components/profile/test_users_info.dart';
import 'package:klimo/config/firebase.dart';
import 'package:klimo/utils/localisation.dart';
import 'update/cubit/profile_update_cubit.dart';

class ProfileEditFragment extends StatelessWidget {
  const ProfileEditFragment({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<ImageUploadCubit, ImageUploadState>(
      listener: (context, state) {
        if (state is ImageUploadCompleted) {
          context.read<ProfileUpdateCubit>().updateBuilder(
              context.read<ProfileUpdateCubit>().state.profile.toBuilder()
                ..image = state.image?.toBuilder());
        }
      },
      child: BlocBuilder<ProfileUpdateCubit, ProfileUpdateState>(
        builder: (context, profileState) {
          return Column(
            children: [
              SizedBox(
                  height: 200,
                  child: ProfileImageComponent(
                      profileImage: profileState.profile.image)),
              TextFormField(
                initialValue: profileState.profile.name ??
                    auth.currentUser?.displayName ??
                    "",
                enabled: (profileState is! ProfileUpdateLoading),
                onChanged: (value) {
                  context.read<ProfileUpdateCubit>().updateBuilder(
                      profileState.profile.toBuilder()..name = value);
                },
                decoration: InputDecoration(
                  labelText: context.localisation().profile_name,
                ),
              ),
              TextFormField(
                initialValue: profileState.profile.zip,
                enabled: (profileState is! ProfileUpdateLoading),
                decoration: InputDecoration(
                  labelText: context.localisation().profile_postal_code,
                ),
                keyboardType: TextInputType.number,
                validator: (value) =>
                    value != null && value.isNotEmpty && value.length != 5
                        ? context.localisation().profile_incorrect_postal_code
                        : null,
                maxLength: 5,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly
                ],
                autovalidateMode: AutovalidateMode.onUserInteraction,
                onChanged: (String value) {
                  context.read<ProfileUpdateCubit>().updateBuilder(
                      profileState.profile.toBuilder()..zip = value);
                },
              ),
              const TestUsersInfo(),
              TextFormField(
                initialValue: profileState.profile.bio,
                enabled: (profileState is! ProfileUpdateLoading),
                minLines: 2,
                maxLines: 4,
                decoration: InputDecoration(
                  labelText: context.localisation().profile_about_me,
                ),
                onChanged: (String value) {
                  context.read<ProfileUpdateCubit>().updateBuilder(
                      profileState.profile.toBuilder()..bio = value);
                },
              ),
            ].padded(const EdgeInsets.only(bottom: 16)),
          );
        },
      ),
    );
  }
}
