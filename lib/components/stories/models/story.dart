import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../common/cubit/api_list_cubit.dart';
import '../../../common/repository/api_repository.dart';
import '../../../common/models/atoms.dart';
import '../../../common/models/attachement.dart';
import '../../../common/models/displayable.dart';
import '../quiz/models/quiz.dart';

part 'story.freezed.dart';
part 'story.g.dart';

@freezed
class Story with _$Story implements Displayable {
  factory Story({
    required String id,
    required Translation<String> title,
    Translation<String>? content,
    Translation<String>? subtitle,
    required Attachement image,
    Translation<String>? overline,
  }) = _Story;

  factory Story.fromJson(Map<String, dynamic> json) => _$StoryFromJson(json);
}

@freezed
class StoryDetails with _$StoryDetails implements Displayable {
  factory StoryDetails({
    required String id,
    required Translation<String> title,
    Translation<String>? content,
    Translation<String>? subtitle,
    required Attachement image,
    Translation<String>? overline,
    @Default([]) List<StoryPageModel> pages,
  }) = _StoryDetails;

  factory StoryDetails.fromJson(Map<String, Object?> json) =>
      _$StoryDetailsFromJson(json);
}

@freezed
class StoryPageModel with _$StoryPageModel implements Displayable {
  factory StoryPageModel(
      {required Translation<String> title,
      Translation<String>? content,
      Translation<String>? subtitle,
      required String id,
      required Attachement image,
      Attachement? illustration,
      @Default([]) List<String> challenges,
      Translation<String>? overline,
      QuizModel? quiz,
      @Default(1000) int order}) = _StoryPageModel;

  factory StoryPageModel.fromJson(Map<String, Object?> json) =>
      _$StoryPageModelFromJson(json);
}

class StoriesRepository extends ApiListRepository<Story> {
  StoriesRepository()
      : super(
          path: '_/guides',
          isV2: true,
          deserialize: (json) => (json['stories'] as List)
              .deserialize((json) => Story.fromJson(json)),
        );
}

typedef StoriesState = Loadable<List<Story>>?;
typedef StoriesCubit = ApiListCubit<Story>;

extension WithItemSerializer on List {
  List<T> deserialize<T>(T Function(Map<String, Object?> json) deserialize) =>
      map<T?>((item) {
        try {
          return deserialize(item);
        } catch (e) {
          debugPrint('Error deserializing ${deserialize.runtimeType}');
          return null;
        }
      }).where((item) => item != null).cast<T>().toList();
}
