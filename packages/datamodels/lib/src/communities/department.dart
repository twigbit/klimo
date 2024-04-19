import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:klimo_datamodels/src/stats/stats.dart';

import '../../util.dart';

part 'department.g.dart';

abstract class DepartmentBase {
  BuiltMap<String, String>? get logoUrl;
  BuiltMap<String, String> get name;
}

abstract class DepartmentModel
    implements DepartmentBase, Built<DepartmentModel, DepartmentModelBuilder> {
  DepartmentModel._();

// use Translation<String> here?
  Translation<String>? get info;
  StatsModel? get stats;

  factory DepartmentModel([void Function(DepartmentModelBuilder)? updates]) =
      _$DepartmentModel;

  static Serializer<DepartmentModel> get serializer =>
      _$departmentModelSerializer;
}

abstract class DepartmentRef
    implements DepartmentBase, Ref, Built<DepartmentRef, DepartmentRefBuilder> {
  DepartmentRef._();

  factory DepartmentRef.fromSnapshot(
      DocumentSnapshot<DepartmentModel> snapshot) {
    final DepartmentModel c = snapshot.data()!;
    return DepartmentRef((b) => b
      ..ref = snapshot.reference
      ..name = c.name.toBuilder()
      ..logoUrl = c.logoUrl?.toBuilder());
  }

  factory DepartmentRef([void Function(DepartmentRefBuilder)? updates]) =
      _$DepartmentRef;

  static Serializer<DepartmentRef> get serializer => _$departmentRefSerializer;
}
