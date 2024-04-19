import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'image.g.dart';

abstract class ImageModel implements Built<ImageModel, ImageModelBuilder> {
  String get storagePath;
  String get downloadUrl;

  ImageModel._();
  factory ImageModel([void Function(ImageModelBuilder) updates]) = _$ImageModel;

  static Serializer<ImageModel> get serializer => _$imageModelSerializer;
}
