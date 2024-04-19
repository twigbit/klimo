import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'offset.g.dart';

abstract class CarbonOffset
    implements Built<CarbonOffset, CarbonOffsetBuilder> {
  CarbonOffset._();

  // TODO add further properties needed especially for identifying projects that user donated for

  num? get emissionSavings;

  factory CarbonOffset([void Function(CarbonOffsetBuilder)? updates]) =
      _$CarbonOffset;

  static Serializer<CarbonOffset> get serializer => _$carbonOffsetSerializer;
}
