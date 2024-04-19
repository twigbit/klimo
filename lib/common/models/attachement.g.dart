// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'attachement.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Attachement _$$_AttachementFromJson(Map<String, dynamic> json) =>
    _$_Attachement(
      url: json['url'] as String,
      type: json['type'] as String,
      id: json['id'] as String,
      height: json['height'] as int?,
      width: json['width'] as int?,
      size: json['size'] as int?,
    );

Map<String, dynamic> _$$_AttachementToJson(_$_Attachement instance) =>
    <String, dynamic>{
      'url': instance.url,
      'type': instance.type,
      'id': instance.id,
      'height': instance.height,
      'width': instance.width,
      'size': instance.size,
    };
