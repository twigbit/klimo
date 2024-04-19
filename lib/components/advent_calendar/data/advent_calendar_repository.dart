import 'dart:convert';

import 'package:built_collection/built_collection.dart';
import 'package:klimo/common/repository/cached_content_repository.dart';
import 'package:klimo/config/firebase.dart';
import 'package:klimo_datamodels/advent_calendar.dart';

class AdventCalendarRepository
    extends CachedContentRepository<BuiltList<AdventCalendarModel>> {
  AdventCalendarRepository();

  @override
  String get url => httpFunctions.getFunctionUrl("fetchAdventsContent");

  @override
  BuiltList<AdventCalendarModel> deserialize(String content) {
    final items = jsonDecode(content)['data'] as List;

    final adventCalendar = items
        .map<AdventCalendarModel?>((item) => AdventCalendarModel.fromJson(item))
        .where((item) => item != null);

    return adventCalendar.cast<AdventCalendarModel>().toBuiltList();
  }
}
