import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

part 'user_context.g.dart';

abstract class UserContext implements Built<UserContext, UserContextBuilder> {
  UserContext._();

  DocumentReference get activeCommunity;

  factory UserContext([void Function(UserContextBuilder)? updates]) =
      _$UserContext;

  static Serializer<UserContext> get serializer => _$userContextSerializer;
}
