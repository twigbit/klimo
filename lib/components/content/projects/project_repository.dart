import 'dart:convert';

import 'package:built_collection/built_collection.dart';
import 'package:klimo/common/repository/cached_content_repository.dart';
import 'package:klimo_datamodels/projects.dart';
import 'package:klimo_datamodels/serializers.dart' as serdes;

class ProjectRepository extends CachedContentRepository<BuiltList<Project>> {
  @override
  final String url = "https://klimo.ecocrowd.de/gbs/api.json/excerpts";

  Iterable<Project> filter(Iterable<Project?> input) => input
      .where((project) => project != null && project.status == "open")
      .cast();

  @override
  BuiltList<Project> deserialize(String content) {
    final json = jsonDecode(content) as List;
    return filter(json.map((item) => serdes.deserialize<Project>(item)))
        .toBuiltList();
  }
}
