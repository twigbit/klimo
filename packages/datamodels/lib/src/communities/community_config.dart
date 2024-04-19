import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'community_config.g.dart';

class Visibility extends EnumClass {
  static const Visibility public = _$public;
  static const Visibility private = _$private;
  static const Visibility internal = _$internal;
  static const Visibility fallback = _$fallback;

  const Visibility._(String name) : super(name);

  static BuiltSet<Visibility> get values => _$VisibilityValues;
  static Visibility valueOf(String name) => _$VisibilityValueOf(name);
  static Serializer<Visibility> get serializer => _$visibilitySerializer;
}

abstract class CommunityConfig
    implements Built<CommunityConfig, CommunityConfigBuilder> {
  FeatureConfig get features;
  Visibility get visibility;

  CommunityConfig._();
  factory CommunityConfig([void Function(CommunityConfigBuilder) updates]) =
      _$CommunityConfig;

  static Serializer<CommunityConfig> get serializer =>
      _$communityConfigSerializer;
}

abstract class FeatureConfig
    implements Built<FeatureConfig, FeatureConfigBuilder> {
  FeatureConfig._();
  factory FeatureConfig([void Function(FeatureConfigBuilder)? updates]) =
      _$FeatureConfig;

  bool get departments;
  bool get teams;

  @BuiltValueHook(initializeBuilder: true)
  static void _setDefaults(FeatureConfigBuilder b) => b
    ..departments = false
    ..teams = false;

  static Serializer<FeatureConfig> get serializer => _$featureConfigSerializer;
}
