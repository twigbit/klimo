import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../../common/models/atoms.dart';

part 'quiz.freezed.dart';
part 'quiz.g.dart';

@freezed
class QuizModel with _$QuizModel {
  const factory QuizModel({
    required String id,
    required Translation<String> question,
    required Translation<String> information,
    required List<Translation<String>> answers,
  }) = _QuizModel;

  factory QuizModel.fromJson(Map<String, Object?> json) =>
      _$QuizModelFromJson(json);
}
