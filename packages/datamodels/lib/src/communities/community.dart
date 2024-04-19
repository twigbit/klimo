import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:klimo_datamodels/src/communities/community_config.dart';
import 'package:klimo_datamodels/util.dart';

part 'community.g.dart';

abstract class CommunityBase {
  bool? get isFallback;
  Translation<String>? get logoUrl;
  Translation<String> get name;
  Translation<String>? get subtitle;
}

abstract class CommunityModel
    implements CommunityBase, Built<CommunityModel, CommunityModelBuilder> {
  CommunityModel._();

  @override
  Translation<String> get name;

  CommunityConfig get config;

  factory CommunityModel([void Function(CommunityModelBuilder)? updates]) =
      _$CommunityModel;

  static Serializer<CommunityModel> get serializer =>
      _$communityModelSerializer;
}

abstract class CommunityRef
    implements Ref, CommunityBase, Built<CommunityRef, CommunityRefBuilder> {
  CommunityRef._();

  factory CommunityRef([void Function(CommunityRefBuilder)? updates]) =
      _$CommunityRef;

  factory CommunityRef.fromSnapshot(DocumentSnapshot<CommunityModel> snapshot) {
    final CommunityModel c = snapshot.data()!;
    return CommunityRef((b) => b
      ..ref = snapshot.reference
      ..name = c.name.toBuilder()
      ..logoUrl = c.logoUrl?.toBuilder()
      ..subtitle = c.subtitle?.toBuilder());
  }

  static Serializer<CommunityRef> get serializer => _$communityRefSerializer;
}
