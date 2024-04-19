import '../../../../calculation_model.dart';

void buildConsumptionBirdEntity(FormulaNodeBuilder b) => b
  ..nodes.addAll([
    // ---
    // --- Umrechnungsfaktoren
    // ---
    FormulaNode.param("U_Tier_V", 0.06 /* tCO2/a*/),
  ])
  ..footprint((input, ref) {
    var numberOfOwner = input<num>(".pets_bird_share") + 1;
    var reference = input<String>(".pets_bird_reference");
    var uBezugV = .0;
    if (reference == "pets_bird_reference_breeding") uBezugV = 1.0;
    var uTierV = ref(".U_Tier_V");
    return (uBezugV * uTierV) / numberOfOwner;
  });
