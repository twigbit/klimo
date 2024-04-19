import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'input.dart';
import 'section.dart';
import 'nested_entity_input.dart';

part 'input_model.g.dart';

abstract class InputScope {
  Input? resolvePath(String path);

  String? resolveInput(Input input);
}

/// The InputModel class provides the entrypoint for constructing
/// a model of all user inputs grouped into sections.
/// It can be consumed for UI generation purposes.
abstract class InputModel
    implements InputScope, Built<InputModel, InputModelBuilder> {
  static Serializer<InputModel> get serializer => _$inputModelSerializer;

  BuiltList<Section> get sections;

  String get name;

  String get version;

  @memoized
  BuiltMap<Input, String> get _inputLUT => BuiltMap.build((b) {
        for (var section in sections) {
          for (var input in section.inputs) {
            b.addAll(input.pathSegments
                .toMap()
                .map((that, path) => MapEntry(that, "${section.key}.$path")));
          }
        }
      });
  
  /// List of all paths including the nested entity types.
  @memoized
  BuiltList<String> get allPaths => BuiltList.build((b) {
        for (var section in sections) {
          for (var input in section.inputs) {
            b.addAll(input.pathSegments.values.map((p) => "${section.key}.$p"));
            if (input is NestedEntityInput) {
              for (var entity in input.entityTypes) {
                for (var nestedInput in entity.inputs) {
                  b.addAll(nestedInput.pathSegments.values.map((p) => "${section.key}.${input.key}.${entity.key}.$p"));
                }
              }
            }
          }
        }
      });

  @memoized
  BuiltMap<String, Input> get _pathLUT => BuiltMap.build((b) =>
      b..addAll(_inputLUT.map((inp, path) => MapEntry(path, inp)).toMap()));

  @override
  Input? resolvePath(String path) => _pathLUT[path];

  @override
  String? resolveInput(Input input) => _inputLUT[input];

  InputModel._() {
    // validate unique constraint on section keys
    Set keys = <String>{};
    for (var section in sections) {
      if (keys.contains(section.key)) {
        throw ArgumentError(
            "duplicate section key \"${section.key}\" provided");
      }
      keys.add(section.key);
    }
  }

  factory InputModel([void Function(InputModelBuilder)? updates]) =
      _$InputModel;
}

extension InputModelBuilderShorthands on InputModelBuilder {
  void section(String key, [void Function(SectionBuilder)? updates]) {
    final b = SectionBuilder();
    updates?.call(b);
    b.key = key;
    sections.add(b.build());
  }
}
