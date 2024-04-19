import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:klimo_datamodels/articles.dart';
import 'package:klimo_datamodels/serializers.dart';
import 'package:klimo_datamodels/util.dart';

part 'advent_calendar.g.dart';

abstract class AdventCalendarModel
    implements Built<AdventCalendarModel, AdventCalendarModelBuilder> {
  DateTime get date;
  String get imageUrl;

  Translation<String>? get title;
  NewsModel? get article;
  String? get challengeRootId;
  CalendarRewardModel? get reward;
  Translation<String>? get fact;
  bool get isOpen;

  AdventCalendarModel._();

  factory AdventCalendarModel(
          [void Function(AdventCalendarModelBuilder) updates]) =
      _$AdventCalendarModel;

  static Serializer<AdventCalendarModel> get serializer =>
      _$adventCalendarModelSerializer;

  Map<String, dynamic>? toJson() {
    return serializers.serializeWith(AdventCalendarModel.serializer, this)
        as Map<String, dynamic>;
  }

  static AdventCalendarModel? fromJson(Map<String, dynamic> json) {
    return serializers.deserializeWith(AdventCalendarModel.serializer, json);
  }

  @BuiltValueHook(initializeBuilder: true)
  static void _setDefaults(AdventCalendarModelBuilder b) => b..isOpen = false;
}

abstract class CalendarRewardModel
    implements Built<CalendarRewardModel, CalendarRewardModelBuilder> {
  Translation<String> get title;
  String get assetUrl;
  String get id;

  CalendarRewardModel._();

  factory CalendarRewardModel(
          [void Function(CalendarRewardModelBuilder)? updates]) =
      _$CalendarRewardModel;

  static Serializer<CalendarRewardModel> get serializer =>
      _$calendarRewardModelSerializer;
}

abstract class OpenedCardModel
    implements Built<OpenedCardModel, OpenedCardModelBuilder> {
  bool get isOpened;

  OpenedCardModel._();
  factory OpenedCardModel([void Function(OpenedCardModelBuilder)? updates]) =
      _$OpenedCardModel;

  static Serializer<OpenedCardModel> get serializer =>
      _$openedCardModelSerializer;

  Map<String, dynamic>? toJson() {
    return serializers.serializeWith(OpenedCardModel.serializer, this)
        as Map<String, dynamic>;
  }

  static OpenedCardModel? fromJson(Map<String, dynamic> json) {
    return serializers.deserializeWith(OpenedCardModel.serializer, json);
  }
}
