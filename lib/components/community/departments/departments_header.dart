import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:klimo/components/community/common/group_empty_header.dart';
import 'package:klimo/components/community/common/dashboard_group_header.dart';
import 'package:klimo/components/community/departments/cubit/users_department_cubit.dart';
import 'package:klimo/navigation/routes.dart';
import 'package:klimo/utils/localisation.dart';

class DepartmentsHeader extends StatelessWidget {
  const DepartmentsHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UsersDepartmentCubit, UsersDepartmentState>(
      builder: (context, usersDepartment) {
        if (usersDepartment != null && usersDepartment.isLoaded) {
          var usersDepartmentData = usersDepartment.value?.data();
          return usersDepartment.value == null
              ? GroupEmptyHeader(
                  title:
                      context.localisation().community_users_department_empty,
                  primaryActionButton: ElevatedButton(
                    child: Text(
                        context.localisation().community_department_select),
                    onPressed: () {
                      Router.of(context).routerDelegate.setNewRoutePath(
                            SwitchDepartmentRoute(),
                          );
                    },
                  ),
                )
              : DashboardGroupHeader(
                  title: context.localisation().community_users_department,
                  groupName: usersDepartmentData?.name.tr(context) ?? "",
                  groupInfo: usersDepartmentData?.info?.tr(context) ?? "",
                  groupChallengeCounts:
                      usersDepartmentData?.stats?.challenges ?? 0,
                  groupChallengeCoins: usersDepartmentData?.stats?.coins ?? 0,
                  groupEmissionSavings:
                      usersDepartmentData?.stats?.emissionSavings ?? 0,
                );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
