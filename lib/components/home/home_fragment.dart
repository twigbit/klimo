import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:klimo/common/layout/dashboard_section.dart';
import 'package:klimo/common/layout/util.dart';
import 'package:klimo/components/home/donations_info_card.dart';
import 'package:klimo/components/home/news_section.dart';
import 'package:klimo/components/home/stories_section.dart';
import 'package:klimo/navigation/bottom_navigation/cubit/bottom_navigation_cubit.dart';
import 'package:klimo/utils/localisation.dart';
import 'challenges_summary.dart';
import 'footprint_summary.dart';

class HomeFragment extends StatelessWidget {
  const HomeFragment({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          /* activate advent calendar if needed */
          // DashboardSection(
          //   title: context.localisation().dashboard_advent_calendar,
          //   child: const SizedBox(
          //     height: 190,
          //     child: AdventCalendar(),
          //   ),
          // ),
          DashboardSection(
            title: context.localisation().dashboard_footprint_headline,
            isWithInfo: true,
            infoTitle: context.localisation().footprint_comparison_info_title,
            infoMessage:
                context.localisation().footprint_comparison_info_message,
            child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: FootprintSummary()),
          ),
          DashboardSection(
            title: context.localisation().dashboard_quizes_headline,
            child: const SizedBox(height: 180, child: StoriesSection()),
          ),
          DashboardSection(
            title: context.localisation().dashboard_actions_headline,
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: ChallengesSummary(),
            ),
          ),
          DashboardSection(
            title: context.localisation().articles_projects,
            trailing: SectionHeaderButton(
                onTap: () =>
                    context.read<BottomNavigationCubit>().navigateToPage(2)),
            child: const Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 8.0,
              ),
              child: DonationsInfoCard(),
            ),
          ),
          DashboardSection(
            title: context.localisation().dashboard_news_guides_headline,
            trailing: SectionHeaderButton(
                onTap: () =>
                    context.read<BottomNavigationCubit>().navigateToPage(2)),
            child: const SizedBox(height: 180, child: NewsSection()),
          ),
        ].padded(const EdgeInsets.only(bottom: 16.0)),
      ),
    );
  }
}
