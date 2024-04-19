import '../../../../calculation_model.dart';

void buildConsumptionReptilesEntity(FormulaNodeBuilder b) => b
  ..nodes.addAll([
    // ---
    // --- Umrechnungsfaktoren
    // ---
    FormulaNode.param("U_Tier_N", 0.2 /* tCO2/a*/),
  ])
  ..footprint((input, ref) {
    var numberOfOwner = input<num>(".pets_reptiles_share") + 1;
    var reference = input<String>(".pets_reptiles_reference");
    var uBezugN = .0;
    if (reference == "pets_reptiles_reference_breeding") uBezugN = 1.0;
    var uTierN = ref(".U_Tier_N");
    return (uBezugN * uTierN) / numberOfOwner;
  });
