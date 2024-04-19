import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'user_values.g.dart';

@BuiltValue(instantiable: false)
abstract class ValueScope {
  BuiltMap<String, Object> get values;

  ValueScope rebuild(void Function(ValueScopeBuilder) updates);
  ValueScopeBuilder toBuilder();
}

abstract class UserValues
    implements ValueScope, Built<UserValues, UserValuesBuilder> {
  static Serializer<UserValues> get serializer => _$userValuesSerializer;

  String get inputModelName;
  String get inputModelVersion;

  UserValues._();
  factory UserValues([void Function(UserValuesBuilder)? updates]) =
      _$UserValues;
}

abstract class NestedValues
    implements ValueScope, Built<NestedValues, NestedValuesBuilder> {
  static Serializer<NestedValues> get serializer => _$nestedValuesSerializer;

  String get entity;

  NestedValues._();
  factory NestedValues([void Function(NestedValuesBuilder)? updates]) =
      _$NestedValues;
  factory NestedValues.empty(String entity) =>
      NestedValues((b) => b..entity = entity);
}
