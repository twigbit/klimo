import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'input.dart';

part 'range_input.g.dart';

abstract class RangeInput
    implements Input, Built<RangeInput, RangeInputBuilder> {
  static Serializer<RangeInput> get serializer => _$rangeInputSerializer;

  double get min;
  double get max;
  int? get divisions;

  @override
  double get defaultValue;

  @override
  Object? getNormalizedValue(Object value) =>
      normalizeValue?.call(value) ?? value;

  @override
  @memoized
  BuiltMap<Input, String> get pathSegments => BuiltMap.of({this: key});

  @BuiltValueHook(initializeBuilder: true)
  static void _inputInitializeHook(RangeInputBuilder b) =>
      Input.initializeBuilder(b);

  @BuiltValueHook(finalizeBuilder: true)
  static void _inputFinalizeHook(RangeInputBuilder b) {
    Input.finalizeBuilder(b);
    b.defaultValue ??= b.min;
  }

  RangeInput._() {
    // validate key
    final keyExp = RegExp(r"^[a-z0-9_]+$");
    if (!keyExp.hasMatch(key)) {
      throw ArgumentError.value(key, "key",
          "Must only contain the following characters: a-z, 0-9 and \"_\".");
    }
  }
  factory RangeInput([void Function(RangeInputBuilder)? updates]) =
      _$RangeInput;
}
