import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:klimo_datamodels/src/user/test_user.dart';
import 'package:klimo_datamodels/src/util/image.dart';

part 'profile.g.dart';

abstract class ProfileRefBase {
  String? get name;
  ImageModel? get image;
  TestUserModel? get testUser;
}

abstract class ProfileBase implements ProfileRefBase {
  String? get bio;
  String? get zip;
}

abstract class ProfileModel
    implements ProfileBase, Built<ProfileModel, ProfileModelBuilder> {
  ProfileModel._();

  factory ProfileModel([void Function(ProfileModelBuilder)? updates]) =
      _$ProfileModel;

  static Serializer<ProfileModel> get serializer => _$profileModelSerializer;
}

abstract class ProfileRef
    implements ProfileRefBase, Built<ProfileRef, ProfileRefBuilder> {
  ProfileRef._();

  factory ProfileRef([void Function(ProfileRefBuilder)? updates]) =
      _$ProfileRef;

  static Serializer<ProfileRef> get serializer => _$profileRefSerializer;
}
