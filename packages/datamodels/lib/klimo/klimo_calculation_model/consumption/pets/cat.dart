import '../../../../calculation_model.dart';
import 'common.dart';

void buildConsumptionCatEntity(FormulaNodeBuilder b) => b
  ..nodes.addAll([
    // ---
    // --- Umrechnungsfaktoren
    // ---
    FormulaNode.param("U_Katze_2_N", 0.25 /* tCO2/a*/),
    FormulaNode.param("U_Katze_3_N", 0.29 /* tCO2/a*/),
    FormulaNode.param("U_Katze_4_N", 0.33 /* tCO2/a*/),
    FormulaNode.param("U_Katze_5_N", 0.39 /* tCO2/a*/),
    FormulaNode.param("U_Katze_6_N", 0.45 /* tCO2/a*/),
    FormulaNode.param("U_Katze_7_N", 0.53 /* tCO2/a*/),
    FormulaNode.param("U_Katze_8_N", 0.61 /* tCO2/a*/),
    FormulaNode.param("U_Katze_2_B", 0.55 /* tCO2/a*/),
    FormulaNode.param("U_Katze_3_B", 0.64 /* tCO2/a*/),
    FormulaNode.param("U_Katze_4_B", 0.73 /* tCO2/a*/),
    FormulaNode.param("U_Katze_5_B", 0.82 /* tCO2/a*/),
    FormulaNode.param("U_Katze_6_B", 0.92 /* tCO2/a*/),
    FormulaNode.param("U_Katze_7_B", 1.02 /* tCO2/a*/),
    FormulaNode.param("U_Katze_8_B", 1.12 /* tCO2/a*/),
  ])
  ..footprint((input, ref) {
    var numberOfOwner = input<num>(".pets_cat_share") + 1;
    var reference = input<String>(".pets_cat_reference");
    var uBezugK = .0;
    if (reference == "pets_cat_reference_breeding") uBezugK = 1.0;
    var uTierK = .0;
    var nutrition = input<String>(".pets_cat_nutrition");
    var weight = input<num>(".pets_cat_weight");
    if (nutrition == "pets_cat_nutrition_normal") {
      switch (roundToNearest(weight, 2, 8, 1)) {
        case 2:
          uTierK = ref(".U_Katze_2_N");
          break;
        case 3:
          uTierK = ref(".U_Katze_3_N");
          break;
        case 4:
          uTierK = ref(".U_Katze_4_N");
          break;
        case 5:
          uTierK = ref(".U_Katze_5_N");
          break;
        case 6:
          uTierK = ref(".U_Katze_6_N");
          break;
        case 7:
          uTierK = ref(".U_Katze_7_N");
          break;
        case 8:
          uTierK = ref(".U_Katze_8_N");
          break;
      }
    } else if (nutrition == "pets_cat_nutrition_barf") {
      switch (roundToNearest(weight, 2, 8, 1)) {
        case 2:
          uTierK = ref(".U_Katze_2_B");
          break;
        case 3:
          uTierK = ref(".U_Katze_3_B");
          break;
        case 4:
          uTierK = ref(".U_Katze_4_B");
          break;
        case 5:
          uTierK = ref(".U_Katze_5_B");
          break;
        case 6:
          uTierK = ref(".U_Katze_6_B");
          break;
        case 7:
          uTierK = ref(".U_Katze_7_B");
          break;
        case 8:
          uTierK = ref(".U_Katze_8_B");
          break;
      }
    }
    return (uBezugK * uTierK) / numberOfOwner;
  });
