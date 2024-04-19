import 'package:built_collection/built_collection.dart';
import 'package:klimo_datamodels/calculation_model.dart';

BuiltList<FormulaNode> vacationParams() {
  return BuiltList([
    //Umrechnungsfaktoren Urlaub
    FormulaNode.param("Ef_Urlaub_Transp_Flug", 0.0214 /* tCO2 je 100km/pP*/),
    FormulaNode.param("Ef_Urlaub_Transp_Auto", 0.01422 /* tCO2 je 100km/pP*/),
    FormulaNode.param("Ef_Urlaub_Transp_Bus", 0.0055 /* tCO2 je 100km/pP*/),
    FormulaNode.param("Ef_Urlaub_Transp_Bahn", 0.0029 /* tCO2 je 100km/pP*/),
    FormulaNode.param("Ef_Urlaub_Transp_Schiff", 0.0277 /* tCO2 je 100km/pP*/),
    FormulaNode.param("Unterkunft_Hotel", 0.0101 /* tCO2 je d/pP*/),
    FormulaNode.param("Unterkunft_Haus", 0.00525 /* tCO2 je d/pP*/),
    FormulaNode.param("Unterkunft_Hostel", 0.002 /* tCO2 je d/pP*/),
    FormulaNode.param("Unterkunft_Camp", 0.0015 /* tCO2 je d/pP*/),
    FormulaNode.param("Unterkunft_Schiff", 0.0148 /* tCO2 je d/pP*/),
    FormulaNode.param("Unterkunft_Balkonien", 0.0052 /* tCO2 je d/pP*/),
    FormulaNode.param("Aktivurlaub_Verpflegung", 0.0046 /* tCO2 je d/pP*/),
    FormulaNode.param("Strandurlaub_Verpflegung", 0.0049 /* tCO2 je d/pP*/),
    FormulaNode.param("Skiurlaub_Verpflegung", 0.0046 /* tCO2 je d/pP*/),
    FormulaNode.param("Familienurlaub_Verpflegung", 0.0057 /* tCO2 je d/pP*/),
    FormulaNode.param("Kultururlaub_Verpflegung", 0.0065 /* tCO2 je d/pP*/),
    FormulaNode.param(
        "Schifffahrtsurlaub_Verpflegung", 0.0027 /* tCO2 je d/pP*/),
    FormulaNode.param("Balkonienurlaub_Verpflegung", 0.0028 /* tCO2 je d/pP*/),
    FormulaNode.param("Aktivurlaub_Aktionen", 0.0011 /* tCO2 je d/pP*/),
    FormulaNode.param("Strandurlaub_Aktionen", 0.0035 /* tCO2 je d/pP*/),
    FormulaNode.param("Skiurlaub_Aktionen", 0.0014 /* tCO2 je d/pP*/),
    FormulaNode.param("Familienurlaub_Aktionen", 0.0071 /* tCO2 je d/pP*/),
    FormulaNode.param("Kultururlaub_Aktionen", 0.0021 /* tCO2 je d/pP*/),
    FormulaNode.param("Schifffahrtsurlaub_Aktionen", 0.0007 /* tCO2 je d/pP*/),
    FormulaNode.param("Balkonienurlaub_Aktionen", 0.0011 /* tCO2 je d/pP*/),
  ]);
}
