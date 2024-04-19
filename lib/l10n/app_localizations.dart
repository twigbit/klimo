// ignore_for_file: non_constant_identifier_names
import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_de.dart';
import 'app_localizations_en.dart';

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('de'),
    Locale('en')
  ];

  /// No description provided for @action_add.
  ///
  /// In en, this message translates to:
  /// **'Add'**
  String get action_add;

  /// No description provided for @action_agree.
  ///
  /// In en, this message translates to:
  /// **'Agree'**
  String get action_agree;

  /// No description provided for @action_back.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get action_back;

  /// No description provided for @action_camera.
  ///
  /// In en, this message translates to:
  /// **'Camera'**
  String get action_camera;

  /// No description provided for @action_cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get action_cancel;

  /// No description provided for @action_confirm.
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get action_confirm;

  /// No description provided for @action_delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get action_delete;

  /// No description provided for @action_done.
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get action_done;

  /// No description provided for @action_edit.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get action_edit;

  /// No description provided for @action_error.
  ///
  /// In en, this message translates to:
  /// **'An error occurred'**
  String get action_error;

  /// No description provided for @action_gallery.
  ///
  /// In en, this message translates to:
  /// **'Gallery'**
  String get action_gallery;

  /// No description provided for @action_next.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get action_next;

  /// No description provided for @action_ok.
  ///
  /// In en, this message translates to:
  /// **'Ok'**
  String get action_ok;

  /// No description provided for @action_repeat.
  ///
  /// In en, this message translates to:
  /// **'Repeat'**
  String get action_repeat;

  /// No description provided for @action_save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get action_save;

  /// No description provided for @action_sign_in.
  ///
  /// In en, this message translates to:
  /// **'Sign In'**
  String get action_sign_in;

  /// No description provided for @action_skip.
  ///
  /// In en, this message translates to:
  /// **'Skip'**
  String get action_skip;

  /// No description provided for @action_update.
  ///
  /// In en, this message translates to:
  /// **'Update'**
  String get action_update;

  /// No description provided for @actions_empty_message_1.
  ///
  /// In en, this message translates to:
  /// **'Find exciting joint actions here in the future that will advance local climate protection. And if you feel like including your own action, contact us '**
  String get actions_empty_message_1;

  /// No description provided for @actions_empty_message_2.
  ///
  /// In en, this message translates to:
  /// **'directly here'**
  String get actions_empty_message_2;

  /// No description provided for @activism.
  ///
  /// In en, this message translates to:
  /// **'Activism'**
  String get activism;

  /// No description provided for @activity_free_time.
  ///
  /// In en, this message translates to:
  /// **'Average free time'**
  String get activity_free_time;

  /// No description provided for @activity_free_time_unit.
  ///
  /// In en, this message translates to:
  /// **'hours / day'**
  String get activity_free_time_unit;

  /// No description provided for @activity_sleep_time.
  ///
  /// In en, this message translates to:
  /// **'How many hours do you sleep on average per day?'**
  String get activity_sleep_time;

  /// No description provided for @activity_sleep_time_unit.
  ///
  /// In en, this message translates to:
  /// **'hours / day'**
  String get activity_sleep_time_unit;

  /// No description provided for @activity_work_time.
  ///
  /// In en, this message translates to:
  /// **'How many hours do you work on average per day?'**
  String get activity_work_time;

  /// No description provided for @activity_work_time_unit.
  ///
  /// In en, this message translates to:
  /// **'hours / day'**
  String get activity_work_time_unit;

  /// No description provided for @advents_tipp_read_more.
  ///
  /// In en, this message translates to:
  /// **'Read more'**
  String get advents_tipp_read_more;

  /// No description provided for @age_19_to_30.
  ///
  /// In en, this message translates to:
  /// **'19 - 30 years'**
  String get age_19_to_30;

  /// No description provided for @age_31_to_60.
  ///
  /// In en, this message translates to:
  /// **'31 - 60 years'**
  String get age_31_to_60;

  /// No description provided for @age_61_to_75.
  ///
  /// In en, this message translates to:
  /// **'61 - 75 years'**
  String get age_61_to_75;

  /// No description provided for @age_more_than_75.
  ///
  /// In en, this message translates to:
  /// **'older than 75 years'**
  String get age_more_than_75;

  /// No description provided for @age_range.
  ///
  /// In en, this message translates to:
  /// **'What age group do you belong to?'**
  String get age_range;

  /// No description provided for @age_up_to_18.
  ///
  /// In en, this message translates to:
  /// **'18 years or younger'**
  String get age_up_to_18;

  /// No description provided for @annual_heat_consumption.
  ///
  /// In en, this message translates to:
  /// **'What is your annual heating consumption according to your bill?'**
  String get annual_heat_consumption;

  /// No description provided for @annual_heat_consumption_unit_description.
  ///
  /// In en, this message translates to:
  /// **'Please select the appropriate unit'**
  String get annual_heat_consumption_unit_description;

  /// No description provided for @annual_heat_consumption_unit_kg.
  ///
  /// In en, this message translates to:
  /// **'kg'**
  String get annual_heat_consumption_unit_kg;

  /// No description provided for @annual_heat_consumption_unit_kwh.
  ///
  /// In en, this message translates to:
  /// **'kWh'**
  String get annual_heat_consumption_unit_kwh;

  /// No description provided for @annual_heat_consumption_unit_l.
  ///
  /// In en, this message translates to:
  /// **'l'**
  String get annual_heat_consumption_unit_l;

  /// No description provided for @annual_heat_consumption_unit_m3.
  ///
  /// In en, this message translates to:
  /// **'m³'**
  String get annual_heat_consumption_unit_m3;

  /// No description provided for @annual_heat_consumption_unit_mwh.
  ///
  /// In en, this message translates to:
  /// **'MWh'**
  String get annual_heat_consumption_unit_mwh;

  /// No description provided for @annual_heat_consumption_water.
  ///
  /// In en, this message translates to:
  /// **'What is your annual hot water consumption according to your bill?'**
  String get annual_heat_consumption_water;

  /// No description provided for @annual_heat_consumption_water_unit_description.
  ///
  /// In en, this message translates to:
  /// **'Please select the appropriate unit'**
  String get annual_heat_consumption_water_unit_description;

  /// No description provided for @annual_heat_consumption_water_unit_kg.
  ///
  /// In en, this message translates to:
  /// **'kg'**
  String get annual_heat_consumption_water_unit_kg;

  /// No description provided for @annual_heat_consumption_water_unit_kwh.
  ///
  /// In en, this message translates to:
  /// **'kWh'**
  String get annual_heat_consumption_water_unit_kwh;

  /// No description provided for @annual_heat_consumption_water_unit_l.
  ///
  /// In en, this message translates to:
  /// **'l'**
  String get annual_heat_consumption_water_unit_l;

  /// No description provided for @annual_heat_consumption_water_unit_m3.
  ///
  /// In en, this message translates to:
  /// **'m³'**
  String get annual_heat_consumption_water_unit_m3;

  /// No description provided for @annual_heat_consumption_water_unit_mwh.
  ///
  /// In en, this message translates to:
  /// **'MWh'**
  String get annual_heat_consumption_water_unit_mwh;

  /// No description provided for @annual_power_consumption.
  ///
  /// In en, this message translates to:
  /// **'What is your annual electricity consumption according to your bill?'**
  String get annual_power_consumption;

  /// No description provided for @annual_power_consumption_unit.
  ///
  /// In en, this message translates to:
  /// **'kWh/a'**
  String get annual_power_consumption_unit;

  /// No description provided for @articles_actions.
  ///
  /// In en, this message translates to:
  /// **'Actions'**
  String get articles_actions;

  /// No description provided for @articles_empty_message.
  ///
  /// In en, this message translates to:
  /// **'There is nothing happening here right now. Stay tuned for the next news!'**
  String get articles_empty_message;

  /// No description provided for @articles_guide.
  ///
  /// In en, this message translates to:
  /// **'Guides'**
  String get articles_guide;

  /// No description provided for @articles_news.
  ///
  /// In en, this message translates to:
  /// **'News'**
  String get articles_news;

  /// No description provided for @articles_partner.
  ///
  /// In en, this message translates to:
  /// **'Partner & Rewards'**
  String get articles_partner;

  /// No description provided for @articles_projects.
  ///
  /// In en, this message translates to:
  /// **'Crowdfunding Projects'**
  String get articles_projects;

  /// No description provided for @articles_projects_first_credits.
  ///
  /// In en, this message translates to:
  /// **'Image Credit: Bro Vector – stock.adobe.com'**
  String get articles_projects_first_credits;

  /// No description provided for @articles_projects_first_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Then start your own crowdfunding campaign here!'**
  String get articles_projects_first_subtitle;

  /// No description provided for @articles_projects_first_title.
  ///
  /// In en, this message translates to:
  /// **'Looking for financial support for YOUR project?'**
  String get articles_projects_first_title;

  /// No description provided for @auth_privacy_policy.
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get auth_privacy_policy;

  /// No description provided for @auth_terms_agreement_message_1.
  ///
  /// In en, this message translates to:
  /// **'By creating an account for the klimo app, you agree to the '**
  String get auth_terms_agreement_message_1;

  /// No description provided for @auth_terms_agreement_message_2.
  ///
  /// In en, this message translates to:
  /// **' and acknowledge reading the '**
  String get auth_terms_agreement_message_2;

  /// No description provided for @auth_terms_agreement_message_3.
  ///
  /// In en, this message translates to:
  /// **'.'**
  String get auth_terms_agreement_message_3;

  /// No description provided for @auth_terms_of_service.
  ///
  /// In en, this message translates to:
  /// **'Terms of Service'**
  String get auth_terms_of_service;

  /// No description provided for @bicycle.
  ///
  /// In en, this message translates to:
  /// **'Bicycle'**
  String get bicycle;

  /// No description provided for @bicycle_bike.
  ///
  /// In en, this message translates to:
  /// **'Bicycle'**
  String get bicycle_bike;

  /// No description provided for @bicycle_distance.
  ///
  /// In en, this message translates to:
  /// **'How many kilometers do you cycle on average per year?'**
  String get bicycle_distance;

  /// No description provided for @bicycle_distance_unit.
  ///
  /// In en, this message translates to:
  /// **'km / year'**
  String get bicycle_distance_unit;

  /// No description provided for @bicycle_ebike.
  ///
  /// In en, this message translates to:
  /// **'E-Bike'**
  String get bicycle_ebike;

  /// No description provided for @bicycle_property.
  ///
  /// In en, this message translates to:
  /// **'Do you own a bicycle or use bicycle-sharing services?'**
  String get bicycle_property;

  /// No description provided for @bicycle_property_own.
  ///
  /// In en, this message translates to:
  /// **'Own bicycle'**
  String get bicycle_property_own;

  /// No description provided for @bicycle_property_sharing.
  ///
  /// In en, this message translates to:
  /// **'Bicycle-sharing service'**
  String get bicycle_property_sharing;

  /// No description provided for @bicycle_type.
  ///
  /// In en, this message translates to:
  /// **'What type of bicycle do you use?'**
  String get bicycle_type;

  /// No description provided for @building_age_category.
  ///
  /// In en, this message translates to:
  /// **'When was your building constructed (age category)?'**
  String get building_age_category;

  /// No description provided for @building_age_category_1949_to_1978.
  ///
  /// In en, this message translates to:
  /// **'1949 - 1978'**
  String get building_age_category_1949_to_1978;

  /// No description provided for @building_age_category_1979_to_2001.
  ///
  /// In en, this message translates to:
  /// **'1979 - 2001'**
  String get building_age_category_1979_to_2001;

  /// No description provided for @building_age_category_2002_to_2015.
  ///
  /// In en, this message translates to:
  /// **'2002 - 2015'**
  String get building_age_category_2002_to_2015;

  /// No description provided for @building_age_category_before_1948.
  ///
  /// In en, this message translates to:
  /// **'Before 1948'**
  String get building_age_category_before_1948;

  /// No description provided for @building_age_category_from_2016.
  ///
  /// In en, this message translates to:
  /// **'From 2016'**
  String get building_age_category_from_2016;

  /// No description provided for @building_type.
  ///
  /// In en, this message translates to:
  /// **'What type of building do you live in?'**
  String get building_type;

  /// No description provided for @building_type_ezfh.
  ///
  /// In en, this message translates to:
  /// **'Single-family or two-family house with a maximum of 3 residential units'**
  String get building_type_ezfh;

  /// No description provided for @building_type_gmfh.
  ///
  /// In en, this message translates to:
  /// **'Residential building with more than 12 residential units'**
  String get building_type_gmfh;

  /// No description provided for @building_type_kmfh.
  ///
  /// In en, this message translates to:
  /// **'Residential building with 4-12 residential units'**
  String get building_type_kmfh;

  /// No description provided for @building_type_rh.
  ///
  /// In en, this message translates to:
  /// **'Row house with a maximum of 3 residential units'**
  String get building_type_rh;

  /// No description provided for @business.
  ///
  /// In en, this message translates to:
  /// **'Business'**
  String get business;

  /// No description provided for @buying_behavior.
  ///
  /// In en, this message translates to:
  /// **'How would you describe your buying behavior?'**
  String get buying_behavior;

  /// No description provided for @buying_behavior_generous.
  ///
  /// In en, this message translates to:
  /// **'Impulsive'**
  String get buying_behavior_generous;

  /// No description provided for @buying_behavior_normal.
  ///
  /// In en, this message translates to:
  /// **'Normal'**
  String get buying_behavior_normal;

  /// No description provided for @buying_behavior_sparse.
  ///
  /// In en, this message translates to:
  /// **'Thoughtful'**
  String get buying_behavior_sparse;

  /// No description provided for @buying_criteria.
  ///
  /// In en, this message translates to:
  /// **'Which criterion is particularly important to you when shopping?'**
  String get buying_criteria;

  /// No description provided for @buying_criteria_costs.
  ///
  /// In en, this message translates to:
  /// **'Costs'**
  String get buying_criteria_costs;

  /// No description provided for @buying_criteria_functionality.
  ///
  /// In en, this message translates to:
  /// **'Functionality'**
  String get buying_criteria_functionality;

  /// No description provided for @buying_criteria_quality.
  ///
  /// In en, this message translates to:
  /// **'Quality'**
  String get buying_criteria_quality;

  /// No description provided for @buying_second_hand.
  ///
  /// In en, this message translates to:
  /// **'Do you buy used items and second-hand things?'**
  String get buying_second_hand;

  /// No description provided for @buying_second_hand_never.
  ///
  /// In en, this message translates to:
  /// **'Never'**
  String get buying_second_hand_never;

  /// No description provided for @buying_second_hand_preferred.
  ///
  /// In en, this message translates to:
  /// **'Preferred'**
  String get buying_second_hand_preferred;

  /// No description provided for @buying_second_hand_sometimes.
  ///
  /// In en, this message translates to:
  /// **'Sometimes'**
  String get buying_second_hand_sometimes;

  /// No description provided for @calculate_calculator_section.
  ///
  /// In en, this message translates to:
  /// **'Calculation'**
  String get calculate_calculator_section;

  /// No description provided for @calculate_calculator_section_message.
  ///
  /// In en, this message translates to:
  /// **'Calculate your CO₂ emissions for the category'**
  String get calculate_calculator_section_message;

  /// No description provided for @calculate_compensation_section_message.
  ///
  /// In en, this message translates to:
  /// **'Calculate your CO₂ emissions offset here'**
  String get calculate_compensation_section_message;

  /// No description provided for @calculator_nested_input_hint.
  ///
  /// In en, this message translates to:
  /// **'Click to edit, swipe sideways to delete'**
  String get calculator_nested_input_hint;

  /// No description provided for @car.
  ///
  /// In en, this message translates to:
  /// **'Car'**
  String get car;

  /// No description provided for @car_motorcycle_car_classification.
  ///
  /// In en, this message translates to:
  /// **'What class of vehicle do you own?'**
  String get car_motorcycle_car_classification;

  /// No description provided for @car_motorcycle_car_classification_middle_class.
  ///
  /// In en, this message translates to:
  /// **'Mid-size car'**
  String get car_motorcycle_car_classification_middle_class;

  /// No description provided for @car_motorcycle_car_classification_small_car.
  ///
  /// In en, this message translates to:
  /// **'Compact car'**
  String get car_motorcycle_car_classification_small_car;

  /// No description provided for @car_motorcycle_car_classification_upper_class.
  ///
  /// In en, this message translates to:
  /// **'Upper-class car'**
  String get car_motorcycle_car_classification_upper_class;

  /// No description provided for @car_motorcycle_car_sharing.
  ///
  /// In en, this message translates to:
  /// **'Car-sharing service'**
  String get car_motorcycle_car_sharing;

  /// No description provided for @car_motorcycle_consumption.
  ///
  /// In en, this message translates to:
  /// **'What is your individual fuel consumption?'**
  String get car_motorcycle_consumption;

  /// No description provided for @car_motorcycle_consumption_unit.
  ///
  /// In en, this message translates to:
  /// **'l or kWh / 100 km'**
  String get car_motorcycle_consumption_unit;

  /// No description provided for @car_motorcycle_distance.
  ///
  /// In en, this message translates to:
  /// **'How many kilometers do you travel on average per year?'**
  String get car_motorcycle_distance;

  /// No description provided for @car_motorcycle_distance_unit.
  ///
  /// In en, this message translates to:
  /// **'km / year'**
  String get car_motorcycle_distance_unit;

  /// No description provided for @car_motorcycle_fuel.
  ///
  /// In en, this message translates to:
  /// **'What type of fuel or energy source do you use?'**
  String get car_motorcycle_fuel;

  /// No description provided for @car_motorcycle_fuel_benzin.
  ///
  /// In en, this message translates to:
  /// **'Gasoline'**
  String get car_motorcycle_fuel_benzin;

  /// No description provided for @car_motorcycle_fuel_diesel.
  ///
  /// In en, this message translates to:
  /// **'Diesel'**
  String get car_motorcycle_fuel_diesel;

  /// No description provided for @car_motorcycle_fuel_electric.
  ///
  /// In en, this message translates to:
  /// **'Electricity'**
  String get car_motorcycle_fuel_electric;

  /// No description provided for @car_motorcycle_fuel_gas.
  ///
  /// In en, this message translates to:
  /// **'Gas (LPG)'**
  String get car_motorcycle_fuel_gas;

  /// No description provided for @car_motorcycle_fuel_hybrid.
  ///
  /// In en, this message translates to:
  /// **'Hybrid'**
  String get car_motorcycle_fuel_hybrid;

  /// No description provided for @car_motorcycle_own_car.
  ///
  /// In en, this message translates to:
  /// **'Own car'**
  String get car_motorcycle_own_car;

  /// No description provided for @car_motorcycle_type.
  ///
  /// In en, this message translates to:
  /// **'Do you own a car or use car-sharing services?'**
  String get car_motorcycle_type;

  /// No description provided for @challenge_complete_no.
  ///
  /// In en, this message translates to:
  /// **'No'**
  String get challenge_complete_no;

  /// No description provided for @challenge_complete_question.
  ///
  /// In en, this message translates to:
  /// **'Did you complete the challenge?'**
  String get challenge_complete_question;

  /// No description provided for @challenge_complete_yes.
  ///
  /// In en, this message translates to:
  /// **'Yes'**
  String get challenge_complete_yes;

  /// No description provided for @challenge_done.
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get challenge_done;

  /// No description provided for @challenge_list_page_title.
  ///
  /// In en, this message translates to:
  /// **'Add Challenge'**
  String get challenge_list_page_title;

  /// No description provided for @challenge_of_the_day.
  ///
  /// In en, this message translates to:
  /// **'Challenge of the day'**
  String get challenge_of_the_day;

  /// No description provided for @challenge_recommended_for_me.
  ///
  /// In en, this message translates to:
  /// **'Recommended for me'**
  String get challenge_recommended_for_me;

  /// No description provided for @challenges_dashboard_actions.
  ///
  /// In en, this message translates to:
  /// **'Actions'**
  String get challenges_dashboard_actions;

  /// No description provided for @challenges_dashboard_actions_empty.
  ///
  /// In en, this message translates to:
  /// **'Plan your actions here!'**
  String get challenges_dashboard_actions_empty;

  /// No description provided for @challenges_dashboard_completed.
  ///
  /// In en, this message translates to:
  /// **'Completed'**
  String get challenges_dashboard_completed;

  /// No description provided for @challenges_dashboard_habits.
  ///
  /// In en, this message translates to:
  /// **'Habits'**
  String get challenges_dashboard_habits;

  /// No description provided for @challenges_dashboard_habits_empty.
  ///
  /// In en, this message translates to:
  /// **'Plan your changes here!'**
  String get challenges_dashboard_habits_empty;

  /// No description provided for @challenges_dashboard_suggestions.
  ///
  /// In en, this message translates to:
  /// **'Suggestions'**
  String get challenges_dashboard_suggestions;

  /// No description provided for @challenges_done.
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get challenges_done;

  /// No description provided for @challenges_earned.
  ///
  /// In en, this message translates to:
  /// **'earned'**
  String get challenges_earned;

  /// No description provided for @challenges_info.
  ///
  /// In en, this message translates to:
  /// **'Information'**
  String get challenges_info;

  /// No description provided for @challenges_one_time.
  ///
  /// In en, this message translates to:
  /// **'One-time'**
  String get challenges_one_time;

  /// No description provided for @challenges_participants.
  ///
  /// In en, this message translates to:
  /// **'Participants'**
  String get challenges_participants;

  /// No description provided for @challenges_planned.
  ///
  /// In en, this message translates to:
  /// **'Planned'**
  String get challenges_planned;

  /// No description provided for @challenges_points.
  ///
  /// In en, this message translates to:
  /// **'Points'**
  String get challenges_points;

  /// No description provided for @challenges_recurring.
  ///
  /// In en, this message translates to:
  /// **'Recurring'**
  String get challenges_recurring;

  /// No description provided for @challenges_saved.
  ///
  /// In en, this message translates to:
  /// **'saved'**
  String get challenges_saved;

  /// No description provided for @challenges_sequential.
  ///
  /// In en, this message translates to:
  /// **'Sequential'**
  String get challenges_sequential;

  /// No description provided for @challenges_summary_message.
  ///
  /// In en, this message translates to:
  /// **'Collect more data to see your statistics.'**
  String get challenges_summary_message;

  /// No description provided for @challenges_total.
  ///
  /// In en, this message translates to:
  /// **'Total'**
  String get challenges_total;

  /// No description provided for @challenges_undone.
  ///
  /// In en, this message translates to:
  /// **'Not done'**
  String get challenges_undone;

  /// No description provided for @challenges_view_empty_week.
  ///
  /// In en, this message translates to:
  /// **'You haven\'t set anything yet. Plan new challenges for this week!'**
  String get challenges_view_empty_week;

  /// No description provided for @challenges_view_today.
  ///
  /// In en, this message translates to:
  /// **'TODAY'**
  String get challenges_view_today;

  /// No description provided for @challenges_view_week.
  ///
  /// In en, this message translates to:
  /// **'Week'**
  String get challenges_view_week;

  /// No description provided for @climate_points_info_message_1.
  ///
  /// In en, this message translates to:
  /// **'To achieve the goals of the Paris Climate Agreement by 2030, we need to reduce our annual CO₂ emissions to a maximum of 2.5 tons per capita. Our figures are based on the year 2020, in which, according to the German Federal Environment Agency, we had an average of 11.6 tons (as of 2020) in Germany. Starting from 2020, we consequently need to manage a difference of 9.1 tons by 2030, which corresponds to a uniform reduction of 910 kg of CO₂ emissions per capita per year.'**
  String get climate_points_info_message_1;

  /// No description provided for @climate_points_info_message_2.
  ///
  /// In en, this message translates to:
  /// **'For all challenges, we have calculated the annual CO₂ savings potential, i.e., the realized savings if you permanently integrate the behavioral changes into your daily life. If a challenge has a CO₂ savings potential of 91 kg per year, that would be 10% of the annual reduction target. Completing the challenge is therefore rewarded with 10 climate points. This means: The climate points of a challenge are approximately the percentage of your annual CO₂ savings target, where a single climate point corresponds to 9.1 kg of annual CO₂ savings.'**
  String get climate_points_info_message_2;

  /// No description provided for @climate_points_info_message_3.
  ///
  /// In en, this message translates to:
  /// **'For challenges where there is no direct CO₂ saving, we have introduced an alternative points calculation. Investments in sustainable products and services are also rewarded: An investment of 50€ corresponds to 10 climate points, so 1 climate point is equivalent to 5€. For example, you receive four climate points for purchasing a power strip for 20€. For very large investments, such as buying a photovoltaic system for 7000€, the app awards 1 climate point for every 50€, to ensure balanced gamification. Time spent on sustainable activities also counts: You receive one climate point for every half hour of time spent. For example, a 2-hour bike ride earns you 4 climate points.'**
  String get climate_points_info_message_3;

  /// No description provided for @climate_points_info_message_4.
  ///
  /// In en, this message translates to:
  /// **'With the climate points, your commitment is rewarded in a variety of ways and contributes to achieving our common climate goals.'**
  String get climate_points_info_message_4;

  /// No description provided for @climate_points_info_title.
  ///
  /// In en, this message translates to:
  /// **'What do the points mean?'**
  String get climate_points_info_title;

  /// No description provided for @community_department_empty.
  ///
  /// In en, this message translates to:
  /// **'There are no groups.'**
  String get community_department_empty;

  /// No description provided for @community_department_select.
  ///
  /// In en, this message translates to:
  /// **'Select a Department'**
  String get community_department_select;

  /// No description provided for @community_select_info.
  ///
  /// In en, this message translates to:
  /// **'If you live in Kassel, select the Kassel Community to receive Kassel-specific challenges and rewards.'**
  String get community_select_info;

  /// No description provided for @community_select_title.
  ///
  /// In en, this message translates to:
  /// **'Choose Your Community'**
  String get community_select_title;

  /// No description provided for @community_teams_create.
  ///
  /// In en, this message translates to:
  /// **'Create Team'**
  String get community_teams_create;

  /// No description provided for @community_teams_create_info.
  ///
  /// In en, this message translates to:
  /// **'Create your own team here, where other users can join. You will complete challenges together and earn collective climate points.'**
  String get community_teams_create_info;

  /// No description provided for @community_teams_empty.
  ///
  /// In en, this message translates to:
  /// **'There are no teams yet.'**
  String get community_teams_empty;

  /// No description provided for @community_teams_select.
  ///
  /// In en, this message translates to:
  /// **'Select a Team'**
  String get community_teams_select;

  /// No description provided for @community_users_department.
  ///
  /// In en, this message translates to:
  /// **'My Department'**
  String get community_users_department;

  /// No description provided for @community_users_department_empty.
  ///
  /// In en, this message translates to:
  /// **'You\'re not in any department yet?'**
  String get community_users_department_empty;

  /// No description provided for @community_users_team.
  ///
  /// In en, this message translates to:
  /// **'My Team'**
  String get community_users_team;

  /// No description provided for @community_users_team_empty.
  ///
  /// In en, this message translates to:
  /// **'You\'re not in any team yet?'**
  String get community_users_team_empty;

  /// No description provided for @compensation.
  ///
  /// In en, this message translates to:
  /// **'Compensations'**
  String get compensation;

  /// No description provided for @compensation_certificates.
  ///
  /// In en, this message translates to:
  /// **'How many compensation certificates do you purchase per year?'**
  String get compensation_certificates;

  /// No description provided for @compensation_certificates_unit.
  ///
  /// In en, this message translates to:
  /// **'t CO₂'**
  String get compensation_certificates_unit;

  /// No description provided for @compensation_electricity.
  ///
  /// In en, this message translates to:
  /// **'How much surplus electricity from your own production do you feed into the grid annually?'**
  String get compensation_electricity;

  /// No description provided for @compensation_electricity_unit.
  ///
  /// In en, this message translates to:
  /// **'kWh/a'**
  String get compensation_electricity_unit;

  /// No description provided for @compensation_investment.
  ///
  /// In en, this message translates to:
  /// **'How much money do you invest in climate-friendly investments?'**
  String get compensation_investment;

  /// No description provided for @compensation_investment_unit.
  ///
  /// In en, this message translates to:
  /// **'€'**
  String get compensation_investment_unit;

  /// No description provided for @consent_data_help.
  ///
  /// In en, this message translates to:
  /// **'We need your help.'**
  String get consent_data_help;

  /// No description provided for @consent_data_no_help.
  ///
  /// In en, this message translates to:
  /// **'Do Not Agree'**
  String get consent_data_no_help;

  /// No description provided for @consent_data_share_message_1.
  ///
  /// In en, this message translates to:
  /// **'We would like to use your usage data for scientific purposes and to improve our app to save even more CO₂ together. This will be done in an anonymized form without mentioning your name. To continuously adapt the app to your needs, we create anonymized crash reports and usage statistics using Google-provided analytical services. In the app settings, you can always revoke your consent for the future. You can find more information in our '**
  String get consent_data_share_message_1;

  /// No description provided for @consent_data_share_message_2.
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy.'**
  String get consent_data_share_message_2;

  /// No description provided for @consent_data_share_message_3.
  ///
  /// In en, this message translates to:
  /// **'If you\'re okay with this, we appreciate your help.'**
  String get consent_data_share_message_3;

  /// No description provided for @consumption.
  ///
  /// In en, this message translates to:
  /// **'Consumption'**
  String get consumption;

  /// No description provided for @consumption_information.
  ///
  /// In en, this message translates to:
  /// **'Indicate here how much and for what you spend your income on pure consumption of products and services. Products and services include:\n\n• Leisure and cultural activities\n• Household appliances and furniture\n• Restaurant visits and accommodations\n• Clothing and shoes\n• Health and education\n• Electronic devices and telecommunications\n• etc.'**
  String get consumption_information;

  /// No description provided for @create_profile_skip_message.
  ///
  /// In en, this message translates to:
  /// **'If you continue without a profile, other users won\'t be able to see your activity, and you won\'t be able to join groups.'**
  String get create_profile_skip_message;

  /// No description provided for @create_profile_skip_title.
  ///
  /// In en, this message translates to:
  /// **'Continue Without a Profile'**
  String get create_profile_skip_title;

  /// No description provided for @create_profile_title.
  ///
  /// In en, this message translates to:
  /// **'Create Your Profile.'**
  String get create_profile_title;

  /// No description provided for @dashboard_actions_headline.
  ///
  /// In en, this message translates to:
  /// **'My Achievements'**
  String get dashboard_actions_headline;

  /// No description provided for @dashboard_advent_calendar.
  ///
  /// In en, this message translates to:
  /// **'Mein Advent Calendar 🧑‍🎄'**
  String get dashboard_advent_calendar;

  /// No description provided for @dashboard_challenges_headline.
  ///
  /// In en, this message translates to:
  /// **'Challenges'**
  String get dashboard_challenges_headline;

  /// No description provided for @dashboard_footprint_headline.
  ///
  /// In en, this message translates to:
  /// **'My Footprint'**
  String get dashboard_footprint_headline;

  /// No description provided for @dashboard_guides_headline.
  ///
  /// In en, this message translates to:
  /// **'Guides'**
  String get dashboard_guides_headline;

  /// No description provided for @dashboard_news_guides_headline.
  ///
  /// In en, this message translates to:
  /// **'News & Guides'**
  String get dashboard_news_guides_headline;

  /// No description provided for @dashboard_news_headline.
  ///
  /// In en, this message translates to:
  /// **'News & Information'**
  String get dashboard_news_headline;

  /// No description provided for @dashboard_quizes_headline.
  ///
  /// In en, this message translates to:
  /// **'My klimo knowledge'**
  String get dashboard_quizes_headline;

  /// No description provided for @delete_account_message.
  ///
  /// In en, this message translates to:
  /// **'Do you really want to delete your account? Your collected data and progress will be completely deleted. After your confirmation, you will be automatically logged out, and we will process your request within the next 7 days.'**
  String get delete_account_message;

  /// No description provided for @delete_account_title.
  ///
  /// In en, this message translates to:
  /// **'Delete Account'**
  String get delete_account_title;

  /// No description provided for @deletion_request_done_message.
  ///
  /// In en, this message translates to:
  /// **'You have sent us a request to delete your account. We will process it and completely delete your data and account in the next few days. Until then, you still have the option to undo your request here.'**
  String get deletion_request_done_message;

  /// No description provided for @deletion_request_done_title.
  ///
  /// In en, this message translates to:
  /// **'Your Account Will Be Deleted Soon'**
  String get deletion_request_done_title;

  /// No description provided for @department_select_info.
  ///
  /// In en, this message translates to:
  /// **'With your district, you earn climate points for the Community Leaderboard!'**
  String get department_select_info;

  /// No description provided for @department_select_title.
  ///
  /// In en, this message translates to:
  /// **'Choose Your District'**
  String get department_select_title;

  /// No description provided for @departments.
  ///
  /// In en, this message translates to:
  /// **'Departments'**
  String get departments;

  /// No description provided for @digital.
  ///
  /// In en, this message translates to:
  /// **'Digital Life'**
  String get digital;

  /// No description provided for @digital_infrastructure.
  ///
  /// In en, this message translates to:
  /// **'Digital Infrastructure'**
  String get digital_infrastructure;

  /// No description provided for @digital_infrastructure_description.
  ///
  /// In en, this message translates to:
  /// **'The increasing trend of using digital services and the associated increase in internet traffic also make this aspect increasingly important. Here, only the provision of the service is covered, but there are other aspects that influence this category, such as the purchase of end devices (TV, PC, smartphone) and electricity consumption.'**
  String get digital_infrastructure_description;

  /// No description provided for @energy_source.
  ///
  /// In en, this message translates to:
  /// **'What is the main energy source for your heat supply?'**
  String get energy_source;

  /// No description provided for @energy_source_biomass.
  ///
  /// In en, this message translates to:
  /// **'Biomass'**
  String get energy_source_biomass;

  /// No description provided for @energy_source_district_heating.
  ///
  /// In en, this message translates to:
  /// **'District heating'**
  String get energy_source_district_heating;

  /// No description provided for @energy_source_electricity.
  ///
  /// In en, this message translates to:
  /// **'Electricity'**
  String get energy_source_electricity;

  /// No description provided for @energy_source_gas.
  ///
  /// In en, this message translates to:
  /// **'Gas'**
  String get energy_source_gas;

  /// No description provided for @energy_source_oil.
  ///
  /// In en, this message translates to:
  /// **'Oil'**
  String get energy_source_oil;

  /// No description provided for @energy_source_other.
  ///
  /// In en, this message translates to:
  /// **'Other'**
  String get energy_source_other;

  /// No description provided for @energy_source_water.
  ///
  /// In en, this message translates to:
  /// **'What energy source is used for the hot water supply?'**
  String get energy_source_water;

  /// No description provided for @energy_source_water_biomass.
  ///
  /// In en, this message translates to:
  /// **'Biomass'**
  String get energy_source_water_biomass;

  /// No description provided for @energy_source_water_district_heating.
  ///
  /// In en, this message translates to:
  /// **'District heating'**
  String get energy_source_water_district_heating;

  /// No description provided for @energy_source_water_electricity.
  ///
  /// In en, this message translates to:
  /// **'Electricity'**
  String get energy_source_water_electricity;

  /// No description provided for @energy_source_water_gas.
  ///
  /// In en, this message translates to:
  /// **'Gas'**
  String get energy_source_water_gas;

  /// No description provided for @energy_source_water_oil.
  ///
  /// In en, this message translates to:
  /// **'Oil'**
  String get energy_source_water_oil;

  /// No description provided for @energy_source_water_other.
  ///
  /// In en, this message translates to:
  /// **'Other'**
  String get energy_source_water_other;

  /// No description provided for @estimated_calculator_section.
  ///
  /// In en, this message translates to:
  /// **'Estimated'**
  String get estimated_calculator_section;

  /// No description provided for @footprint_comparison_german.
  ///
  /// In en, this message translates to:
  /// **'Germany'**
  String get footprint_comparison_german;

  /// No description provided for @footprint_comparison_info_message.
  ///
  /// In en, this message translates to:
  /// **'Different accounting principles underlie the comparison of annual CO2 emissions per capita. The value for Germany is determined based on the causative principle with a consumption-based perspective. The value for Kassel, however, is determined based on the causative principle with a partially consumption-based and partially territorial-based perspective. The differences exist in the areas of Housing and Public.'**
  String get footprint_comparison_info_message;

  /// No description provided for @footprint_comparison_info_title.
  ///
  /// In en, this message translates to:
  /// **'Emission Comparisons'**
  String get footprint_comparison_info_title;

  /// No description provided for @footprint_comparison_kassel.
  ///
  /// In en, this message translates to:
  /// **'Kassel'**
  String get footprint_comparison_kassel;

  /// No description provided for @footprint_comparison_user.
  ///
  /// In en, this message translates to:
  /// **'Me'**
  String get footprint_comparison_user;

  /// No description provided for @footprint_onboarding_detailed_calculation.
  ///
  /// In en, this message translates to:
  /// **'Go to detailed calculation'**
  String get footprint_onboarding_detailed_calculation;

  /// No description provided for @footprint_onboarding_result_message.
  ///
  /// In en, this message translates to:
  /// **'Your estimated CO₂e footprint includes:'**
  String get footprint_onboarding_result_message;

  /// No description provided for @footprint_onboarding_result_title.
  ///
  /// In en, this message translates to:
  /// **'Done!'**
  String get footprint_onboarding_result_title;

  /// No description provided for @footprint_onboarding_skip_message.
  ///
  /// In en, this message translates to:
  /// **'If you don\'t calculate your CO₂ footprint, it will be estimated based on the German average. In that case, you won\'t receive personalized tips, challenges, and advice to individually reduce it in the future. However, you can adjust your CO₂ footprint later at any time.'**
  String get footprint_onboarding_skip_message;

  /// No description provided for @footprint_onboarding_skip_title.
  ///
  /// In en, this message translates to:
  /// **'Skip Calculation'**
  String get footprint_onboarding_skip_title;

  /// No description provided for @footprint_onboarding_start.
  ///
  /// In en, this message translates to:
  /// **'Let\'s Go!'**
  String get footprint_onboarding_start;

  /// No description provided for @footprint_onboarding_start_message_1.
  ///
  /// In en, this message translates to:
  /// **'Answer a few short questions to get an initial estimate of your CO2e footprint. Any questions you don\'t answer will be estimated based on the German average.'**
  String get footprint_onboarding_start_message_1;

  /// No description provided for @footprint_onboarding_start_message_2.
  ///
  /// In en, this message translates to:
  /// **'Important!'**
  String get footprint_onboarding_start_message_2;

  /// No description provided for @footprint_onboarding_start_message_3.
  ///
  /// In en, this message translates to:
  /// **'You can calculate a detailed CO2e footprint directly in the app or later!'**
  String get footprint_onboarding_start_message_3;

  /// No description provided for @footprint_onboarding_start_title.
  ///
  /// In en, this message translates to:
  /// **'Calculate Your CO₂e Footprint.'**
  String get footprint_onboarding_start_title;

  /// No description provided for @footprint_trees_info_content.
  ///
  /// In en, this message translates to:
  /// **'We can assume that a mature tree absorbs an average of about 10 kg of CO₂ per year.'**
  String get footprint_trees_info_content;

  /// No description provided for @footprint_trees_info_title.
  ///
  /// In en, this message translates to:
  /// **'How is this number derived?'**
  String get footprint_trees_info_title;

  /// No description provided for @footprint_trees_message.
  ///
  /// In en, this message translates to:
  /// **'approximately mature trees needed to sequester the CO₂ emissions'**
  String get footprint_trees_message;

  /// No description provided for @footprint_unit.
  ///
  /// In en, this message translates to:
  /// **'t CO₂e / Year'**
  String get footprint_unit;

  /// No description provided for @free_time_behavior.
  ///
  /// In en, this message translates to:
  /// **'How do you mainly spend your free time?'**
  String get free_time_behavior;

  /// No description provided for @free_time_behavior_sitting_lying.
  ///
  /// In en, this message translates to:
  /// **'Sitting / Lying'**
  String get free_time_behavior_sitting_lying;

  /// No description provided for @free_time_behavior_sitting_standing.
  ///
  /// In en, this message translates to:
  /// **'Sitting / Standing'**
  String get free_time_behavior_sitting_standing;

  /// No description provided for @free_time_behavior_sitting_standing_walking.
  ///
  /// In en, this message translates to:
  /// **'Sitting / Standing / Walking'**
  String get free_time_behavior_sitting_standing_walking;

  /// No description provided for @free_time_behavior_sporty.
  ///
  /// In en, this message translates to:
  /// **'Mainly sporty'**
  String get free_time_behavior_sporty;

  /// No description provided for @free_time_behavior_standing_walking_sporty.
  ///
  /// In en, this message translates to:
  /// **'Standing / Walking / Sporty'**
  String get free_time_behavior_standing_walking_sporty;

  /// No description provided for @freight_traffic.
  ///
  /// In en, this message translates to:
  /// **'Freight Traffic'**
  String get freight_traffic;

  /// No description provided for @freight_traffic_description.
  ///
  /// In en, this message translates to:
  /// **'Based on the territorial principle, we calculated the average kilometers covered by freight transport in the German transport network. It is noted that the share is significantly lower than for a car, but the emission values are considered higher.'**
  String get freight_traffic_description;

  /// No description provided for @frozen_food.
  ///
  /// In en, this message translates to:
  /// **'How often do you consume frozen food?'**
  String get frozen_food;

  /// No description provided for @frozen_food_daily.
  ///
  /// In en, this message translates to:
  /// **'Daily'**
  String get frozen_food_daily;

  /// No description provided for @frozen_food_never.
  ///
  /// In en, this message translates to:
  /// **'Never / occasionally'**
  String get frozen_food_never;

  /// No description provided for @frozen_food_weekly.
  ///
  /// In en, this message translates to:
  /// **'1-3 times/week'**
  String get frozen_food_weekly;

  /// No description provided for @gender.
  ///
  /// In en, this message translates to:
  /// **'What is your gender?'**
  String get gender;

  /// No description provided for @gender_diverse.
  ///
  /// In en, this message translates to:
  /// **'Diverse'**
  String get gender_diverse;

  /// No description provided for @gender_female.
  ///
  /// In en, this message translates to:
  /// **'Female'**
  String get gender_female;

  /// No description provided for @gender_male.
  ///
  /// In en, this message translates to:
  /// **'Male'**
  String get gender_male;

  /// No description provided for @gender_no_value.
  ///
  /// In en, this message translates to:
  /// **'Prefer not to say'**
  String get gender_no_value;

  /// No description provided for @general.
  ///
  /// In en, this message translates to:
  /// **'General'**
  String get general;

  /// No description provided for @heat_generator.
  ///
  /// In en, this message translates to:
  /// **'What type of heat generator do you primarily use to heat your building?'**
  String get heat_generator;

  /// No description provided for @heat_generator_boiler.
  ///
  /// In en, this message translates to:
  /// **'Boiler / Heating system'**
  String get heat_generator_boiler;

  /// No description provided for @heat_generator_district_heating.
  ///
  /// In en, this message translates to:
  /// **'District heating connection'**
  String get heat_generator_district_heating;

  /// No description provided for @heat_generator_heat_pump.
  ///
  /// In en, this message translates to:
  /// **'Heat pump'**
  String get heat_generator_heat_pump;

  /// No description provided for @heat_water_separated.
  ///
  /// In en, this message translates to:
  /// **'Are your hot water and heating systems separated?'**
  String get heat_water_separated;

  /// No description provided for @hobbies.
  ///
  /// In en, this message translates to:
  /// **'Hobbies'**
  String get hobbies;

  /// No description provided for @housing.
  ///
  /// In en, this message translates to:
  /// **'Do you own or rent the apartment or house?'**
  String get housing;

  /// No description provided for @housing_ownership.
  ///
  /// In en, this message translates to:
  /// **'Ownership'**
  String get housing_ownership;

  /// No description provided for @housing_rent.
  ///
  /// In en, this message translates to:
  /// **'Rent'**
  String get housing_rent;

  /// No description provided for @info_calculator_section.
  ///
  /// In en, this message translates to:
  /// **'More Information'**
  String get info_calculator_section;

  /// No description provided for @info_calculator_section_message.
  ///
  /// In en, this message translates to:
  /// **'Learn more about the category'**
  String get info_calculator_section_message;

  /// No description provided for @leave_calculator_section_content.
  ///
  /// In en, this message translates to:
  /// **'You have unsaved data. Do you really want to leave this page?'**
  String get leave_calculator_section_content;

  /// No description provided for @leave_calculator_section_title.
  ///
  /// In en, this message translates to:
  /// **'Leave Calculation'**
  String get leave_calculator_section_title;

  /// No description provided for @leave_department.
  ///
  /// In en, this message translates to:
  /// **'Leave Department'**
  String get leave_department;

  /// No description provided for @leave_team.
  ///
  /// In en, this message translates to:
  /// **'Leave Team'**
  String get leave_team;

  /// No description provided for @living.
  ///
  /// In en, this message translates to:
  /// **'Living'**
  String get living;

  /// No description provided for @living_area.
  ///
  /// In en, this message translates to:
  /// **'What is the living area of your apartment or house in square meters?'**
  String get living_area;

  /// No description provided for @living_area_unit.
  ///
  /// In en, this message translates to:
  /// **'m²'**
  String get living_area_unit;

  /// No description provided for @living_information.
  ///
  /// In en, this message translates to:
  /// **'Enter information about the building you live in. Your consumption data will be derived from this information. The most accurate CO₂ emissions can be calculated if you provide your personal consumption data from your electricity or heat supplier\'s bill. However, information about the building and heating structure is also essential to determine your individual CO₂ reduction potential.'**
  String get living_information;

  /// No description provided for @means_of_transport.
  ///
  /// In en, this message translates to:
  /// **'Means of Transport'**
  String get means_of_transport;

  /// No description provided for @means_of_transport_onboarding.
  ///
  /// In en, this message translates to:
  /// **'Which means of transportation do you use in your daily life?'**
  String get means_of_transport_onboarding;

  /// No description provided for @mobility.
  ///
  /// In en, this message translates to:
  /// **'Mobility'**
  String get mobility;

  /// No description provided for @monthly_expenses.
  ///
  /// In en, this message translates to:
  /// **'How much do you spend on average per month on products and services?'**
  String get monthly_expenses;

  /// No description provided for @monthly_expenses_unit.
  ///
  /// In en, this message translates to:
  /// **'€'**
  String get monthly_expenses_unit;

  /// No description provided for @motorcycle.
  ///
  /// In en, this message translates to:
  /// **'Motorcycle / Moped'**
  String get motorcycle;

  /// No description provided for @motorcycle_type.
  ///
  /// In en, this message translates to:
  /// **'Do you own a motorcycle/moped or use moped-sharing services?'**
  String get motorcycle_type;

  /// No description provided for @motorcycle_type_own_motorcycle.
  ///
  /// In en, this message translates to:
  /// **'Own motorcycle/moped'**
  String get motorcycle_type_own_motorcycle;

  /// No description provided for @motorcycle_type_sharing.
  ///
  /// In en, this message translates to:
  /// **'Moped-sharing service'**
  String get motorcycle_type_sharing;

  /// No description provided for @nutrition.
  ///
  /// In en, this message translates to:
  /// **'Nutrition'**
  String get nutrition;

  /// No description provided for @nutrition_information.
  ///
  /// In en, this message translates to:
  /// **'Enter here how you move in everyday life, how you eat, and which foods you consume. The interaction of all these factors has a decisive influence on the CO₂ emissions in this category. The age, gender, and weight of the person determine the basic energy consumption that a person needs in calories per day at rest. The activity behavior influences performance and depends on physical activity at work and in leisure time. We meet our daily energy needs with food. Not all foods are rated equally in terms of their production.'**
  String get nutrition_information;

  /// No description provided for @nutrition_meat_reduced.
  ///
  /// In en, this message translates to:
  /// **'Meat reduced'**
  String get nutrition_meat_reduced;

  /// No description provided for @nutrition_meaty.
  ///
  /// In en, this message translates to:
  /// **'Meat-rich'**
  String get nutrition_meaty;

  /// No description provided for @nutrition_mixed.
  ///
  /// In en, this message translates to:
  /// **'Mixed diet'**
  String get nutrition_mixed;

  /// No description provided for @nutrition_question.
  ///
  /// In en, this message translates to:
  /// **'How would you best describe your nutrition?'**
  String get nutrition_question;

  /// No description provided for @nutrition_vegan.
  ///
  /// In en, this message translates to:
  /// **'Vegan'**
  String get nutrition_vegan;

  /// No description provided for @nutrition_vegetarian.
  ///
  /// In en, this message translates to:
  /// **'Vegetarian'**
  String get nutrition_vegetarian;

  /// No description provided for @partner_view_title.
  ///
  /// In en, this message translates to:
  /// **'Partnership'**
  String get partner_view_title;

  /// No description provided for @people_in_household.
  ///
  /// In en, this message translates to:
  /// **'How many people, including yourself, permanently live in your household?'**
  String get people_in_household;

  /// No description provided for @permissions_message_camera.
  ///
  /// In en, this message translates to:
  /// **'To take photos, allow access to your phone\'s camera in settings.'**
  String get permissions_message_camera;

  /// No description provided for @permissions_message_photo.
  ///
  /// In en, this message translates to:
  /// **'To add photos, allow access to your phone\'s gallery in settings.'**
  String get permissions_message_photo;

  /// No description provided for @permissions_missing_dismiss.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get permissions_missing_dismiss;

  /// No description provided for @permissions_missing_settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get permissions_missing_settings;

  /// No description provided for @permissions_missing_title.
  ///
  /// In en, this message translates to:
  /// **'Please allow access'**
  String get permissions_missing_title;

  /// No description provided for @pets.
  ///
  /// In en, this message translates to:
  /// **'Pets'**
  String get pets;

  /// No description provided for @pets_bird.
  ///
  /// In en, this message translates to:
  /// **'Bird'**
  String get pets_bird;

  /// No description provided for @pets_bird_reference.
  ///
  /// In en, this message translates to:
  /// **'Where did you get your bird from?'**
  String get pets_bird_reference;

  /// No description provided for @pets_bird_reference_breeding.
  ///
  /// In en, this message translates to:
  /// **'Breeding / Pet store'**
  String get pets_bird_reference_breeding;

  /// No description provided for @pets_bird_reference_shelter.
  ///
  /// In en, this message translates to:
  /// **'Animal shelter / Adoption'**
  String get pets_bird_reference_shelter;

  /// No description provided for @pets_bird_share.
  ///
  /// In en, this message translates to:
  /// **'Do you share your bird with other people? If so, how many?'**
  String get pets_bird_share;

  /// No description provided for @pets_cat.
  ///
  /// In en, this message translates to:
  /// **'Cat'**
  String get pets_cat;

  /// No description provided for @pets_cat_nutrition.
  ///
  /// In en, this message translates to:
  /// **'How do you feed your cat?'**
  String get pets_cat_nutrition;

  /// No description provided for @pets_cat_nutrition_barf.
  ///
  /// In en, this message translates to:
  /// **'BARF'**
  String get pets_cat_nutrition_barf;

  /// No description provided for @pets_cat_nutrition_normal.
  ///
  /// In en, this message translates to:
  /// **'Normal'**
  String get pets_cat_nutrition_normal;

  /// No description provided for @pets_cat_reference.
  ///
  /// In en, this message translates to:
  /// **'Where did you get your cat from?'**
  String get pets_cat_reference;

  /// No description provided for @pets_cat_reference_breeding.
  ///
  /// In en, this message translates to:
  /// **'Breeding / Pet store'**
  String get pets_cat_reference_breeding;

  /// No description provided for @pets_cat_reference_shelter.
  ///
  /// In en, this message translates to:
  /// **'Animal shelter / Adoption'**
  String get pets_cat_reference_shelter;

  /// No description provided for @pets_cat_share.
  ///
  /// In en, this message translates to:
  /// **'Do you share your cat with other people? If so, how many?'**
  String get pets_cat_share;

  /// No description provided for @pets_cat_weight.
  ///
  /// In en, this message translates to:
  /// **'How much does your cat weigh?'**
  String get pets_cat_weight;

  /// No description provided for @pets_cat_weight_unit.
  ///
  /// In en, this message translates to:
  /// **'kg'**
  String get pets_cat_weight_unit;

  /// No description provided for @pets_dog.
  ///
  /// In en, this message translates to:
  /// **'Dog'**
  String get pets_dog;

  /// No description provided for @pets_dog_nutrition.
  ///
  /// In en, this message translates to:
  /// **'How do you feed your dog?'**
  String get pets_dog_nutrition;

  /// No description provided for @pets_dog_nutrition_barf.
  ///
  /// In en, this message translates to:
  /// **'BARF'**
  String get pets_dog_nutrition_barf;

  /// No description provided for @pets_dog_nutrition_normal.
  ///
  /// In en, this message translates to:
  /// **'Normal'**
  String get pets_dog_nutrition_normal;

  /// No description provided for @pets_dog_reference.
  ///
  /// In en, this message translates to:
  /// **'Where did you get your dog from?'**
  String get pets_dog_reference;

  /// No description provided for @pets_dog_reference_breeding.
  ///
  /// In en, this message translates to:
  /// **'Breeding / Pet store'**
  String get pets_dog_reference_breeding;

  /// No description provided for @pets_dog_reference_shelter.
  ///
  /// In en, this message translates to:
  /// **'Animal shelter / Adoption'**
  String get pets_dog_reference_shelter;

  /// No description provided for @pets_dog_share.
  ///
  /// In en, this message translates to:
  /// **'Do you share your dog with other people? If so, how many?'**
  String get pets_dog_share;

  /// No description provided for @pets_dog_weight.
  ///
  /// In en, this message translates to:
  /// **'How much does your dog weigh?'**
  String get pets_dog_weight;

  /// No description provided for @pets_dog_weight_unit.
  ///
  /// In en, this message translates to:
  /// **'kg'**
  String get pets_dog_weight_unit;

  /// No description provided for @pets_fish.
  ///
  /// In en, this message translates to:
  /// **'Fish'**
  String get pets_fish;

  /// No description provided for @pets_fish_reference.
  ///
  /// In en, this message translates to:
  /// **'Where did you get your fish from?'**
  String get pets_fish_reference;

  /// No description provided for @pets_fish_reference_breeding.
  ///
  /// In en, this message translates to:
  /// **'Breeding / Pet store'**
  String get pets_fish_reference_breeding;

  /// No description provided for @pets_fish_reference_shelter.
  ///
  /// In en, this message translates to:
  /// **'Animal shelter / Adoption'**
  String get pets_fish_reference_shelter;

  /// No description provided for @pets_fish_share.
  ///
  /// In en, this message translates to:
  /// **'Do you share your fish with other people? If so, how many?'**
  String get pets_fish_share;

  /// No description provided for @pets_horse.
  ///
  /// In en, this message translates to:
  /// **'Horse'**
  String get pets_horse;

  /// No description provided for @pets_horse_nutrition.
  ///
  /// In en, this message translates to:
  /// **'How do you feed your horse?'**
  String get pets_horse_nutrition;

  /// No description provided for @pets_horse_nutrition_normal.
  ///
  /// In en, this message translates to:
  /// **'Normal'**
  String get pets_horse_nutrition_normal;

  /// No description provided for @pets_horse_nutrition_simple.
  ///
  /// In en, this message translates to:
  /// **'Simple'**
  String get pets_horse_nutrition_simple;

  /// No description provided for @pets_horse_reference.
  ///
  /// In en, this message translates to:
  /// **'Where did you get your horse from?'**
  String get pets_horse_reference;

  /// No description provided for @pets_horse_reference_breeding.
  ///
  /// In en, this message translates to:
  /// **'Breeding / Pet store'**
  String get pets_horse_reference_breeding;

  /// No description provided for @pets_horse_reference_shelter.
  ///
  /// In en, this message translates to:
  /// **'Animal shelter / Adoption'**
  String get pets_horse_reference_shelter;

  /// No description provided for @pets_horse_share.
  ///
  /// In en, this message translates to:
  /// **'Do you share your horse with other people? If so, how many?'**
  String get pets_horse_share;

  /// No description provided for @pets_horse_weight.
  ///
  /// In en, this message translates to:
  /// **'How much does your horse weigh?'**
  String get pets_horse_weight;

  /// No description provided for @pets_horse_weight_unit.
  ///
  /// In en, this message translates to:
  /// **'kg'**
  String get pets_horse_weight_unit;

  /// No description provided for @pets_reptiles.
  ///
  /// In en, this message translates to:
  /// **'Reptile'**
  String get pets_reptiles;

  /// No description provided for @pets_reptiles_reference.
  ///
  /// In en, this message translates to:
  /// **'Where did you get your reptile from?'**
  String get pets_reptiles_reference;

  /// No description provided for @pets_reptiles_reference_breeding.
  ///
  /// In en, this message translates to:
  /// **'Breeding / Pet store'**
  String get pets_reptiles_reference_breeding;

  /// No description provided for @pets_reptiles_reference_shelter.
  ///
  /// In en, this message translates to:
  /// **'Animal shelter / Adoption'**
  String get pets_reptiles_reference_shelter;

  /// No description provided for @pets_reptiles_share.
  ///
  /// In en, this message translates to:
  /// **'Do you share your reptile with other people? If so, how many?'**
  String get pets_reptiles_share;

  /// No description provided for @pets_rodent.
  ///
  /// In en, this message translates to:
  /// **'Rodent'**
  String get pets_rodent;

  /// No description provided for @pets_rodent_reference.
  ///
  /// In en, this message translates to:
  /// **'Where did you get your rodent from?'**
  String get pets_rodent_reference;

  /// No description provided for @pets_rodent_reference_breeding.
  ///
  /// In en, this message translates to:
  /// **'Breeding / Pet store'**
  String get pets_rodent_reference_breeding;

  /// No description provided for @pets_rodent_reference_shelter.
  ///
  /// In en, this message translates to:
  /// **'Animal shelter / Adoption'**
  String get pets_rodent_reference_shelter;

  /// No description provided for @pets_rodent_share.
  ///
  /// In en, this message translates to:
  /// **'Do you share your rodent with other people? If so, how many?'**
  String get pets_rodent_share;

  /// No description provided for @power_consumption_source.
  ///
  /// In en, this message translates to:
  /// **'Based on what do you have your electricity contract?'**
  String get power_consumption_source;

  /// No description provided for @power_consumption_source_green.
  ///
  /// In en, this message translates to:
  /// **'Green Power'**
  String get power_consumption_source_green;

  /// No description provided for @power_consumption_source_mix.
  ///
  /// In en, this message translates to:
  /// **'Power Mix'**
  String get power_consumption_source_mix;

  /// No description provided for @profile_about_me.
  ///
  /// In en, this message translates to:
  /// **'About Me'**
  String get profile_about_me;

  /// No description provided for @profile_email.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get profile_email;

  /// No description provided for @profile_image_delete.
  ///
  /// In en, this message translates to:
  /// **'Delete Profile Picture'**
  String get profile_image_delete;

  /// No description provided for @profile_image_delete_message.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete your profile picture?'**
  String get profile_image_delete_message;

  /// No description provided for @profile_incorrect_postal_code.
  ///
  /// In en, this message translates to:
  /// **'Invalid Postal Code'**
  String get profile_incorrect_postal_code;

  /// No description provided for @profile_mandatory_fields_hint.
  ///
  /// In en, this message translates to:
  /// **'Mandatory for registered study participants'**
  String get profile_mandatory_fields_hint;

  /// No description provided for @profile_name.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get profile_name;

  /// No description provided for @profile_name_unknown.
  ///
  /// In en, this message translates to:
  /// **'Unknown'**
  String get profile_name_unknown;

  /// No description provided for @profile_postal_code.
  ///
  /// In en, this message translates to:
  /// **'Postal Code'**
  String get profile_postal_code;

  /// No description provided for @profile_test_user_activate.
  ///
  /// In en, this message translates to:
  /// **'I am a registered study participant'**
  String get profile_test_user_activate;

  /// No description provided for @profile_test_user_deactivate.
  ///
  /// In en, this message translates to:
  /// **'Withdraw registration as a study participant'**
  String get profile_test_user_deactivate;

  /// No description provided for @profile_test_user_deactivate_message.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to withdraw as a study participant? By doing so, you will leave the University of Kassel\'s study, and your access credentials will be reset.'**
  String get profile_test_user_deactivate_message;

  /// No description provided for @profile_test_user_federal_state.
  ///
  /// In en, this message translates to:
  /// **'Federal State'**
  String get profile_test_user_federal_state;

  /// No description provided for @profile_test_user_federal_state_validate.
  ///
  /// In en, this message translates to:
  /// **'Please select a federal state'**
  String get profile_test_user_federal_state_validate;

  /// No description provided for @profile_test_user_password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get profile_test_user_password;

  /// No description provided for @profile_test_user_password_empty.
  ///
  /// In en, this message translates to:
  /// **'Please provide the password'**
  String get profile_test_user_password_empty;

  /// No description provided for @profile_test_user_password_wrong.
  ///
  /// In en, this message translates to:
  /// **'Invalid password'**
  String get profile_test_user_password_wrong;

  /// No description provided for @profile_test_user_token.
  ///
  /// In en, this message translates to:
  /// **'Access Key'**
  String get profile_test_user_token;

  /// No description provided for @profile_test_user_token_validate.
  ///
  /// In en, this message translates to:
  /// **'Please provide your access key'**
  String get profile_test_user_token_validate;

  /// No description provided for @projects_donations_info.
  ///
  /// In en, this message translates to:
  /// **'kg CO₂e emissions are saved annually thanks to your support for projects'**
  String get projects_donations_info;

  /// No description provided for @public.
  ///
  /// In en, this message translates to:
  /// **'Public'**
  String get public;

  /// No description provided for @public_general_information.
  ///
  /// In en, this message translates to:
  /// **'General Information'**
  String get public_general_information;

  /// No description provided for @public_general_information_description.
  ///
  /// In en, this message translates to:
  /// **'In this category, emissions caused by providing public infrastructure are allocated to an average citizen in Germany. There is no direct possibility for citizens to influence this sector.'**
  String get public_general_information_description;

  /// No description provided for @public_kassel.
  ///
  /// In en, this message translates to:
  /// **'Public Emissions Kassel'**
  String get public_kassel;

  /// No description provided for @public_properties.
  ///
  /// In en, this message translates to:
  /// **'Public Properties'**
  String get public_properties;

  /// No description provided for @public_properties_description.
  ///
  /// In en, this message translates to:
  /// **'Public properties are buildings and services necessary for the maintenance and organization of municipal operations. Examples include municipal administration buildings such as the town hall, as well as medical facilities, fire department, police, schools, etc.'**
  String get public_properties_description;

  /// No description provided for @public_transport.
  ///
  /// In en, this message translates to:
  /// **'Public Transport'**
  String get public_transport;

  /// No description provided for @public_transport_distance_bus_long.
  ///
  /// In en, this message translates to:
  /// **'How many kilometers do you travel by bus (long-distance) on average per year?'**
  String get public_transport_distance_bus_long;

  /// No description provided for @public_transport_distance_bus_long_unit.
  ///
  /// In en, this message translates to:
  /// **'km / year'**
  String get public_transport_distance_bus_long_unit;

  /// No description provided for @public_transport_distance_bus_near.
  ///
  /// In en, this message translates to:
  /// **'How many kilometers do you travel by bus (local transport) on average per year?'**
  String get public_transport_distance_bus_near;

  /// No description provided for @public_transport_distance_bus_near_unit.
  ///
  /// In en, this message translates to:
  /// **'km / year'**
  String get public_transport_distance_bus_near_unit;

  /// No description provided for @public_transport_distance_general.
  ///
  /// In en, this message translates to:
  /// **'General distance'**
  String get public_transport_distance_general;

  /// No description provided for @public_transport_distance_general_unit.
  ///
  /// In en, this message translates to:
  /// **'km / year'**
  String get public_transport_distance_general_unit;

  /// No description provided for @public_transport_distance_train_long.
  ///
  /// In en, this message translates to:
  /// **'How many kilometers do you travel by train (long-distance) on average per year?'**
  String get public_transport_distance_train_long;

  /// No description provided for @public_transport_distance_train_long_unit.
  ///
  /// In en, this message translates to:
  /// **'km / year'**
  String get public_transport_distance_train_long_unit;

  /// No description provided for @public_transport_distance_train_near.
  ///
  /// In en, this message translates to:
  /// **'How many kilometers do you travel by train (local transport) on average per year?'**
  String get public_transport_distance_train_near;

  /// No description provided for @public_transport_distance_train_near_unit.
  ///
  /// In en, this message translates to:
  /// **'km / year'**
  String get public_transport_distance_train_near_unit;

  /// No description provided for @purchasing_behavior.
  ///
  /// In en, this message translates to:
  /// **'Which products/foods do you mainly consume for daily use?'**
  String get purchasing_behavior;

  /// No description provided for @purchasing_behavior_bio.
  ///
  /// In en, this message translates to:
  /// **'Organic products'**
  String get purchasing_behavior_bio;

  /// No description provided for @purchasing_behavior_own_cultivation.
  ///
  /// In en, this message translates to:
  /// **'Own cultivation'**
  String get purchasing_behavior_own_cultivation;

  /// No description provided for @purchasing_behavior_regional.
  ///
  /// In en, this message translates to:
  /// **'Regional products'**
  String get purchasing_behavior_regional;

  /// No description provided for @purchasing_behavior_regional_seasonal.
  ///
  /// In en, this message translates to:
  /// **'Regional + seasonal products'**
  String get purchasing_behavior_regional_seasonal;

  /// No description provided for @purchasing_behavior_supermarket.
  ///
  /// In en, this message translates to:
  /// **'Conventional supermarket products'**
  String get purchasing_behavior_supermarket;

  /// No description provided for @quiz_repeat_message.
  ///
  /// In en, this message translates to:
  /// **'Would you like to repeat this quiz question?'**
  String get quiz_repeat_message;

  /// No description provided for @quiz_repeat_title.
  ///
  /// In en, this message translates to:
  /// **'Repeat quiz question'**
  String get quiz_repeat_title;

  /// No description provided for @quiz_result_correct_answer.
  ///
  /// In en, this message translates to:
  /// **'Great! Your answer was correct 🎉'**
  String get quiz_result_correct_answer;

  /// No description provided for @quiz_result_wrong_answer.
  ///
  /// In en, this message translates to:
  /// **'Too bad! Your answer was incorrect 🤓'**
  String get quiz_result_wrong_answer;

  /// No description provided for @remove_calculator_group_input_content.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to remove this entry?'**
  String get remove_calculator_group_input_content;

  /// No description provided for @remove_calculator_group_input_title.
  ///
  /// In en, this message translates to:
  /// **'Remove Entry'**
  String get remove_calculator_group_input_title;

  /// No description provided for @renovation_since_construction.
  ///
  /// In en, this message translates to:
  /// **'Has your building undergone energy-efficient renovations since construction?'**
  String get renovation_since_construction;

  /// No description provided for @revoke_deletion_request_question.
  ///
  /// In en, this message translates to:
  /// **'Do you really want to revoke the request to delete your account? By confirming, you can continue using the app, and your data and progress will remain intact.'**
  String get revoke_deletion_request_question;

  /// No description provided for @revoke_deletion_request_title.
  ///
  /// In en, this message translates to:
  /// **'Revoke Request'**
  String get revoke_deletion_request_title;

  /// No description provided for @reward_advent_calendar_card_loading.
  ///
  /// In en, this message translates to:
  /// **'It may take a moment for your reward to be redeemed...'**
  String get reward_advent_calendar_card_loading;

  /// No description provided for @reward_advent_calendar_card_note.
  ///
  /// In en, this message translates to:
  /// **'Click on the image to redeem the reward'**
  String get reward_advent_calendar_card_note;

  /// No description provided for @reward_advent_calendar_card_note_redeemed.
  ///
  /// In en, this message translates to:
  /// **'Go to your city here'**
  String get reward_advent_calendar_card_note_redeemed;

  /// No description provided for @reward_advent_calendar_card_title.
  ///
  /// In en, this message translates to:
  /// **'New Reward'**
  String get reward_advent_calendar_card_title;

  /// No description provided for @reward_advent_calendar_card_title_redeemed.
  ///
  /// In en, this message translates to:
  /// **'Reward has been redeemed'**
  String get reward_advent_calendar_card_title_redeemed;

  /// No description provided for @reward_assigned.
  ///
  /// In en, this message translates to:
  /// **'Received New Reward'**
  String get reward_assigned;

  /// No description provided for @rewards_current_points.
  ///
  /// In en, this message translates to:
  /// **'My Climate Points:'**
  String get rewards_current_points;

  /// No description provided for @rewards_dashboard_headline.
  ///
  /// In en, this message translates to:
  /// **'My City'**
  String get rewards_dashboard_headline;

  /// No description provided for @rewards_dashboard_hint.
  ///
  /// In en, this message translates to:
  /// **'Complete challenges to collect rewards and make your city greener.'**
  String get rewards_dashboard_hint;

  /// No description provided for @rewards_required_points.
  ///
  /// In en, this message translates to:
  /// **'Required Climate Points:'**
  String get rewards_required_points;

  /// No description provided for @rewards_success_code.
  ///
  /// In en, this message translates to:
  /// **'Congratulations! Use the following code to redeem the discount:'**
  String get rewards_success_code;

  /// No description provided for @rewards_success_screen.
  ///
  /// In en, this message translates to:
  /// **'Congratulations! Show this screen to redeem the discount.'**
  String get rewards_success_screen;

  /// No description provided for @rewards_unlock.
  ///
  /// In en, this message translates to:
  /// **'Unlocking at'**
  String get rewards_unlock;

  /// No description provided for @rewards_unlock_points.
  ///
  /// In en, this message translates to:
  /// **'Climate Points'**
  String get rewards_unlock_points;

  /// No description provided for @save_calculator_section_content.
  ///
  /// In en, this message translates to:
  /// **'Do you want to save your changes and overwrite currently saved values?'**
  String get save_calculator_section_content;

  /// No description provided for @save_calculator_section_title.
  ///
  /// In en, this message translates to:
  /// **'Update Values'**
  String get save_calculator_section_title;

  /// No description provided for @scooter.
  ///
  /// In en, this message translates to:
  /// **'Scooter'**
  String get scooter;

  /// No description provided for @scooter_distance.
  ///
  /// In en, this message translates to:
  /// **'How many kilometers do you travel on average per year?'**
  String get scooter_distance;

  /// No description provided for @scooter_distance_unit.
  ///
  /// In en, this message translates to:
  /// **'km / year'**
  String get scooter_distance_unit;

  /// No description provided for @scooter_escooter.
  ///
  /// In en, this message translates to:
  /// **'Electric scooter'**
  String get scooter_escooter;

  /// No description provided for @scooter_kick.
  ///
  /// In en, this message translates to:
  /// **'Kick scooter'**
  String get scooter_kick;

  /// No description provided for @scooter_property.
  ///
  /// In en, this message translates to:
  /// **'Do you own a scooter or use scooter-sharing services?'**
  String get scooter_property;

  /// No description provided for @scooter_property_own.
  ///
  /// In en, this message translates to:
  /// **'Own scooter'**
  String get scooter_property_own;

  /// No description provided for @scooter_property_sharing.
  ///
  /// In en, this message translates to:
  /// **'Scooter-sharing service'**
  String get scooter_property_sharing;

  /// No description provided for @scooter_type.
  ///
  /// In en, this message translates to:
  /// **'What type of scooter do you use?'**
  String get scooter_type;

  /// No description provided for @secondary_generation.
  ///
  /// In en, this message translates to:
  /// **'Does your building have supplementary secondary generation for electricity, heat, or hot water demand?'**
  String get secondary_generation;

  /// No description provided for @secondary_generation_electricity.
  ///
  /// In en, this message translates to:
  /// **'Electricity: Photovoltaic'**
  String get secondary_generation_electricity;

  /// No description provided for @secondary_generation_electricity_power.
  ///
  /// In en, this message translates to:
  /// **'What is the annual generation?'**
  String get secondary_generation_electricity_power;

  /// No description provided for @secondary_generation_electricity_power_unit.
  ///
  /// In en, this message translates to:
  /// **'kWh/a'**
  String get secondary_generation_electricity_power_unit;

  /// No description provided for @secondary_generation_heat.
  ///
  /// In en, this message translates to:
  /// **'Heat: Heat pump'**
  String get secondary_generation_heat;

  /// No description provided for @secondary_generation_heat_power.
  ///
  /// In en, this message translates to:
  /// **'What is the annual generation?'**
  String get secondary_generation_heat_power;

  /// No description provided for @secondary_generation_heat_power_unit.
  ///
  /// In en, this message translates to:
  /// **'kWh/a'**
  String get secondary_generation_heat_power_unit;

  /// No description provided for @secondary_generation_solar_thermal.
  ///
  /// In en, this message translates to:
  /// **'Heat: Solar thermal'**
  String get secondary_generation_solar_thermal;

  /// No description provided for @secondary_generation_solar_thermal_power.
  ///
  /// In en, this message translates to:
  /// **'What is the annual generation?'**
  String get secondary_generation_solar_thermal_power;

  /// No description provided for @secondary_generation_solar_thermal_power_unit.
  ///
  /// In en, this message translates to:
  /// **'kWh/a'**
  String get secondary_generation_solar_thermal_power_unit;

  /// No description provided for @settings_about_klimo.
  ///
  /// In en, this message translates to:
  /// **'About klimo'**
  String get settings_about_klimo;

  /// No description provided for @settings_account_headline.
  ///
  /// In en, this message translates to:
  /// **'Account'**
  String get settings_account_headline;

  /// No description provided for @settings_action.
  ///
  /// In en, this message translates to:
  /// **'Register Action'**
  String get settings_action;

  /// No description provided for @settings_approvals_headline.
  ///
  /// In en, this message translates to:
  /// **'Consents & Privacy'**
  String get settings_approvals_headline;

  /// No description provided for @settings_communities_headline.
  ///
  /// In en, this message translates to:
  /// **'Communities & Initiatives'**
  String get settings_communities_headline;

  /// No description provided for @settings_contact.
  ///
  /// In en, this message translates to:
  /// **'Contact'**
  String get settings_contact;

  /// No description provided for @settings_faq.
  ///
  /// In en, this message translates to:
  /// **'FAQ'**
  String get settings_faq;

  /// No description provided for @settings_feedback.
  ///
  /// In en, this message translates to:
  /// **'Feedback & Suggestions'**
  String get settings_feedback;

  /// No description provided for @settings_general_headline.
  ///
  /// In en, this message translates to:
  /// **'General'**
  String get settings_general_headline;

  /// No description provided for @settings_headline.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings_headline;

  /// No description provided for @settings_help.
  ///
  /// In en, this message translates to:
  /// **'Help / FAQ'**
  String get settings_help;

  /// No description provided for @settings_imprint.
  ///
  /// In en, this message translates to:
  /// **'Imprint'**
  String get settings_imprint;

  /// No description provided for @settings_join_switch_community.
  ///
  /// In en, this message translates to:
  /// **'Join Community'**
  String get settings_join_switch_community;

  /// No description provided for @settings_join_switch_department.
  ///
  /// In en, this message translates to:
  /// **'Join Group (District)'**
  String get settings_join_switch_department;

  /// No description provided for @settings_more_headline.
  ///
  /// In en, this message translates to:
  /// **'More'**
  String get settings_more_headline;

  /// No description provided for @settings_partner.
  ///
  /// In en, this message translates to:
  /// **'A project by:'**
  String get settings_partner;

  /// No description provided for @settings_privacy_policy.
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get settings_privacy_policy;

  /// No description provided for @settings_profile_edit.
  ///
  /// In en, this message translates to:
  /// **'Edit Profile'**
  String get settings_profile_edit;

  /// No description provided for @settings_profile_headline.
  ///
  /// In en, this message translates to:
  /// **'My Profile'**
  String get settings_profile_headline;

  /// No description provided for @settings_share.
  ///
  /// In en, this message translates to:
  /// **'Invite Friends'**
  String get settings_share;

  /// No description provided for @settings_share_data.
  ///
  /// In en, this message translates to:
  /// **'Share Data'**
  String get settings_share_data;

  /// No description provided for @settings_share_data_description.
  ///
  /// In en, this message translates to:
  /// **'We would like to use your data in an anonymized form and evaluate it in scientific studies on climate and behavioral changes.'**
  String get settings_share_data_description;

  /// No description provided for @settings_terms_of_use.
  ///
  /// In en, this message translates to:
  /// **'Terms of Use'**
  String get settings_terms_of_use;

  /// No description provided for @settings_tutorial.
  ///
  /// In en, this message translates to:
  /// **'Watch Tutorial'**
  String get settings_tutorial;

  /// No description provided for @share_message.
  ///
  /// In en, this message translates to:
  /// **'Help us promote regional climate protection! Learn how:'**
  String get share_message;

  /// No description provided for @shopping.
  ///
  /// In en, this message translates to:
  /// **'Shopping'**
  String get shopping;

  /// No description provided for @sign_in_apple.
  ///
  /// In en, this message translates to:
  /// **'Continue with Apple'**
  String get sign_in_apple;

  /// No description provided for @sign_in_button.
  ///
  /// In en, this message translates to:
  /// **'Sign In'**
  String get sign_in_button;

  /// No description provided for @sign_in_google.
  ///
  /// In en, this message translates to:
  /// **'Continue with Google'**
  String get sign_in_google;

  /// No description provided for @sign_in_mail.
  ///
  /// In en, this message translates to:
  /// **'Enter your email address to continue'**
  String get sign_in_mail;

  /// No description provided for @sign_in_mail_info.
  ///
  /// In en, this message translates to:
  /// **'We\'ve sent you an email with a magic link. To complete your registration successfully, please open this link directly on your phone.'**
  String get sign_in_mail_info;

  /// No description provided for @sign_in_mail_info_1.
  ///
  /// In en, this message translates to:
  /// **'We have sent you an email with a magic link. To complete your registration, please open the link in the email '**
  String get sign_in_mail_info_1;

  /// No description provided for @sign_in_mail_info_2.
  ///
  /// In en, this message translates to:
  /// **' directly on your phone.'**
  String get sign_in_mail_info_2;

  /// No description provided for @sign_in_open_mail.
  ///
  /// In en, this message translates to:
  /// **'Open Email App'**
  String get sign_in_open_mail;

  /// No description provided for @sign_in_other_providers.
  ///
  /// In en, this message translates to:
  /// **'Or use one of the following options'**
  String get sign_in_other_providers;

  /// No description provided for @sign_in_receive_mail.
  ///
  /// In en, this message translates to:
  /// **'You\'ve received an email'**
  String get sign_in_receive_mail;

  /// No description provided for @sign_in_resend_mail.
  ///
  /// In en, this message translates to:
  /// **'Resend Email'**
  String get sign_in_resend_mail;

  /// No description provided for @sign_in_skip_message.
  ///
  /// In en, this message translates to:
  /// **'Do you really want to continue anonymously? If you skip registration, your data cannot be restored after logging out or losing your device.'**
  String get sign_in_skip_message;

  /// No description provided for @sign_in_skip_title.
  ///
  /// In en, this message translates to:
  /// **'Continue Anonymously'**
  String get sign_in_skip_title;

  /// No description provided for @sign_in_title.
  ///
  /// In en, this message translates to:
  /// **'Please Sign In.'**
  String get sign_in_title;

  /// No description provided for @sign_out_message.
  ///
  /// In en, this message translates to:
  /// **'Do you really want to sign out?'**
  String get sign_out_message;

  /// No description provided for @sign_out_title.
  ///
  /// In en, this message translates to:
  /// **'Sign Out'**
  String get sign_out_title;

  /// No description provided for @specific_final_energy_requirement.
  ///
  /// In en, this message translates to:
  /// **'If possible, specify your final energy demand.'**
  String get specific_final_energy_requirement;

  /// No description provided for @specific_final_energy_requirement_unit.
  ///
  /// In en, this message translates to:
  /// **'kWh/m²a'**
  String get specific_final_energy_requirement_unit;

  /// No description provided for @specific_heating_requirement.
  ///
  /// In en, this message translates to:
  /// **'If possible, specify your heating energy demand.'**
  String get specific_heating_requirement;

  /// No description provided for @specific_heating_requirement_unit.
  ///
  /// In en, this message translates to:
  /// **'kWh/m²a'**
  String get specific_heating_requirement_unit;

  /// No description provided for @story_no_page.
  ///
  /// In en, this message translates to:
  /// **'No pages available'**
  String get story_no_page;

  /// No description provided for @team_create_info.
  ///
  /// In en, this message translates to:
  /// **'Information (optional)'**
  String get team_create_info;

  /// No description provided for @team_create_name.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get team_create_name;

  /// No description provided for @teams.
  ///
  /// In en, this message translates to:
  /// **'Teams'**
  String get teams;

  /// No description provided for @teams_select_title.
  ///
  /// In en, this message translates to:
  /// **'Choose Your Team'**
  String get teams_select_title;

  /// No description provided for @traffic_signals_street_lighting.
  ///
  /// In en, this message translates to:
  /// **'Traffic signals and street lighting'**
  String get traffic_signals_street_lighting;

  /// No description provided for @traffic_signals_street_lighting_description.
  ///
  /// In en, this message translates to:
  /// **'\n'**
  String get traffic_signals_street_lighting_description;

  /// No description provided for @type_of_renovation.
  ///
  /// In en, this message translates to:
  /// **'If yes, select the corresponding components (multiple selections are possible)'**
  String get type_of_renovation;

  /// No description provided for @type_of_renovation_basement_ceiling.
  ///
  /// In en, this message translates to:
  /// **'Floor / Basement ceiling'**
  String get type_of_renovation_basement_ceiling;

  /// No description provided for @type_of_renovation_facade.
  ///
  /// In en, this message translates to:
  /// **'Facade'**
  String get type_of_renovation_facade;

  /// No description provided for @type_of_renovation_roof.
  ///
  /// In en, this message translates to:
  /// **'Roof'**
  String get type_of_renovation_roof;

  /// No description provided for @type_of_renovation_window.
  ///
  /// In en, this message translates to:
  /// **'Windows'**
  String get type_of_renovation_window;

  /// No description provided for @update_calculator_section.
  ///
  /// In en, this message translates to:
  /// **'Update Data'**
  String get update_calculator_section;

  /// No description provided for @update_calculator_section_message.
  ///
  /// In en, this message translates to:
  /// **'Update your data for the category'**
  String get update_calculator_section_message;

  /// No description provided for @update_compensation_section_message.
  ///
  /// In en, this message translates to:
  /// **'Update your CO₂ emissions offset information here'**
  String get update_compensation_section_message;

  /// No description provided for @user_unknown_name.
  ///
  /// In en, this message translates to:
  /// **'You'**
  String get user_unknown_name;

  /// No description provided for @vacation.
  ///
  /// In en, this message translates to:
  /// **'Vacation'**
  String get vacation;

  /// No description provided for @vacation_active.
  ///
  /// In en, this message translates to:
  /// **'Active vacation'**
  String get vacation_active;

  /// No description provided for @vacation_active_accommodation.
  ///
  /// In en, this message translates to:
  /// **'How are you accommodated at the vacation destination?'**
  String get vacation_active_accommodation;

  /// No description provided for @vacation_active_accommodation_camping.
  ///
  /// In en, this message translates to:
  /// **'Camping'**
  String get vacation_active_accommodation_camping;

  /// No description provided for @vacation_active_accommodation_hostel.
  ///
  /// In en, this message translates to:
  /// **'Hostel / Youth hostel'**
  String get vacation_active_accommodation_hostel;

  /// No description provided for @vacation_active_accommodation_hotel.
  ///
  /// In en, this message translates to:
  /// **'Hotel'**
  String get vacation_active_accommodation_hotel;

  /// No description provided for @vacation_active_accommodation_vacation_home.
  ///
  /// In en, this message translates to:
  /// **'Holiday home / Vacation apartment'**
  String get vacation_active_accommodation_vacation_home;

  /// No description provided for @vacation_active_days.
  ///
  /// In en, this message translates to:
  /// **'How many days does your vacation last?'**
  String get vacation_active_days;

  /// No description provided for @vacation_active_destination.
  ///
  /// In en, this message translates to:
  /// **'How far is your place of residence from your vacation destination?'**
  String get vacation_active_destination;

  /// No description provided for @vacation_active_destination_unit.
  ///
  /// In en, this message translates to:
  /// **'km'**
  String get vacation_active_destination_unit;

  /// No description provided for @vacation_active_transport.
  ///
  /// In en, this message translates to:
  /// **'What is your main means of transportation to the vacation destination?'**
  String get vacation_active_transport;

  /// No description provided for @vacation_active_transport_airplane.
  ///
  /// In en, this message translates to:
  /// **'Airplane'**
  String get vacation_active_transport_airplane;

  /// No description provided for @vacation_active_transport_bus.
  ///
  /// In en, this message translates to:
  /// **'Bus'**
  String get vacation_active_transport_bus;

  /// No description provided for @vacation_active_transport_own_car.
  ///
  /// In en, this message translates to:
  /// **'Own car'**
  String get vacation_active_transport_own_car;

  /// No description provided for @vacation_active_transport_train.
  ///
  /// In en, this message translates to:
  /// **'Train'**
  String get vacation_active_transport_train;

  /// No description provided for @vacation_balcony.
  ///
  /// In en, this message translates to:
  /// **'Staycation / Vacation at home'**
  String get vacation_balcony;

  /// No description provided for @vacation_balcony_days.
  ///
  /// In en, this message translates to:
  /// **'How many days does your vacation at home last?'**
  String get vacation_balcony_days;

  /// No description provided for @vacation_balcony_destination.
  ///
  /// In en, this message translates to:
  /// **'How far is your place of residence from your vacation at home destination?'**
  String get vacation_balcony_destination;

  /// No description provided for @vacation_balcony_destination_unit.
  ///
  /// In en, this message translates to:
  /// **'km'**
  String get vacation_balcony_destination_unit;

  /// No description provided for @vacation_balcony_transport.
  ///
  /// In en, this message translates to:
  /// **'What is your main means of transportation for a vacation at home (staycation)?'**
  String get vacation_balcony_transport;

  /// No description provided for @vacation_balcony_transport_airplane.
  ///
  /// In en, this message translates to:
  /// **'Airplane'**
  String get vacation_balcony_transport_airplane;

  /// No description provided for @vacation_balcony_transport_bus.
  ///
  /// In en, this message translates to:
  /// **'Bus'**
  String get vacation_balcony_transport_bus;

  /// No description provided for @vacation_balcony_transport_own_car.
  ///
  /// In en, this message translates to:
  /// **'Own car'**
  String get vacation_balcony_transport_own_car;

  /// No description provided for @vacation_balcony_transport_train.
  ///
  /// In en, this message translates to:
  /// **'Train'**
  String get vacation_balcony_transport_train;

  /// No description provided for @vacation_beach.
  ///
  /// In en, this message translates to:
  /// **'Beach & party vacation'**
  String get vacation_beach;

  /// No description provided for @vacation_beach_accommodation.
  ///
  /// In en, this message translates to:
  /// **'How are you accommodated at the beach vacation destination?'**
  String get vacation_beach_accommodation;

  /// No description provided for @vacation_beach_accommodation_camping.
  ///
  /// In en, this message translates to:
  /// **'Camping'**
  String get vacation_beach_accommodation_camping;

  /// No description provided for @vacation_beach_accommodation_hostel.
  ///
  /// In en, this message translates to:
  /// **'Hostel / Youth hostel'**
  String get vacation_beach_accommodation_hostel;

  /// No description provided for @vacation_beach_accommodation_hotel.
  ///
  /// In en, this message translates to:
  /// **'Hotel'**
  String get vacation_beach_accommodation_hotel;

  /// No description provided for @vacation_beach_accommodation_vacation_home.
  ///
  /// In en, this message translates to:
  /// **'Holiday home / Vacation apartment'**
  String get vacation_beach_accommodation_vacation_home;

  /// No description provided for @vacation_beach_days.
  ///
  /// In en, this message translates to:
  /// **'How many days does your beach vacation last?'**
  String get vacation_beach_days;

  /// No description provided for @vacation_beach_destination.
  ///
  /// In en, this message translates to:
  /// **'How far is your place of residence from your beach vacation destination?'**
  String get vacation_beach_destination;

  /// No description provided for @vacation_beach_destination_unit.
  ///
  /// In en, this message translates to:
  /// **'km'**
  String get vacation_beach_destination_unit;

  /// No description provided for @vacation_beach_transport.
  ///
  /// In en, this message translates to:
  /// **'What is your main means of transportation to the beach vacation destination?'**
  String get vacation_beach_transport;

  /// No description provided for @vacation_beach_transport_airplane.
  ///
  /// In en, this message translates to:
  /// **'Airplane'**
  String get vacation_beach_transport_airplane;

  /// No description provided for @vacation_beach_transport_bus.
  ///
  /// In en, this message translates to:
  /// **'Bus'**
  String get vacation_beach_transport_bus;

  /// No description provided for @vacation_beach_transport_own_car.
  ///
  /// In en, this message translates to:
  /// **'Own car'**
  String get vacation_beach_transport_own_car;

  /// No description provided for @vacation_beach_transport_train.
  ///
  /// In en, this message translates to:
  /// **'Train'**
  String get vacation_beach_transport_train;

  /// No description provided for @vacation_cultural.
  ///
  /// In en, this message translates to:
  /// **'Culture & city trip'**
  String get vacation_cultural;

  /// No description provided for @vacation_cultural_accommodation.
  ///
  /// In en, this message translates to:
  /// **'How are you accommodated at the cultural vacation destination?'**
  String get vacation_cultural_accommodation;

  /// No description provided for @vacation_cultural_accommodation_camping.
  ///
  /// In en, this message translates to:
  /// **'Camping'**
  String get vacation_cultural_accommodation_camping;

  /// No description provided for @vacation_cultural_accommodation_hostel.
  ///
  /// In en, this message translates to:
  /// **'Hostel / Youth hostel'**
  String get vacation_cultural_accommodation_hostel;

  /// No description provided for @vacation_cultural_accommodation_hotel.
  ///
  /// In en, this message translates to:
  /// **'Hotel'**
  String get vacation_cultural_accommodation_hotel;

  /// No description provided for @vacation_cultural_accommodation_vacation_home.
  ///
  /// In en, this message translates to:
  /// **'Holiday home / Vacation apartment'**
  String get vacation_cultural_accommodation_vacation_home;

  /// No description provided for @vacation_cultural_days.
  ///
  /// In en, this message translates to:
  /// **'How many days does your cultural vacation last?'**
  String get vacation_cultural_days;

  /// No description provided for @vacation_cultural_destination.
  ///
  /// In en, this message translates to:
  /// **'How far is your place of residence from your cultural vacation destination?'**
  String get vacation_cultural_destination;

  /// No description provided for @vacation_cultural_destination_unit.
  ///
  /// In en, this message translates to:
  /// **'km'**
  String get vacation_cultural_destination_unit;

  /// No description provided for @vacation_cultural_transport.
  ///
  /// In en, this message translates to:
  /// **'What is your main means of transportation to the cultural vacation destination?'**
  String get vacation_cultural_transport;

  /// No description provided for @vacation_cultural_transport_airplane.
  ///
  /// In en, this message translates to:
  /// **'Airplane'**
  String get vacation_cultural_transport_airplane;

  /// No description provided for @vacation_cultural_transport_bus.
  ///
  /// In en, this message translates to:
  /// **'Bus'**
  String get vacation_cultural_transport_bus;

  /// No description provided for @vacation_cultural_transport_own_car.
  ///
  /// In en, this message translates to:
  /// **'Own car'**
  String get vacation_cultural_transport_own_car;

  /// No description provided for @vacation_cultural_transport_train.
  ///
  /// In en, this message translates to:
  /// **'Train'**
  String get vacation_cultural_transport_train;

  /// No description provided for @vacation_days_unit.
  ///
  /// In en, this message translates to:
  /// **'Days'**
  String get vacation_days_unit;

  /// No description provided for @vacation_family.
  ///
  /// In en, this message translates to:
  /// **'Family vacation'**
  String get vacation_family;

  /// No description provided for @vacation_family_accommodation.
  ///
  /// In en, this message translates to:
  /// **'How are you accommodated during the family vacation?'**
  String get vacation_family_accommodation;

  /// No description provided for @vacation_family_accommodation_camping.
  ///
  /// In en, this message translates to:
  /// **'Camping'**
  String get vacation_family_accommodation_camping;

  /// No description provided for @vacation_family_accommodation_hostel.
  ///
  /// In en, this message translates to:
  /// **'Hostel / Youth hostel'**
  String get vacation_family_accommodation_hostel;

  /// No description provided for @vacation_family_accommodation_hotel.
  ///
  /// In en, this message translates to:
  /// **'Hotel'**
  String get vacation_family_accommodation_hotel;

  /// No description provided for @vacation_family_accommodation_vacation_home.
  ///
  /// In en, this message translates to:
  /// **'Holiday home / Vacation apartment'**
  String get vacation_family_accommodation_vacation_home;

  /// No description provided for @vacation_family_days.
  ///
  /// In en, this message translates to:
  /// **'How many days does your family vacation last?'**
  String get vacation_family_days;

  /// No description provided for @vacation_family_destination.
  ///
  /// In en, this message translates to:
  /// **'How far is your place of residence from your family vacation destination?'**
  String get vacation_family_destination;

  /// No description provided for @vacation_family_destination_unit.
  ///
  /// In en, this message translates to:
  /// **'km'**
  String get vacation_family_destination_unit;

  /// No description provided for @vacation_family_transport.
  ///
  /// In en, this message translates to:
  /// **'What is your main means of transportation to the family vacation destination?'**
  String get vacation_family_transport;

  /// No description provided for @vacation_family_transport_airplane.
  ///
  /// In en, this message translates to:
  /// **'Airplane'**
  String get vacation_family_transport_airplane;

  /// No description provided for @vacation_family_transport_bus.
  ///
  /// In en, this message translates to:
  /// **'Bus'**
  String get vacation_family_transport_bus;

  /// No description provided for @vacation_family_transport_own_car.
  ///
  /// In en, this message translates to:
  /// **'Own car'**
  String get vacation_family_transport_own_car;

  /// No description provided for @vacation_family_transport_train.
  ///
  /// In en, this message translates to:
  /// **'Train'**
  String get vacation_family_transport_train;

  /// No description provided for @vacation_shipping.
  ///
  /// In en, this message translates to:
  /// **'Cruise'**
  String get vacation_shipping;

  /// No description provided for @vacation_shipping_days.
  ///
  /// In en, this message translates to:
  /// **'How many days does your cruise vacation last?'**
  String get vacation_shipping_days;

  /// No description provided for @vacation_shipping_destination.
  ///
  /// In en, this message translates to:
  /// **'How far is your place of residence from your cruise vacation destination?'**
  String get vacation_shipping_destination;

  /// No description provided for @vacation_shipping_destination_unit.
  ///
  /// In en, this message translates to:
  /// **'km'**
  String get vacation_shipping_destination_unit;

  /// No description provided for @vacation_shipping_transport.
  ///
  /// In en, this message translates to:
  /// **'What is your main means of transportation to the cruise vacation destination?'**
  String get vacation_shipping_transport;

  /// No description provided for @vacation_shipping_transport_airplane.
  ///
  /// In en, this message translates to:
  /// **'Airplane'**
  String get vacation_shipping_transport_airplane;

  /// No description provided for @vacation_shipping_transport_bus.
  ///
  /// In en, this message translates to:
  /// **'Bus'**
  String get vacation_shipping_transport_bus;

  /// No description provided for @vacation_shipping_transport_own_car.
  ///
  /// In en, this message translates to:
  /// **'Own car'**
  String get vacation_shipping_transport_own_car;

  /// No description provided for @vacation_shipping_transport_train.
  ///
  /// In en, this message translates to:
  /// **'Train'**
  String get vacation_shipping_transport_train;

  /// No description provided for @vacation_skiing.
  ///
  /// In en, this message translates to:
  /// **'Ski vacation'**
  String get vacation_skiing;

  /// No description provided for @vacation_skiing_accommodation.
  ///
  /// In en, this message translates to:
  /// **'How are you accommodated at the ski vacation destination?'**
  String get vacation_skiing_accommodation;

  /// No description provided for @vacation_skiing_accommodation_camping.
  ///
  /// In en, this message translates to:
  /// **'Camping'**
  String get vacation_skiing_accommodation_camping;

  /// No description provided for @vacation_skiing_accommodation_hostel.
  ///
  /// In en, this message translates to:
  /// **'Hostel / Youth hostel'**
  String get vacation_skiing_accommodation_hostel;

  /// No description provided for @vacation_skiing_accommodation_hotel.
  ///
  /// In en, this message translates to:
  /// **'Hotel'**
  String get vacation_skiing_accommodation_hotel;

  /// No description provided for @vacation_skiing_accommodation_vacation_home.
  ///
  /// In en, this message translates to:
  /// **'Holiday home / Vacation apartment'**
  String get vacation_skiing_accommodation_vacation_home;

  /// No description provided for @vacation_skiing_days.
  ///
  /// In en, this message translates to:
  /// **'How many days does your ski vacation last?'**
  String get vacation_skiing_days;

  /// No description provided for @vacation_skiing_destination.
  ///
  /// In en, this message translates to:
  /// **'How far is your place of residence from your ski vacation destination?'**
  String get vacation_skiing_destination;

  /// No description provided for @vacation_skiing_destination_unit.
  ///
  /// In en, this message translates to:
  /// **'km'**
  String get vacation_skiing_destination_unit;

  /// No description provided for @vacation_skiing_transport.
  ///
  /// In en, this message translates to:
  /// **'What is your main means of transportation to the ski vacation destination?'**
  String get vacation_skiing_transport;

  /// No description provided for @vacation_skiing_transport_airplane.
  ///
  /// In en, this message translates to:
  /// **'Airplane'**
  String get vacation_skiing_transport_airplane;

  /// No description provided for @vacation_skiing_transport_bus.
  ///
  /// In en, this message translates to:
  /// **'Bus'**
  String get vacation_skiing_transport_bus;

  /// No description provided for @vacation_skiing_transport_own_car.
  ///
  /// In en, this message translates to:
  /// **'Own car'**
  String get vacation_skiing_transport_own_car;

  /// No description provided for @vacation_skiing_transport_train.
  ///
  /// In en, this message translates to:
  /// **'Train'**
  String get vacation_skiing_transport_train;

  /// No description provided for @waste_recycling_management.
  ///
  /// In en, this message translates to:
  /// **'Waste and Recycling Management'**
  String get waste_recycling_management;

  /// No description provided for @waste_recycling_management_description.
  ///
  /// In en, this message translates to:
  /// **'According to the Circular Economy Act, the city is obliged to implement and ensure resource-saving waste and recycling management. In addition to waste disposal and recycling, this also includes the cleaning of wastewater.'**
  String get waste_recycling_management_description;

  /// No description provided for @weight_101_to_110.
  ///
  /// In en, this message translates to:
  /// **'101 - 110 kg'**
  String get weight_101_to_110;

  /// No description provided for @weight_111_to_120.
  ///
  /// In en, this message translates to:
  /// **'111 - 120 kg'**
  String get weight_111_to_120;

  /// No description provided for @weight_41_to_50.
  ///
  /// In en, this message translates to:
  /// **'41 - 50 kg'**
  String get weight_41_to_50;

  /// No description provided for @weight_51_to_60.
  ///
  /// In en, this message translates to:
  /// **'51 - 60 kg'**
  String get weight_51_to_60;

  /// No description provided for @weight_61_to_70.
  ///
  /// In en, this message translates to:
  /// **'61 - 70 kg'**
  String get weight_61_to_70;

  /// No description provided for @weight_71_to_80.
  ///
  /// In en, this message translates to:
  /// **'71 - 80 kg'**
  String get weight_71_to_80;

  /// No description provided for @weight_81_to_90.
  ///
  /// In en, this message translates to:
  /// **'81 - 90 kg'**
  String get weight_81_to_90;

  /// No description provided for @weight_91_to_100.
  ///
  /// In en, this message translates to:
  /// **'91 - 100 kg'**
  String get weight_91_to_100;

  /// No description provided for @weight_more_than_120.
  ///
  /// In en, this message translates to:
  /// **'more than 120 kg'**
  String get weight_more_than_120;

  /// No description provided for @weight_range.
  ///
  /// In en, this message translates to:
  /// **'What weight category do you belong to?'**
  String get weight_range;

  /// No description provided for @weight_up_to_40.
  ///
  /// In en, this message translates to:
  /// **'40 kg or less'**
  String get weight_up_to_40;

  /// No description provided for @welcome_already_signed_in.
  ///
  /// In en, this message translates to:
  /// **'Already registered?'**
  String get welcome_already_signed_in;

  /// No description provided for @welcome_button_start.
  ///
  /// In en, this message translates to:
  /// **'Let\'s Go!'**
  String get welcome_button_start;

  /// No description provided for @welcome_contact.
  ///
  /// In en, this message translates to:
  /// **'Do you want to contact us?'**
  String get welcome_contact;

  /// No description provided for @welcome_contact_message.
  ///
  /// In en, this message translates to:
  /// **'Send us an email'**
  String get welcome_contact_message;

  /// No description provided for @welcome_start.
  ///
  /// In en, this message translates to:
  /// **'Get Started Now'**
  String get welcome_start;

  /// No description provided for @welcome_subtitle.
  ///
  /// In en, this message translates to:
  /// **'With the klimo app for regional climate protection'**
  String get welcome_subtitle;

  /// No description provided for @welcome_title.
  ///
  /// In en, this message translates to:
  /// **'Welcome'**
  String get welcome_title;

  /// No description provided for @welcome_tutorial_1.
  ///
  /// In en, this message translates to:
  /// **'Engage in regional climate protection with the klimo app. Find out '**
  String get welcome_tutorial_1;

  /// No description provided for @welcome_tutorial_2.
  ///
  /// In en, this message translates to:
  /// **'here'**
  String get welcome_tutorial_2;

  /// No description provided for @welcome_tutorial_3.
  ///
  /// In en, this message translates to:
  /// **'how.'**
  String get welcome_tutorial_3;

  /// No description provided for @work_behavior.
  ///
  /// In en, this message translates to:
  /// **'What is your work behavior?'**
  String get work_behavior;

  /// No description provided for @work_behavior_hard_work.
  ///
  /// In en, this message translates to:
  /// **'Heavy physical work'**
  String get work_behavior_hard_work;

  /// No description provided for @work_behavior_physically_demanding.
  ///
  /// In en, this message translates to:
  /// **'Physically demanding'**
  String get work_behavior_physically_demanding;

  /// No description provided for @work_behavior_sitting.
  ///
  /// In en, this message translates to:
  /// **'Sitting'**
  String get work_behavior_sitting;

  /// No description provided for @work_behavior_sitting_standing.
  ///
  /// In en, this message translates to:
  /// **'Sitting / Standing'**
  String get work_behavior_sitting_standing;

  /// No description provided for @work_behavior_sitting_standing_walking.
  ///
  /// In en, this message translates to:
  /// **'Sitting / Standing / Walking'**
  String get work_behavior_sitting_standing_walking;

  /// No description provided for @work_behavior_standing_walking.
  ///
  /// In en, this message translates to:
  /// **'Standing / Walking'**
  String get work_behavior_standing_walking;

  /// No description provided for @year_of_renovation.
  ///
  /// In en, this message translates to:
  /// **'Year of Renovation'**
  String get year_of_renovation;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['de', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'de':
      return AppLocalizationsDe();
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
