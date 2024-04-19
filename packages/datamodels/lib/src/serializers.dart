import 'package:built_collection/built_collection.dart';
import 'package:built_value/serializer.dart';
import 'package:built_value/standard_json_plugin.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:klimo_datamodels/articles.dart';
import 'package:klimo_datamodels/challenges.dart';
import 'package:klimo_datamodels/community.dart';
import 'package:klimo_datamodels/projects.dart';
import 'package:klimo_datamodels/src/advent_calendar/advent_calendar.dart';
import 'package:klimo_datamodels/src/communities/community_config.dart';
import 'package:klimo_datamodels/src/consent/consent.dart';
import 'package:klimo_datamodels/src/rewards/reward.dart';
import 'package:klimo_datamodels/src/rewards/reward_stats.dart';
import 'package:klimo_datamodels/src/stats/stats.dart';
import 'package:klimo_datamodels/user.dart';
import 'package:klimo_datamodels/util.dart';

import '../calculation_engine.dart';
import '../partners.dart';
import 'calculator_information/calculator_information.dart';
import 'challenges/challenge_state.dart';

part 'serializers.g.dart';

// Add all of the built value types that require serialization.
@SerializersFor([
  // Challenge Stuff
  Challenge,
  ChallengeType,
  ChallengeStatus,
  ChallengeStats,
  ChallengeState,
  Interaction,
  Category,
  UserChallenge,
  // Calculation
  CalculationResults,
  StatsValuePair,
  CalculationSnapshot,
  UserValues,
  NestedValues,
  CalculatorInformationResponse,
  // Profile
  UserModel,
  UserContext,
  UserRef,
  UserUpdate,
  UserChallengeUpdate,
  StatsModel,
  RewardStatsModel,
  UserCommuntityReference,
  UserCommuntityReferenceUpdate,
  ConsentModel,
  DeletionRequest,
  DeletionRequestUpdate,
  ProfileModel,
  TestUserModel,
  //Community
  CommunityModel,
  CommunityConfig,
  DepartmentModel,
  TeamModel,
  // Content
  Article,
  NewsModel,
  Project,
  PartnerModel,
  CarbonOffset,
  VirtualRewardModel,
  AdventCalendarModel,
  CalendarRewardModel,
  OpenedCardModel,
  // Util
  InitiativeRef,
  ImageModel,
  InitiativeModel,
  UserRewardModel,
])
final Serializers serializers = (_$serializers.toBuilder()
      ..add(DocumentReferenceSerializer())
      ..add(FieldValueSerializer())
      ..addPlugin(FilteredBuiltListDeserializerPlugin())
      ..addPlugin(FirebaseSerializerPlugin())
      ..addPlugin(StandardJsonPlugin(valueKey: "#")))
    .build();

// TODO create interface
class FirebaseSerializerPlugin implements SerializerPlugin {
  @override
  Object? beforeSerialize(Object? object, FullType specifiedType) {
    if (object is DateTime && specifiedType.root == DateTime) {
      return object.toUtc();
    }
    return object;
  }

  @override
  Object? afterSerialize(Object? object, FullType specifiedType) {
    if (object is int && specifiedType.root == DateTime) {
      return Timestamp.fromMicrosecondsSinceEpoch(object);
    }
    return object;
  }

  @override
  Object? beforeDeserialize(Object? object, FullType specifiedType) {
    if (object is Timestamp && specifiedType.root == DateTime) {
      return object.microsecondsSinceEpoch;
    } else if (object is String && specifiedType.root == DateTime) {
      // This is to parse string dates coming from JSON, i.e. webflow
      return DateTime.parse(object).microsecondsSinceEpoch;
    } else {
      return object;
    }
  }

  @override
  Object? afterDeserialize(Object? object, FullType specifiedType) {
    return object;
  }
}

/// This plugin allows to deserialize lists to BuiltLists of a BuiltValue type
/// even if the input contains values, that fail deserialization. Those items
/// are simply filtered out by this plugin.
class FilteredBuiltListDeserializerPlugin implements SerializerPlugin {
  @override
  Object? beforeSerialize(Object? object, FullType specifiedType) => object;

  @override
  Object? afterSerialize(Object? object, FullType specifiedType) => object;

  @override
  Object? beforeDeserialize(Object? object, FullType specifiedType) {
    if (object is List &&
        specifiedType.root == BuiltList &&
        specifiedType.parameters.isNotEmpty) {
      final elementType = specifiedType.parameters[0];
      // List here all types (ORed together) that should have graceful BuiltLists enabled
      if (elementType.root == CalculatorInformationRecord) {
        return object.where((element) {
          try {
            // FIXME: this effectivly double deserializes every entry
            // A better way would be to overwrite the BuiltList serializer somehow
            serializers.deserialize(element, specifiedType: elementType);
            return true;
          } on DeserializationError {
            return false;
          }
        });
      }
    }
    return object;
  }

  @override
  Object? afterDeserialize(Object? object, FullType specifiedType) => object;
}

// TODO moritz merge this serializer with firebase
class DocumentReferenceSerializer
    implements PrimitiveSerializer<DocumentReference> {
  @override
  final Iterable<Type> types = const [DocumentReference];
  @override
  final String wireName = 'DocumentReference';

  @override
  Object serialize(Serializers serializers, DocumentReference documentReference,
      {FullType specifiedType = FullType.unspecified}) {
    return documentReference;
  }

  @override
  DocumentReference deserialize(Serializers serializers, Object serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final DocumentReference ref = serialized as DocumentReference;
    // if (specifiedType ==
    //     FullType(DocumentReference, [FullType(UserCommuntityReference)])) {
    //   return ref.parent
    //       .typedF<UserCommuntityReference>(serializers)
    //       .doc(ref.id);
    // } else if (specifiedType ==
    //     FullType(DocumentReference, [FullType(CommunityModel)])) {
    //   return ref.parent.typedF<CommunityModel>(serializers).doc(ref.id);
    // } else if (specifiedType ==
    //     FullType(DocumentReference, [FullType(DepartmentModel)])) {
    //   return ref.parent.typedF<DepartmentModel>(serializers).doc(ref.id);
    // } else if (specifiedType ==
    //     FullType(DocumentReference, [FullType(UserModel)])) {
    //   return ref.parent.typedF<UserModel>(serializers).doc(ref.id);
    // }
    // if(specifiedType is DocumentReference<UserCommuntityReference>){
    //   return DocumentReference<UserCommuntityReference>()
    // }
    // return DocumentReference();
    return ref;
  }
}

class FieldValueSerializer implements PrimitiveSerializer<FieldValue> {
  @override
  final Iterable<Type> types = const [FieldValue];
  @override
  final String wireName = 'FieldValue';

  @override
  Object serialize(Serializers serializers, FieldValue documentReference,
      {FullType specifiedType = FullType.unspecified}) {
    return documentReference;
  }

  @override
  FieldValue deserialize(Serializers serializers, Object serialized,
      {FullType specifiedType = FullType.unspecified}) {
    throw Exception('Hey, you dont want to deserialize Field Values!');
  }
}

T? deserialize<T>(dynamic value) => serializers.deserializeWith<T>(
    serializers.serializerForType(T) as Serializer<T>, value);

BuiltList<T> deserializeListOf<T>(Iterable<dynamic> value) => BuiltList.from(
    value.map((value) => deserialize<T>(value)).toList(growable: false));

extension TypedCollection on CollectionReference {
  CollectionReference<T> typedF<T>(serializers) {
    return withConverter<T>(
        fromFirestore: (snapshot, _) => serializers
            .deserialize(snapshot.data()!, specifiedType: FullType(T)) as T,
        toFirestore: (T value, _) => serializers.serialize(value,
            specifiedType: FullType(T)) as Map<String, Object?>);
  }
}
