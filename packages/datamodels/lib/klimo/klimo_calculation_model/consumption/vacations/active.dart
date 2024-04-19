import '../../../../calculation_model.dart';
import '_common.dart';

void buildVacationActiveEntity(FormulaNodeBuilder b) => b
  ..nodes.addAll([
    // ---
    // --- Umrechnungsfaktoren
    // ---
    ...vacationParams()
  ])
  ..footprint((input, ref) {
    var transport = input<String>("vacation_active_transport");
    var accommodation = input<String>("vacation_active_accommodation");
    var distance = input<num>("vacation_active_destination");
    var days = input<num>("vacation_active_days");

    var efUrlaubTransport = .0;

    var unterkunft = .0;
    var verpflegung = ref(".Aktivurlaub_Verpflegung");
    var aktionen = ref(".Aktivurlaub_Aktionen");

    switch (transport) {
      case "vacation_active_transport_airplane":
        efUrlaubTransport = ref(".Ef_Urlaub_Transp_Flug");
        break;
      case "vacation_active_transport_train":
        efUrlaubTransport = ref(".Ef_Urlaub_Transp_Bahn");
        break;
      case "vacation_active_transport_bus":
        efUrlaubTransport = ref(".Ef_Urlaub_Transp_Bahn");
        break;
      case "vacation_active_transport_own_car":
        efUrlaubTransport = ref(".Ef_Urlaub_Transp_Auto");
        break;
    }

    switch (accommodation) {
      case "vacation_active_accommodation_hotel":
        unterkunft = ref(".Unterkunft_Hotel");
        break;
      case "vacation_active_accommodation_vacation_home":
        unterkunft = ref(".Unterkunft_Haus");
        break;
      case "vacation_active_accommodation_hostel":
        unterkunft = ref(".Unterkunft_Hostel");
        break;
      case "vacation_active_accommodation_camping":
        unterkunft = ref(".Unterkunft_Camp");
        break;
    }

    return (distance * 2 / 100 * efUrlaubTransport) +
        days * (unterkunft + verpflegung + aktionen);
  });
