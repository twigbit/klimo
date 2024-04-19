import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:klimo/common/layout/klimo_bottom_sheet.dart';
import 'package:klimo/components/images/cubit/image_upload_cubit.dart';
import 'package:klimo/config/constants.dart';
import 'package:klimo/utils/localisation.dart';
import 'package:klimo/utils/theme.dart';

import 'profile_edit_fragment.dart';
import 'update/cubit/profile_update_cubit.dart';

class ProfileEditBottomSheet extends StatelessWidget {
  const ProfileEditBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        KlimoBottomSheet(
          header: KlimoBottomSheetHeader(
            title: context.localisation().settings_profile_edit,
          ),
          body: Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewPadding.bottom),
            child: const ProfileEditFragment(),
          ),
        ),
        Positioned(
          bottom: 48,
          right: 24,
          child: BlocConsumer<ProfileUpdateCubit, ProfileUpdateState>(
            listener: (context, state) {
              if (state is ProfileUpdateSuccess) {
                Navigator.pop(context);
              }
            },
            builder: (context, state) {
              if (state is ProfileUpdateLoading ||
                  context.watch<ImageUploadCubit>().state
                      is ImageUploadLoading) {
                return const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: SizedBox(
                    height: 24,
                    width: 24,
                    child: CircularProgressIndicator(),
                  ),
                );
              } else {
                bool isActiveTestUser = state.profile.testUser != null;
                return FloatingActionButton(
                  onPressed: (context.watch<ImageUploadCubit>().state
                              is ImageUploadLoading) ||
                          isActiveTestUser &&
                              ((state.profile.testUser?.password ?? '').isEmpty ||
                                  (state.profile.testUser?.token ?? '')
                                      .isEmpty ||
                                  (state.profile.testUser?.password !=
                                      testUsersPassword) ||
                                  (state.profile.testUser?.federalState ?? '')
                                      .isEmpty)
                      ? null
                      : () {
                          context.read<ProfileUpdateCubit>().save();
                        },
                  child: const Icon(
                    Icons.check,
                    color: Palette.white,
                  ),
                );
              }
            },
          ),
        ),
      ],
    );
  }
}
