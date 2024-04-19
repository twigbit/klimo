import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';

part 'input.g.dart';

@BuiltValue(instantiable: false)
abstract class Input {
  String get key;
  String get title;
  String? get onboardingTitle;
  String get unit;
  String? get description;
  String? get detailedInfo;
  Object? get defaultValue;
  /// Provide the path to a condition to conditionally show or hide this input.
  String? get condition;

  /// If provided, can be used to normalize (e.g. parse String to int)
  /// the value before passing it to the calculation.
  @BuiltValueField(serialize: false)
  Object? Function(Object value)? get normalizeValue;

  Object? getNormalizedValue(Object value) {
    return normalizeValue?.call(value) ?? value;
  }

  @memoized
  BuiltMap<Input, String> get pathSegments => BuiltMap.of({});

  static void initializeBuilder(InputBuilder b) => b.unit = "";
  static void finalizeBuilder(InputBuilder b) => b.title ??= b.key;

  Input rebuild(void Function(InputBuilder) updates);
  InputBuilder toBuilder();
}
