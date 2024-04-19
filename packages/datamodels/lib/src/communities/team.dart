library team;

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:klimo_datamodels/src/stats/stats.dart';
import 'package:klimo_datamodels/util.dart';

part 'team.g.dart';

abstract class TeamBase {
  String get name;
}

abstract class TeamModel
    implements TeamBase, Built<TeamModel, TeamModelBuilder> {
  TeamModel._();

  String? get info;
  StatsModel? get stats;

  factory TeamModel([void Function(TeamModelBuilder) updates]) = _$TeamModel;

  static Serializer<TeamModel> get serializer => _$teamModelSerializer;
}

abstract class TeamRef
    implements TeamBase, Ref, Built<TeamRef, TeamRefBuilder> {
  TeamRef._();

  factory TeamRef([void Function(TeamRefBuilder) updates]) = _$TeamRef;

  factory TeamRef.fromModel(TeamModel model, DocumentReference ref) {
    return TeamRef((b) => b
      ..ref = ref
      ..name = model.name);
  }

  factory TeamRef.fromSnapshot(DocumentSnapshot<TeamModel> snapshot) {
    return TeamRef.fromModel(snapshot.data()!, snapshot.reference);
  }

  static Serializer<TeamRef> get serializer => _$teamRefSerializer;
}
