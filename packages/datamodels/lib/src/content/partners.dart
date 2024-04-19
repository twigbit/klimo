import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

import '../../serializers.dart';
import '../util/localisation.dart';

part 'partners.g.dart';

abstract class PartnerModel
    implements Built<PartnerModel, PartnerModelBuilder> {
  PartnerModel._();

  Translation<String> get title;

  Translation<String> get content;
  Translation<String>? get bannerImage;
  Translation<String>? get logo;
  BuiltList<String>? get partners;
  num? get coins;
  String? get coupon;
  String? get link;
  Translation<String>? get action;

  factory PartnerModel([void Function(PartnerModelBuilder) updates]) =
      _$PartnerModel;

  static Serializer<PartnerModel> get serializer => _$partnerModelSerializer;

  Map<String, dynamic>? toJson() {
    return serializers.serializeWith(PartnerModel.serializer, this)
        as Map<String, dynamic>;
  }

  static PartnerModel? fromJson(Map<String, dynamic> json) {
    return serializers.deserializeWith(PartnerModel.serializer, json);
  }
}
