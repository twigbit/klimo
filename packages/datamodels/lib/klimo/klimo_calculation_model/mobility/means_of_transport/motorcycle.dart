import '../../../../calculation_model.dart';

/// Calculation model for emissions from motorcycle usage.
///
/// Last checked: 17. Jan 2022 by Emil
///
void buildMobilityMotorcycleEntity(FormulaNodeBuilder b) => b
  ..nodes.addAll([
    // ---
    // --- Umrechnungsfaktoren
    // ---
    FormulaNode.param("Motorrad_Leben", 15 /* a */),
    FormulaNode.param("Prod_Motorrad", 0.967 /* tCO2 */),
    // Kraftstoff Emissionsfaktoren
    FormulaNode.param("Ef_Benzin", 2.73 /* kgCO2/100km */),
    FormulaNode.param("Ef_Strom", 0.401 /* kgCo2/kWh */),

    // ---
    // ---
    // ---
    FormulaNode((n) => n
      ..key = "usage"
      ..footprint((input, ref) {
        var fuel = input<String>("car_motorcycle_fuel");
        var consumption = input<double>("car_motorcycle_consumption");
        var d = input<int>("car_motorcycle_distance").toDouble();

        // transform distance from km/year to 100km/year
        d /= 100;

        var ef = consumption;
        switch (fuel) {
          case "car_motorcycle_fuel_benzin":
            ef *= ref("..Ef_Benzin");
            break;
          case "car_motorcycle_fuel_electric":
            ef *= ref("..Ef_Strom");
            break;
        }
        ef /= 1000; /* conversion from kgCO2 to tCO2 */

        return d * ef;
      })),
  ])
  ..footprint((input, ref) {
    var type = input<String>("motorcycle_type");
    if (type == "motorcycle_type_own_motorcycle") {
      // TODO check if production costs have to be differentiated according to fuel
      return ref(".usage") + ref(".Prod_Motorrad") / ref(".Motorrad_Leben");
    } else {
      return ref(".usage") / ref(".Motorrad_Leben");
    }
  });
