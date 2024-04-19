import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'challenge_status.g.dart';

class ChallengeStatus extends EnumClass {
  /* 
  Values
   */
  static const ChallengeStatus suggested = _$suggested;
  static const ChallengeStatus inactive = _$inactive;
  static const ChallengeStatus active = _$active;
  static const ChallengeStatus rejected = _$rejected;
  static const ChallengeStatus completed = _$completed;
  static const ChallengeStatus activated = _$activated;

  const ChallengeStatus._(String name) : super(name);
  static BuiltSet<ChallengeStatus> get values => _$values;
  static ChallengeStatus valueOf(String name) => _$valueOf(name);
  static Serializer<ChallengeStatus> get serializer =>
      _$challengeStatusSerializer;
}
