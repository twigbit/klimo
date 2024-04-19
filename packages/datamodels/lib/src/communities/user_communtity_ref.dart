import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:klimo_datamodels/community.dart';

part 'user_communtity_ref.g.dart';

abstract class UserCommuntityReferenceBase {
  DepartmentRef? get department;
  TeamRef? get team;
  CommunityRef? get community;
}

abstract class UserCommuntityReference
    implements
        UserCommuntityReferenceBase,
        Built<UserCommuntityReference, UserCommuntityReferenceBuilder> {
  // Fields

  @override
  CommunityRef get community;

  UserCommuntityReference._();

  factory UserCommuntityReference(
          [void Function(UserCommuntityReferenceBuilder) updates]) =
      _$UserCommuntityReference;

  static Serializer<UserCommuntityReference> get serializer =>
      _$userCommuntityReferenceSerializer;
}

abstract class UserCommuntityReferenceUpdate
    implements
        UserCommuntityReferenceBase,
        Built<UserCommuntityReferenceUpdate,
            UserCommuntityReferenceUpdateBuilder> {
  // Fields
  UserCommuntityReferenceUpdate._();

  factory UserCommuntityReferenceUpdate(
          [void Function(UserCommuntityReferenceUpdateBuilder) updates]) =
      _$UserCommuntityReferenceUpdate;

  @BuiltValueField(wireName: "team")
  FieldValue? get teamFieldValue;

  @BuiltValueField(wireName: "department")
  FieldValue? get departmentFieldValue;

  static Serializer<UserCommuntityReferenceUpdate> get serializer =>
      _$userCommuntityReferenceUpdateSerializer;
}
