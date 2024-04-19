import 'package:intl/intl.dart';

extension Stringifyable on DateTime {
  String toReadableDate() => DateFormat("dd.MM.yyyy").format(this);
}
