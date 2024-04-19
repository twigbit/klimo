import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';

part 'calculation_result.g.dart';

/// The results of a calculation scope.
/// Can also be the result of a nested block.
abstract class CalculationResult
    implements Built<CalculationResult, CalculationResultBuilder> {
  BuiltList<num> get values;

  @memoized
  num get sum => values.reduce((a, b) => a + b);

  CalculationResult._();
  factory CalculationResult(
      [void Function(CalculationResultBuilder)? updates]) = _$CalculationResult;
}
