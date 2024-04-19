import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'input.dart';

part 'header.g.dart';

/// The header class represents an input that is no input, useful for rendering
/// an informative subsection header.
abstract class Header implements Input, Built<Header, HeaderBuilder> {
  static Serializer<Header> get serializer => _$headerSerializer;

  @override
  Object? getNormalizedValue(Object value) => null;

  @override
  @memoized
  BuiltMap<Input, String> get pathSegments => BuiltMap.of({});

  @BuiltValueHook(initializeBuilder: true)
  static void _inputInitializeHook(HeaderBuilder b) =>
      Input.initializeBuilder(b);

  @BuiltValueHook(finalizeBuilder: true)
  static void _inputFinalizeHook(HeaderBuilder b) => Input.finalizeBuilder(b);

  Header._() {
    // validate key
    final keyExp = RegExp(r"^[a-z0-9_]+$");
    if (!keyExp.hasMatch(key)) {
      throw ArgumentError.value(key, "key",
          "Must only contain the following characters: a-z, 0-9 and \"_\".");
    }
  }
  factory Header([void Function(HeaderBuilder)? updates]) = _$Header;
}
