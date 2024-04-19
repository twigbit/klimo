import '../../../../calculation_model.dart';
import '_common.dart';

void buildVacationCruiseEntity(FormulaNodeBuilder b) => b
  ..nodes.addAll([
    // ---
    // --- Umrechnungsfaktoren
    // ---
    ...vacationParams()
  ])
  ..footprint((input, ref) {
    var transport = input<String>("vacation_shipping_transport");
    var distance = input<num>("vacation_shipping_destination");
    var days = input<num>("vacation_shipping_days");

    var efUrlaubTransport = .0;

    switch (transport) {
      case "vacation_shipping_transport_airplane":
        efUrlaubTransport = ref(".Ef_Urlaub_Transp_Flug");
        break;
      case "vacation_shipping_transport_train":
        efUrlaubTransport = ref(".Ef_Urlaub_Transp_Bahn");
        break;
      case "vacation_shipping_transport_bus":
        efUrlaubTransport = ref(".Ef_Urlaub_Transp_Bahn");
        break;
      case "vacation_shipping_transport_own_car":
        efUrlaubTransport = ref(".Ef_Urlaub_Transp_Auto");
        break;
    }

    var unterkunft = ref(".Unterkunft_Schiff");
    var verpflegung = ref(".Schifffahrtsurlaub_Verpflegung");
    var aktionen = ref(".Schifffahrtsurlaub_Aktionen");
    var efSchiff = ref(".Ef_Urlaub_Transp_Schiff");
    const seeMeilen = 242; //durchschnittliche km pro Tag

    return (distance * 2 / 100 * efUrlaubTransport) +
        days *
            (unterkunft +
                verpflegung +
                aktionen +
                (efSchiff * seeMeilen / 100));
  });
