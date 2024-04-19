import 'package:built_collection/built_collection.dart';

import '../input_model.dart';

void buildKlimoInputModel(InputModelBuilder m) {
  m.name = "Klimo";
  m.version = "1";

  m.section("living", (s) {
    s.title = "living";
    s.info = "living_information";
    s.inputs.addAll([
      RangeInput((i) => i
        ..key = "people_in_household"
        ..min = 1.0
        ..max = 10.0
        ..divisions = 10
        ..defaultValue = 2.0),
      RangeInput((i) => i
        ..key = "living_area"
        ..unit = "living_area_unit"
        ..min = 5.0
        ..max = 200.0
        ..divisions = 39
        ..defaultValue = 78.0),
      RadioInput((i) => i
        ..key = "building_type"
        ..options.addAll([
          "building_type_ezfh",
          "building_type_rh",
          "building_type_kmfh",
          "building_type_gmfh",
        ])),
      RadioInput((i) => i
        ..key = "building_age_category"
        ..options.addAll([
          "building_age_category_before_1948",
          "building_age_category_1949_to_1978",
          "building_age_category_1979_to_2001",
          "building_age_category_2002_to_2015",
          "building_age_category_from_2016",
        ])),
      RadioInput((i) => i
        ..key = "housing"
        ..options.addAll([
          "housing_rent",
          "housing_ownership",
        ])),
      MultiSelectInput((i) => i
        ..key = "renovation_since_construction"
        ..description = "type_of_renovation"
        ..options.addAll([
          "type_of_renovation_roof",
          "type_of_renovation_window",
          "type_of_renovation_facade",
          "type_of_renovation_basement_ceiling",
        ])),

      /// no longer asked for but can be determined by the asked for final energy requirement
      // RangeInput((i) => i
      //   ..key = "specific_heating_requirement"
      //   ..unit = "specific_heating_requirement_unit"
      //   ..min = .0
      //   ..max = 250.0
      //   ..divisions = 25),
      RangeInput((i) => i
        ..key = "specific_final_energy_requirement"
        ..unit = "specific_final_energy_requirement_unit"
        ..min = .0
        ..max = 250.0
        ..divisions = 25),
      RadioInput((i) => i
        ..key = "energy_source"
        ..options.addAll([
          "energy_source_gas",
          "energy_source_oil",
          "energy_source_biomass",
          "energy_source_electricity",
          "energy_source_district_heating",
          "energy_source_other",
        ])
        ..defaultValue = "energy_source_gas"),

      /// TODO enable this again when dependent variables / prediced values are implemented
      // RadioInput((i) => i
      //   ..key = "heat_generator"
      //   ..defaultValue = "heat_generator_boiler"
      //   ..options.addAll([
      //     "heat_generator_boiler",
      //     "heat_generator_heat_pump",
      //     "heat_generator_district_heating",
      //   ])
      //   ..description = "heat_generator_description"),

      NumberInput<double>((i) => i..key = "annual_heat_consumption"),
      RadioInput((i) => i
        ..key = "annual_heat_consumption_unit"
        ..title = ""
        ..description = "annual_heat_consumption_unit_description"
        ..options.addAll([
          "annual_heat_consumption_unit_kwh",
          "annual_heat_consumption_unit_mwh",
          "annual_heat_consumption_unit_l",
          "annual_heat_consumption_unit_m3",
          "annual_heat_consumption_unit_kg",
        ])
        ..defaultValue = "annual_heat_consumption_water_unit_kwh"
        ..isRadioList = false),
      GroupInput((i) => i
        ..key = "heat_water_separated"
        ..inputs.addAll([
          RadioInput((i) => i
            ..key = "energy_source_water"
            ..options.addAll([
              "energy_source_water_gas",
              "energy_source_water_oil",
              "energy_source_water_biomass",
              "energy_source_water_electricity",
              "energy_source_water_district_heating",
              "energy_source_water_other",
            ])),
          NumberInput<double>((i) => i..key = "annual_heat_consumption_water"),
          RadioInput((i) => i
            ..key = "annual_heat_consumption_water_unit"
            ..title = ""
            ..description = "annual_heat_consumption_water_unit_description"
            ..options.addAll([
              "annual_heat_consumption_water_unit_kwh",
              "annual_heat_consumption_water_unit_mwh",
              "annual_heat_consumption_water_unit_l",
              "annual_heat_consumption_water_unit_m3",
              "annual_heat_consumption_water_unit_kg",
            ])
            ..isRadioList = false),
        ])),
      RadioInput((i) => i
        ..key = "power_consumption_source"
        ..options.addAll([
          "power_consumption_source_mix",
          "power_consumption_source_green",
        ])
        ..defaultValue = "power_consumption_source_mix"),
      NumberInput<double>((i) => i
        ..key = "annual_power_consumption"
        ..unit = "annual_power_consumption_unit"
        ..defaultValue = 2500),
      Header((h) => h
        ..key = "secondary_generation"
        ..title = "secondary_generation"),
      // this value is asked for but becomes only relevant in case of overproduction since produced electricity should already be offset with power consumption value
      GroupInput(
        (i) => i
          ..key = "secondary_generation_electricity"
          ..inputs.addAll([
            NumberInput<double>((i) => i
              ..key = "secondary_generation_electricity_power"
              ..unit = "secondary_generation_electricity_power_unit")
          ]),
      ),
      GroupInput(
        (i) => i
          ..key = "secondary_generation_heat"
          ..inputs.addAll([
            NumberInput<double>((i) => i
              ..key = "secondary_generation_heat_power"
              ..unit = "secondary_generation_heat_power_unit")
          ]),
      ),
      GroupInput(
        (i) => i
          ..key = "secondary_generation_solar_thermal"
          ..inputs.addAll([
            NumberInput<double>((i) => i
              ..key = "secondary_generation_solar_thermal_power"
              ..unit = "secondary_generation_solar_thermal_power_unit")
          ]),
      ),
    ]);
  });

  m.section("mobility", (s) {
    s.title = "mobility";
    s.inputs.addAll([
      NestedEntityInput((h) => h
        ..key = "means_of_transport"
        ..onboardingTitle = "means_of_transport_onboarding"
        ..defaultValue.addAll(["car", "public_transport", "bicycle"])
        ..allowRepeated = true
        ..entityTypes.addAll([
          NestedEntity((e) => e
            ..key = "car"
            ..inputs.addAll([
              RadioInput((i) => i
                ..key = "car_motorcycle_type"
                ..defaultValue = "car_motorcycle_own_car"
                ..options.addAll([
                  "car_motorcycle_own_car",
                  "car_motorcycle_car_sharing",
                ])),
              RadioInput((i) => i
                ..key = "car_motorcycle_car_classification"
                ..defaultValue =
                    "car_motorcycle_car_classification_middle_class"
                ..options.addAll([
                  "car_motorcycle_car_classification_small_car",
                  "car_motorcycle_car_classification_middle_class",
                  "car_motorcycle_car_classification_upper_class"
                ])),
              RadioInput((i) => i
                ..key = "car_motorcycle_fuel"
                ..defaultValue = "car_motorcycle_fuel_benzin"
                ..options.addAll([
                  "car_motorcycle_fuel_benzin",
                  "car_motorcycle_fuel_diesel",
                  "car_motorcycle_fuel_electric",
                  "car_motorcycle_fuel_hybrid",
                  "car_motorcycle_fuel_gas",
                ])),
              NumberInput<double>((i) => i
                ..key = "car_motorcycle_consumption"
                ..unit = "car_motorcycle_consumption_unit"
                ..defaultValue = 8.0),
              NumberInput<int>((i) => i
                ..key = "car_motorcycle_distance"
                ..unit = "car_motorcycle_distance_unit"
                ..defaultValue = 8000),
            ])),
          NestedEntity((e) => e
            ..key = "motorcycle"
            ..inputs.addAll([
              RadioInput((i) => i
                ..key = "motorcycle_type"
                ..defaultValue = "motorcycle_type_own_motorcycle"
                ..options.addAll([
                  "motorcycle_type_own_motorcycle",
                  "motorcycle_type_sharing",
                ])),
              RadioInput((i) => i
                ..key = "car_motorcycle_fuel"
                ..options.addAll([
                  "car_motorcycle_fuel_benzin",
                  "car_motorcycle_fuel_electric",
                ])),
              NumberInput<double>((i) => i
                ..key = "car_motorcycle_consumption"
                ..unit = "car_motorcycle_consumption_unit"
                ..defaultValue = 8.0),
              NumberInput<int>((i) => i
                ..key = "car_motorcycle_distance"
                ..unit = "car_motorcycle_distance_unit"
                ..defaultValue = 8000),
            ])),
          NestedEntity((e) => e
            ..key = "public_transport"
            ..allowRepeated = false
            ..inputs.addAll([
              NumberInput<int>((i) => i
                ..key = "public_transport_distance_bus_near"
                ..unit = "public_transport_distance_bus_near_unit"),
              NumberInput<int>((i) => i
                ..key = "public_transport_distance_bus_long"
                ..unit = "public_transport_distance_bus_long_unit"),
              NumberInput<int>((i) => i
                ..key = "public_transport_distance_train_near"
                ..unit = "public_transport_distance_train_near_unit"),
              NumberInput<int>((i) => i
                ..key = "public_transport_distance_train_long"
                ..unit = "public_transport_distance_train_long_unit"),
            ])),
          NestedEntity((e) => e
            ..key = "bicycle"
            ..inputs.addAll([
              RadioInput((i) => i
                ..key = "bicycle_property"
                ..defaultValue = "bicycle_property_own"
                ..options.addAll([
                  "bicycle_property_own",
                  "bicycle_property_sharing",
                ])),
              RadioInput((i) => i
                ..key = "bicycle_type"
                ..defaultValue = "bicycle_bike"
                ..options.addAll([
                  "bicycle_bike",
                  "bicycle_ebike",
                ])),
              NumberInput<int>((i) => i
                ..key = "bicycle_distance"
                ..unit = "bicycle_distance_unit"
                ..defaultValue = 19),
            ])),
          NestedEntity((e) => e
            ..key = "scooter"
            ..inputs.addAll([
              RadioInput((i) => i
                ..key = "scooter_property"
                ..defaultValue = "scooter_property_own"
                ..options.addAll([
                  "scooter_property_own",
                  "scooter_property_sharing",
                ])),
              RadioInput((i) => i
                ..key = "scooter_type"
                ..defaultValue = "scooter_kick"
                ..options.addAll([
                  "scooter_kick",
                  "scooter_escooter",
                ])),
              NumberInput<int>((i) => i
                ..key = "scooter_distance"
                ..unit = "scooter_distance_unit"
                ..defaultValue = 19),
            ])),
        ])),
    ]);
  });

  m.section("nutrition", (s) {
    s.title = "nutrition";
    s.info = "nutrition_information";

    s.inputs.addAll([
      RadioInput((i) => i
        ..key = "gender"
        ..title = "gender"
        ..defaultValue = "gender_diverse"
        ..options.addAll([
          "gender_male",
          "gender_female",
          "gender_diverse",
          "gender_no_value",
        ])),
      RadioInput((i) => i
        ..key = "age_range"
        ..title = "age_range"
        ..defaultValue = "age_31_to_60"
        ..options.addAll([
          "age_up_to_18",
          "age_19_to_30",
          "age_31_to_60",
          "age_61_to_75",
          "age_more_than_75",
        ])
        ..isRadioList = false),
      RadioInput((i) => i
        ..key = "weight_range"
        ..title = "weight_range"
        ..defaultValue = "weight_61_to_70"
        ..options.addAll([
          "weight_up_to_40",
          "weight_41_to_50",
          "weight_51_to_60",
          "weight_61_to_70",
          "weight_71_to_80",
          "weight_81_to_90",
          "weight_91_to_100",
          "weight_101_to_110",
          "weight_111_to_120",
          "weight_more_than_120",
        ])
        ..isRadioList = false),
      NumberInput<int>((i) => i
        ..key = "activity_sleep_time"
        ..unit = "activity_sleep_time_unit"
        ..defaultValue = 8),
      NumberInput<int>((i) => i
        ..key = "activity_work_time"
        ..unit = "activity_work_time_unit"
        ..defaultValue = 8),
      RadioInput((i) => i
        ..key = "work_behavior"
        ..title = "work_behavior"
        ..defaultValue = "work_behavior_sitting_standing_walking"
        ..options.addAll([
          "work_behavior_sitting",
          "work_behavior_sitting_standing",
          "work_behavior_sitting_standing_walking",
          "work_behavior_standing_walking",
          "work_behavior_physically_demanding",
          "work_behavior_hard_work",
        ])),
      RadioInput((i) => i
        ..key = "free_time_behavior"
        ..title = "free_time_behavior"
        ..defaultValue = "free_time_behavior_sitting_standing_walking"
        ..options.addAll([
          "free_time_behavior_sitting_lying",
          "free_time_behavior_sitting_standing",
          "free_time_behavior_sitting_standing_walking",
          "free_time_behavior_standing_walking_sporty",
          "free_time_behavior_sporty"
        ])),
      RadioInput((i) => i
        ..key = "nutrition_question"
        ..title = "nutrition_question"
        ..defaultValue = "nutrition_mixed"
        ..options.addAll([
          "nutrition_meaty",
          "nutrition_mixed",
          "nutrition_meat_reduced",
          "nutrition_vegetarian",
          "nutrition_vegan",
        ])),
      RadioInput((i) => i
        ..key = "frozen_food"
        ..title = "frozen_food"
        ..defaultValue = "frozen_food_weekly"
        ..options.addAll([
          "frozen_food_never",
          "frozen_food_weekly",
          "frozen_food_daily",
        ])),
      MultiSelectInput(
        (i) => i
          ..key = "purchasing_behavior"
          ..options.addAll([
            "purchasing_behavior_supermarket",
            "purchasing_behavior_regional",
            "purchasing_behavior_regional_seasonal",
            "purchasing_behavior_bio",
            "purchasing_behavior_own_cultivation",
          ])
          ..defaultValue = ListBuilder(),
      )
    ]);
  });

  m.section("consumption", (s) {
    s.title = "consumption";
    s.info = "consumption_information";

    s.inputs.addAll([
      RangeInput((i) => i
        ..key = "monthly_expenses"
        ..unit = "monthly_expenses_unit"
        ..min = .0
        ..max = 2000.0
        ..divisions = 2000
        ..defaultValue = 300.0),
      RadioInput((i) => i
        ..key = "buying_behavior"
        ..title = "buying_behavior"
        ..defaultValue = "buying_behavior_normal"
        ..options.addAll([
          "buying_behavior_sparse",
          "buying_behavior_normal",
          "buying_behavior_generous",
        ])),
      RadioInput((i) => i
        ..key = "buying_criteria"
        ..title = "buying_criteria"
        ..defaultValue = "buying_criteria_functionality"
        ..options.addAll([
          "buying_criteria_quality",
          "buying_criteria_functionality",
          "buying_criteria_costs",
        ])),
      RadioInput((i) => i
        ..key = "buying_second_hand"
        ..title = "buying_second_hand"
        ..defaultValue = "buying_second_hand_sometimes"
        ..options.addAll([
          "buying_second_hand_preferred",
          "buying_second_hand_sometimes",
          "buying_second_hand_never",
        ])),
      NestedEntityInput((i) => i
        ..key = "pets"
        ..defaultValue.replace(BuiltList())
        ..allowRepeated = true
        ..entityTypes.addAll([
          NestedEntity((e) => e
            ..key = "dog"
            ..title = "pets_dog"
            ..inputs.addAll([
              RadioInput((i) => i
                ..key = "pets_dog_reference"
                ..title = "pets_dog_reference"
                ..options.addAll([
                  "pets_dog_reference_breeding",
                  "pets_dog_reference_shelter",
                ])),
              NumberInput<int>((i) => i
                ..key = "pets_dog_share"
                ..defaultValue = 0),
              RadioInput((i) => i
                ..key = "pets_dog_nutrition"
                ..title = "pets_dog_nutrition"
                ..options.addAll([
                  "pets_dog_nutrition_normal",
                  "pets_dog_nutrition_barf",
                ])),
              RangeInput((i) => i
                ..key = "pets_dog_weight"
                ..title = "pets_dog_weight"
                ..unit = "pets_dog_weight_unit"
                ..min = 5
                ..max = 35
                ..divisions = 6),
            ])),
          NestedEntity((e) => e
            ..key = "cat"
            ..title = "pets_cat"
            ..inputs.addAll([
              RadioInput((i) => i
                ..key = "pets_cat_reference"
                ..title = "pets_cat_reference"
                ..options.addAll([
                  "pets_cat_reference_breeding",
                  "pets_cat_reference_shelter",
                ])),
              NumberInput<int>((i) => i
                ..key = "pets_cat_share"
                ..defaultValue = 0),
              RadioInput((i) => i
                ..key = "pets_cat_nutrition"
                ..title = "pets_cat_nutrition"
                ..options.addAll([
                  "pets_cat_nutrition_normal",
                  "pets_cat_nutrition_barf",
                ])),
              RangeInput((i) => i
                ..key = "pets_cat_weight"
                ..title = "pets_cat_weight"
                ..unit = "pets_cat_weight_unit"
                ..min = 2
                ..max = 8
                ..divisions = 6),
            ])),
          NestedEntity((e) => e
            ..key = "horse"
            ..title = "pets_horse"
            ..inputs.addAll([
              RadioInput((i) => i
                ..key = "pets_horse_reference"
                ..title = "pets_horse_reference"
                ..options.addAll([
                  "pets_horse_reference_breeding",
                  "pets_horse_reference_shelter",
                ])),
              NumberInput<int>((i) => i
                ..key = "pets_horse_share"
                ..defaultValue = 0),
              RadioInput((i) => i
                ..key = "pets_horse_nutrition"
                ..title = "pets_horse_nutrition"
                ..options.addAll([
                  "pets_horse_nutrition_normal",
                  "pets_horse_nutrition_simple",
                ])),
              RangeInput((i) => i
                ..key = "pets_horse_weight"
                ..title = "pets_horse_weight"
                ..unit = "pets_horse_weight_unit"
                ..min = 400
                ..max = 600
                ..divisions = 4),
            ])),
          NestedEntity((e) => e
            ..key = "rodent"
            ..title = "pets_rodent"
            ..inputs.addAll([
              RadioInput((i) => i
                ..key = "pets_rodent_reference"
                ..title = "pets_rodent_reference"
                ..options.addAll([
                  "pets_rodent_reference_breeding",
                  "pets_rodent_reference_shelter",
                ])),
              NumberInput<int>((i) => i
                ..key = "pets_rodent_share"
                ..defaultValue = 0),
            ])),
          NestedEntity((e) => e
            ..key = "bird"
            ..title = "pets_bird"
            ..inputs.addAll([
              RadioInput((i) => i
                ..key = "pets_bird_reference"
                ..title = "pets_bird_reference"
                ..options.addAll([
                  "pets_bird_reference_breeding",
                  "pets_bird_reference_shelter",
                ])),
              NumberInput<int>((i) => i
                ..key = "pets_bird_share"
                ..defaultValue = 0),
            ])),
          NestedEntity((e) => e
            ..key = "reptiles"
            ..title = "pets_reptiles"
            ..inputs.addAll([
              RadioInput((i) => i
                ..key = "pets_reptiles_reference"
                ..title = "pets_reptiles_reference"
                ..options.addAll([
                  "pets_reptiles_reference_breeding",
                  "pets_reptiles_reference_shelter",
                ])),
              NumberInput<int>((i) => i
                ..key = "pets_reptiles_share"
                ..defaultValue = 0),
            ])),
          NestedEntity((e) => e
            ..key = "fish"
            ..title = "pets_fish"
            ..inputs.addAll([
              RadioInput((i) => i
                ..key = "pets_fish_reference"
                ..title = "pets_fish_reference"
                ..options.addAll([
                  "pets_fish_reference_breeding",
                  "pets_fish_reference_shelter",
                ])),
              NumberInput<int>((i) => i
                ..key = "pets_fish_share"
                ..defaultValue = 0),
            ])),
        ])),
      NestedEntityInput((i) => i
        ..key = "vacation"
        ..defaultValue.addAll(["beach"])
        ..allowRepeated = true
        ..entityTypes.addAll([
          NestedEntity((e) => e
            ..key = "active"
            ..title = "vacation_active"
            ..inputs.addAll([
              RadioInput((i) => i
                ..key = "vacation_active_transport"
                ..title = "vacation_active_transport"
                ..options.addAll([
                  "vacation_active_transport_airplane",
                  "vacation_active_transport_train",
                  "vacation_active_transport_bus",
                  "vacation_active_transport_own_car",
                ])),
              NumberInput(
                (i) => i
                  ..key = "vacation_active_destination"
                  ..unit = "vacation_active_destination_unit",
              ),
              RadioInput((i) => i
                ..key = "vacation_active_accommodation"
                ..title = "vacation_active_accommodation"
                ..options.addAll([
                  "vacation_active_accommodation_hotel",
                  "vacation_active_accommodation_vacation_home",
                  "vacation_active_accommodation_hostel",
                  "vacation_active_accommodation_camping",
                ])),
              NumberInput((i) => i
                ..key = "vacation_active_days"
                ..unit = "vacation_days_unit"),
            ])),
          NestedEntity((e) => e
            ..key = "beach"
            ..title = "vacation_beach"
            ..inputs.addAll([
              RadioInput((i) => i
                ..key = "vacation_beach_transport"
                ..title = "vacation_beach_transport"
                ..defaultValue = "vacation_beach_transport_airplane"
                ..options.addAll([
                  "vacation_beach_transport_airplane",
                  "vacation_beach_transport_train",
                  "vacation_beach_transport_bus",
                  "vacation_beach_transport_own_car",
                ])),
              NumberInput((i) => i
                ..key = "vacation_beach_destination"
                ..unit = "vacation_beach_destination_unit"
                ..defaultValue = 1750),
              RadioInput((i) => i
                ..key = "vacation_beach_accommodation"
                ..title = "vacation_beach_accommodation"
                ..defaultValue = "vacation_beach_accommodation_hotel"
                ..options.addAll([
                  "vacation_beach_accommodation_hotel",
                  "vacation_beach_accommodation_vacation_home",
                  "vacation_beach_accommodation_hostel",
                  "vacation_beach_accommodation_camping",
                ])),
              NumberInput((i) => i
                ..key = "vacation_beach_days"
                ..unit = "vacation_days_unit"
                ..defaultValue = 10),
            ])),
          NestedEntity((e) => e
            ..key = "family"
            ..title = "vacation_family"
            ..inputs.addAll([
              RadioInput((i) => i
                ..key = "vacation_family_transport"
                ..title = "vacation_family_transport"
                ..options.addAll([
                  "vacation_family_transport_airplane",
                  "vacation_family_transport_train",
                  "vacation_family_transport_bus",
                  "vacation_family_transport_own_car",
                ])),
              NumberInput(
                (i) => i
                  ..key = "vacation_family_destination"
                  ..unit = "vacation_family_destination_unit",
              ),
              RadioInput((i) => i
                ..key = "vacation_family_accommodation"
                ..title = "vacation_family_accommodation"
                ..options.addAll([
                  "vacation_family_accommodation_hotel",
                  "vacation_family_accommodation_vacation_home",
                  "vacation_family_accommodation_hostel",
                  "vacation_family_accommodation_camping",
                ])),
              NumberInput((i) => i
                ..key = "vacation_family_days"
                ..unit = "vacation_days_unit"),
            ])),
          NestedEntity((e) => e
            ..key = "skiing"
            ..title = "vacation_skiing"
            ..inputs.addAll([
              RadioInput((i) => i
                ..key = "vacation_skiing_transport"
                ..title = "vacation_skiing_transport"
                ..options.addAll([
                  "vacation_skiing_transport_airplane",
                  "vacation_skiing_transport_train",
                  "vacation_skiing_transport_bus",
                  "vacation_skiing_transport_own_car",
                ])),
              NumberInput(
                (i) => i
                  ..key = "vacation_skiing_destination"
                  ..unit = "vacation_skiing_destination_unit",
              ),
              RadioInput((i) => i
                ..key = "vacation_skiing_accommodation"
                ..title = "vacation_skiing_accommodation"
                ..options.addAll([
                  "vacation_skiing_accommodation_hotel",
                  "vacation_skiing_accommodation_vacation_home",
                  "vacation_skiing_accommodation_hostel",
                  "vacation_skiing_accommodation_camping",
                ])),
              NumberInput((i) => i
                ..key = "vacation_skiing_days"
                ..unit = "vacation_days_unit"),
            ])),
          NestedEntity((e) => e
            ..key = "cultural"
            ..title = "vacation_cultural"
            ..inputs.addAll([
              RadioInput((i) => i
                ..key = "vacation_cultural_transport"
                ..title = "vacation_cultural_transport"
                ..options.addAll([
                  "vacation_cultural_transport_airplane",
                  "vacation_cultural_transport_train",
                  "vacation_cultural_transport_bus",
                  "vacation_cultural_transport_own_car",
                ])),
              NumberInput(
                (i) => i
                  ..key = "vacation_cultural_destination"
                  ..unit = "vacation_cultural_destination_unit",
              ),
              RadioInput((i) => i
                ..key = "vacation_cultural_accommodation"
                ..title = "vacation_cultural_accommodation"
                ..options.addAll([
                  "vacation_cultural_accommodation_hotel",
                  "vacation_cultural_accommodation_vacation_home",
                  "vacation_cultural_accommodation_hostel",
                  "vacation_cultural_accommodation_camping",
                ])),
              NumberInput((i) => i
                ..key = "vacation_cultural_days"
                ..unit = "vacation_days_unit"),
            ])),
          NestedEntity((e) => e
            ..key = "cruise"
            ..title = "vacation_shipping"
            ..inputs.addAll([
              RadioInput((i) => i
                ..key = "vacation_shipping_transport"
                ..title = "vacation_shipping_transport"
                ..options.addAll([
                  "vacation_shipping_transport_airplane",
                  "vacation_shipping_transport_train",
                  "vacation_shipping_transport_bus",
                  "vacation_shipping_transport_own_car",
                ])),
              NumberInput(
                (i) => i
                  ..key = "vacation_shipping_destination"
                  ..unit = "vacation_shipping_destination_unit",
              ),
              NumberInput((i) => i
                ..key = "vacation_shipping_days"
                ..unit = "vacation_days_unit"),
            ])),
          NestedEntity((e) => e
            ..key = "balcony"
            ..title = "vacation_balcony"
            ..inputs.addAll([
              RadioInput((i) => i
                ..key = "vacation_balcony_transport"
                ..title = "vacation_balcony_transport"
                ..options.addAll([
                  "vacation_balcony_transport_airplane",
                  "vacation_balcony_transport_train",
                  "vacation_balcony_transport_bus",
                  "vacation_balcony_transport_own_car",
                ])),
              NumberInput(
                (i) => i
                  ..key = "vacation_balcony_destination"
                  ..unit = "vacation_balcony_destination_unit",
              ),
              NumberInput((i) => i
                ..key = "vacation_balcony_days"
                ..unit = "vacation_days_unit"),
            ])),
        ])),
    ]);
  });

  m.section("public", (s) {
    s.title = "public";
    s.inputs.addAll([
      Header((h) => h
        ..key = "public_general_information"
        ..title = "public_general_information"
        ..description = "public_general_information_description"),
      Header((h) => h
        ..key = "public_properties"
        ..title = "public_properties"
        ..defaultValue = 0.093
        ..description = "public_properties_description"),
      Header((h) => h
        ..key = "waste_recycling_management"
        ..title = "waste_recycling_management"
        ..defaultValue = 0.127
        ..description = "waste_recycling_management_description"),
      Header((h) => h
        ..key = "digital_infrastructure"
        ..title = "digital_infrastructure"
        ..defaultValue = 0.143
        ..description = "digital_infrastructure_description"),
      Header((h) => h
        ..key = "traffic_signals_street_lighting"
        ..title = "traffic_signals_street_lighting"
        ..description = "traffic_signals_street_lighting_description"
        ..defaultValue = 0.029),
      Header((h) => h
        ..key = "freight_traffic"
        ..defaultValue = 0.349
        ..title = "freight_traffic"
        ..description = "freight_traffic_description"),
    ]);
  });

  m.section("compensation", (s) {
    s.key = " compensation";
    s.title = "compensation";
    s.inputs.addAll([
      NumberInput<double>((i) => i
        ..key = "compensation_investment"
        ..title = "compensation_investment"
        ..unit = "compensation_investment_unit"),
      NumberInput<double>((i) => i
        ..key = "compensation_certificates"
        ..title = "compensation_certificates"
        ..unit = "compensation_certificates_unit"),
      NumberInput<double>((i) => i
        ..key = "compensation_electricity"
        ..title = "compensation_electricity"
        ..unit = "compensation_electricity_unit"),
    ]);
  });
}
