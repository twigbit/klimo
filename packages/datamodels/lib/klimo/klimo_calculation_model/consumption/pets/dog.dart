import '../../../../calculation_model.dart';
import 'common.dart';

void buildConsumptionDogEntity(FormulaNodeBuilder b) => b
  ..nodes.addAll([
    // ---
    // --- Umrechnungsfaktoren
    // ---
    FormulaNode.param("U_Hund_5_N", 0.37 /* tCO2/a*/),
    FormulaNode.param("U_Hund_10_N", 0.46 /* tCO2/a*/),
    FormulaNode.param("U_Hund_15_N", 0.55 /* tCO2/a*/),
    FormulaNode.param("U_Hund_20_N", 0.65 /* tCO2/a*/),
    FormulaNode.param("U_Hund_25_N", 0.75 /* tCO2/a*/),
    FormulaNode.param("U_Hund_30_N", 0.86 /* tCO2/a*/),
    FormulaNode.param("U_Hund_35_N", 0.97 /* tCO2/a*/),
    FormulaNode.param("U_Hund_5_B", 0.95 /* tCO2/a*/),
    FormulaNode.param("U_Hund_10_B", 1.16 /* tCO2/a*/),
    FormulaNode.param("U_Hund_15_B", 1.37 /* tCO2/a*/),
    FormulaNode.param("U_Hund_20_B", 1.57 /* tCO2/a*/),
    FormulaNode.param("U_Hund_25_B", 1.77 /* tCO2/a*/),
    FormulaNode.param("U_Hund_30_B", 1.96 /* tCO2/a*/),
    FormulaNode.param("U_Hund_35_B", 2.15 /* tCO2/a*/),
  ])
  ..footprint((input, ref) {
    var numberOfOwner = input<num>(".pets_dog_share") + 1;
    var reference = input<String>(".pets_dog_reference");
    var uBezugH = .0;
    if (reference == "pets_dog_reference_breeding") uBezugH = 1.0;
    var uTierH = .0;
    var nutrition = input<String>(".pets_dog_nutrition");
    var weight = input<num>(".pets_dog_weight");
    if (nutrition == "pets_dog_nutrition_normal") {
      switch (roundToNearest(weight, 5, 35, 5)) {
        case 5:
          uTierH = ref(".U_Hund_5_N");
          break;
        case 10:
          uTierH = ref(".U_Hund_10_N");
          break;
        case 15:
          uTierH = ref(".U_Hund_15_N");
          break;
        case 20:
          uTierH = ref(".U_Hund_20_N");
          break;
        case 25:
          uTierH = ref(".U_Hund_25_N");
          break;
        case 30:
          uTierH = ref(".U_Hund_30_N");
          break;
        case 35:
          uTierH = ref(".U_Hund_35_N");
          break;
      }
    } else if (nutrition == "pets_dog_nutrition_barf") {
      switch (roundToNearest(weight, 5, 35, 5)) {
        case 5:
          uTierH = ref(".U_Hund_5_B");
          break;
        case 10:
          uTierH = ref(".U_Hund_10_B");
          break;
        case 15:
          uTierH = ref(".U_Hund_15_B");
          break;
        case 20:
          uTierH = ref(".U_Hund_20_B");
          break;
        case 25:
          uTierH = ref(".U_Hund_25_B");
          break;
        case 30:
          uTierH = ref(".U_Hund_30_B");
          break;
        case 35:
          uTierH = ref(".U_Hund_35_B");
          break;
      }
    }
    return (uBezugH * uTierH) / numberOfOwner;
  });
