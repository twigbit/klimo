import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'input.dart';

part 'radio_input.g.dart';

abstract class RadioInput
    implements Input, Built<RadioInput, RadioInputBuilder> {
  static Serializer<RadioInput> get serializer => _$radioInputSerializer;

  BuiltSet<String> get options;

  @override
  String get defaultValue;

  bool get isRadioList;

  @override
  Object? getNormalizedValue(Object value) =>
      normalizeValue?.call(value) ?? value;

  @override
  @memoized
  BuiltMap<Input, String> get pathSegments => BuiltMap.of({this: key});

  @BuiltValueHook(initializeBuilder: true)
  static void _inputInitializeHook(RadioInputBuilder b) {
    Input.initializeBuilder(b);
    b.defaultValue = "";
    //TODO set to false and adjust in klimo input model in case we will use chips & radio lists, otherwise parameter can be deleted again
    b.isRadioList = true;
  }

  @BuiltValueHook(finalizeBuilder: true)
  static void _inputFinalizeHook(RadioInputBuilder b) =>
      Input.finalizeBuilder(b);

  RadioInput._() {
    // validate key
    final keyExp = RegExp(r"^[a-z0-9_]+$");
    if (!keyExp.hasMatch(key)) {
      throw ArgumentError.value(key, "key",
          "Must only contain the following characters: a-z, 0-9 and \"_\".");
    }
  }

  factory RadioInput([void Function(RadioInputBuilder)? updates]) =
      _$RadioInput;
}
