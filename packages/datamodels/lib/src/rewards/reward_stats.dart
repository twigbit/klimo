import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

import '../../serializers.dart';

part 'reward_stats.g.dart';

abstract class RewardStatsModel
    implements Built<RewardStatsModel, RewardStatsModelBuilder> {
  num get points;
  DateTime? get lastReward;

  @BuiltValueHook(initializeBuilder: true)
  static void _setDefaults(RewardStatsModelBuilder b) => b..points = 0;

  RewardStatsModel._();
  factory RewardStatsModel([void Function(RewardStatsModelBuilder) updates]) =
      _$RewardStatsModel;

  Map<String, dynamic> toJson() {
    return serializers.serializeWith(RewardStatsModel.serializer, this)
        as Map<String, dynamic>;
  }

  static RewardStatsModel? fromJson(Map<String, dynamic> json) {
    return serializers.deserializeWith(RewardStatsModel.serializer, json);
  }

  static Serializer<RewardStatsModel> get serializer =>
      _$rewardStatsModelSerializer;
}
