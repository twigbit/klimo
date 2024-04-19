import 'dart:convert';

import 'package:built_collection/built_collection.dart';
import 'package:klimo/common/repository/cached_content_repository.dart';
import 'package:klimo/utils/markdown.dart';
import 'package:klimo_datamodels/articles.dart';
import 'package:klimo_datamodels/partners.dart';

import '../config/firebase.dart';

class NewsContentRepository
    extends CachedContentRepository<BuiltList<NewsModel>> {
  final String communityId;

  NewsContentRepository(this.communityId);

  @override
  String get url => httpFunctions.getFunctionUrl("fetchCommunityContent", {
        "community": communityId,
        "table": "news",
        if (auth.currentUser?.uid != null) "uid": auth.currentUser!.uid,
      });

  @override
  BuiltList<NewsModel> deserialize(String content) {
    final items = jsonDecode(content)['news'] as List;

    final news = items
        .map<NewsModel?>((item) => NewsModel.fromJson(item))
        .where((item) => item != null)
        .map((item) => item!.contentFormat != "html"
            ? item.rebuild((b) => b
              ..content.addEntries(item.content.entries.map((entry) => MapEntry(
                  entry.key, preprocessAirtableMarkdown(entry.value)))))
            : item);

    return news.cast<NewsModel>().toBuiltList();
  }
}

class PartnersContentRepository
    extends CachedContentRepository<BuiltList<PartnerModel>> {
  final String communityId;

  PartnersContentRepository(this.communityId);

  @override
  String get url => httpFunctions.getFunctionUrl("fetchCommunityContent", {
        "community": communityId,
        "table": "partners",
        if (auth.currentUser?.uid != null) "uid": auth.currentUser!.uid,
      });

  @override
  BuiltList<PartnerModel> deserialize(String content) {
    final items = jsonDecode(content)['partners'] as List;

    final partners = items
        .map<PartnerModel?>((item) => PartnerModel.fromJson(item))
        .where((item) => item != null);

    return partners.cast<PartnerModel>().toBuiltList();
  }
}
