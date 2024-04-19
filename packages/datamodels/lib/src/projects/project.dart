import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'project.g.dart';

abstract class Project implements Built<Project, ProjectBuilder> {
  Project._();

  String get title;
  String get url;
  String get summary;
  @BuiltValueField(wireName: 'photo_small')
  String get imageUrl;
  String get status;

  factory Project([void Function(ProjectBuilder)? updates]) = _$Project;

  static Serializer<Project> get serializer => _$projectSerializer;
}
