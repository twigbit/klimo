import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'article.g.dart';

abstract class Article implements Built<Article, ArticleBuilder> {
  @BuiltValueField(wireName: 'name')
  String get header;

  String get subheader;

  WebflowThumbnail get thumbnail;

  @BuiltValueField(wireName: 'published-on')
  DateTime? get publishedOn;

  @BuiltValueField(wireName: 'content-text')
  String get content;

  @BuiltValueField(wireName: '_id')
  String get id;

  String get type;

  Article._();

  factory Article([void Function(ArticleBuilder)? updates]) = _$Article;

  static Serializer<Article> get serializer => _$articleSerializer;
}

abstract class WebflowThumbnail
    implements Built<WebflowThumbnail, WebflowThumbnailBuilder> {
  String get url;

  // String get author;
  WebflowThumbnail._();

  factory WebflowThumbnail([void Function(WebflowThumbnailBuilder)? updates]) =
      _$WebflowThumbnail;

  static Serializer<WebflowThumbnail> get serializer =>
      _$webflowThumbnailSerializer;
}

extension WithUtility on Iterable<Article> {
  Iterable<Article> get news =>
      where((Article a) => a.type == "ef18dfe1ba3ef560e390ef0125a4430f");

  Iterable<Article> get articles =>
      where((Article a) => a.type == "5aa5092bd845f617849787f6c2d3f90c");
}
