import 'package:intl/intl.dart';

// extension LocalisationUtil on String {
//   String translate() => isEmpty ? this : tr(context);
// }

extension WithStringFormat on num {
  String stringValue() {
    return NumberFormat("###.##").format(this);
  }
}

extension WithSafeParse on String {
  num? safeParse() {
    try {
      return NumberFormat().parse(this);
    } on FormatException {
      return null;
    }
  }
}
