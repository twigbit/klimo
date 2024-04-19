// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quiz.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_QuizModel _$$_QuizModelFromJson(Map<String, dynamic> json) => _$_QuizModel(
      id: json['id'] as String,
      question: Map<String, String>.from(json['question'] as Map),
      information: Map<String, String>.from(json['information'] as Map),
      answers: (json['answers'] as List<dynamic>)
          .map((e) => Map<String, String>.from(e as Map))
          .toList(),
    );

Map<String, dynamic> _$$_QuizModelToJson(_$_QuizModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'question': instance.question,
      'information': instance.information,
      'answers': instance.answers,
    };
