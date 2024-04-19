import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'input.dart';

part 'number_input.g.dart';

abstract class NumberInput<T extends num>
    implements Input, Built<NumberInput<T>, NumberInputBuilder<T>> {
  static Serializer<NumberInput> get serializer => _$numberInputSerializer;

  @override
  T get defaultValue;

  @override
  @BuiltValueField(serialize: false)
  T Function(Object value)? get normalizeValue;

  @override
  T? getNormalizedValue(Object value) {
    if (value is num) {
      if (T == double) return value.toDouble() as T;
      if (T == int) return value.toInt() as T;
      return value as T;
    }
    if (value is! String) return null;
    if (T == double) {
      return double.tryParse(value) as T?;
    }
    if (T == int) {
      return int.tryParse(value) as T?;
    }
    return num.tryParse(value) as T?;
  }

  @override
  @memoized
  BuiltMap<Input, String> get pathSegments => BuiltMap.of({this: key});

  @BuiltValueHook(initializeBuilder: true)
  static void _inputInitializeHook<T extends num>(NumberInputBuilder<T> b) {
    Input.initializeBuilder(b);
    b.defaultValue = (T == double ? .0 : 0) as T?;
  }

  @BuiltValueHook(finalizeBuilder: true)
  static void _inputFinalizeHook(NumberInputBuilder b) =>
      Input.finalizeBuilder(b);

  NumberInput._() {
    // validate key
    final keyExp = RegExp(r"^[a-z0-9_]+$");
    if (!keyExp.hasMatch(key)) {
      throw ArgumentError.value(key, "key",
          "Must only contain the following characters: a-z, 0-9 and \"_\".");
    }
  }
  factory NumberInput([void Function(NumberInputBuilder<T>)? updates]) =
      _$NumberInput<T>;
}
