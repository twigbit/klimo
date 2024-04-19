import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:klimo/common/buttons/elevated_button.dart';
import 'package:klimo/components/community/departments/cubit/join_department_cubit.dart';
import 'package:klimo/components/community/departments/departments_fragment.dart';
import 'package:klimo/utils/localisation.dart';

class SwitchDepartmentPage extends StatelessWidget {
  const SwitchDepartmentPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          AppBar(title: Text(context.localisation().department_select_title)),
      body: Stack(
        children: [
          const Padding(
            padding: EdgeInsets.only(
              top: 24.0,
              bottom: 8.0,
              right: 8.0,
              left: 8.0,
            ),
            child: SingleChildScrollView(
              child: DepartmentsFragment(),
            ),
          ),
          BlocBuilder<JoinDepartmentCubit, JoinDepartmentState>(
            builder: (context, state) {
              return Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 24.0),
                  child: ElevatedButton(
                    onPressed: state is DepartmentsLoaded &&
                            state.selectedIndex != null
                        ? () {
                            context
                                .read<JoinDepartmentCubit>()
                                .joinDepartment();
                            Navigator.pop(context);
                          }
                        : null,
                    child: Text(
                      context.localisation().action_save,
                    ),
                  ).expanded(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
