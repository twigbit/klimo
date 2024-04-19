import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'challenge_type.g.dart';

class ChallengeType extends EnumClass {
  /* 
  Values
   */
  static const ChallengeType oneTime = _$oneTime;
  static const ChallengeType recurring = _$recurring;

  const ChallengeType._(String name) : super(name);
  static BuiltSet<ChallengeType> get values => _$values;
  static ChallengeType valueOf(String name) => _$valueOf(name);
  static Serializer<ChallengeType> get serializer => _$challengeTypeSerializer;
}
