import '../../../../calculation_model.dart';
import '_common.dart';

void buildVacationCulturalEntity(FormulaNodeBuilder b) => b
  ..nodes.addAll([
    // ---
    // --- Umrechnungsfaktoren
    // ---
    ...vacationParams()
  ])
  ..footprint((input, ref) {
    var transport = input<String>("vacation_cultural_transport");
    var accommodation = input<String>("vacation_cultural_accommodation");
    var distance = input<num>("vacation_cultural_destination");
    var days = input<num>("vacation_cultural_days");

    var efUrlaubTransport = .0;

    var unterkunft = .0;
    var verpflegung = ref(".Kultururlaub_Verpflegung");
    var aktionen = ref(".Kultururlaub_Aktionen");

    switch (transport) {
      case "vacation_cultural_transport_airplane":
        efUrlaubTransport = ref(".Ef_Urlaub_Transp_Flug");
        break;
      case "vacation_cultural_transport_train":
        efUrlaubTransport = ref(".Ef_Urlaub_Transp_Bahn");
        break;
      case "vacation_cultural_transport_bus":
        efUrlaubTransport = ref(".Ef_Urlaub_Transp_Bahn");
        break;
      case "vacation_cultural_transport_own_car":
        efUrlaubTransport = ref(".Ef_Urlaub_Transp_Auto");
        break;
    }

    switch (accommodation) {
      case "vacation_cultural_accommodation_hotel":
        unterkunft = ref(".Unterkunft_Hotel");
        break;
      case "vacation_cultural_accommodation_vacation_home":
        unterkunft = ref(".Unterkunft_Haus");
        break;
      case "vacation_cultural_accommodation_hostel":
        unterkunft = ref(".Unterkunft_Hostel");
        break;
      case "vacation_cultural_accommodation_camping":
        unterkunft = ref(".Unterkunft_Camp");
        break;
    }

    return (distance * 2 / 100 * efUrlaubTransport) +
        days * (unterkunft + verpflegung + aktionen);
  });
