import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'input.dart';
import 'nested_entity_input.dart';

part 'section.g.dart';

abstract class Section implements Built<Section, SectionBuilder> {
  static Serializer<Section> get serializer => _$sectionSerializer;

  String get key;
  String get title;
  String? get info;

  BuiltList<Input> get inputs;

  @memoized
  BuiltList<Input> get normalInputs =>
      inputs.where((i) => i is! NestedEntityInput).toBuiltList();

  @memoized
  BuiltList<Input> get nestedInputs =>
      inputs.whereType<NestedEntityInput>().toBuiltList();

  @BuiltValueHook(initializeBuilder: true)
  static void _setDefaults(SectionBuilder b) => b..inputs;

  Section._() {
    // validate key
    final keyExp = RegExp(r"^[a-z0-9_]+$");
    if (!keyExp.hasMatch(key)) {
      throw ArgumentError.value(key, "key",
          "Must only contain the following characters: a-z, 0-9 and \"_\".");
    }
  }
  factory Section([void Function(SectionBuilder)? updates]) = _$Section;
}
