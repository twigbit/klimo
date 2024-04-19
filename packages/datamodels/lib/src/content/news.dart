import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:klimo_datamodels/serializers.dart';

import '../../util.dart';

part 'news.g.dart';

class ArticleType extends EnumClass {
  static Serializer<ArticleType> get serializer => _$articleTypeSerializer;

  static const ArticleType news = _$news;
  static const ArticleType article = _$article;
  static const ArticleType guide = _$guide;

  const ArticleType._(String name) : super(name);

  static BuiltSet<ArticleType> get values => _$values;
  static ArticleType valueOf(String name) => _$valueOf(name);
}

abstract class NewsModel implements Built<NewsModel, NewsModelBuilder> {
  // id, title, content, bannerImage, type, author, topics, publishedAt
  String get id;
  Translation<String> get title;
  Translation<String>? get subheader;
  Translation<String> get content;
  String? get contentFormat;
  Translation<String> get bannerImage;
  BuiltList<String> get author;
  BuiltList<String> get topics;
  ArticleType? get type;
  DateTime get publishedAt;

  @BuiltValueHook(initializeBuilder: true)
  static void _setDefaults(NewsModelBuilder b) =>
      b..publishedAt = DateTime.now();

  NewsModel._();
  factory NewsModel([void Function(NewsModelBuilder) updates]) = _$NewsModel;

  Map<String, dynamic>? toJson() {
    return serializers.serializeWith(NewsModel.serializer, this)
        as Map<String, dynamic>;
  }

  static NewsModel? fromJson(Map<String, dynamic> json) {
    return serializers.deserializeWith(NewsModel.serializer, json);
  }

  static Serializer<NewsModel> get serializer => _$newsModelSerializer;
}
