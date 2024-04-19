import '../../calculation_model.dart';

void buildCompensationSection(FormulaNodeBuilder b) {
  b.key = "compensation";

  // ---
  // --- Berechnungsparameter
  // ---
  b.nodes.addAll(
    [
      FormulaNode.param("fEm_Strom_Mix", 0.401 /* kgCO2/kWh */),
      FormulaNode.param("EmCO2_Komp", 0.21 /* tCO2/a je 1000€*/),
    ],
  );

  // ---
  // --- Berechnung
  // ---
  b.nodes.addAll(
    [
      FormulaNode(
        (n) => n
          ..key = "investments"
          ..footprint((input, ref) {
            var investmentValue = input<double>("..compensation_investment");
            var emCO2Komp = ref("..EmCO2_Komp");
            return (investmentValue * emCO2Komp) / 1000;
          }),
      ),
      FormulaNode(
        (n) => n
          ..key = "certificates"
          ..footprint(
              (input, ref) => input<double>("..compensation_certificates")),
      ),
      FormulaNode(
        (n) => n
          ..key = "electricity_surplus"
          ..footprint((input, ref) {
            var electricityValue = input<double>("..compensation_electricity");
            var fEmStromMix = ref("..fEm_Strom_Mix");

            return electricityValue * fEmStromMix / 1000;
          }),
      ),
    ],
  );

  b.footprint((inp, ref) {
    return -(ref(".investments") +
        ref(".certificates") +
        ref(".electricity_surplus"));
  });
}
