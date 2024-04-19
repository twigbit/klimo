import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:klimo/components/community/community_dashboard.dart';
import 'package:klimo/components/community/cubit/user_community_cubit.dart';
import 'package:klimo/components/content/content_dashboard.dart';
import 'package:klimo/components/home/home_fragment.dart';
import 'package:klimo/components/user/cubit/user_cubit.dart';
import 'package:klimo/config/constants.dart';
import 'package:klimo/config/firebase.dart';
import 'package:klimo/navigation/routes.dart';
import 'package:klimo/utils/loading.dart';
import 'package:klimo/utils/localisation.dart';
import 'package:klimo/utils/theme.dart';
import '../../components/challenges/dashboard/challenge_dashboard.dart';
import '../../components/rewards/rewards_dashboard.dart';
import 'cubit/bottom_navigation_cubit.dart';

class RootBottomNavigation extends StatelessWidget {
  const RootBottomNavigation({Key? key}) : super(key: key);

  final List<Widget> _bodyWidgets = const <Widget>[
    HomeFragment(),
    ChallengeDashboard(),
    ContentDashboard(),
    CommunityDashbaord(),
    RewardsDashboard(),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BottomNavigationCubit, int>(
      builder: (context, state) {
        return WillPopScope(
          onWillPop: () async {
            // disable system back navigation only for iOS devices
            if (Platform.isIOS) {
              return false;
            } else {
              return true;
            }
          },
          child: Scaffold(
            appBar: getAppBarContent(context),
            body: _bodyWidgets.elementAt(state),
            bottomNavigationBar: BottomNavigationBar(
              elevation: 12,
              showSelectedLabels: false,
              showUnselectedLabels: false,
              type: BottomNavigationBarType.fixed,
              currentIndex: context.read<BottomNavigationCubit>().state,
              onTap: (int index) {
                context.read<BottomNavigationCubit>().navigateToPage(index);
                // TODO check this since different views are NOT different routes
                analytics.setCurrentScreen(screenName: getScreenName(index));
              },
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(
                    FontAwesomeIcons.home,
                  ),
                  label: homeTab,
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    FontAwesomeIcons.cubes,
                  ),
                  label: challengesTab,
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    FontAwesomeIcons.bars,
                  ),
                  label: feedTab,
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    FontAwesomeIcons.users,
                  ),
                  label: communityTab,
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    FontAwesomeIcons.gift,
                  ),
                  label: rewardsTab,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  String getScreenName(int index) {
    switch (index) {
      case 0:
        return homeTab;
      case 1:
        return challengesTab;
      case 2:
        return feedTab;
      case 3:
        return communityTab;
      default:
        return "";
    }
  }

  getAppBarContent(BuildContext context) {
    int selectedTab = context.read<BottomNavigationCubit>().state;
    if (selectedTab == 0) {
      return AppBar(
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(0),
          child: Padding(
            padding: const EdgeInsets.only(
              left: 16.0,
              bottom: 16.0,
            ),
            child: BlocBuilder<UserCommunityCubit, UserCommunityState>(
              builder: (context, communityRef) {
                if (communityRef != null &&
                    communityRef.isLoaded &&
                    communityRef.value?.data() != null) {
                  // allow switching communtity also when clicking on the name here
                  return GestureDetector(
                    onTap: () {
                      Router.of(context)
                          .routerDelegate
                          .setNewRoutePath(SwitchCommunityRoute());
                    },
                    child: Row(
                      children: [
                        const Icon(Icons.group),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  communityRef
                                      .data()!
                                      .community
                                      .name
                                      .tr(context),
                                  style: context.textTheme().bodyLarge,
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(),
                      ],
                    ),
                  );
                } else {
                  return Container();
                }
              },
            ),
          ),
        ),
        automaticallyImplyLeading: false,
        toolbarHeight: 90,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              "Hey ${context.watch<UserCubit>().state?.data()?.profile?.name ?? context.localisation().user_unknown_name}",
              style: context.textTheme().displayMedium,
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: SvgPicture.asset('assets/icons/user.svg'),
            onPressed: () {
              Router.of(context).routerDelegate.setNewRoutePath(
                    SettingsRoute(),
                  );
            },
          ),
        ],
      );
    } else if (selectedTab == 2) {
      return AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 80,
        title: SvgPicture.asset(
          logo,
          height: 48,
        ),
      );
    } else {
      return null;
    }
  }
}
