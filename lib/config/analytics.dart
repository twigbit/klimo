//

import 'package:firebase_analytics/firebase_analytics.dart';
import 'firebase.dart';

// ************************************
// USER INTERACTION EVENTS
// ************************************
extension WithInteractionLogging1<T, V> on V Function(T) {
  V Function(T) logInteraction({Map<String, dynamic>? params}) => (T input) {
        params?.removeWhere((k, v) => v == null);
        if (params != null && params.isNotEmpty) {
          analytics.logEvent(
            name: AnalyticsEvents.userInteraction,
            parameters: params,
          );
          return this(input);
        } else {
          analytics.logEvent(name: AnalyticsEvents.userInteraction);
          return this(input);
        }
      };
}

extension WithInteractionLogging0<T> on T Function() {
  T Function() logInteraction({Map<String, dynamic>? params}) => () {
        params?.removeWhere((k, v) => v == null);
        if (params != null && params.isNotEmpty) {
          analytics.logEvent(
            name: AnalyticsEvents.userInteraction,
            parameters: params,
          );
          return this();
        } else {
          analytics.logEvent(name: AnalyticsEvents.userInteraction);
          return this();
        }
      };
}

extension WithCustomAnalytics on FirebaseAnalytics {
  // ************************************
  // USER PROPERTIES
  // ************************************

  setAnalyticsUsageProperty({bool? isPermitted}) async {
    if (isPermitted != null) {
      await setUserProperty(
        name: UserProperties.analyticsUsage,
        value: isPermitted ? 'permitted' : 'denied',
      );
    }
  }

  setTargetGroupUserProperty(int targetId) async {
    await setUserProperty(
      name: UserProperties.targetId,
      value: targetId.toString(),
    );
  }

  setPostalCodeProperty({required String postalCode}) async {
    await setUserProperty(
      name: UserProperties.postalCode,
      value: postalCode,
    );
  }

  setCommunityProperty({String? communityId}) async {
    await setUserProperty(
      name: UserProperties.community,
      // account for communityId null values
      value: communityId ?? "no communityId",
    );
  }

  setDepartmentProperty({String? departmentId}) async {
    await setUserProperty(
      name: UserProperties.department,
      // account for departmemtId null values
      value: departmentId ?? "no departmentId",
    );
  }

  setTeamProperty({String? teamId}) async {
    await setUserProperty(
      name: UserProperties.team,
      // account for teamId null values
      value: teamId ?? "no teamId",
    );
  }

  // study specific data collection

  setTestUserProperty({required bool? isActiveTestUser}) async {
    if (isActiveTestUser != null) {
      await setUserProperty(
        name: UserProperties.testUser,
        value: isActiveTestUser ? 'active' : null,
      );
    }
  }

  setTestUserTokenProperty({String? token}) async {
    await setUserProperty(
      name: UserProperties.testUserToken,
      value: token,
    );
  }

  setFederalStateProperty({String? federalState}) async {
    await setUserProperty(
      name: UserProperties.federalState,
      value: federalState,
    );
  }

  // ************************************
  // EVENTS
  // ************************************

  logAnalyticsEvent({
    required String eventName,
    Map<String, dynamic>? params,
  }) async {
    params?.removeWhere((k, v) => v == null);

    if (params != null && params.isNotEmpty) {
      await logEvent(
        name: eventName,
        parameters: params,
      );
    } else {
      await logEvent(name: eventName);
    }
  }

  // ONBOARDING & SETTINGS SCOPE

  logSignIn({required String signInMethod}) async {
    await logEvent(
      name: AnalyticsEvents.signIn,
      parameters: {
        AnalyticsParameters.signIn: signInMethod,
      },
    );
  }

  logOnboardingAction({required String action}) async {
    await logEvent(
      name: AnalyticsEvents.onboardingAction,
      parameters: {
        AnalyticsParameters.onboardingAction: action,
      },
    );
  }

  logSettingsAction({required String action}) async {
    await logEvent(
      name: AnalyticsEvents.settingsAction,
      parameters: {
        AnalyticsParameters.settingsAction: action,
      },
    );
  }

  logUpdateConsent({Map<String, dynamic>? params}) => logAnalyticsEvent(
        eventName: AnalyticsEvents.updateConsent,
        params: params,
      );

  logUpdateProfile() async {
    await logEvent(name: AnalyticsEvents.updateProfile);
  }

  // CALCULATOR SCOPE

  logUpdateFootprint({Map<String, dynamic>? params}) => logAnalyticsEvent(
        eventName: AnalyticsEvents.updateFootprint,
        params: params,
      );

  logUpdateCalculatorSection({Map<String, dynamic>? params}) =>
      logAnalyticsEvent(
        eventName: AnalyticsEvents.updateCalculatorSection,
        params: params,
      );

  // CHALLENGE SCOPE

  logChallengeAdded({Map<String, dynamic>? params}) => logAnalyticsEvent(
        eventName: AnalyticsEvents.challengeAdded,
        params: params,
      );

  logChallengeCompleted({Map<String, dynamic>? params}) => logAnalyticsEvent(
        eventName: AnalyticsEvents.challengeCompleted,
        params: params,
      );

// COMMUNITY SCOPE

  logJoinCommunity({Map<String, dynamic>? params}) => logAnalyticsEvent(
        eventName: AnalyticsEvents.joinCommunity,
        params: params,
      );

  logJoinDepartment({Map<String, dynamic>? params}) => logAnalyticsEvent(
        eventName: AnalyticsEvents.joinDepartment,
        params: params,
      );

  logLeaveDepartment({Map<String, dynamic>? params}) => logAnalyticsEvent(
        eventName: AnalyticsEvents.leaveDepartment,
        params: params,
      );

  logCreateTeam({Map<String, dynamic>? params}) => logAnalyticsEvent(
        eventName: AnalyticsEvents.createTeam,
        params: params,
      );

  logJoinTeam({Map<String, dynamic>? params}) => logAnalyticsEvent(
        eventName: AnalyticsEvents.joinTeam,
        params: params,
      );

  logLeaveTeam({Map<String, dynamic>? params}) => logAnalyticsEvent(
        eventName: AnalyticsEvents.leaveTeam,
        params: params,
      );

  logUpdateCommunity({
    Map<String, dynamic>? params,
  }) =>
      logAnalyticsEvent(
        eventName: AnalyticsEvents.updateCommunity,
        params: params,
      );

  // TEST STUDY SCOPE

  logTestUserRegistration({
    Map<String, dynamic>? params,
  }) =>
      logAnalyticsEvent(
        eventName: AnalyticsEvents.registerTestUser,
        params: params,
      );
}

// ********************************************
// NAMES FOR PROPERTIES, EVENTS & PARAMETERS
// ********************************************

// constants for user properties
// NOTE: they correspond to custom definitions for Analytics (set in Firebase console)
class UserProperties {
  static const String analyticsUsage = "analytics_usage";
  static const String targetId = "target_id";
  static const String postalCode = "postal_code";
  static const String community = "community";
  static const String department = "department";
  static const String team = "team";

  static const String testUser = "test_user";
  static const String testUserToken = "test_user_token";
  static const String federalState = "federal_state";
}

// constants for analytics event names
// NOTE: they will be displayed accordingly in Firebase console
class AnalyticsEvents {
  // general
  static const String userInteraction = "user_interaction";

  // onboarding & settings scope
  static const String signIn = "sign_in";
  static const String onboardingAction = "onboarding_action";
  static const String settingsAction = "settings_action";
  static const String updateConsent = "update_consent";
  static const String updateProfile = "update_profile";

  // community scope
  static const String joinCommunity = "join_community";
  static const String joinDepartment = "join_department";
  static const String joinTeam = "join_team";
  static const String leaveDepartment = "leave_department";
  static const String createTeam = "create_team";
  static const String leaveTeam = "leaveTeam";
  static const String updateCommunity = "update_community";

  // challenges scope
  static const String challengeCompleted = "challenge_completed";
  static const String challengeAdded = "challenge_added";

  // calculator scope
  static const updateFootprint = "update_footprint";
  static const updateCalculatorSection = "update_calculator_section";

  static const String clickRewardBanner = "click_reward_banner";

  // test study scope
  static const String registerTestUser = "register_test_user";

  // quiz scope
  static const String openStoryCard = "open_story_card";
  static const String answerQuizQuestion = "answer_quiz_question";
  static const String repeatQuizQuestion = "repeat_quiz_question";
}

// constants for analytics parameters names
// NOTE: they correspond to custom definitions for Analytics (set in Firebase console)
class AnalyticsParameters {
  // general
  static const String action = "action";
  static const String scope = "scope";
  static const String category = "category";

  static const String previousValue = "previousValue";
  static const String value = "value";

  // onboarding & settings scope
  static const String onboardingAction = "onboarding_action";
  static const String settingsAction = "settings_action";
  static const String signIn = "sign_in";

  // community scope
  static const String communityId = "community_id";
  static const String communityName = "community_name";
  static const String communityNameEN = "community_name_en";
  static const String departmentId = "department_id";
  static const String departmentName = "department_name";
  static const String departmentNameEN = "department_name_en";
  static const String teamId = "team_id";
  static const String teamName = "team_name";

  // challenges scope
  static const String challengeSuccess = "challenge_success";
  static const String challengeId = "challenge_id";
  static const String challengeRootId = "challenge_root_id";
  static const String challengeTitle = "challenge_title";
  static const String challengeTitleEN = "challenge_title_en";
  static const String challengeCategory = "challenge_category";
  static const String challengeCoins = "challenge_coins";
  static const String challengeEmissionSavings = "challenge_emission_savings";
  static const String challengeStart = "start";
  static const String challengeEnd = "end";

  // calculator scope
  static const footprintTotal = "footprint_total";
  static const footprintLiving = "footprint_living";
  static const footprintMobility = "footprint_mobility";
  static const footprintNutrition = "footprint_nutrition";
  static const footprintConsumption = "footprint_consumption";
  static const footprintSection = "section";

  // rewards scope
  static const String rewardLink = "reward_link";
  static const String usersCommunityCoins = "users_community_coins";
  static const String rewardRequiredCoins = "reward_required_coins";

  // test study scope
  static const String token = "token";
  static const String federalState = "federal_state";

  // quiz scope
  static const storyId = "story_id";
  static const quizQuestion = "quiz_question";
  static const givenQuizAnswer = "given_quiz_answer";
  static const isCorrectAnswer = "is_correct_answer";
}

// constants for some analytics values
class AnalyticsValues {
  static const String useEmailContact = "use_email_contact";
  // sign in scope
  static const String emailSignIn = "sign_in_with_email";
  static const String appleSignIn = "sign_in_with_apple";
  static const String googleSignIn = "sign_in_with_google";
  static const String anonymousSignIn = "sign_in_anonymously";

  // onboarding scope
  static const String skipCommunitySelection = "skip_community_selection";
  static const String skipDepartmentSelection = "skip_department_selection";
  static const String skipProfileCreation = "skip_profile_creation";
  static const String skipFootprintOnboarding = "skip_footprint_onboarding";
  static const String doFootprintOnboarding = "do_footprint_onboarding";
  static const String chooseDetailedFootprintCalculation =
      "choose_detailed_footprint_calculation";

  // settings scope
  static const String openProfile = "open_profile";
  static const String inviteFriends = "invite_friends";
  static const String submitAction = "submit_action";
  static const String giveFeedback = "give_feedback";
  static const String signOut = "sign_out";
  static const String openTermsOfServices = "open_terms_of_services";
  static const String openPrivacyPolicies = "open_privacy_policies";
  static const String switchConsentSettings = "switch_consent_settings";
  static const String sendAccountDeletionRequest =
      "send_account_deletion_request";
  static const String openAboutUs = "open_about_us";
  static const String openFAQ = "open_faq";
  static const String openHelp = "open_help";
  static const String openInstagram = "open_instagram";
  static const String contactSupport = "contact_support";

  // scopes
  static const String challengesScope = "challenges";
  static const String adventsCalendarScope = "advents_calendar";
  static const String useChallengeFilter = "use_challenge_filter";
  static const String homeScreenScope = "home_screen_scope";
  static const String feedScope = "feed_scope";

  // challenges scope
  static const String increaseWeekView = "increase_week_view";
  static const String decreaseWeekView = "decrease_week_view";

  // community scope
  static const String joinCommunity = "join_community";
  static const String joinDepartment = "join_department";

  // content scope
  static const String openArticle = "open_article";

  // advent calendar scope
  static const String openAdventCalendarStory = "open_advent_calendar_story";
  static const String openAdventCalendarFact = "open_advent_calendar_fact";
  static const String openAdventCalendarChallenge =
      "open_advent_calendar_challenge";
  static const String addAdventCalendarChallenge =
      "add_advent_calendar_challenge";
}
