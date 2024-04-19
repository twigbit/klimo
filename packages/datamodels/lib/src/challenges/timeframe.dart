import 'package:built_value/built_value.dart';

part 'timeframe.g.dart';

abstract class Timeframe implements Built<Timeframe, TimeframeBuilder> {
  DateTime get start;
  DateTime get end;

  bool get isCurrent =>
      start.isBefore(DateTime.now()) && end.isAfter(DateTime.now());
  bool get isPast => end.isBefore(DateTime.now());
  bool get isFuture => start.isAfter(DateTime.now());

  Timeframe._();
  factory Timeframe([void Function(TimeframeBuilder) updates]) = _$Timeframe;
  factory Timeframe.fromTimestamp(DateTime timestamp) => Timeframe((b) => b
    ..start = getDate(timestamp.subtract(Duration(days: timestamp.weekday - 1)))
    ..end = getDate(timestamp
            .add(Duration(days: DateTime.daysPerWeek - timestamp.weekday + 1)))
        .subtract(Duration(seconds: 1)));
}

DateTime getDate(DateTime d) => DateTime(d.year, d.month, d.day);
