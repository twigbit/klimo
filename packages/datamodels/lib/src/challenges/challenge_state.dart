import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../serializers.dart';

part 'challenge_state.g.dart';

abstract class ChallengeStateBase {
  DateTime? get startedAt;
  DateTime? get completedAt;
  bool? get success;
}

abstract class ChallengeState
    implements
        ChallengeStateBase,
        Built<ChallengeState, ChallengeStateBuilder> {
  ChallengeState._();
  factory ChallengeState([void Function(ChallengeStateBuilder) updates]) =
      _$ChallengeState;

  @override
  DateTime get startedAt;

  Map<String, dynamic> toJson() {
    return serializers.serializeWith(ChallengeState.serializer, this)
        as Map<String, dynamic>;
  }

  static ChallengeState? fromJson(Map<String, dynamic> json) {
    return serializers.deserializeWith(ChallengeState.serializer, json);
  }

  static Serializer<ChallengeState> get serializer =>
      _$challengeStateSerializer;
}

abstract class ChallengeStateUpdate
    implements
        ChallengeStateBase,
        Built<ChallengeStateUpdate, ChallengeStateUpdateBuilder> {
  ChallengeStateUpdate._();
  factory ChallengeStateUpdate(
          [void Function(ChallengeStateUpdateBuilder) updates]) =
      _$ChallengeStateUpdate;
  @BuiltValue(wireName: "completedAt")
  FieldValue? get completedAtFieldValue;
  @BuiltValue(wireName: "success")
  FieldValue? get successFieldValue;

  Map<String, dynamic> toJson() {
    return serializers.serializeWith(ChallengeStateUpdate.serializer, this)
        as Map<String, dynamic>;
  }

  static ChallengeStateUpdate? fromJson(Map<String, dynamic> json) {
    return serializers.deserializeWith(ChallengeStateUpdate.serializer, json);
  }

  static Serializer<ChallengeStateUpdate> get serializer =>
      _$challengeStateUpdateSerializer;
}
