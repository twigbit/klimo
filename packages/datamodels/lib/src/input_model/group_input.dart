import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'input.dart';

part 'group_input.g.dart';

abstract class GroupInput
    implements Input, Built<GroupInput, GroupInputBuilder> {
  static Serializer<GroupInput> get serializer => _$groupInputSerializer;

  BuiltList<Input> get inputs;
  @override
  bool get defaultValue;
  bool get isNestedInput;

  @override
  Object? getNormalizedValue(Object value) =>
      normalizeValue?.call(value) ?? value;

  @override
  @memoized
  BuiltMap<Input, String> get pathSegments => BuiltMap.build((b) {
        b.addEntries([MapEntry(this, key)]);
        for (var i in inputs) {
          b.addAll(i.pathSegments
              .toMap()
              .map((that, path) => MapEntry(that, "$key.$path")));
        }
      });

  @BuiltValueHook(initializeBuilder: true)
  static void _inputInitializeHook(GroupInputBuilder b) {
    Input.initializeBuilder(b);
    b.defaultValue = false;
    b.isNestedInput = false;
  }

  @BuiltValueHook(finalizeBuilder: true)
  static void _inputFinalizeHook(GroupInputBuilder b) =>
      Input.finalizeBuilder(b);

  GroupInput._() {
    // validate key
    final keyExp = RegExp(r"^[a-z0-9_]+$");
    if (!keyExp.hasMatch(key)) {
      throw ArgumentError.value(key, "key",
          "Must only contain the following characters: a-z, 0-9 and \"_\".");
    }
  }
  factory GroupInput([void Function(GroupInputBuilder)? updates]) =
      _$GroupInput;
}
