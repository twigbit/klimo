import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

import '../../util.dart';

part 'initiative.g.dart';

abstract class InitiativeModelBase {
  DateTime get start;
  DateTime get end;
  String? get logoUrl;
}

abstract class InitiativeModel
    implements
        InitiativeModelBase,
        Built<InitiativeModel, InitiativeModelBuilder> {
  InitiativeModel._();
  factory InitiativeModel([void Function(InitiativeModelBuilder) updates]) =
      _$InitiativeModel;

  static Serializer<InitiativeModel> get serializer =>
      _$initiativeModelSerializer;
}

abstract class InitiativeTimeframe
    implements Built<InitiativeTimeframe, InitiativeTimeframeBuilder> {
  Translation<String>? get title;
  InitiativeTimeframe._();
  factory InitiativeTimeframe(
          [void Function(InitiativeTimeframeBuilder)? updates]) =
      _$InitiativeTimeframe;
  static Serializer<InitiativeTimeframe> get serializer =>
      _$initiativeTimeframeSerializer;
}

abstract class InitiativeRef
    implements Built<InitiativeRef, InitiativeRefBuilder> {
  InitiativeRef._();

  InitiativeTimeframe get timeframe;

  factory InitiativeRef([void Function(InitiativeRefBuilder)? updates]) =
      _$InitiativeRef;

  static Serializer<InitiativeRef> get serializer => _$initiativeRefSerializer;
}
