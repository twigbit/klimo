import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'reward.g.dart';

abstract class UserRewardModel
    implements Built<UserRewardModel, UserRewardModelBuilder> {
  DateTime get timestamp;
  VirtualRewardModel get reward;

  UserRewardModel._();

  factory UserRewardModel([void Function(UserRewardModelBuilder)? updates]) =
      _$UserRewardModel;

  static Serializer<UserRewardModel> get serializer =>
      _$userRewardModelSerializer;
}

abstract class VirtualRewardModel
    implements Built<VirtualRewardModel, VirtualRewardModelBuilder> {
  String? get title;
  String get assetUrl;
  num get height;
  num get width;
  num get x;
  num get y;
  num? get z;

  VirtualRewardModel._();

  factory VirtualRewardModel(
          [void Function(VirtualRewardModelBuilder)? updates]) =
      _$VirtualRewardModel;

  static Serializer<VirtualRewardModel> get serializer =>
      _$virtualRewardModelSerializer;
}
