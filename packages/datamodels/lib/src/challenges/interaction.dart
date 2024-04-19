import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'categories.dart';
import 'challenge_stats.dart';

part 'interaction.g.dart';

abstract class Interaction implements Built<Interaction, InteractionBuilder> {
  Interaction._();

  DocumentReference get challengeRef;
  bool? get success;
  DateTime get timestamp;
  DateTime get updatedAt;
  StatsValuePair get stats;
  Category get category;

  factory Interaction([void Function(InteractionBuilder)? updates]) =
      _$Interaction;

  static Serializer<Interaction> get serializer => _$interactionSerializer;
}
