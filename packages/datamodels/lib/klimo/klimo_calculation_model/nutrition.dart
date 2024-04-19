import 'package:built_collection/built_collection.dart';

import '../../calculation_model.dart';

void buildNutritionSection(FormulaNodeBuilder b) {
  b.key = "nutrition";

  // ---
  // --- Berechnungsparameter
  // ---
  b.nodes.addAll([
    FormulaNode.param("fCO2_GU_Mensch", 1.13 /* tCO2/a */),
    FormulaNode.param("PAL_Sch", 0.95 /* tCO2/a */),
    FormulaNode.param("PAL_Az_sitzend", 1.35 /* tCO2/a */),
    FormulaNode.param("PAL_Az_sitzend_stehend", 1.4 /* tCO2/a */),
    FormulaNode.param("PAL_Az_sitzend_stehend_gehend", 1.55 /* tCO2/a */),
    FormulaNode.param("PAL_Az_stehend_gehend", 1.75 /* tCO2/a */),
    FormulaNode.param("PAL_Az_koerperlich_anstrengend", 2.1 /* tCO2/a */),
    FormulaNode.param("PAL_Az_koerperliche_schwerstarbeit", 3.7 /* tCO2/a */),
    FormulaNode.param("PAL_Fz_sitzend_liegend", 1.1 /* tCO2/a */),
    FormulaNode.param("PAL_Fz_sitzend_stehend", 1.4 /* tCO2/a */),
    FormulaNode.param("PAL_Fz_sitzend_stehend_gehend", 1.55 /* tCO2/a */),
    FormulaNode.param("PAL_Fz_stehend_gehend_sportlich", 2.1 /* tCO2/a */),
    FormulaNode.param("PAL_Fz_ueberwiegend_sportlich", 3.7 /* tCO2/a */),
    FormulaNode.param("Ukcal_2000", 0.83 /* tCO2/a */),
    FormulaNode.param("Ukcal_2400", 1.00 /* tCO2/a */),
    FormulaNode.param("Ukcal_3000", 1.25 /* tCO2/a */),
    FormulaNode.param("Ukcal_4000", 1.67 /* tCO2/a */),
    FormulaNode.param("UEr_fleischbetont", 1.3 /* tCO2/a */),
    FormulaNode.param("UEr_mischkost", 1.0 /* tCO2/a */),
    FormulaNode.param("UEr_fleischreduziert", 0.8 /* tCO2/a */),
    FormulaNode.param("UEr_vegetarisch", 0.7 /* tCO2/a */),
    FormulaNode.param("UEr_vegan", 0.65 /* tCO2/a */),
    FormulaNode.param("UTk_nie", 1.0 /* tCO2/a */),
    FormulaNode.param("UTk_woechentlich", 1.1 /* tCO2/a */),
    FormulaNode.param("UTk_taeglich", 1.2 /* tCO2/a */),
    FormulaNode.param("UEv_supermarket", 1.0 /* tCO2/a */),
    FormulaNode.param("UEv_regional", 0.9 /* tCO2/a */),
    FormulaNode.param("UEv_regional_seasonal", 0.86 /* tCO2/a */),
    FormulaNode.param("UEv_bio", 0.85 /* tCO2/a */),
    FormulaNode.param("UEv_own_cultivation", 0.6 /* tCO2/a */),
  ]);

  // ---
  // --- Berechnung
  // ---
  b.nodes.addAll([
    // Grundumsatz je nach Geschlecht
    FormulaNode((n) => n
      ..key = "base_mentabolism"
      ..footprint((input, ref) {
        var gender = input<String>("..gender");
        var ageRange = input<String>("..age_range");
        // default value that is given with range 31 to 60
        var ageValue = 45.0;

        switch (ageRange) {
          case "age_up_to_18":
            ageValue = 18.0;
            break;
          case "age_19_to_30":
            ageValue = 24.0;
            break;
          case "age_31_to_60":
            ageValue = 45.0;
            break;
          case "age_61_to_75":
            ageValue = 68.0;
            break;
          case "age_mor_than_75":
            ageValue = 76.0;
            break;
        }

        var weightRange = input<String>("..weight_range");
        // default value given with range 61 tp 70 kg
        var weightValue = 65.0;

        switch (weightRange) {
          case "weight_up_to_40":
            weightValue = 40.0;
            break;
          case "weight_41_to_50":
            weightValue = 45.0;
            break;
          case "weight_51_to_60":
            weightValue = 55.0;
            break;
          case "weight_61_to_70":
            weightValue = 65.0;
            break;
          case "weight_71_to_80":
            weightValue = 75.0;
            break;
          case "weight_81_to_90":
            weightValue = 85.0;
            break;
          case "weight_91_to_100":
            weightValue = 95.0;
            break;
          case "weight_101_to_110":
            weightValue = 105.0;
            break;
          case "weight_111_to_120":
            weightValue = 115.0;
            break;
          case "weight_more_than_120":
            weightValue = 121;
            break;
        }

        double genderCoe;
        if (gender == "gender_male") {
          genderCoe = 1.009;
        } else if (gender == "gender_diverse" || gender == "gender_no_value") {
          genderCoe = 0.5045;
        } else {
          genderCoe = 0.0;
        }

        return ((0.047 * weightValue) +
                genderCoe -
                (0.01452 * ageValue) +
                3.21) *
            239;
      })),

    //Physical Activity Level
    FormulaNode((n) => n
      ..key = "physical_activity_level"
      ..footprint((input, ref) {
        var sleepTime = input<num>("..activity_sleep_time");
        var workTime = input<num>("..activity_work_time");
        var freeTime = 24.0 - sleepTime - workTime;
        var palSch = ref("..PAL_Sch");
        var workBehavior = input<String>("..work_behavior");
        var palAz = .0;
        var freeTimeBehavior = input<String>("..free_time_behavior");
        var palFz = .0;

        switch (workBehavior) {
          case "work_behavior_sitting":
            palAz = ref("..PAL_Az_sitzend");
            break;
          case "work_behavior_sitting_standing":
            palAz = ref("..PAL_Az_sitzend_stehend");
            break;
          case "work_behavior_sitting_standing_walking":
            palAz = ref("..PAL_Az_sitzend_stehend_gehend");
            break;
          case "work_behavior_standing_walking":
            palAz = ref("..PAL_Az_stehend_gehend");
            break;
          case "work_behavior_physically_demanding":
            palAz = ref("..PAL_Az_koerperlich_anstrengend");
            break;
          case "work_behavior_hard_work":
            palAz = ref("..PAL_Az_koerperliche_schwerstarbeit");
            break;
        }

        switch (freeTimeBehavior) {
          case "free_time_behavior_sitting_lying":
            palFz = ref("..PAL_Fz_sitzend_liegend");
            break;
          case "free_time_behavior_sitting_standing":
            palFz = ref("..PAL_Fz_sitzend_stehend");
            break;
          case "free_time_behavior_sitting_standing_walking":
            palFz = ref("..PAL_Fz_sitzend_stehend_gehend");
            break;
          case "free_time_behavior_standing_walking_sporty":
            palFz = ref("..PAL_Fz_stehend_gehend_sportlich");
            break;
          case "free_time_behavior_sporty":
            palFz = ref("..PAL_Fz_ueberwiegend_sportlich");
            break;
        }

        return ((sleepTime * palSch * 7) +
                (workTime * palAz * 5) +
                (freeTime * palFz * 5) +
                ((freeTime + workTime) * palFz * 2)) /
            168;
      })),
  ]);

  // ---
  // --- Outputparameter
  // ---
  b.nodes.addAll([
    //Umrechnungsfaktoren Einkaufsverhalten
    //TODO discuss concept with Tarek
    /// for now there is a multi select variable & I assumed equal distribution among selected values
    /// -> because problem with manual shares: how to assure that user can not exceed 100%?
    /// -> and problem with this concept at all: no overlapping values possible

    FormulaNode((n) => n
      ..key = "purchasing_behavior"
      ..footprint((input, ref) {
        var purchasingBehavior =
            input<BuiltList<Object>>("..purchasing_behavior");
        var uevSupermarket = ref("..UEv_supermarket").toDouble();
        var uevRegional = ref("..UEv_regional").toDouble();
        var uevRegionalSeasonal = ref("..UEv_regional_seasonal").toDouble();
        var uevBio = ref("..UEv_bio").toDouble();
        var uevOwnCultivation = ref("..UEv_own_cultivation").toDouble();
        var uev = .0;

        if (purchasingBehavior.isEmpty) {
          // TODO adjust default value when shares are asked for explicitly or question are changed generally
          purchasingBehavior = BuiltList<Object>([
            "purchasing_behavior_supermarket",
            "purchasing_behavior_bio",
          ]);
        }

        if (purchasingBehavior.length == 1) {
          if (purchasingBehavior.contains("purchasing_behavior_supermarket")) {
            uev = uevSupermarket;
          } else if (purchasingBehavior
              .contains("purchasing_behavior_regional")) {
            uev = uevRegional;
          } else if (purchasingBehavior
              .contains("purchasing_behavior_regional_seasonal")) {
            uev = uevRegionalSeasonal;
          } else if (purchasingBehavior.contains("purchasing_behavior_bio")) {
            uev = uevBio;
          } else if (purchasingBehavior
              .contains("purchasing_behavior_own_cultivation")) {
            uev = uevOwnCultivation;
          }
        } else if (purchasingBehavior.length == 2) {
          if (purchasingBehavior.contains("purchasing_behavior_supermarket") &&
              purchasingBehavior.contains("purchasing_behavior_regional")) {
            uev = (1 / 2) * (uevSupermarket + uevRegional);
          } else if (purchasingBehavior
                  .contains("purchasing_behavior_supermarket") &&
              purchasingBehavior
                  .contains("purchasing_behavior_regional_seasonal")) {
            uev = (1 / 2) * (uevSupermarket + uevRegionalSeasonal);
          } else if (purchasingBehavior
                  .contains("purchasing_behavior_supermarket") &&
              purchasingBehavior.contains("purchasing_behavior_bio")) {
            uev = (1 / 2) * (uevSupermarket + uevBio);
          } else if (purchasingBehavior
                  .contains("purchasing_behavior_supermarket") &&
              purchasingBehavior
                  .contains("purchasing_behavior_own_cultivation")) {
            uev = (1 / 2) * (uevSupermarket + uevOwnCultivation);
          } else if (purchasingBehavior
                  .contains("purchasing_behavior_regional") &&
              purchasingBehavior
                  .contains("purchasing_behavior_regional_seasonal")) {
            uev = (1 / 2) * (uevRegional + uevRegionalSeasonal);
          } else if (purchasingBehavior
                  .contains("purchasing_behavior_regional") &&
              purchasingBehavior.contains("purchasing_behavior_bio")) {
            uev = (1 / 2) * (uevRegional + uevBio);
          } else if (purchasingBehavior
                  .contains("purchasing_behavior_regional") &&
              purchasingBehavior
                  .contains("purchasing_behavior_own_cultivation")) {
            uev = (1 / 2) * (uevRegional + uevOwnCultivation);
          } else if (purchasingBehavior
                  .contains("purchasing_behavior_regional_seasonal") &&
              purchasingBehavior.contains("purchasing_behavior_bio")) {
            uev = (1 / 2) * (uevRegionalSeasonal + uevBio);
          } else if (purchasingBehavior
                  .contains("purchasing_behavior_regional_seasonal") &&
              purchasingBehavior
                  .contains("purchasing_behavior_own_cultivation")) {
            uev = (1 / 2) * (uevRegionalSeasonal + uevOwnCultivation);
          } else if (purchasingBehavior.contains("purchasing_behavior_bio") &&
              purchasingBehavior
                  .contains("purchasing_behavior_own_cultivation")) {
            uev = (1 / 2) * (uevRegional + uevBio);
          }
        } else if (purchasingBehavior.length == 3) {
          if (purchasingBehavior.contains("purchasing_behavior_supermarket") &&
              purchasingBehavior.contains("purchasing_behavior_regional") &&
              purchasingBehavior
                  .contains("purchasing_behavior_regional_seasonal")) {
            uev =
                (1 / 3) * (uevSupermarket + uevRegional + uevRegionalSeasonal);
          } else if (purchasingBehavior
                  .contains("purchasing_behavior_supermarket") &&
              purchasingBehavior.contains("purchasing_behavior_regional") &&
              purchasingBehavior.contains("purchasing_behavior_bio")) {
            uev = (1 / 3) * (uevSupermarket + uevRegional + uevBio);
          } else if (purchasingBehavior
                  .contains("purchasing_behavior_supermarket") &&
              purchasingBehavior.contains("purchasing_behavior_regional") &&
              purchasingBehavior
                  .contains("purchasing_behavior_own_cultivation")) {
            uev = (1 / 3) * (uevSupermarket + uevRegional + uevOwnCultivation);
          } else if (purchasingBehavior
                  .contains("purchasing_behavior_supermarket") &&
              purchasingBehavior
                  .contains("purchasing_behavior_regional_seasonal") &&
              purchasingBehavior.contains("purchasing_behavior_bio")) {
            uev = (1 / 3) * (uevSupermarket + uevRegionalSeasonal + uevBio);
          } else if (purchasingBehavior
                  .contains("purchasing_behavior_supermarket") &&
              purchasingBehavior
                  .contains("purchasing_behavior_regional_seasonal") &&
              purchasingBehavior
                  .contains("purchasing_behavior_ownCultivation")) {
            uev = (1 / 3) *
                (uevSupermarket + uevRegionalSeasonal + uevOwnCultivation);
          } else if (purchasingBehavior
                  .contains("purchasing_behavior_supermarket") &&
              purchasingBehavior.contains("purchasing_behavior_bio") &&
              purchasingBehavior
                  .contains("purchasing_behavior_own_cultivation")) {
            uev = (1 / 3) * (uevSupermarket + uevBio + uevOwnCultivation);
          } else if (purchasingBehavior
                  .contains("purchasing_behavior_regional") &&
              purchasingBehavior
                  .contains("purchasing_behavior_regional_seasonal") &&
              purchasingBehavior.contains("purchasing_behavior_bio")) {
            uev = (1 / 3) * (uevRegional + uevRegionalSeasonal + uevBio);
          } else if (purchasingBehavior
                  .contains("purchasing_behavior_regional") &&
              purchasingBehavior
                  .contains("purchasing_behavior_regional_seasonal") &&
              purchasingBehavior
                  .contains("purchasing_behavior_own_cultivation")) {
            uev = (1 / 3) *
                (uevRegional + uevRegionalSeasonal + uevOwnCultivation);
          } else if (purchasingBehavior
                  .contains("purchasing_behavior_regional") &&
              purchasingBehavior.contains("purchasing_behavior_bio") &&
              purchasingBehavior
                  .contains("purchasing_behavior_own_cultivation")) {
            uev = (1 / 3) * (uevRegional + uevBio + uevOwnCultivation);
          } else if (purchasingBehavior
                  .contains("purchasing_behavior_regional_seasonal") &&
              purchasingBehavior.contains("purchasing_behavior_bio") &&
              purchasingBehavior
                  .contains("purchasing_behavior_own_cultivation")) {
            uev = (1 / 3) * (uevRegionalSeasonal + uevBio + uevOwnCultivation);
          }
        } else if (purchasingBehavior.length == 4) {
          if (purchasingBehavior.contains("purchasing_behavior_supermarket") &&
              purchasingBehavior.contains("purchasing_behavior_regional") &&
              purchasingBehavior
                  .contains("purchasing_behavior_regional_seasonal") &&
              purchasingBehavior.contains("purchasing_behavior_bio")) {
            uev = (1 / 4) *
                (uevSupermarket + uevRegional + uevRegionalSeasonal + uevBio);
          } else if (purchasingBehavior
                  .contains("purchasing_behavior_supermarket") &&
              purchasingBehavior.contains("purchasing_behavior_regional") &&
              purchasingBehavior
                  .contains("purchasing_behavior_regional_seasonal") &&
              purchasingBehavior
                  .contains("purchasing_behavior_own_cultivation")) {
            uev = (1 / 4) *
                (uevSupermarket +
                    uevRegional +
                    uevRegionalSeasonal +
                    uevOwnCultivation);
          } else if (purchasingBehavior
                  .contains("purchasing_behavior_regional") &&
              purchasingBehavior
                  .contains("purchasing_behavior_regional_seasonal") &&
              purchasingBehavior.contains("purchasing_behavior_bio") &&
              purchasingBehavior
                  .contains("purchasing_behavior_own_cultivation")) {
            uev = (1 / 4) *
                (uevRegional +
                    uevRegionalSeasonal +
                    uevBio +
                    uevOwnCultivation);
          } else if (purchasingBehavior
                  .contains("purchasing_behavior_supermarket") &&
              purchasingBehavior
                  .contains("purchasing_behavior_regional_seasonal") &&
              purchasingBehavior.contains("purchasing_behavior_bio") &&
              purchasingBehavior
                  .contains("purchasing_behavior_own_cultivation")) {
            print("HII");
            uev = (1 / 4) *
                (uevSupermarket +
                    uevRegionalSeasonal +
                    uevBio +
                    uevOwnCultivation);
          } else if (purchasingBehavior
                  .contains("purchasing_behavior_supermarket") &&
              purchasingBehavior.contains("purchasing_behavior_regional") &&
              purchasingBehavior.contains("purchasing_behavior_bio") &&
              purchasingBehavior
                  .contains("purchasing_behavior_own_cultivation")) {
            uev = (1 / 4) *
                (uevSupermarket + uevRegional + uevBio + uevOwnCultivation);
          }
        } else if (purchasingBehavior.length == 5) {
          uev = (1 / 5) *
              (uevSupermarket +
                  uevRegional +
                  uevRegionalSeasonal +
                  uevBio +
                  uevOwnCultivation);
        }

        return uev;
      })),
    FormulaNode((n) => n
      ..key = "nutrition_emission"
      ..footprint((input, ref) {
        //erforderliche Energiezufuhr
        var requiredEnergy =
            ref("..base_mentabolism") * ref("..physical_activity_level");
        var calorieDemand = ref("..base_mentabolism");
        var ukcal = .0;
        var nutritionType = input<String>("..nutrition_question");
        var uer = .0;
        var frozenFood = input<String>("..frozen_food");
        var utk = .0;

        if (calorieDemand <= 2000.0) {
          ukcal = ref("..Ukcal_2000");
        } else if (calorieDemand <= 2400.0) {
          ukcal = ref("..Ukcal_2400");
        } else if (calorieDemand <= 3000.0) {
          ukcal = ref("..Ukcal_3000");
        } else {
          ukcal = ref("..Ukcal_4000");
        }
        switch (nutritionType) {
          case "nutrition_meaty":
            uer = ref("..UEr_fleischbetont");
            break;
          case "nutrition_mixed":
            uer = ref("..UEr_mischkost");
            break;
          case "nutrition_meat_reduced":
            uer = ref("..UEr_fleischreduziert");
            break;
          case "nutrition_vegetarian":
            uer = ref("..UEr_vegetarisch");
            break;
          case "nutrition_vegan":
            uer = ref("..UEr_vegan");
            break;
        }
        switch (frozenFood) {
          case "frozen_food_never":
            utk = ref("..UTk_nie");
            break;
          case "frozen_food_weekly":
            utk = ref("..UTk_woechentlich");
            break;
          case "frozen_food_daily":
            utk = ref("..UTk_taeglich");
            break;
        }

        return (requiredEnergy *
                ukcal *
                uer *
                utk *
                ref("..purchasing_behavior") *
                ref("..fCO2_GU_Mensch")) /
            1000;
      })),
  ]);

  b.footprint((inp, ref) {
    return ref(".nutrition_emission");
  });
}
