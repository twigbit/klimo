import 'dart:collection';

import 'package:firebase_analytics/observer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:klimo/common/cubit/document_fetcher_cubit.dart';
import 'package:klimo/components/analytics_consent/cubit/consent_cubit.dart';
import 'package:klimo/components/auth/cubit/auth_cubit.dart';
import 'package:klimo/components/calculator/cubit/calculator_cubit.dart';
import 'package:klimo/components/calculator/information/calculator_information_cubit.dart';
import 'package:klimo/components/calculator/information/calculator_information_repository.dart';
import 'package:klimo/components/community/cubit/user_community_cubit.dart';
import 'package:klimo/components/onboarding/cubit/cubit/deletion_request_cubit.dart';
import 'package:klimo/components/onboarding/cubit/onboarding_cubit.dart';
import 'package:klimo/components/onboarding/steps/community_page.dart';
import 'package:klimo/components/onboarding/steps/consent_page.dart';
import 'package:klimo/components/onboarding/steps/department_page.dart';
import 'package:klimo/components/onboarding/steps/footprint_estimation_page.dart';
import 'package:klimo/components/onboarding/steps/footprint_page.dart';
import 'package:klimo/components/onboarding/steps/profile_page.dart';
import 'package:klimo/components/onboarding/steps/sign_in_page.dart';
import 'package:klimo/components/onboarding/steps/welcome_page.dart';
import 'package:klimo/components/user/cubit/onboarding_user_cubit.dart';
import 'package:klimo/components/user/cubit/user_cubit.dart';
import 'package:klimo/navigation/routes.dart';
import 'package:klimo/repositories/dynamiclink_repository.dart';
import 'package:klimo/utils/localisation.dart';
import 'package:klimo_datamodels/community.dart';
import 'package:provider/provider.dart';

import '../components/onboarding/steps/deletion_request_page.dart';
import '../components/onboarding/steps/tutorial_page.dart';
import '../config/firebase.dart';

extension AsPage on Widget {
  Page asPage(String key) {
    return MaterialPage(key: ValueKey(key), child: this);
  }
}

class KlimoRouterDelegate extends RouterDelegate<KlimoRoute>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<KlimoRoute> {
  @override
  final GlobalKey<NavigatorState> navigatorKey;

  final Queue<KlimoRoute> navigationStack = Queue<KlimoRoute>();

  KlimoRouterDelegate() : navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthCubit(context.read<DynamicLinkRepository>()),
          lazy: false,
        ),
        BlocProvider(
          create: (context) => UserCubit(context.read<AuthCubit>()),
        ),
        BlocProvider(
          create: (context) => UserCommunityCubit(context.read<UserCubit>()),
        ),
        ProxyProvider0<DocumentFetcherCubit<CommunityModel>>(
            update: (BuildContext context, value) => DocumentFetcherCubit(
                context
                    .watch<UserCommunityCubit>()
                    .state
                    ?.value
                    ?.data()
                    ?.community
                    .ref
                    .type<CommunityModel>())
              ..load()),
        BlocProvider(
          create: (context) => DeletionRequestCubit(context.read<AuthCubit>()),
        ),
        BlocProvider(
            create: (context) => ConsentCubit(context.read<AuthCubit>())),
        BlocProvider(
            create: (context) => OnboardingCubit(
                context.read<AuthCubit>(),
                OnboardingUserCubit(context.read<AuthCubit>()),
                context.read<ConsentCubit>(),
                context.read<UserCommunityCubit>(),
                context.read<DeletionRequestCubit>())
              ..mapDataToState()),
        BlocProvider(
          create: (context) => CalculatorCubit(
            context.read<AuthCubit>(),
            context.read<UserCommunityCubit>(),
          )..initialize(),
        ),
        ProxyProvider0<CalculatorInformationRepository>(
          update: (context, _) =>
              CalculatorInformationRepository(context.locale().languageCode),
        ),
        BlocProvider(
          create: (context) => CalculatorInformationCubit(
              context.read<CalculatorInformationRepository>())
            ..initialize(),
        ),
      ],
      child: BlocListener<AuthCubit, AuthState>(
        listenWhen: (previous, current) =>
            previous.value == null && current.value != null,
        listener: (context, state) {
          // this is a reauthentication
          navigationStack.clear();
        },
        child: BlocConsumer<OnboardingCubit, OnboardingState>(
          listener: (context, state) {
            if (state is OnboardingStepFootprint) {
              context.read<CalculatorCubit>().updateCubit.reset();
            }
          },
          builder: (context, state) {
            return Navigator(
                key: navigatorKey,
                observers: [
                  VibrationObserver(),
                  FirebaseAnalyticsObserver(analytics: analytics)
                ],
                pages: [
                  const Scaffold(
                    body: Center(
                      child: CircularProgressIndicator(),
                    ),
                  ).asPage('loading'),
                  if (state is OnboardingDone) ...[
                    HomeRoute().page(context),
                    ...navigationStack
                        .map((KlimoRoute e) => e.page(context))
                        .toList()
                  ] else ...[
                    if (state is OnboardingStepWelcome)
                      const WelcomePage().asPage('onboarding_welcome'),
                    if (state is OnboardingStepTutorial)
                      const TutorialPage().asPage('onboarding_tutorial'),
                    if (state is OnboardingStepAuth)
                      const SignInPage().asPage('onboarding_sign_in'),
                    if (state is OnboardingStepConsent)
                      const ConsentPage().asPage('onboarding_consent'),
                    if (state is OnboardingStepCommunity)
                      const CommunityPage().asPage('onboarding_community'),
                    if (state is OnboardingStepDepartment)
                      const DepartmentPage().asPage('onboarding_department'),
                    if (state is OnboardingStepDeletionRequestPending)
                      const DeletionRequestPage()
                          .asPage('onboarding_deletion_request'),
                    if (state is OnboardingStepProfile)
                      const ProfilePage().asPage('onboarding_profile'),
                    if (state is OnboardingStepFootprint)
                      const FootprintPage().asPage('onboarding_footprint'),
                    if (state is OnboardingStepCalculatingFootprint)
                      const FootprintEstimationPage()
                          .asPage('onboarding_footprint_calculation'),
                  ]
                ],
                onPopPage: (route, result) {
                  if (!route.didPop(result)) {
                    return false;
                  }
                  if (state is OnboardingDone && navigationStack.isNotEmpty) {
                    navigationStack.removeLast();
                  }
                  notifyListeners();
                  return true;
                });
          },
        ),
      ),
    );
  }

  @override
  Future<void> setNewRoutePath(KlimoRoute configuration) async {
    navigationStack.add(configuration);
    notifyListeners();
  }
}

class FadeAnimationPage extends Page {
  final Widget child;

  const FadeAnimationPage({required LocalKey key, required this.child})
      : super(key: key);

  @override
  Route createRoute(BuildContext context) {
    return PageRouteBuilder(
      settings: this,
      pageBuilder: (context, animation, animation2) {
        var curveTween = CurveTween(curve: Curves.easeIn);
        return FadeTransition(
          opacity: animation.drive(curveTween),
          child: child,
        );
      },
    );
  }
}

class VibrationObserver extends RouteObserver<PageRoute<dynamic>> {
  @override
  void didPush(Route route, Route? previousRoute) {
    if (route is! KlimoRoute) HapticFeedback.mediumImpact();
    super.didPush(route, previousRoute);
  }
}

class KlimoRouteInformationParser extends RouteInformationParser<KlimoRoute> {
  @override
  Future<KlimoRoute> parseRouteInformation(
      RouteInformation routeInformation) async {
    final uri = Uri.parse(routeInformation.uri.path);

    // Handle '/'
    if (uri.pathSegments.isEmpty) {
      return HomeRoute();
      //uncomment for testing Onboarding
      //return OnboardingRoute();
    }

    // Handle unknown routes
    return HomeRoute();
  }

  @override
  RouteInformation restoreRouteInformation(KlimoRoute configuration) {
    return RouteInformation(uri: Uri.parse(configuration.settings.name ?? ""));
  }
}
