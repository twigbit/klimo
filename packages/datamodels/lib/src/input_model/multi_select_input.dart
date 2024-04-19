import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

import 'input.dart';

part 'multi_select_input.g.dart';

abstract class MultiSelectInput
    implements Input, Built<MultiSelectInput, MultiSelectInputBuilder> {
  static Serializer<MultiSelectInput> get serializer =>
      _$multiSelectInputSerializer;

  BuiltSet<String> get options;

  @override
  BuiltList<String> get defaultValue;

  @override
  Object? getNormalizedValue(Object value) =>
      normalizeValue?.call(value) ?? value;

  @override
  @memoized
  BuiltMap<Input, String> get pathSegments => BuiltMap.of({this: key});

  @BuiltValueHook(initializeBuilder: true)
  static void _inputInitializeHook(MultiSelectInputBuilder b) {
    Input.initializeBuilder(b);
  }

  @BuiltValueHook(finalizeBuilder: true)
  static void _inputFinalizeHook(MultiSelectInputBuilder b) =>
      Input.finalizeBuilder(b);

  MultiSelectInput._() {
    // validate key
    final keyExp = RegExp(r"^[a-z0-9_]+$");
    if (!keyExp.hasMatch(key)) {
      throw ArgumentError.value(key, "key",
          "Must only contain the following characters: a-z, 0-9 and \"_\".");
    }
  }

  factory MultiSelectInput([void Function(MultiSelectInputBuilder)? updates]) =
      _$MultiSelectInput;
}
