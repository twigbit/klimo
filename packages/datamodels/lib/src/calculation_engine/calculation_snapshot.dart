import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

import 'user_values.dart';
import 'calculation_results.dart';

part 'calculation_snapshot.g.dart';

abstract class CalculationSnapshot
    implements Built<CalculationSnapshot, CalculationSnapshotBuilder> {
  static Serializer<CalculationSnapshot> get serializer =>
      _$calculationSnapshotSerializer;

  DateTime get updatedAt;
  UserValues get userValues;
  CalculationResults get calculationResults;

  @BuiltValueHook(initializeBuilder: true)
  static void _setDefaults(CalculationSnapshotBuilder b) =>
      b..updatedAt = DateTime.now();

  CalculationSnapshot._();
  factory CalculationSnapshot(
          [void Function(CalculationSnapshotBuilder)? updates]) =
      _$CalculationSnapshot;
}
