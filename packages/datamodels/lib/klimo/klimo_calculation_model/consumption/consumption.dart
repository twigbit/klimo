import '../../../calculation_model.dart';
import 'pets/bird.dart';
import 'pets/cat.dart';
import 'pets/dog.dart';
import 'pets/fish.dart';
import 'pets/horse.dart';
import 'pets/reptiles.dart';
import 'pets/rodent.dart';
import 'vacations/active.dart';
import 'vacations/balcony.dart';
import 'vacations/beach.dart';
import 'vacations/cruise.dart';
import 'vacations/cultural.dart';
import 'vacations/family.dart';
import 'vacations/skiing.dart';

void buildConsumptionSection(FormulaNodeBuilder b) {
  b.key = "consumption";
  // ---
  // --- Berechnungsparameter
  // ---
  b.nodes.addAll([
    //Umrechnungsfaktoren Produkte & Dienstleistungen
    FormulaNode.param("UmA", 0.65 /* tCO2/a je 100€*/),
    FormulaNode.param("UKaufv_2", 0.035 /* tCO2/a je 100€*/),
    FormulaNode.param("UKaufv_3", 0.07 /* tCO2/a je 100€*/),
    FormulaNode.param("UKaufk_2", 0.035 /* tCO2/a je 100€*/),
    FormulaNode.param("UKaufk_3", 0.07 /* tCO2/a je 100€*/),
    FormulaNode.param("UKauf2_2", 0.035 /* tCO2/a je 100€*/),
    FormulaNode.param("UKauf2_3", 0.07 /* tCO2/a je 100€*/),
  ]);

  // ---
  // --- Outputparameter Konsum
  // ---
  b.nodes.addAll([
    FormulaNode((n) => n
      ..key = "products_services"
      ..footprint((input, ref) {
        var monthlyExpenses = input<double>("..monthly_expenses");
        var uma = ref("..UmA");
        var behavior = input<String>("..buying_behavior");
        var ukaufv = .0;
        var criteria = input<String>("..buying_criteria");
        var ukaufk = .0;
        var secondHand = input<String>("..buying_second_hand");
        var ukauf2 = .0;

        switch (behavior) {
          case "buying_behavior_normal":
            ukaufv = ref("..UKaufv_2");
            break;
          case "buying_behavior_generous":
            ukaufv = ref("..UKaufv_3");
            break;
        }
        switch (criteria) {
          case "buying_criteria_functionality":
            ukaufk = ref("..UKaufk_2");
            break;
          case "buying_criteria_costs":
            ukaufk = ref("..UKaufk_3");
            break;
        }
        switch (secondHand) {
          case "buying_second_hand_sometimes":
            ukauf2 = ref("..UKauf2_2");
            break;
          case "buying_second_hand_never":
            ukauf2 = ref("..UKauf2_3");
            break;
        }

        return (monthlyExpenses / 100) * (uma + ukaufv + ukaufk + ukauf2);
      })),
  ]);

  // ---
  // --- Outputparameter Haustier
  // ---

  //Summe Haustier
  b.nodes.add(
    NestedNode((n) => n
      ..key = "pets"
      ..input = "consumption.pets"
      ..entityType("dog", buildConsumptionDogEntity)
      ..entityType("cat", buildConsumptionCatEntity)
      ..entityType("horse", buildConsumptionHorseEntity)
      ..entityType("rodent", buildConsumptionRodentEntity)
      ..entityType("bird", buildConsumptionBirdEntity)
      ..entityType("reptiles", buildConsumptionReptilesEntity)
      ..entityType("fish", buildConsumptionFishEntity)),
  );

  // ---
  // --- Outputparameter Urlaub
  // ---

  //Summe Urlaub
  b.nodes.add(
    NestedNode((n) => n
      ..key = "vacation"
      ..input = "consumption.vacation"
      ..entityType("active", buildVacationActiveEntity)
      ..entityType("beach", buildVacationBeachEntity)
      ..entityType("family", buildVacationFamilyEntity)
      ..entityType("skiing", buildVacationSkiingEntity)
      ..entityType("cultural", buildVacationCulturalEntity)
      ..entityType("cruise", buildVacationCruiseEntity)
      ..entityType("balcony", buildVacationBalconyEntity)),
  );

  b.footprint((inp, ref) {
    return ref(".products_services") + ref(".pets") + ref(".vacation");
  });
}
