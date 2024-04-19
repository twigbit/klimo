//import 'dart:js_interop';

import 'package:flutter/material.dart';
import 'package:klimo/utils/localisation.dart';

final Map<String, String Function(BuildContext)> stringTranslations = {
  // tranlsations for co2 calculator
  "living": (BuildContext context) => context.localisation().living,
  "mobility": (BuildContext context) => context.localisation().mobility,
  "nutrition": (BuildContext context) => context.localisation().nutrition,
  "consumption": (BuildContext context) => context.localisation().consumption,
  "public": (BuildContext context) => context.localisation().public,
  "hobbies": (BuildContext context) => context.localisation().hobbies,
  "digital": (BuildContext context) => context.localisation().digital,
  "shopping": (BuildContext context) => context.localisation().shopping,
  "living_information": (BuildContext context) =>
      context.localisation().living_information,
  "people_in_household": (BuildContext context) =>
      context.localisation().people_in_household,
  "housing": (BuildContext context) => context.localisation().housing,
  "housing_rent": (BuildContext context) => context.localisation().housing_rent,
  "housing_ownership": (BuildContext context) =>
      context.localisation().housing_ownership,
  "building_type": (BuildContext context) =>
      context.localisation().building_type,
  "building_type_ezfh": (BuildContext context) =>
      context.localisation().building_type_ezfh,
  "building_type_rh": (BuildContext context) =>
      context.localisation().building_type_rh,
  "building_type_kmfh": (BuildContext context) =>
      context.localisation().building_type_kmfh,
  "building_type_gmfh": (BuildContext context) =>
      context.localisation().building_type_gmfh,
  "living_area": (BuildContext context) => context.localisation().living_area,
  "living_area_unit": (BuildContext context) =>
      context.localisation().living_area_unit,
  "building_age_category": (BuildContext context) =>
      context.localisation().building_age_category,
  "building_age_category_before_1948": (BuildContext context) =>
      context.localisation().building_age_category_before_1948,
  "building_age_category_1949_to_1978": (BuildContext context) =>
      context.localisation().building_age_category_1949_to_1978,
  "building_age_category_1979_to_2001": (BuildContext context) =>
      context.localisation().building_age_category_1979_to_2001,
  "building_age_category_2002_to_2015": (BuildContext context) =>
      context.localisation().building_age_category_2002_to_2015,
  "building_age_category_from_2016": (BuildContext context) =>
      context.localisation().building_age_category_from_2016,
  "renovation_since_construction": (BuildContext context) =>
      context.localisation().renovation_since_construction,
  "type_of_renovation": (BuildContext context) =>
      context.localisation().type_of_renovation,
  "type_of_renovation_roof": (BuildContext context) =>
      context.localisation().type_of_renovation_roof,
  "type_of_renovation_window": (BuildContext context) =>
      context.localisation().type_of_renovation_window,
  "type_of_renovation_facade": (BuildContext context) =>
      context.localisation().type_of_renovation_facade,
  "type_of_renovation_basement_ceiling": (BuildContext context) =>
      context.localisation().type_of_renovation_basement_ceiling,
  "year_of_renovation": (BuildContext context) =>
      context.localisation().year_of_renovation,
  "specific_heating_requirement": (BuildContext context) =>
      context.localisation().specific_heating_requirement,
  "specific_heating_requirement_unit": (BuildContext context) =>
      context.localisation().specific_heating_requirement_unit,
  "specific_final_energy_requirement": (BuildContext context) =>
      context.localisation().specific_final_energy_requirement,
  "specific_final_energy_requirement_unit": (BuildContext context) =>
      context.localisation().specific_final_energy_requirement_unit,
  "heat_generator": (BuildContext context) =>
      context.localisation().heat_generator,
  "heat_generator_boiler": (BuildContext context) =>
      context.localisation().heat_generator_boiler,
  "heat_generator_heat_pump": (BuildContext context) =>
      context.localisation().heat_generator_heat_pump,
  "heat_generator_district_heating": (BuildContext context) =>
      context.localisation().heat_generator_district_heating,
  "energy_source": (BuildContext context) =>
      context.localisation().energy_source,
  "energy_source_gas": (BuildContext context) =>
      context.localisation().energy_source_gas,
  "energy_source_oil": (BuildContext context) =>
      context.localisation().energy_source_oil,
  "energy_source_biomass": (BuildContext context) =>
      context.localisation().energy_source_biomass,
  "energy_source_electricity": (BuildContext context) =>
      context.localisation().energy_source_electricity,
  "energy_source_district_heating": (BuildContext context) =>
      context.localisation().energy_source_district_heating,
  "energy_source_other": (BuildContext context) =>
      context.localisation().energy_source_other,
  "energy_source_water": (BuildContext context) =>
      context.localisation().energy_source_water,
  "energy_source_water_gas": (BuildContext context) =>
      context.localisation().energy_source_water_gas,
  "energy_source_water_oil": (BuildContext context) =>
      context.localisation().energy_source_water_oil,
  "energy_source_water_biomass": (BuildContext context) =>
      context.localisation().energy_source_water_biomass,
  "energy_source_water_electricity": (BuildContext context) =>
      context.localisation().energy_source_water_electricity,
  "energy_source_water_district_heating": (BuildContext context) =>
      context.localisation().energy_source_water_district_heating,
  "energy_source_water_other": (BuildContext context) =>
      context.localisation().energy_source_water_other,
  "heat_water_separated": (BuildContext context) =>
      context.localisation().heat_water_separated,
  "annual_heat_consumption": (BuildContext context) =>
      context.localisation().annual_heat_consumption,
  "annual_heat_consumption_unit_description": (BuildContext context) =>
      context.localisation().annual_heat_consumption_unit_description,
  "annual_heat_consumption_unit_kwh": (BuildContext context) =>
      context.localisation().annual_heat_consumption_unit_kwh,
  "annual_heat_consumption_unit_mwh": (BuildContext context) =>
      context.localisation().annual_heat_consumption_unit_mwh,
  "annual_heat_consumption_unit_l": (BuildContext context) =>
      context.localisation().annual_heat_consumption_unit_l,
  "annual_heat_consumption_unit_m3": (BuildContext context) =>
      context.localisation().annual_heat_consumption_unit_m3,
  "annual_heat_consumption_unit_kg": (BuildContext context) =>
      context.localisation().annual_heat_consumption_unit_kg,
  "annual_heat_consumption_water": (BuildContext context) =>
      context.localisation().annual_heat_consumption_water,
  "annual_heat_consumption_water_unit_description": (BuildContext context) =>
      context.localisation().annual_heat_consumption_water_unit_description,
  "annual_heat_consumption_water_unit_kwh": (BuildContext context) =>
      context.localisation().annual_heat_consumption_water_unit_kwh,
  "annual_heat_consumption_water_unit_mwh": (BuildContext context) =>
      context.localisation().annual_heat_consumption_water_unit_mwh,
  "annual_heat_consumption_water_unit_l": (BuildContext context) =>
      context.localisation().annual_heat_consumption_water_unit_l,
  "annual_heat_consumption_water_unit_m3": (BuildContext context) =>
      context.localisation().annual_heat_consumption_water_unit_m3,
  "annual_heat_consumption_water_unit_kg": (BuildContext context) =>
      context.localisation().annual_heat_consumption_water_unit_kg,
  "annual_power_consumption": (BuildContext context) =>
      context.localisation().annual_power_consumption,
  "annual_power_consumption_unit": (BuildContext context) =>
      context.localisation().annual_power_consumption_unit,
  "secondary_generation": (BuildContext context) =>
      context.localisation().secondary_generation,
  "secondary_generation_electricity": (BuildContext context) =>
      context.localisation().secondary_generation_electricity,
  "secondary_generation_electricity_power": (BuildContext context) =>
      context.localisation().secondary_generation_electricity_power,
  "secondary_generation_electricity_power_unit": (BuildContext context) =>
      context.localisation().secondary_generation_electricity_power_unit,
  "secondary_generation_heat": (BuildContext context) =>
      context.localisation().secondary_generation_heat,
  "secondary_generation_heat_power": (BuildContext context) =>
      context.localisation().secondary_generation_heat_power,
  "secondary_generation_heat_power_unit": (BuildContext context) =>
      context.localisation().secondary_generation_heat_power_unit,
  "secondary_generation_solar_thermal": (BuildContext context) =>
      context.localisation().secondary_generation_solar_thermal,
  "secondary_generation_solar_thermal_power": (BuildContext context) =>
      context.localisation().secondary_generation_solar_thermal_power,
  "secondary_generation_solar_thermal_power_unit": (BuildContext context) =>
      context.localisation().secondary_generation_solar_thermal_power_unit,
  "power_consumption_source": (BuildContext context) =>
      context.localisation().power_consumption_source,
  "power_consumption_source_mix": (BuildContext context) =>
      context.localisation().power_consumption_source_mix,
  "power_consumption_source_green": (BuildContext context) =>
      context.localisation().power_consumption_source_green,
  "means_of_transport": (BuildContext context) =>
      context.localisation().means_of_transport,
  "car": (BuildContext context) => context.localisation().car,
  "car_motorcycle_type": (BuildContext context) =>
      context.localisation().car_motorcycle_type,
  "car_motorcycle_car_sharing": (BuildContext context) =>
      context.localisation().car_motorcycle_car_sharing,
  "car_motorcycle_own_car": (BuildContext context) =>
      context.localisation().car_motorcycle_own_car,
  "car_motorcycle_consumption": (BuildContext context) =>
      context.localisation().car_motorcycle_consumption,
  "car_motorcycle_consumption_unit": (BuildContext context) =>
      context.localisation().car_motorcycle_consumption_unit,
  "car_motorcycle_distance": (BuildContext context) =>
      context.localisation().car_motorcycle_distance,
  "car_motorcycle_distance_unit": (BuildContext context) =>
      context.localisation().car_motorcycle_distance_unit,
  "car_motorcycle_car_classification": (BuildContext context) =>
      context.localisation().car_motorcycle_car_classification,
  "car_motorcycle_car_classification_small_car": (BuildContext context) =>
      context.localisation().car_motorcycle_car_classification_small_car,
  "car_motorcycle_car_classification_middle_class": (BuildContext context) =>
      context.localisation().car_motorcycle_car_classification_middle_class,
  "car_motorcycle_car_classification_upper_class": (BuildContext context) =>
      context.localisation().car_motorcycle_car_classification_upper_class,
  "car_motorcycle_fuel": (BuildContext context) =>
      context.localisation().car_motorcycle_fuel,
  "car_motorcycle_fuel_benzin": (BuildContext context) =>
      context.localisation().car_motorcycle_fuel_benzin,
  "car_motorcycle_fuel_diesel": (BuildContext context) =>
      context.localisation().car_motorcycle_fuel_diesel,
  "car_motorcycle_fuel_electric": (BuildContext context) =>
      context.localisation().car_motorcycle_fuel_electric,
  "car_motorcycle_fuel_hybrid": (BuildContext context) =>
      context.localisation().car_motorcycle_fuel_hybrid,
  "car_motorcycle_fuel_gas": (BuildContext context) =>
      context.localisation().car_motorcycle_fuel_gas,
  "motorcycle": (BuildContext context) => context.localisation().motorcycle,
  "motorcycle_type": (BuildContext context) =>
      context.localisation().motorcycle_type,
  "motorcycle_type_sharing": (BuildContext context) =>
      context.localisation().motorcycle_type_sharing,
  "motorcycle_type_own_motorcycle": (BuildContext context) =>
      context.localisation().motorcycle_type_own_motorcycle,
  "public_transport": (BuildContext context) =>
      context.localisation().public_transport,
  "public_transport_distance_general": (BuildContext context) =>
      context.localisation().public_transport_distance_general,
  "public_transport_distance_general_unit": (BuildContext context) =>
      context.localisation().public_transport_distance_general_unit,
  "public_transport_distance_bus_near": (BuildContext context) =>
      context.localisation().public_transport_distance_bus_near,
  "public_transport_distance_bus_near_unit": (BuildContext context) =>
      context.localisation().public_transport_distance_bus_near_unit,
  "public_transport_distance_bus_long": (BuildContext context) =>
      context.localisation().public_transport_distance_bus_long,
  "public_transport_distance_bus_long_unit": (BuildContext context) =>
      context.localisation().public_transport_distance_bus_long_unit,
  "public_transport_distance_train_near": (BuildContext context) =>
      context.localisation().public_transport_distance_train_near,
  "public_transport_distance_train_near_unit": (BuildContext context) =>
      context.localisation().public_transport_distance_train_near_unit,
  "public_transport_distance_train_long": (BuildContext context) =>
      context.localisation().public_transport_distance_train_long,
  "public_transport_distance_train_long_unit": (BuildContext context) =>
      context.localisation().public_transport_distance_train_long_unit,
  "bicycle": (BuildContext context) => context.localisation().bicycle,
  "bicycle_property": (BuildContext context) =>
      context.localisation().bicycle_property,
  "bicycle_property_sharing": (BuildContext context) =>
      context.localisation().bicycle_property_sharing,
  "bicycle_property_own": (BuildContext context) =>
      context.localisation().bicycle_property_own,
  "bicycle_type": (BuildContext context) => context.localisation().bicycle_type,
  "bicycle_ebike": (BuildContext context) =>
      context.localisation().bicycle_ebike,
  "bicycle_bike": (BuildContext context) => context.localisation().bicycle_bike,
  "bicycle_distance": (BuildContext context) =>
      context.localisation().bicycle_distance,
  "bicycle_distance_unit": (BuildContext context) =>
      context.localisation().bicycle_distance_unit,
  "scooter": (BuildContext context) => context.localisation().scooter,
  "scooter_property": (BuildContext context) =>
      context.localisation().scooter_property,
  "scooter_property_sharing": (BuildContext context) =>
      context.localisation().scooter_property_sharing,
  "scooter_property_own": (BuildContext context) =>
      context.localisation().scooter_property_own,
  "scooter_type": (BuildContext context) => context.localisation().scooter_type,
  "scooter_kick": (BuildContext context) => context.localisation().scooter_kick,
  "scooter_escooter": (BuildContext context) =>
      context.localisation().scooter_escooter,
  "scooter_distance": (BuildContext context) =>
      context.localisation().scooter_distance,
  "scooter_distance_unit": (BuildContext context) =>
      context.localisation().scooter_distance_unit,
  "nutrition_information": (BuildContext context) =>
      context.localisation().nutrition_information,
  "gender": (BuildContext context) => context.localisation().gender,
  "gender_male": (BuildContext context) => context.localisation().gender_male,
  "gender_female": (BuildContext context) =>
      context.localisation().gender_female,
  "gender_diverse": (BuildContext context) =>
      context.localisation().gender_diverse,
  "gender_no_value": (BuildContext context) =>
      context.localisation().gender_no_value,
  "age_range": (BuildContext context) => context.localisation().age_range,
  "age_up_to_18": (BuildContext context) => context.localisation().age_up_to_18,
  "age_19_to_30": (BuildContext context) => context.localisation().age_19_to_30,
  "age_31_to_60": (BuildContext context) => context.localisation().age_31_to_60,
  "age_61_to_75": (BuildContext context) => context.localisation().age_61_to_75,
  "age_more_than_75": (BuildContext context) =>
      context.localisation().age_more_than_75,
  "weight_range": (BuildContext context) => context.localisation().weight_range,
  "weight_up_to_40": (BuildContext context) =>
      context.localisation().weight_up_to_40,
  "weight_41_to_50": (BuildContext context) =>
      context.localisation().weight_41_to_50,
  "weight_51_to_60": (BuildContext context) =>
      context.localisation().weight_51_to_60,
  "weight_61_to_70": (BuildContext context) =>
      context.localisation().weight_61_to_70,
  "weight_71_to_80": (BuildContext context) =>
      context.localisation().weight_71_to_80,
  "weight_81_to_90": (BuildContext context) =>
      context.localisation().weight_81_to_90,
  "weight_91_to_100": (BuildContext context) =>
      context.localisation().weight_91_to_100,
  "weight_101_to_110": (BuildContext context) =>
      context.localisation().weight_101_to_110,
  "weight_111_to_120": (BuildContext context) =>
      context.localisation().weight_111_to_120,
  "weight_more_than_120": (BuildContext context) =>
      context.localisation().weight_more_than_120,
  "activity_work_time": (BuildContext context) =>
      context.localisation().activity_work_time,
  "activity_work_time_unit": (BuildContext context) =>
      context.localisation().activity_work_time_unit,
  "activity_sleep_time": (BuildContext context) =>
      context.localisation().activity_sleep_time,
  "activity_sleep_time_unit": (BuildContext context) =>
      context.localisation().activity_sleep_time_unit,
  "activity_free_time": (BuildContext context) =>
      context.localisation().activity_free_time,
  "activity_free_time_unit": (BuildContext context) =>
      context.localisation().activity_free_time_unit,
  "free_time_behavior": (BuildContext context) =>
      context.localisation().free_time_behavior,
  "free_time_behavior_sitting_lying": (BuildContext context) =>
      context.localisation().free_time_behavior_sitting_lying,
  "free_time_behavior_sitting_standing": (BuildContext context) =>
      context.localisation().free_time_behavior_sitting_standing,
  "free_time_behavior_sitting_standing_walking": (BuildContext context) =>
      context.localisation().free_time_behavior_sitting_standing_walking,
  "free_time_behavior_standing_walking_sporty": (BuildContext context) =>
      context.localisation().free_time_behavior_standing_walking_sporty,
  "free_time_behavior_sporty": (BuildContext context) =>
      context.localisation().free_time_behavior_sporty,
  "work_behavior": (BuildContext context) =>
      context.localisation().work_behavior,
  "work_behavior_sitting": (BuildContext context) =>
      context.localisation().work_behavior_sitting,
  "work_behavior_sitting_standing": (BuildContext context) =>
      context.localisation().work_behavior_sitting_standing,
  "work_behavior_sitting_standing_walking": (BuildContext context) =>
      context.localisation().work_behavior_sitting_standing_walking,
  "work_behavior_standing_walking": (BuildContext context) =>
      context.localisation().work_behavior_standing_walking,
  "work_behavior_physically_demanding": (BuildContext context) =>
      context.localisation().work_behavior_physically_demanding,
  "work_behavior_hard_work": (BuildContext context) =>
      context.localisation().work_behavior_hard_work,
  "frozen_food": (BuildContext context) => context.localisation().frozen_food,
  "frozen_food_never": (BuildContext context) =>
      context.localisation().frozen_food_never,
  "frozen_food_weekly": (BuildContext context) =>
      context.localisation().frozen_food_weekly,
  "frozen_food_daily": (BuildContext context) =>
      context.localisation().frozen_food_daily,
  "nutrition_question": (BuildContext context) =>
      context.localisation().nutrition_question,
  "nutrition_meaty": (BuildContext context) =>
      context.localisation().nutrition_meaty,
  "nutrition_mixed": (BuildContext context) =>
      context.localisation().nutrition_mixed,
  "nutrition_meat_reduced": (BuildContext context) =>
      context.localisation().nutrition_meat_reduced,
  "nutrition_vegetarian": (BuildContext context) =>
      context.localisation().nutrition_vegetarian,
  "nutrition_vegan": (BuildContext context) =>
      context.localisation().nutrition_vegan,
  "purchasing_behavior": (BuildContext context) =>
      context.localisation().purchasing_behavior,
  "purchasing_behavior_supermarket": (BuildContext context) =>
      context.localisation().purchasing_behavior_supermarket,
  "purchasing_behavior_regional": (BuildContext context) =>
      context.localisation().purchasing_behavior_regional,
  "purchasing_behavior_regional_seasonal": (BuildContext context) =>
      context.localisation().purchasing_behavior_regional_seasonal,
  "purchasing_behavior_bio": (BuildContext context) =>
      context.localisation().purchasing_behavior_bio,
  "purchasing_behavior_own_cultivation": (BuildContext context) =>
      context.localisation().purchasing_behavior_own_cultivation,
  "consumption_information": (BuildContext context) =>
      context.localisation().consumption_information,
  "monthly_expenses": (BuildContext context) =>
      context.localisation().monthly_expenses,
  "monthly_expenses_unit": (BuildContext context) =>
      context.localisation().monthly_expenses_unit,
  "buying_behavior": (BuildContext context) =>
      context.localisation().buying_behavior,
  "buying_behavior_sparse": (BuildContext context) =>
      context.localisation().buying_behavior_sparse,
  "buying_behavior_normal": (BuildContext context) =>
      context.localisation().buying_behavior_normal,
  "buying_behavior_generous": (BuildContext context) =>
      context.localisation().buying_behavior_generous,
  "buying_criteria": (BuildContext context) =>
      context.localisation().buying_criteria,
  "buying_criteria_quality": (BuildContext context) =>
      context.localisation().buying_criteria_quality,
  "buying_criteria_functionality": (BuildContext context) =>
      context.localisation().buying_criteria_functionality,
  "buying_criteria_costs": (BuildContext context) =>
      context.localisation().buying_criteria_costs,
  "buying_second_hand": (BuildContext context) =>
      context.localisation().buying_second_hand,
  "buying_second_hand_preferred": (BuildContext context) =>
      context.localisation().buying_second_hand_preferred,
  "buying_second_hand_sometimes": (BuildContext context) =>
      context.localisation().buying_second_hand_sometimes,
  "buying_second_hand_never": (BuildContext context) =>
      context.localisation().buying_second_hand_never,
  "pets": (BuildContext context) => context.localisation().pets,
  "pets_dog": (BuildContext context) => context.localisation().pets_dog,
  "pets_cat": (BuildContext context) => context.localisation().pets_cat,
  "pets_horse": (BuildContext context) => context.localisation().pets_horse,
  "pets_rodent": (BuildContext context) => context.localisation().pets_rodent,
  "pets_bird": (BuildContext context) => context.localisation().pets_bird,
  "pets_reptiles": (BuildContext context) =>
      context.localisation().pets_reptiles,
  "pets_fish": (BuildContext context) => context.localisation().pets_fish,
  "pets_dog_reference": (BuildContext context) =>
      context.localisation().pets_dog_reference,
  "pets_dog_reference_breeding": (BuildContext context) =>
      context.localisation().pets_dog_reference_breeding,
  "pets_dog_reference_shelter": (BuildContext context) =>
      context.localisation().pets_dog_reference_shelter,
  "pets_dog_share": (BuildContext context) =>
      context.localisation().pets_dog_share,
  "pets_dog_nutrition": (BuildContext context) =>
      context.localisation().pets_dog_nutrition,
  "pets_dog_nutrition_normal": (BuildContext context) =>
      context.localisation().pets_dog_nutrition_normal,
  "pets_dog_nutrition_barf": (BuildContext context) =>
      context.localisation().pets_dog_nutrition_barf,
  "pets_dog_weight": (BuildContext context) =>
      context.localisation().pets_dog_weight,
  "pets_dog_weight_unit": (BuildContext context) =>
      context.localisation().pets_dog_weight_unit,
  "pets_cat_reference": (BuildContext context) =>
      context.localisation().pets_cat_reference,
  "pets_cat_reference_breeding": (BuildContext context) =>
      context.localisation().pets_cat_reference_breeding,
  "pets_cat_reference_shelter": (BuildContext context) =>
      context.localisation().pets_cat_reference_shelter,
  "pets_cat_share": (BuildContext context) =>
      context.localisation().pets_cat_share,
  "pets_cat_nutrition": (BuildContext context) =>
      context.localisation().pets_cat_nutrition,
  "pets_cat_nutrition_normal": (BuildContext context) =>
      context.localisation().pets_cat_nutrition_normal,
  "pets_cat_nutrition_barf": (BuildContext context) =>
      context.localisation().pets_cat_nutrition_barf,
  "pets_cat_weight": (BuildContext context) =>
      context.localisation().pets_cat_weight,
  "pets_cat_weight_unit": (BuildContext context) =>
      context.localisation().pets_cat_weight_unit,
  "pets_horse_reference": (BuildContext context) =>
      context.localisation().pets_horse_reference,
  "pets_horse_reference_breeding": (BuildContext context) =>
      context.localisation().pets_horse_reference_breeding,
  "pets_horse_reference_shelter": (BuildContext context) =>
      context.localisation().pets_horse_reference_shelter,
  "pets_horse_share": (BuildContext context) =>
      context.localisation().pets_horse_share,
  "pets_horse_nutrition": (BuildContext context) =>
      context.localisation().pets_horse_nutrition,
  "pets_horse_nutrition_normal": (BuildContext context) =>
      context.localisation().pets_horse_nutrition_normal,
  "pets_horse_nutrition_simple": (BuildContext context) =>
      context.localisation().pets_horse_nutrition_simple,
  "pets_horse_weight": (BuildContext context) =>
      context.localisation().pets_horse_weight,
  "pets_horse_weight_unit": (BuildContext context) =>
      context.localisation().pets_horse_weight_unit,
  "pets_rodent_reference": (BuildContext context) =>
      context.localisation().pets_rodent_reference,
  "pets_rodent_reference_breeding": (BuildContext context) =>
      context.localisation().pets_rodent_reference_breeding,
  "pets_rodent_reference_shelter": (BuildContext context) =>
      context.localisation().pets_rodent_reference_shelter,
  "pets_rodent_share": (BuildContext context) =>
      context.localisation().pets_rodent_share,
  "pets_bird_reference": (BuildContext context) =>
      context.localisation().pets_bird_reference,
  "pets_bird_reference_breeding": (BuildContext context) =>
      context.localisation().pets_bird_reference_breeding,
  "pets_bird_reference_shelter": (BuildContext context) =>
      context.localisation().pets_bird_reference_shelter,
  "pets_bird_share": (BuildContext context) =>
      context.localisation().pets_bird_share,
  "pets_reptiles_reference": (BuildContext context) =>
      context.localisation().pets_reptiles_reference,
  "pets_reptiles_reference_breeding": (BuildContext context) =>
      context.localisation().pets_reptiles_reference_breeding,
  "pets_reptiles_reference_shelter": (BuildContext context) =>
      context.localisation().pets_reptiles_reference_shelter,
  "pets_reptiles_share": (BuildContext context) =>
      context.localisation().pets_reptiles_share,
  "pets_fish_reference": (BuildContext context) =>
      context.localisation().pets_fish_reference,
  "pets_fish_reference_breeding": (BuildContext context) =>
      context.localisation().pets_fish_reference_breeding,
  "pets_fish_reference_shelter": (BuildContext context) =>
      context.localisation().pets_fish_reference_shelter,
  "pets_fish_share": (BuildContext context) =>
      context.localisation().pets_fish_share,
  "vacation": (BuildContext context) => context.localisation().vacation,
  "vacation_active": (BuildContext context) =>
      context.localisation().vacation_active,
  "vacation_beach": (BuildContext context) =>
      context.localisation().vacation_beach,
  "vacation_family": (BuildContext context) =>
      context.localisation().vacation_family,
  "vacation_skiing": (BuildContext context) =>
      context.localisation().vacation_skiing,
  "vacation_cultural": (BuildContext context) =>
      context.localisation().vacation_cultural,
  "vacation_shipping": (BuildContext context) =>
      context.localisation().vacation_shipping,
  "vacation_balcony": (BuildContext context) =>
      context.localisation().vacation_balcony,
  "vacation_days_unit": (BuildContext context) =>
      context.localisation().vacation_days_unit,
  "vacation_active_transport": (BuildContext context) =>
      context.localisation().vacation_active_transport,
  "vacation_active_transport_airplane": (BuildContext context) =>
      context.localisation().vacation_active_transport_airplane,
  "vacation_active_transport_train": (BuildContext context) =>
      context.localisation().vacation_active_transport_train,
  "vacation_active_transport_bus": (BuildContext context) =>
      context.localisation().vacation_active_transport_bus,
  "vacation_active_transport_own_car": (BuildContext context) =>
      context.localisation().vacation_active_transport_own_car,
  "vacation_active_destination": (BuildContext context) =>
      context.localisation().vacation_active_destination,
  "vacation_active_destination_unit": (BuildContext context) =>
      context.localisation().vacation_active_destination_unit,
  "vacation_active_accommodation": (BuildContext context) =>
      context.localisation().vacation_active_accommodation,
  "vacation_active_accommodation_hotel": (BuildContext context) =>
      context.localisation().vacation_active_accommodation_hotel,
  "vacation_active_accommodation_hostel": (BuildContext context) =>
      context.localisation().vacation_active_accommodation_hostel,
  "vacation_active_accommodation_vacation_home": (BuildContext context) =>
      context.localisation().vacation_active_accommodation_vacation_home,
  "vacation_active_accommodation_camping": (BuildContext context) =>
      context.localisation().vacation_active_accommodation_camping,
  "vacation_active_days": (BuildContext context) =>
      context.localisation().vacation_active_days,
  "vacation_beach_transport": (BuildContext context) =>
      context.localisation().vacation_beach_transport,
  "vacation_beach_transport_airplane": (BuildContext context) =>
      context.localisation().vacation_beach_transport_airplane,
  "vacation_beach_transport_train": (BuildContext context) =>
      context.localisation().vacation_beach_transport_train,
  "vacation_beach_transport_bus": (BuildContext context) =>
      context.localisation().vacation_beach_transport_bus,
  "vacation_beach_transport_own_car": (BuildContext context) =>
      context.localisation().vacation_beach_transport_own_car,
  "vacation_beach_destination": (BuildContext context) =>
      context.localisation().vacation_beach_destination,
  "vacation_beach_destination_unit": (BuildContext context) =>
      context.localisation().vacation_beach_destination_unit,
  "vacation_beach_accommodation": (BuildContext context) =>
      context.localisation().vacation_beach_accommodation,
  "vacation_beach_accommodation_hotel": (BuildContext context) =>
      context.localisation().vacation_beach_accommodation_hotel,
  "vacation_beach_accommodation_hostel": (BuildContext context) =>
      context.localisation().vacation_beach_accommodation_hostel,
  "vacation_beach_accommodation_vacation_home": (BuildContext context) =>
      context.localisation().vacation_beach_accommodation_vacation_home,
  "vacation_beach_accommodation_camping": (BuildContext context) =>
      context.localisation().vacation_beach_accommodation_camping,
  "vacation_beach_days": (BuildContext context) =>
      context.localisation().vacation_beach_days,
  "vacation_family_transport": (BuildContext context) =>
      context.localisation().vacation_family_transport,
  "vacation_family_transport_airplane": (BuildContext context) =>
      context.localisation().vacation_family_transport_airplane,
  "vacation_family_transport_train": (BuildContext context) =>
      context.localisation().vacation_family_transport_train,
  "vacation_family_transport_bus": (BuildContext context) =>
      context.localisation().vacation_family_transport_bus,
  "vacation_family_transport_own_car": (BuildContext context) =>
      context.localisation().vacation_family_transport_own_car,
  "vacation_family_destination": (BuildContext context) =>
      context.localisation().vacation_family_destination,
  "vacation_family_destination_unit": (BuildContext context) =>
      context.localisation().vacation_family_destination_unit,
  "vacation_family_accommodation": (BuildContext context) =>
      context.localisation().vacation_family_accommodation,
  "vacation_family_accommodation_hotel": (BuildContext context) =>
      context.localisation().vacation_family_accommodation_hotel,
  "vacation_family_accommodation_hostel": (BuildContext context) =>
      context.localisation().vacation_family_accommodation_hostel,
  "vacation_family_accommodation_vacation_home": (BuildContext context) =>
      context.localisation().vacation_family_accommodation_vacation_home,
  "vacation_family_accommodation_camping": (BuildContext context) =>
      context.localisation().vacation_family_accommodation_camping,
  "vacation_family_days": (BuildContext context) =>
      context.localisation().vacation_family_days,
  "vacation_skiing_transport": (BuildContext context) =>
      context.localisation().vacation_skiing_transport,
  "vacation_skiing_transport_airplane": (BuildContext context) =>
      context.localisation().vacation_skiing_transport_airplane,
  "vacation_skiing_transport_train": (BuildContext context) =>
      context.localisation().vacation_skiing_transport_train,
  "vacation_skiing_transport_bus": (BuildContext context) =>
      context.localisation().vacation_skiing_transport_bus,
  "vacation_skiing_transport_own_car": (BuildContext context) =>
      context.localisation().vacation_skiing_transport_own_car,
  "vacation_skiing_destination": (BuildContext context) =>
      context.localisation().vacation_skiing_destination,
  "vacation_skiing_destination_unit": (BuildContext context) =>
      context.localisation().vacation_skiing_destination_unit,
  "vacation_skiing_accommodation": (BuildContext context) =>
      context.localisation().vacation_skiing_accommodation,
  "vacation_skiing_accommodation_hotel": (BuildContext context) =>
      context.localisation().vacation_skiing_accommodation_hotel,
  "vacation_skiing_accommodation_hostel": (BuildContext context) =>
      context.localisation().vacation_skiing_accommodation_hostel,
  "vacation_skiing_accommodation_vacation_home": (BuildContext context) =>
      context.localisation().vacation_skiing_accommodation_vacation_home,
  "vacation_skiing_accommodation_camping": (BuildContext context) =>
      context.localisation().vacation_skiing_accommodation_camping,
  "vacation_skiing_days": (BuildContext context) =>
      context.localisation().vacation_skiing_days,
  "vacation_cultural_transport": (BuildContext context) =>
      context.localisation().vacation_cultural_transport,
  "vacation_cultural_transport_airplane": (BuildContext context) =>
      context.localisation().vacation_cultural_transport_airplane,
  "vacation_cultural_transport_train": (BuildContext context) =>
      context.localisation().vacation_cultural_transport_train,
  "vacation_cultural_transport_bus": (BuildContext context) =>
      context.localisation().vacation_cultural_transport_bus,
  "vacation_cultural_transport_own_car": (BuildContext context) =>
      context.localisation().vacation_cultural_transport_own_car,
  "vacation_cultural_destination": (BuildContext context) =>
      context.localisation().vacation_cultural_destination,
  "vacation_cultural_destination_unit": (BuildContext context) =>
      context.localisation().vacation_cultural_destination_unit,
  "vacation_cultural_accommodation": (BuildContext context) =>
      context.localisation().vacation_cultural_accommodation,
  "vacation_cultural_accommodation_hotel": (BuildContext context) =>
      context.localisation().vacation_cultural_accommodation_hotel,
  "vacation_cultural_accommodation_hostel": (BuildContext context) =>
      context.localisation().vacation_cultural_accommodation_hostel,
  "vacation_cultural_accommodation_vacation_home": (BuildContext context) =>
      context.localisation().vacation_cultural_accommodation_vacation_home,
  "vacation_cultural_accommodation_camping": (BuildContext context) =>
      context.localisation().vacation_cultural_accommodation_camping,
  "vacation_cultural_days": (BuildContext context) =>
      context.localisation().vacation_cultural_days,
  "vacation_shipping_transport": (BuildContext context) =>
      context.localisation().vacation_shipping_transport,
  "vacation_shipping_transport_airplane": (BuildContext context) =>
      context.localisation().vacation_shipping_transport_airplane,
  "vacation_shipping_transport_train": (BuildContext context) =>
      context.localisation().vacation_shipping_transport_train,
  "vacation_shipping_transport_bus": (BuildContext context) =>
      context.localisation().vacation_shipping_transport_bus,
  "vacation_shipping_transport_own_car": (BuildContext context) =>
      context.localisation().vacation_shipping_transport_own_car,
  "vacation_shipping_destination": (BuildContext context) =>
      context.localisation().vacation_shipping_destination,
  "vacation_shipping_destination_unit": (BuildContext context) =>
      context.localisation().vacation_shipping_destination_unit,
  "vacation_shipping_days": (BuildContext context) =>
      context.localisation().vacation_shipping_days,
  "vacation_balcony_transport": (BuildContext context) =>
      context.localisation().vacation_balcony_transport,
  "vacation_balcony_transport_airplane": (BuildContext context) =>
      context.localisation().vacation_balcony_transport_airplane,
  "vacation_balcony_transport_train": (BuildContext context) =>
      context.localisation().vacation_balcony_transport_train,
  "vacation_balcony_transport_bus": (BuildContext context) =>
      context.localisation().vacation_balcony_transport_bus,
  "vacation_balcony_transport_own_car": (BuildContext context) =>
      context.localisation().vacation_balcony_transport_own_car,
  "vacation_balcony_destination": (BuildContext context) =>
      context.localisation().vacation_balcony_destination,
  "vacation_balcony_destination_unit": (BuildContext context) =>
      context.localisation().vacation_balcony_destination_unit,
  "vacation_balcony_days": (BuildContext context) =>
      context.localisation().vacation_balcony_days,
  "compensation": (BuildContext context) => context.localisation().compensation,
  "compensation_investment": (BuildContext context) =>
      context.localisation().compensation_investment,
  "compensation_investment_unit": (BuildContext context) =>
      context.localisation().compensation_investment_unit,
  "compensation_certificates": (BuildContext context) =>
      context.localisation().compensation_certificates,
  "compensation_certificates_unit": (BuildContext context) =>
      context.localisation().compensation_certificates_unit,
  "compensation_electricity": (BuildContext context) =>
      context.localisation().compensation_electricity,
  "compensation_electricity_unit": (BuildContext context) =>
      context.localisation().compensation_electricity_unit,
  "public_kassel": (BuildContext context) =>
      context.localisation().public_kassel,
  "public_general_information": (BuildContext context) =>
      context.localisation().public_general_information,
  "public_general_information_description": (BuildContext context) =>
      context.localisation().public_general_information_description,
  "public_properties": (BuildContext context) =>
      context.localisation().public_properties,
  "public_properties_description": (BuildContext context) =>
      context.localisation().public_properties_description,
  "waste_recycling_management": (BuildContext context) =>
      context.localisation().waste_recycling_management,
  "waste_recycling_management_description": (BuildContext context) =>
      context.localisation().waste_recycling_management_description,
  "digital_infrastructure": (BuildContext context) =>
      context.localisation().digital_infrastructure,
  "digital_infrastructure_description": (BuildContext context) =>
      context.localisation().digital_infrastructure_description,
  "traffic_signals_street_lighting": (BuildContext context) =>
      context.localisation().traffic_signals_street_lighting,
  "traffic_signals_street_lighting_description": (BuildContext context) =>
      context.localisation().traffic_signals_street_lighting_description,
  "freight_traffic": (BuildContext context) =>
      context.localisation().freight_traffic,
  "freight_traffic_description": (BuildContext context) =>
      context.localisation().freight_traffic_description,
  "footprint_comparison_user": (BuildContext context) =>
      context.localisation().footprint_comparison_user,
  "footprint_comparison_kassel": (BuildContext context) =>
      context.localisation().footprint_comparison_kassel,
  "footprint_comparison_german": (BuildContext context) =>
      context.localisation().footprint_comparison_german,
  "means_of_transport_onboarding": (BuildContext context) =>
      context.localisation().means_of_transport_onboarding,
  "departments": (BuildContext context) => context.localisation().departments,
  "teams": (BuildContext context) => context.localisation().teams,
};
