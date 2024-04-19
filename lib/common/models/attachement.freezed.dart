// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'attachement.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Attachement _$AttachementFromJson(Map<String, dynamic> json) {
  return _Attachement.fromJson(json);
}

/// @nodoc
mixin _$Attachement {
  String get url => throw _privateConstructorUsedError;
  String get type => throw _privateConstructorUsedError;
  String get id => throw _privateConstructorUsedError;
  int? get height => throw _privateConstructorUsedError;
  int? get width => throw _privateConstructorUsedError;
  int? get size => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AttachementCopyWith<Attachement> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AttachementCopyWith<$Res> {
  factory $AttachementCopyWith(
          Attachement value, $Res Function(Attachement) then) =
      _$AttachementCopyWithImpl<$Res, Attachement>;
  @useResult
  $Res call(
      {String url, String type, String id, int? height, int? width, int? size});
}

/// @nodoc
class _$AttachementCopyWithImpl<$Res, $Val extends Attachement>
    implements $AttachementCopyWith<$Res> {
  _$AttachementCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? url = null,
    Object? type = null,
    Object? id = null,
    Object? height = freezed,
    Object? width = freezed,
    Object? size = freezed,
  }) {
    return _then(_value.copyWith(
      url: null == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      height: freezed == height
          ? _value.height
          : height // ignore: cast_nullable_to_non_nullable
              as int?,
      width: freezed == width
          ? _value.width
          : width // ignore: cast_nullable_to_non_nullable
              as int?,
      size: freezed == size
          ? _value.size
          : size // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_AttachementCopyWith<$Res>
    implements $AttachementCopyWith<$Res> {
  factory _$$_AttachementCopyWith(
          _$_Attachement value, $Res Function(_$_Attachement) then) =
      __$$_AttachementCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String url, String type, String id, int? height, int? width, int? size});
}

/// @nodoc
class __$$_AttachementCopyWithImpl<$Res>
    extends _$AttachementCopyWithImpl<$Res, _$_Attachement>
    implements _$$_AttachementCopyWith<$Res> {
  __$$_AttachementCopyWithImpl(
      _$_Attachement _value, $Res Function(_$_Attachement) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? url = null,
    Object? type = null,
    Object? id = null,
    Object? height = freezed,
    Object? width = freezed,
    Object? size = freezed,
  }) {
    return _then(_$_Attachement(
      url: null == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      height: freezed == height
          ? _value.height
          : height // ignore: cast_nullable_to_non_nullable
              as int?,
      width: freezed == width
          ? _value.width
          : width // ignore: cast_nullable_to_non_nullable
              as int?,
      size: freezed == size
          ? _value.size
          : size // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Attachement implements _Attachement {
  const _$_Attachement(
      {required this.url,
      required this.type,
      required this.id,
      this.height,
      this.width,
      this.size});

  factory _$_Attachement.fromJson(Map<String, dynamic> json) =>
      _$$_AttachementFromJson(json);

  @override
  final String url;
  @override
  final String type;
  @override
  final String id;
  @override
  final int? height;
  @override
  final int? width;
  @override
  final int? size;

  @override
  String toString() {
    return 'Attachement(url: $url, type: $type, id: $id, height: $height, width: $width, size: $size)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Attachement &&
            (identical(other.url, url) || other.url == url) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.height, height) || other.height == height) &&
            (identical(other.width, width) || other.width == width) &&
            (identical(other.size, size) || other.size == size));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, url, type, id, height, width, size);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_AttachementCopyWith<_$_Attachement> get copyWith =>
      __$$_AttachementCopyWithImpl<_$_Attachement>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_AttachementToJson(
      this,
    );
  }
}

abstract class _Attachement implements Attachement {
  const factory _Attachement(
      {required final String url,
      required final String type,
      required final String id,
      final int? height,
      final int? width,
      final int? size}) = _$_Attachement;

  factory _Attachement.fromJson(Map<String, dynamic> json) =
      _$_Attachement.fromJson;

  @override
  String get url;
  @override
  String get type;
  @override
  String get id;
  @override
  int? get height;
  @override
  int? get width;
  @override
  int? get size;
  @override
  @JsonKey(ignore: true)
  _$$_AttachementCopyWith<_$_Attachement> get copyWith =>
      throw _privateConstructorUsedError;
}
