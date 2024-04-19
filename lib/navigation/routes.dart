import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:klimo/components/auth/cubit/auth_cubit.dart';
import 'package:klimo/components/calculator/view/calculator_dashboard.dart';
import 'package:klimo/components/calculator/view/calculator_section_page.dart';
import 'package:klimo/components/challenges/dashboard/cubit/initiative_cubit.dart';
import 'package:klimo/components/challenges/dashboard/cubit/user_challenge_list_cubit.dart';
import 'package:klimo/components/challenges/dashboard/timeframe/cubit/timeframe_cubit.dart';
import 'package:klimo/components/challenges/list/cubit/challenge_list_cubit.dart';
import 'package:klimo/components/community/cubit/user_community_cubit.dart';
import 'package:klimo/components/community/departments/switch_department_page.dart';
import 'package:klimo/components/community/switch_community_page.dart';
import 'package:klimo/components/community/teams/teams_select_page.dart';
import 'package:klimo/components/content/articles/cubit/article_cubit.dart';
import 'package:klimo/components/content/articles/cubit/articles_cubit.dart';
import 'package:klimo/components/content/projects/cubit/projects_list_cubit.dart';
import 'package:klimo/components/settings/settings_page.dart';
import 'package:klimo/utils/localisation.dart';
import 'package:klimo_datamodels/articles.dart';
import 'package:klimo_datamodels/input_model.dart';

import '../components/advent_calendar/cubit/advent_calendar_cubit.dart';
import '../components/challenges/filter/cubit/filtered_challenges_cubit.dart';
import '../components/challenges/list/challenge_list_page.dart';
import '../components/community/cubit/join_community_cubit.dart';
import '../components/community/departments/cubit/join_department_cubit.dart';
import '../components/community/teams/cubit/join_or_create_team_cubit.dart';
import '../components/community/teams/cubit/teams_cubit.dart';
import '../components/content/articles/article_view_page.dart';
import '../components/onboarding/steps/tutorial_page.dart';
import '../components/stories/story_page.dart';
import '../components/user/cubit/user_cubit.dart';
import 'bottom_navigation/cubit/bottom_navigation_cubit.dart';
import 'bottom_navigation/root_bottom_navigation.dart';

class ArticleViewRoute extends KlimoRoute {
  final String? id;
  final NewsModel? article;

  ArticleViewRoute({this.id, this.article})
      : assert(id != null || article != null),
        super(RouteSettings(name: "/article_view", arguments: {id: id}));

  @override
  Widget _build(BuildContext context) => BlocProvider(
        create: (context) => id != null
            ? (ArticleCubit(context.read<UserCommunityCubit>())..load(id))
            : ArticleCubit(context.read<UserCommunityCubit>())
          ..show(article!),
        child: const ArticleViewPage(),
      );
}

class TutorialRoute extends KlimoRoute {
  TutorialRoute() : super(const RouteSettings(name: "/tutorial_view"));

  @override
  Widget _build(BuildContext context) => const Scaffold(
        body: TutorialPage(
          isOpenedExplicitly: true,
        ),
      );
}

abstract class AuthenticatedKlimoRoute extends KlimoRoute {
  AuthenticatedKlimoRoute(RouteSettings settings) : super(settings);

  @override
  Page page(BuildContext context) {
    return MaterialPage(
      child: BlocBuilder<AuthCubit, AuthState>(
          builder: (context, state) {
            if (state.value != null) {
              return _build(context);
            } else {
              return const Scaffold(
                  body: Center(child: CircularProgressIndicator()));
            }
          },
          key: key),
    );
  }
}

class CalculatorRoute extends AuthenticatedKlimoRoute {
  CalculatorRoute() : super(const RouteSettings(name: "/calculator"));

  @override
  Widget _build(BuildContext context) => const CalculatorDashboard();
}

class CalculatorSectionRoute extends AuthenticatedKlimoRoute {
  final Section section;

  CalculatorSectionRoute(this.section)
      : super(RouteSettings(
            name: "/calculator_section",
            arguments: {"key": section.key, "title": section.title}));

  @override
  Widget _build(BuildContext context) =>
      CalculatorSectionPage(sectionModel: section);
}

class ChallengeListRoute extends AuthenticatedKlimoRoute {
  final UserChallengeListCubit userChallengeListCubit;
  final TimeframeCubit timeframeCubit;
  final InitiativeCubit initiativeCubit;

  ChallengeListRoute(
    this.userChallengeListCubit,
    this.timeframeCubit,
    this.initiativeCubit,
  ) : super(const RouteSettings(name: "/challenge_list"));

  @override
  Widget _build(BuildContext context) => MultiBlocProvider(
        providers: [
          BlocProvider.value(value: userChallengeListCubit),
          BlocProvider.value(value: timeframeCubit),
          BlocProvider.value(value: initiativeCubit),
          BlocProvider(
            create: (BuildContext context) =>
                ChallengeListCubit.fromContext(context),
          ),
          BlocProvider(
            create: (context) =>
                FilteredChallengesCubit(context.read<ChallengeListCubit>()),
          ),
        ],
        child: ChallengeListPage(
          title: context.localisation().challenge_list_page_title,
        ),
      );
}

// class DetailedChallengeRoute extends AuthenticatedKlimoRoute {
//   final String challengeId;

//   DetailedChallengeRoute(this.challengeId);

//   @override
//   String get location => "/detailed_challenge";

//   @override
//   Widget _build(BuildContext context) => BlocProvider(
//         create: (context) => ChallengeCubit()..loadChallenge(challengeId),
//         child: const ChallengeViewPage(),
//       );
// }

class HomeRoute extends AuthenticatedKlimoRoute {
  HomeRoute() : super(const RouteSettings(name: "/"));

  @override
  Widget _build(BuildContext context) => MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => TimeframeCubit(),
          ),
          BlocProvider(
              create: (context) => UserChallengeListCubit(
                  context.read<UserCubit>(),
                  context.read<TimeframeCubit>(),
                  context.read<UserCommunityCubit>())),
          BlocProvider(
              create: (context) =>
                  ArticlesCubit(context.read<UserCommunityCubit>())),
          BlocProvider(
            lazy: false,
            create: (context) => ProjectsListCubit()..loadProjects(),
          ),
          BlocProvider(
            create: (context) => BottomNavigationCubit(),
          ),
          BlocProvider(create: (context) => AdventCalendarCubit()..load()),
        ],
        child: const RootBottomNavigation(),
      );
}

abstract class KlimoRoute extends Route {
  KlimoRoute(RouteSettings settings) : super(settings: settings);

  ValueKey get key => ValueKey(settings.name);

  Page page(BuildContext context) =>
      MaterialPage(child: _build(context), key: key);

  Widget _build(BuildContext context);
}

class SettingsRoute extends AuthenticatedKlimoRoute {
  SettingsRoute() : super(const RouteSettings(name: "/settings"));

  @override
  Widget _build(BuildContext context) => const SettingsPage();
}

class StoryRoute extends AuthenticatedKlimoRoute {
  final String storyId;

  StoryRoute({required this.storyId})
      : super(const RouteSettings(name: "/story"));

  @override
  Widget _build(BuildContext context) => StoryPage(storyId: storyId);
}

class SwitchCommunityRoute extends AuthenticatedKlimoRoute {
  SwitchCommunityRoute()
      : super(const RouteSettings(name: "/switch_community"));

  @override
  Widget _build(BuildContext context) => BlocProvider(
        create: (context) => JoinCommunityCubit(
          context.read<UserCommunityCubit>(),
          context.read<UserCubit>(),
        )..loadCommunities(),
        child: const SwitchCommunityPage(),
      );
}

class SwitchDepartmentRoute extends AuthenticatedKlimoRoute {
  SwitchDepartmentRoute()
      : super(const RouteSettings(name: "/switch_department"));

  @override
  Widget _build(BuildContext context) => BlocProvider(
        create: (context) => JoinDepartmentCubit(
          context.read<UserCommunityCubit>().state!.value!,
          context.read<UserCubit>(),
        ),
        child: const SwitchDepartmentPage(),
      );
}

class SelectTeamRoute extends AuthenticatedKlimoRoute {
  SelectTeamRoute() : super(const RouteSettings(name: "/select_team"));

  @override
  Widget _build(BuildContext context) => MultiBlocProvider(
        providers: [
          BlocProvider(
              create: (context) =>
                  TeamsCubit(context.read<UserCommunityCubit>())),
          BlocProvider(
            create: (context) => JoinOrCreateTeamCubit.fromContext(context),
          ),
        ],
        child: const TeamsSelectPage(),
      );
}

class UnknownRoute extends KlimoRoute {
  UnknownRoute(RouteSettings settings) : super(settings);

  @override
  Widget _build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Unknown Route'),
      ),
    );
  }
}
