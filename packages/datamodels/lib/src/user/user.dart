import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:klimo_datamodels/src/stats/stats.dart';
import 'package:klimo_datamodels/user.dart';

import '../../util.dart';
import '../rewards/reward_stats.dart';

part 'user.g.dart';

abstract class UserModelBase {
  ProfileModel? get profile;
  UserContext? get context;
}

abstract class UserUpdate
    implements UserModelBase, Built<UserUpdate, UserUpdateBuilder> {
  UserUpdate._();

  factory UserUpdate([void Function(UserUpdateBuilder)? updates]) =
      _$UserUpdate;

  static Serializer<UserUpdate> get serializer => _$userUpdateSerializer;
}

abstract class UserModel
    implements UserModelBase, Built<UserModel, UserModelBuilder> {
  UserModel._();

  // @override
  // ProfileModel get profile;
  // @override
  // UserContext get context;
  StatsModel get stats;
  RewardStatsModel get rewardStats;

  @BuiltValueHook(initializeBuilder: true)
  static void _setDefaults(UserModelBuilder b) => b
    ..stats = StatsModelBuilder()
    ..rewardStats = RewardStatsModelBuilder();

  factory UserModel([void Function(UserModelBuilder)? updates]) = _$UserModel;

  static Serializer<UserModel> get serializer => _$userModelSerializer;
}

abstract class UserRef
    implements UserModelBase, Ref, Built<UserRef, UserRefBuilder> {
  UserRef._();
  factory UserRef([void Function(UserRefBuilder) updates]) = _$UserRef;
  factory UserRef.fromSnapshot(DocumentSnapshot<UserModel> snapshot) =>
      UserRef((b) => b
        ..ref = snapshot.reference
        ..profile = snapshot.data()?.profile?.toBuilder());

  static Serializer<UserRef> get serializer => _$userRefSerializer;
}
