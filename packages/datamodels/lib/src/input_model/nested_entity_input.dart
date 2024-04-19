import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

import 'input_model.dart';
import 'input.dart';

part 'nested_entity_input.g.dart';

abstract class NestedEntityInput
    implements Input, Built<NestedEntityInput, NestedEntityInputBuilder> {
  static Serializer<NestedEntityInput> get serializer =>
      _$nestedEntityInputSerializer;

  /// Set of the input definitions of the different entities the
  /// NestedEntityInput can hold.
  BuiltSet<NestedEntity> get entityTypes;

  /// Allow the user to create multiple entities of the same type.
  /// This field is used as the default for all [entityTypes] if not overridden
  /// by [NestedEntity.allowRepeated].
  /// The default value is `true`.
  bool get allowRepeated;

  /// Maximum amount of entities the user is allowed to create.
  /// This setting does not take the entity type into account.
  int? get maxEntities;

  /// List of keys of the nested entities, that are contained in
  /// the default profile
  @override
  BuiltList<String>? get defaultValue;

  @override
  @memoized
  BuiltMap<Input, String> get pathSegments => BuiltMap.of({this: key});

  @override
  Object? getNormalizedValue(Object value) => value;

  @BuiltValueHook(initializeBuilder: true)
  static void _inputInitializeHook(NestedEntityInputBuilder b) {
    Input.initializeBuilder(b);
    b.allowRepeated = true;
  }

  @BuiltValueHook(finalizeBuilder: true)
  static void _inputFinalizeHook(NestedEntityInputBuilder b) =>
      Input.finalizeBuilder(b);

  NestedEntityInput._() {
    // validate key
    final keyExp = RegExp(r"^[a-z0-9_]+$");
    if (!keyExp.hasMatch(key)) {
      throw ArgumentError.value(key, "key",
          "Must only contain the following characters: a-z, 0-9 and \"_\".");
    }
  }

  factory NestedEntityInput(
      [void Function(NestedEntityInputBuilder)? updates]) = _$NestedEntityInput;
}

abstract class NestedEntity
    implements InputScope, Built<NestedEntity, NestedEntityBuilder> {
  static Serializer<NestedEntity> get serializer => _$nestedEntitySerializer;

  String get key;

  String get title;

  String get description;

  String? get icon;

  BuiltList<Input> get inputs;

  /// Allow the user to create multiple instances of this entity type,
  /// in contrast to allow each type to be instantiated only once.
  /// If set to `null` the enclosing [NestedEntityInput.allowRepeated] value
  /// is used. The default is `null`.
  bool? get allowRepeated;

  @memoized
  BuiltMap<Input, String> get _inputLUT => BuiltMap.build((b) {
        for (var input in inputs) {
          b.addAll(input.pathSegments.toMap());
        }
      });

  @memoized
  BuiltMap<String, Input> get _pathLUT => BuiltMap.build((b) =>
      b..addAll(_inputLUT.map((inp, path) => MapEntry(path, inp)).toMap()));

  @override
  Input? resolvePath(String path) => _pathLUT[path];

  @override
  String? resolveInput(Input input) => _inputLUT[input];

  @BuiltValueHook(initializeBuilder: true)
  static void _setDefaults(NestedEntityBuilder b) => b..description = "";

  @BuiltValueHook(finalizeBuilder: true)
  static void _defaultTitleToKey(NestedEntityBuilder b) => b..title ??= b.key;

  NestedEntity._();

  factory NestedEntity([void Function(NestedEntityBuilder)? updates]) =
      _$NestedEntity;
}
