import '../../../../calculation_model.dart';

/// Calculation model for emissions from e-bike usage.
///
/// Last checked: 12. Jan 2022 by Emil
///
void buildMobilityBicycleEntity(FormulaNodeBuilder b) => b
  ..nodes.addAll([
    // ---
    // --- Umrechnungsfaktoren
    // ---
    FormulaNode.param("EBike_Ladung", 1.0 /* kWh/100km */),
    FormulaNode.param("EFK_Strom", 0.401 /* kgCO2/kWh */),
    FormulaNode.param("Prod_eAkku", 65 /* kgCO2/kWh */),
    FormulaNode.param("EBike_Akku_Size", 0.525 /* kWh */),
    FormulaNode.param("Akku_Leben", 5 /* a */),
  ])
  ..footprint((input, ref) {
    final type = input<String>("bicycle_type");
    if (type.isEmpty || type == "bicycle_bike") return .0;

    // production cost
    var property = input<String>("bicycle_property");
    final num prod;
    if (property == "bicycle_property_own") {
      prod = ref(".Prod_eAkku") /* kgCO2/kWh */
          *
          ref(".EBike_Akku_Size") /* kgCO2 */
          /
          ref(".Akku_Leben"); /* kgCO2/year */
    } else {
      prod = .0;
    }

    // usage cost
    final d = input<int>("bicycle_distance") / 100; /* 100km/year */
    final usage = d *
        ref<double>(".EBike_Ladung") *
        ref<double>(".EFK_Strom"); /* kgCO2/year */

    return (prod + usage) / 1000;
  });

/// Calculation model for emissions from e-scooter usage.
///
/// Last checked: 12. Jan 2022 by Emil
///
void buildMobilityScooterEntity(FormulaNodeBuilder b) => b
  ..nodes.addAll([
    // ---
    // --- Umrechnungsfaktoren
    // ---
    FormulaNode.param("EBike_Ladung", 1.0 /* kWh/100km */),
    FormulaNode.param("EFK_Strom", 0.401 /* kgCO2/kWh */),
    FormulaNode.param("Prod_eAkku", 65 /* kgCO2/kWh */),
    FormulaNode.param("EScooter_Akku_Size", 0.2 /* kWh */),
    FormulaNode.param("Akku_Leben", 5 /* a */),
  ])
  ..footprint((input, ref) {
    final type = input<String>("scooter_type");
    if (type.isEmpty || type == "scooter_kick") return .0;

    // production cost
    var property = input<String>("scooter_property");
    final num prod;
    if (property == "scooter_property_own") {
      prod = ref(".Prod_eAkku") /* kgCO2/kWh */
          *
          ref(".EScooter_Akku_Size") /* kgCO2 */
          /
          ref(".Akku_Leben"); /* kgCO2/year */

    } else {
      prod = .0;
    }

    // usage cost
    final d = input<int>("scooter_distance") / 100; /* 100km/year */
    final usage = d *
        ref<double>(".EBike_Ladung") *
        ref<double>(".EFK_Strom"); /* kgCO2/year */

    return (prod + usage) / 1000;
  });
