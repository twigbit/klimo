import '../../../../calculation_model.dart';

void buildConsumptionFishEntity(FormulaNodeBuilder b) => b
  ..nodes.addAll([
    // ---
    // --- Umrechnungsfaktoren
    // ---
    FormulaNode.param("U_Tier_N", 0.01 /* tCO2/a*/),
  ])
  ..footprint((input, ref) {
    var numberOfOwner = input<num>(".pets_fish_share") + 1;
    var reference = input<String>(".pets_fish_reference");
    var uBezugN = .0;
    if (reference == "pets_fish_reference_breeding") uBezugN = 1.0;
    var uTierN = ref(".U_Tier_N");
    return (uBezugN * uTierN) / numberOfOwner;
  });
