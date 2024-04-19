import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'challenge_stats.g.dart';

abstract class ChallengeStats
    implements Built<ChallengeStats, ChallengeStatsBuilder> {
  ChallengeStats._();

  StatsValuePair? get total;

  factory ChallengeStats([void Function(ChallengeStatsBuilder)? updates]) =
      _$ChallengeStats;

  static Serializer<ChallengeStats> get serializer =>
      _$challengeStatsSerializer;
}

abstract class StatsValuePair
    implements Built<StatsValuePair, StatsValuePairBuilder> {
  StatsValuePair._();

  num? get coins;
  num? get emissionSavings;

  factory StatsValuePair([void Function(StatsValuePairBuilder)? updates]) =
      _$StatsValuePair;

  static Serializer<StatsValuePair> get serializer =>
      _$statsValuePairSerializer;
}
