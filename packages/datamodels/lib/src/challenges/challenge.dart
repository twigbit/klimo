import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../serializers.dart';
import '../../util.dart';

part 'challenge.g.dart';

abstract class ChallengeBase {
  String? get rootId;
  Translation<String> get title;
  Translation<String> get content;
  Translation<String>? get informations;
  String? get category;
  String? get type;

  num get coins;
  num? get emissionSavings;
}

abstract class ChallengeRef
    implements ChallengeBase, Ref, Built<ChallengeRef, ChallengeRefBuilder> {
  ChallengeRef._();
  factory ChallengeRef([void Function(ChallengeRefBuilder) updates]) =
      _$ChallengeRef;
  factory ChallengeRef.fromSnapshot(DocumentSnapshot<Challenge> snap) =>
      ChallengeRef((b) => b
        ..ref = snap.reference
        ..rootId = snap.data()!.rootId
        ..coins = snap.data()!.coins
        ..emissionSavings = snap.data()!.emissionSavings
        ..title = snap.data()!.title.toBuilder()
        ..content = snap.data()!.content.toBuilder()
        ..informations = snap.data()!.informations?.toBuilder()
        ..category = snap.data()!.category
        ..type = snap.data()!.type);

  Map<String, dynamic> toJson() {
    return serializers.serializeWith(ChallengeRef.serializer, this)
        as Map<String, dynamic>;
  }

  static ChallengeRef? fromJson(Map<String, dynamic> json) {
    return serializers.deserializeWith(ChallengeRef.serializer, json);
  }

  static Serializer<ChallengeRef> get serializer => _$challengeRefSerializer;
}

abstract class Challenge
    implements ChallengeBase, Built<Challenge, ChallengeBuilder> {
  Challenge._();
  factory Challenge([void Function(ChallengeBuilder) updates]) = _$Challenge;

  Map<String, dynamic> toJson() {
    return serializers.serializeWith(Challenge.serializer, this)
        as Map<String, dynamic>;
  }

  static Challenge? fromJson(Map<String, dynamic> json) {
    return serializers.deserializeWith(Challenge.serializer, json);
  }

  static Serializer<Challenge> get serializer => _$challengeSerializer;
}
// abstract class ChallengeRef
//     implements
//         Ref,
//         ChallengeBase,
//         BuiltValue<ChallengeRef, ChallengeRefBuilder> {}

// abstract class Challenge implements Built<Challenge, ChallengeBuilder> {
//   String get id;

//   ChallengeType get type;

//   ChallengeStatus? get status;

//   Category get category;

//   @override
//   BuiltMap<String, String> get title;

//   @override
//   BuiltMap<String, String> get content;
//   BuiltMap<String, String> get informations;
//   // BuiltMap<String, BuiltMap<String, num>>? get stats;

//   ChallengeStats? get stats;

//   Challenge._();

//   factory Challenge([void Function(ChallengeBuilder)? updates]) = _$Challenge;

//   static Serializer<Challenge> get serializer => _$challengeSerializer;

//   @BuiltValueHook(initializeBuilder: true)
//   static void _setDefaults(ChallengeBuilder b) =>
//       b..status = ChallengeStatus.inactive;
// }

// abstract class ChallengeState
//     implements Built<ChallengeState, ChallengeStateBuilder> {
//   DateTime get startedAt;
//   ChallengeState._();
//   factory ChallengeState([void Function(ChallengeStateBuilder) updates]) =
//       _$ChallengeState;
// }
