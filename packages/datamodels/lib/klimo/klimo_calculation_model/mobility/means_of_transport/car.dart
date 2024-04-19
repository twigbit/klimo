import '../../../../calculation_model.dart';

/// Calculation model for emissions from private car usage.
///
/// Last checked: 17. Jan 2022 by Emil
///
void buildMobilityCarEntity(FormulaNodeBuilder b) => b
  ..nodes.addAll([
    // ---
    // --- Umrechnungsfaktoren
    // ---
    FormulaNode.param("Auto_Leben", 17.0 /* a */),
    FormulaNode.param("Prod_PkW_klein", 7.0 /* tCO2 */),
    FormulaNode.param("Prod_PkW_mittel", 9.0 /* tCO2 */),
    FormulaNode.param("Prod_PkW_ober", 13.0 /* tCO2 */),
    FormulaNode.param("Prod_ePkW_klein", 9.0 /* tCO2 */),
    FormulaNode.param("Prod_ePkW_mittel", 11.0 /* tCO2 */),
    FormulaNode.param("Prod_ePkW_ober", 22.0 /* tCO2 */),
    // Kraftstoff Emissionsfaktoren
    FormulaNode.param("Ef_Benzin", 2.73 /* kgCo2/l */),
    FormulaNode.param("Ef_Diesel", 3.08 /* kgCo2/l */),
    FormulaNode.param("Ef_Strom", 0.401 /* kgCo2/kWh */),
    // FormulaNode.param("Ef_StromEE", 0.1 /* kgCo2/kWh */),
    // Note: Kasseler Ökostrom ist klimaneutral
    FormulaNode.param("Ef_StromEE", 0.0 /* kgCo2/kWh */),
    FormulaNode.param("Ef_Hybrid", 0.173 /* kgCo2/km */),
    FormulaNode.param("Ef_LPG", 2.179 /* kgCo2/l */),
    // ---
    // ---
    // ---
    FormulaNode((n) => n
      ..key = "production"
      ..footprint((input, ref) {
        var type = input<String>("car_motorcycle_type");
        if (type == "car_motorcycle_own_car") {
          var cls = input<String>("car_motorcycle_car_classification");
          var elec = input<String>("car_motorcycle_fuel") ==
              "car_motorcycle_fuel_electric";
          if (elec) {
            switch (cls) {
              case "car_motorcycle_car_classification_small_car":
                return ref("..Prod_ePkW_klein");
              case "car_motorcycle_car_classification_upper_class":
                return ref("..Prod_ePkW_ober");
              case "car_motorcycle_car_classification_middle_class":
              default:
                return ref("..Prod_ePkW_mittel");
            }
          } else {
            switch (cls) {
              case "car_motorcycle_car_classification_small_car":
                return ref("..Prod_PkW_klein");
              case "car_motorcycle_car_classification_upper_class":
                return ref("..Prod_PkW_ober");
              case "car_motorcycle_car_classification_middle_class":
              default:
                return ref("..Prod_PkW_mittel");
            }
          }
        }
        return 0;
      })),
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
          case "car_motorcycle_fuel_diesel":
            ef *= ref("..Ef_Diesel");
            break;
          case "car_motorcycle_fuel_electric":
            ef *= ref("..Ef_Strom");
            break;
          case "car_motorcycle_fuel_hybrid":
            // This is using a different formula independent of the consumption
            ef = ref("..Ef_Hybrid") * 100;
            break;
          case "car_motorcycle_fuel_gas":
            ef *= ref("..Ef_LPG");
            break;
          default:
        }
        ef /= 1000; /* conversion from kgCO2 to tCO2 */

        return d * ef;
      })),
  ])
  ..footprint((input, ref) {
    return ref(".usage") + ref(".production") / ref(".Auto_Leben");
  });
