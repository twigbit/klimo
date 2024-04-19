import 'package:freezed_annotation/freezed_annotation.dart';

part 'attachement.freezed.dart';
part 'attachement.g.dart';

@freezed
class Attachement with _$Attachement {
  const factory Attachement({
    required String url,
    required String type,
    required String id,
    int? height,
    int? width,
    int? size,
  }) = _Attachement;

  factory Attachement.fromJson(Map<String, Object?> json) =>
      _$AttachementFromJson(json);
}
