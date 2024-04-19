import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:klimo/common/layout/util.dart';
import 'package:klimo/components/community/common/select_group_card.dart';
import 'package:klimo/components/community/departments/cubit/join_department_cubit.dart';
import 'package:klimo/components/onboarding/cubit/onboarding_cubit.dart';
import 'package:klimo/utils/localisation.dart';
import 'package:klimo/utils/theme.dart';
import 'package:klimo_datamodels/community.dart';

class DepartmentsFragment extends StatelessWidget {
  final String? title;

  const DepartmentsFragment({Key? key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<JoinDepartmentCubit, JoinDepartmentState>(
      listener: (context, state) {
        if (state is JoinDepartmentSuccess) {
          context.read<OnboardingCubit>().check();
        }
      },
      builder: (context, state) {
        if (state is DepartmentsLoaded) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.min,
            children: [
              Column(
                children: [
                  if (title != null)
                    Text(
                      title!,
                      style: context.textTheme().displayLarge,
                      textAlign: TextAlign.center,
                    ),
                  Text(
                    context.localisation().department_select_info,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
              ListView.builder(
                clipBehavior: Clip.hardEdge,
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                padding: const EdgeInsets.only(bottom: 96),
                itemCount: state.departments.length,
                itemBuilder: (context, index) {
                  DepartmentModel departmentModel =
                      state.departments[index].data();
                  return SelectGroupCard(
                      logoUrl: departmentModel.logoUrl,
                      name: departmentModel.name.tr(context),
                      onTap: () {
                        context
                            .read<JoinDepartmentCubit>()
                            .selectDepartment(index);
                      },
                      isSelected: index == state.selectedIndex);
                },
              )
            ].padded(const EdgeInsets.only(bottom: 16)),
          );
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
