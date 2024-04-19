import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:klimo/components/community/cubit/user_community_cubit.dart';
import 'package:klimo/components/community/dashboard_view_button.dart';
import 'package:klimo/components/community/departments/cubit/departments_cubit.dart';
import 'package:klimo/components/community/departments/departments_view.dart';
import 'package:klimo/components/community/teams/cubit/teams_cubit.dart';
import 'package:klimo/components/community/teams/cubit/users_team_cubit.dart';
import 'package:klimo/components/community/teams/teams_view.dart';
import 'package:klimo/utils/theme.dart';
import 'package:klimo_datamodels/community.dart';
import '../../common/cubit/document_fetcher_cubit.dart';
import 'departments/cubit/users_department_cubit.dart';

class CommunityDashbaord extends StatelessWidget {
  const CommunityDashbaord({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DocumentFetcherCubit<CommunityModel>,
        DocumentFetcherState<CommunityModel>>(
      builder: (context, state) {
        // ideas was to define and pass dashboard groups here to get correct initial view within the fragment

        if (state.isLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return CommunityDashboardFragment(dashboardGroups: [
          if (state.value?.data()?.config.features.departments ?? false)
            "departments",
          if (state.value?.data()?.config.features.teams ?? false) "teams"
        ]);
      },
    );
  }
}

class CommunityDashboardFragment extends StatefulWidget {
  final List<String> dashboardGroups;
  const CommunityDashboardFragment({Key? key, required this.dashboardGroups})
      : assert(dashboardGroups.length > 0),
        super(key: key);

  @override
  State<CommunityDashboardFragment> createState() =>
      _CommunityDashboardFragmentState();
}

class _CommunityDashboardFragmentState
    extends State<CommunityDashboardFragment> {
  String selectedGroup = "";

  @override
  void initState() {
    selectedGroup = widget.dashboardGroups[0];
    super.initState();
  }

  void onGroupSelect(String group) {
    setState(() {
      selectedGroup = group;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (ctx) => DepartmentsCubit(
            ctx.read<UserCommunityCubit>(),
          ),
        ),
        BlocProvider(
          create: (ctx) => UsersDepartmentCubit(
            ctx.read<UserCommunityCubit>(),
          ),
        ),
        BlocProvider(
          create: (ctx) => TeamsCubit(
            ctx.read<UserCommunityCubit>(),
          ),
        ),
        BlocProvider(
          create: (ctx) => UsersTeamCubit(
            ctx.read<UserCommunityCubit>(),
          ),
        ),
      ],
      child: Stack(
        children: [
          _getDashboardView(),
          if (widget.dashboardGroups.length > 1)
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                margin: const EdgeInsets.all(8.0),
                padding: const EdgeInsets.all(6.0),
                decoration: BoxDecoration(
                  color: Palette.greenBackground,
                  borderRadius: BorderRadius.circular(32.0),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: widget.dashboardGroups
                      .map((group) => DashboardViewButton(
                            title: group,
                            isSelected: selectedGroup == group,
                            onSelect: () {
                              onGroupSelect(group);
                            },
                          ))
                      .toList(),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _getDashboardView() {
    if (selectedGroup == "departments") {
      return const DepartmentsView();
    } else if (selectedGroup == "teams") {
      return const TeamsView();
    } else {
      return Container();
    }
  }
}
