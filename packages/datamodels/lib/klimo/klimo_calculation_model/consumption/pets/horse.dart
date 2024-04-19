import '../../../../calculation_model.dart';
import 'common.dart';

void buildConsumptionHorseEntity(FormulaNodeBuilder b) => b
  ..nodes.addAll([
    // ---
    // --- Umrechnungsfaktoren
    // ---
    FormulaNode.param("U_Pferd_400_N", 2.03 /* tCO2/a*/),
    FormulaNode.param("U_Pferd_450_N", 2.16 /* tCO2/a*/),
    FormulaNode.param("U_Pferd_500_N", 2.28 /* tCO2/a*/),
    FormulaNode.param("U_Pferd_550_N", 2.39 /* tCO2/a*/),
    FormulaNode.param("U_Pferd_600_N", 2.5 /* tCO2/a*/),
    FormulaNode.param("U_Pferd_400_E", 1.72 /* tCO2/a*/),
    FormulaNode.param("U_Pferd_450_E", 1.8 /* tCO2/a*/),
    FormulaNode.param("U_Pferd_500_E", 1.88 /* tCO2/a*/),
    FormulaNode.param("U_Pferd_550_E", 1.97 /* tCO2/a*/),
    FormulaNode.param("U_Pferd_600_E", 2.05 /* tCO2/a*/),
  ])
  ..footprint((input, ref) {
    var numberOfOwner = input<num>(".pets_horse_share") + 1;
    var reference = input<String>(".pets_horse_reference");
    var uBezugP = .0;
    if (reference == "pets_horse_reference_breeding") uBezugP = 1.0;
    var uTierP = .0;
    var nutrition = input<String>(".pets_horse_nutrition");
    var weight = input<num>(".pets_horse_weight");
    if (nutrition == "pets_horse_nutrition_normal") {
      switch (roundToNearest(weight, 400, 600, 50)) {
        case 400:
          uTierP = ref(".U_Pferd_400_N");
          break;
        case 450:
          uTierP = ref(".U_Pferd_450_N");
          break;
        case 500:
          uTierP = ref(".U_Pferd_500_N");
          break;
        case 550:
          uTierP = ref(".U_Pferd_550_N");
          break;
        case 600:
          uTierP = ref(".U_Pferd_600_N");
          break;
      }
    } else if (nutrition == "pets_horse_nutrition_simple") {
      switch (roundToNearest(weight, 400, 600, 50)) {
        case 400:
          uTierP = ref(".U_Pferd_400_E");
          break;
        case 450:
          uTierP = ref(".U_Pferd_450_E");
          break;
        case 500:
          uTierP = ref(".U_Pferd_500_E");
          break;
        case 550:
          uTierP = ref(".U_Pferd_550_E");
          break;
        case 600:
          uTierP = ref(".U_Pferd_600_E");
          break;
      }
    }
    return (uBezugP * uTierP) / numberOfOwner;
  });
