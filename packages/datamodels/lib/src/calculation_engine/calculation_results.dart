import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'calculation_results.g.dart';

abstract class CalculationResults
    implements Built<CalculationResults, CalculationResultsBuilder> {
  static Serializer<CalculationResults> get serializer =>
      _$calculationResultsSerializer;

  String get calculationModelName;
  String get calculationModelVersion;

  BuiltMap<String, double> get sectionResults;
  double get totalResult;

  CalculationResults._();
  factory CalculationResults(
          [void Function(CalculationResultsBuilder)? updates]) =
      _$CalculationResults;
}
