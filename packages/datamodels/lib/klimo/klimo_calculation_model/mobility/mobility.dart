import '../../../calculation_model.dart';
import 'means_of_transport/bicycle_scooter.dart';
import 'means_of_transport/car.dart';
import 'means_of_transport/motorcycle.dart';
import 'means_of_transport/public_transport.dart';

void buildMobilitySection(FormulaNodeBuilder b) {
  b.key = "mobility";

  // ---
  // --- Berechnungsparameter
  // ---

  b.nodes.addAll([
    FormulaNode.param("EFK_Benzin", 2.37 /* kgCO2/l */),
    FormulaNode.param("EFK_Diesel", 2.65 /* kgCO2/l */),
    FormulaNode.param("EFK_Hybrid", 0.173 /* kgCO2/km */),
    FormulaNode.param("EFK_Gas", 3.1 /* kgCO2/m^3 */),
  ]);

  // ---
  // --- Berechnung
  // ---

  b.nodes.add(
    NestedNode((n) => n
      ..key = "means_of_transport"
      ..input = "mobility.means_of_transport"
      ..entityType("car", buildMobilityCarEntity)
      ..entityType("motorcycle", buildMobilityMotorcycleEntity)
      ..entityType("public_transport", buildMobilityPublicTransportEntity)
      ..entityType("bicycle", buildMobilityBicycleEntity)
      ..entityType("scooter", buildMobilityScooterEntity)),
  );

  b.footprint((inp, ref) {
    return ref(".means_of_transport");
  });
}
