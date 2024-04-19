// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'story.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Story _$$_StoryFromJson(Map<String, dynamic> json) => _$_Story(
      id: json['id'] as String,
      title: Map<String, String>.from(json['title'] as Map),
      content: (json['content'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String),
      ),
      subtitle: (json['subtitle'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String),
      ),
      image: Attachement.fromJson(json['image'] as Map<String, dynamic>),
      overline: (json['overline'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String),
      ),
    );

Map<String, dynamic> _$$_StoryToJson(_$_Story instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'content': instance.content,
      'subtitle': instance.subtitle,
      'image': instance.image,
      'overline': instance.overline,
    };

_$_StoryDetails _$$_StoryDetailsFromJson(Map<String, dynamic> json) =>
    _$_StoryDetails(
      id: json['id'] as String,
      title: Map<String, String>.from(json['title'] as Map),
      content: (json['content'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String),
      ),
      subtitle: (json['subtitle'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String),
      ),
      image: Attachement.fromJson(json['image'] as Map<String, dynamic>),
      overline: (json['overline'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String),
      ),
      pages: (json['pages'] as List<dynamic>?)
              ?.map((e) => StoryPageModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$_StoryDetailsToJson(_$_StoryDetails instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'content': instance.content,
      'subtitle': instance.subtitle,
      'image': instance.image,
      'overline': instance.overline,
      'pages': instance.pages,
    };

_$_StoryPageModel _$$_StoryPageModelFromJson(Map<String, dynamic> json) =>
    _$_StoryPageModel(
      title: Map<String, String>.from(json['title'] as Map),
      content: (json['content'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String),
      ),
      subtitle: (json['subtitle'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String),
      ),
      id: json['id'] as String,
      image: Attachement.fromJson(json['image'] as Map<String, dynamic>),
      illustration: json['illustration'] == null
          ? null
          : Attachement.fromJson(json['illustration'] as Map<String, dynamic>),
      challenges: (json['challenges'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      overline: (json['overline'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String),
      ),
      quiz: json['quiz'] == null
          ? null
          : QuizModel.fromJson(json['quiz'] as Map<String, dynamic>),
      order: json['order'] as int? ?? 1000,
    );

Map<String, dynamic> _$$_StoryPageModelToJson(_$_StoryPageModel instance) =>
    <String, dynamic>{
      'title': instance.title,
      'content': instance.content,
      'subtitle': instance.subtitle,
      'id': instance.id,
      'image': instance.image,
      'illustration': instance.illustration,
      'challenges': instance.challenges,
      'overline': instance.overline,
      'quiz': instance.quiz,
      'order': instance.order,
    };
