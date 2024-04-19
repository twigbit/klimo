import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'test_user.g.dart';

abstract class TestUserModel
    implements Built<TestUserModel, TestUserModelBuilder> {
  String? get federalState;
  String? get token;
  String? get password;

  TestUserModel._();

  factory TestUserModel([void Function(TestUserModelBuilder) updates]) =
      _$TestUserModel;

  static Serializer<TestUserModel> get serializer => _$testUserModelSerializer;
}
