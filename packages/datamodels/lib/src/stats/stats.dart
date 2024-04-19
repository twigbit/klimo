import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

import '../../serializers.dart';

part 'stats.g.dart';

abstract class StatsModel implements Built<StatsModel, StatsModelBuilder> {
  num get emissionSavings;
  num get coins;
  num get challenges;
  num get quizPoints;

  @BuiltValueHook(initializeBuilder: true)
  static void _setDefaults(StatsModelBuilder b) => b
    ..challenges = 0
    ..emissionSavings = 0
    ..coins = 0
    ..quizPoints = 0;

  StatsModel._();
  factory StatsModel([void Function(StatsModelBuilder) updates]) = _$StatsModel;

  Map<String, dynamic> toJson() {
    return serializers.serializeWith(StatsModel.serializer, this)
        as Map<String, dynamic>;
  }

  static StatsModel? fromJson(Map<String, dynamic> json) {
    return serializers.deserializeWith(StatsModel.serializer, json);
  }

  static Serializer<StatsModel> get serializer => _$statsModelSerializer;
}
