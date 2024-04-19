import 'dart:math';

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'consent.g.dart';

abstract class ConsentModel
    implements Built<ConsentModel, ConsentModelBuilder> {
  bool? get enableAnalytics;
  DateTime get timestamp;
  int get targetId;

  ConsentModel._();

  factory ConsentModel([void Function(ConsentModelBuilder)? updates]) =
      _$ConsentModel;

  static Serializer<ConsentModel> get serializer => _$consentModelSerializer;

  @BuiltValueHook(initializeBuilder: true)
  static void _setDefaults(ConsentModelBuilder b) =>
      b..targetId = Random().nextInt(4294967296); //this is 2^32
}
