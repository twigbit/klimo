import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:klimo/components/community/common/custom_sliver_appbar.dart';
import 'package:klimo/components/community/common/header_menu.dart';
import 'package:klimo/components/community/common/leaderboard.dart';
import 'package:klimo/components/community/common/leaderboard_headline.dart';
import 'package:klimo/components/community/common/leaderbord_list_card.dart';
import 'package:klimo/components/community/departments/cubit/departments_cubit.dart';
import 'package:klimo/components/community/departments/cubit/users_department_cubit.dart';
import 'package:klimo/components/community/departments/departments_header.dart';
import 'package:klimo/utils/localisation.dart';
import 'package:klimo/utils/theme.dart';
import 'package:klimo_datamodels/community.dart';

class DepartmentsView extends StatelessWidget {
  const DepartmentsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
      floatHeaderSlivers: true,
      headerSliverBuilder: (BuildContext context, innerBoxIsScrolled) {
        return [
          BlocBuilder<UsersDepartmentCubit, UsersDepartmentState>(
            builder: (BuildContext context, UsersDepartmentState state) {
              final double expandedHeight;
              if (state != null && state.isLoaded) {
                final bool isNonEmptyState = state.value != null;
                final bool isWithoutInfo = state.value != null &&
                    (state.value?.data()?.info == null ||
                        state.value?.data()?.info != null &&
                            state.value!.data()!.info!.isEmpty);
                if (isNonEmptyState && isWithoutInfo) {
                  expandedHeight = 150;
                } else if (isNonEmptyState && !isWithoutInfo) {
                  expandedHeight = 180;
                } else {
                  expandedHeight = 200;
                }
              } else {
                expandedHeight = 200;
              }
              return CustomSliverAppBar(
                expandedHeight: expandedHeight,
                backgroundWidget: const DepartmentsHeader(),
                actionWidget: HeaderMenu(
                  onLeave: state?.value != null
                      ? () {
                          context
                              .read<UsersDepartmentCubit>()
                              .leaveDepartment();
                        }
                      : null,
                  leaveText: context.localisation().leave_department,
                ),
              );
            },
          ),
          const SliverPersistentHeader(
            pinned: true,
            delegate: LeaderboardHeadline(),
          ),
        ];
      },
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Leaderboard(
          loadItems: (context) => context.watch<DepartmentsCubit>().state,
          buildItem:
              (BuildContext _, QueryDocumentSnapshot<DepartmentModel> item) {
            final d = item.data();
            return BlocBuilder<UsersDepartmentCubit, UsersDepartmentState>(
              builder: (context, usersDepartment) {
                bool isUsersDepartment = item.id == usersDepartment?.value?.id;

                return LeaderBoardListCard(
                  groupName: d.name.tr(context),
                  groupInfo: d.info?.tr(context),
                  groupChallengeCounts: d.stats?.challenges ?? 0,
                  groupChallengeCoins: d.stats?.coins ?? 0,
                  groupEmissionsSavings: d.stats?.emissionSavings ?? 0,
                  borderColor: isUsersDepartment
                      ? context.colorScheme().primary
                      : Colors.transparent,
                );
              },
            );
          },
          buildEmptyState: (_) => Center(
            child: Text(context.localisation().community_department_empty),
          ),
        ), // TODO: useful empty state
      ),
    );
  }
}
