import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:klimo_datamodels/community.dart';
import 'package:klimo_datamodels/src/challenges/challenge_state.dart';

import '../../challenges.dart';
import '../../serializers.dart';

part 'user_challenge.g.dart';

abstract class UserChallengeBase {
  ChallengeRef? get challenge;
  CommunityRef? get community;
  InitiativeRef? get initiative;
  ChallengeStateBase? get state;
}

abstract class UserChallengeUpdate
    implements
        UserChallengeBase,
        Built<UserChallengeUpdate, UserChallengeUpdateBuilder> {
  UserChallengeUpdate._();
  factory UserChallengeUpdate(
          [void Function(UserChallengeUpdateBuilder) updates]) =
      _$UserChallengeUpdate;

  @override
  ChallengeStateUpdate? get state;

  static Serializer<UserChallengeUpdate> get serializer =>
      _$userChallengeUpdateSerializer;

  Map<String, dynamic> toJson() {
    return serializers.serializeWith(UserChallengeUpdate.serializer, this)
        as Map<String, dynamic>;
  }

  static UserChallengeUpdate? fromJson(Map<String, dynamic> json) {
    return serializers.deserializeWith(UserChallengeUpdate.serializer, json);
  }
}

abstract class UserChallenge
    implements UserChallengeBase, Built<UserChallenge, UserChallengeBuilder> {
  @override
  ChallengeRef get challenge;
  @override
  CommunityRef get community;
  @override
  ChallengeState? get state;
  bool get isSuccess => state?.completedAt != null && state?.success == true;
  bool get isFailure => state?.completedAt != null && state?.success == false;

  UserChallenge._();
  factory UserChallenge([void Function(UserChallengeBuilder) updates]) =
      _$UserChallenge;

  Map<String, dynamic> toJson() {
    return serializers.serializeWith(UserChallenge.serializer, this)
        as Map<String, dynamic>;
  }

  static UserChallenge? fromJson(Map<String, dynamic> json) {
    return serializers.deserializeWith(UserChallenge.serializer, json);
  }

  static Serializer<UserChallenge> get serializer => _$userChallengeSerializer;
}
