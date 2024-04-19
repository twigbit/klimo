import '../../../../calculation_model.dart';
import '_common.dart';

void buildVacationBalconyEntity(FormulaNodeBuilder b) => b
  ..nodes.addAll([
    // ---
    // --- Umrechnungsfaktoren
    // ---
    ...vacationParams()
  ])
  ..footprint((input, ref) {
    var days = input<num>("vacation_balcony_days");

    var unterkunft = ref(".Unterkunft_Balkonien");
    var verpflegung = ref(".Balkonienurlaub_Verpflegung");
    var aktionen = ref(".Balkonienurlaub_Aktionen");

    return days * (unterkunft + verpflegung + aktionen);
  });
