import '../../../../calculation_model.dart';

/// Calculation model for emissions from day to day use of
/// public transport services.
///
/// Last checked: 12. Jan 2022 by Emil
///
void buildMobilityPublicTransportEntity(FormulaNodeBuilder b) => b
  ..nodes.addAll([
    // ---
    // --- Umrechnungsfaktoren
    // ---
    // FormulaNode.param("EFBahn_nah", 0.055 /* kgCO2/Pkm */),
    // Note: Kasseler Bahn-Nahverkehr ist klimaneutral
    FormulaNode.param("EFBahn_nah", 0.0 /* kgCO2/Pkm */),
    FormulaNode.param("EFBahn_fern", 0.029 /* kgCO2/Pkm */),
    FormulaNode.param("EFBus_nah", 0.080 /* kgCO2/Pkm */),
    FormulaNode.param("EFBus_fern", 0.055 /* kgCO2/Pkm */),
  ])
  ..footprint((input, ref) {
    var busNear = input<int>("public_transport_distance_bus_near");
    var busLong = input<int>("public_transport_distance_bus_long");
    var trainNear = input<int>("public_transport_distance_train_near");
    var trainLong = input<int>("public_transport_distance_train_long");

    // default profile
    if (busNear == 0 && busLong == 0 && trainNear == 0 && trainLong == 0) {
      busNear = 720;
      busLong = 0;
      trainNear = 4432;
      trainLong = 0;
    }

    return (busNear * ref(".EFBus_nah") +
            busLong * ref(".EFBus_fern") +
            trainNear * ref(".EFBahn_nah") +
            trainLong * ref(".EFBahn_fern")) /
        1000;
  });
