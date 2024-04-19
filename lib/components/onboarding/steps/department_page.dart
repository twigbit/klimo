import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:klimo/common/buttons/elevated_button.dart';
import 'package:klimo/components/community/cubit/user_community_cubit.dart';
import 'package:klimo/components/community/departments/cubit/join_department_cubit.dart';
import 'package:klimo/components/community/departments/departments_fragment.dart';
import 'package:klimo/components/onboarding/cubit/onboarding_cubit.dart';
import 'package:klimo/components/onboarding/onboarding_layout.dart';
import 'package:klimo/components/user/cubit/user_cubit.dart';
import 'package:klimo/config/analytics.dart';
import 'package:klimo/utils/localisation.dart';

import '../../../config/firebase.dart';

class DepartmentPage extends StatelessWidget {
  const DepartmentPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => JoinDepartmentCubit(
        context.read<UserCommunityCubit>().state!.value!,
        context.read<UserCubit>(),
      ),
      child: BlocConsumer<JoinDepartmentCubit, JoinDepartmentState>(
        listener: (BuildContext context, Object? state) {
          if (state is JoinDepartmentSuccess) {
            context.read<OnboardingCubit>().next();
          }
        },
        builder: (BuildContext context, state) {
          return OnboardingLayout(
            headerAction: TextButton(
                onPressed: () {
                  context.read<JoinDepartmentCubit>().selectDepartment(null);
                  context.read<JoinDepartmentCubit>().joinDepartment();

                  // analytics
                  analytics.logOnboardingAction(
                      action: AnalyticsValues.skipDepartmentSelection);
                },
                child: Text(context.localisation().action_skip)),
            primaryButton: ElevatedButton(
              onPressed:
                  state is DepartmentsLoaded && state.selectedIndex != null
                      ? () {
                          context.read<JoinDepartmentCubit>().joinDepartment();

                          // analytics
                          analytics.logOnboardingAction(
                              action: AnalyticsValues.joinDepartment);
                        }
                      : null,
              child: Text(context.localisation().action_save),
            ).expanded(),
            progress: 4 / 7,
            decoration: state is JoinDepartmentLoading
                ? OnboardingLayoutDecoration.loading
                : state is JoinDepartmentSuccess
                    ? OnboardingLayoutDecoration.success
                    : null,
            title: context.localisation().department_select_title,
            child: const DepartmentsFragment(),
          );
        },
      ),
    );
  }
}
