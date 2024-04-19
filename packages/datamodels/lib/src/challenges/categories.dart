import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'categories.g.dart';

class Category extends EnumClass {
  /* 
  Values 
  TODO: Fill with life!
   */
  static const Category mobility = _$mobility;
  static const Category nutrition = _$nutrition;
  static const Category hobbies = _$hobbies;
  static const Category activism = _$activism;
  static const Category living = _$living;
  static const Category general = _$general;
  static const Category consumption = _$consumption;
  static const Category digital = _$digital;
  static const Category shopping = _$shopping;

  const Category._(String name) : super(name);
  static BuiltSet<Category> get values => _$values;
  static Category valueOf(String name) => _$valueOf(name);
  static Serializer<Category> get serializer => _$categorySerializer;
}
