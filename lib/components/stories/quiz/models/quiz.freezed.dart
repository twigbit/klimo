// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'quiz.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

QuizModel _$QuizModelFromJson(Map<String, dynamic> json) {
  return _QuizModel.fromJson(json);
}

/// @nodoc
mixin _$QuizModel {
  String get id => throw _privateConstructorUsedError;
  Map<String, String> get question => throw _privateConstructorUsedError;
  Map<String, String> get information => throw _privateConstructorUsedError;
  List<Map<String, String>> get answers => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $QuizModelCopyWith<QuizModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $QuizModelCopyWith<$Res> {
  factory $QuizModelCopyWith(QuizModel value, $Res Function(QuizModel) then) =
      _$QuizModelCopyWithImpl<$Res, QuizModel>;
  @useResult
  $Res call(
      {String id,
      Map<String, String> question,
      Map<String, String> information,
      List<Map<String, String>> answers});
}

/// @nodoc
class _$QuizModelCopyWithImpl<$Res, $Val extends QuizModel>
    implements $QuizModelCopyWith<$Res> {
  _$QuizModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? question = null,
    Object? information = null,
    Object? answers = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      question: null == question
          ? _value.question
          : question // ignore: cast_nullable_to_non_nullable
              as Map<String, String>,
      information: null == information
          ? _value.information
          : information // ignore: cast_nullable_to_non_nullable
              as Map<String, String>,
      answers: null == answers
          ? _value.answers
          : answers // ignore: cast_nullable_to_non_nullable
              as List<Map<String, String>>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_QuizModelCopyWith<$Res> implements $QuizModelCopyWith<$Res> {
  factory _$$_QuizModelCopyWith(
          _$_QuizModel value, $Res Function(_$_QuizModel) then) =
      __$$_QuizModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      Map<String, String> question,
      Map<String, String> information,
      List<Map<String, String>> answers});
}

/// @nodoc
class __$$_QuizModelCopyWithImpl<$Res>
    extends _$QuizModelCopyWithImpl<$Res, _$_QuizModel>
    implements _$$_QuizModelCopyWith<$Res> {
  __$$_QuizModelCopyWithImpl(
      _$_QuizModel _value, $Res Function(_$_QuizModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? question = null,
    Object? information = null,
    Object? answers = null,
  }) {
    return _then(_$_QuizModel(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      question: null == question
          ? _value._question
          : question // ignore: cast_nullable_to_non_nullable
              as Map<String, String>,
      information: null == information
          ? _value._information
          : information // ignore: cast_nullable_to_non_nullable
              as Map<String, String>,
      answers: null == answers
          ? _value._answers
          : answers // ignore: cast_nullable_to_non_nullable
              as List<Map<String, String>>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_QuizModel implements _QuizModel {
  const _$_QuizModel(
      {required this.id,
      required final Map<String, String> question,
      required final Map<String, String> information,
      required final List<Map<String, String>> answers})
      : _question = question,
        _information = information,
        _answers = answers;

  factory _$_QuizModel.fromJson(Map<String, dynamic> json) =>
      _$$_QuizModelFromJson(json);

  @override
  final String id;
  final Map<String, String> _question;
  @override
  Map<String, String> get question {
    if (_question is EqualUnmodifiableMapView) return _question;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_question);
  }

  final Map<String, String> _information;
  @override
  Map<String, String> get information {
    if (_information is EqualUnmodifiableMapView) return _information;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_information);
  }

  final List<Map<String, String>> _answers;
  @override
  List<Map<String, String>> get answers {
    if (_answers is EqualUnmodifiableListView) return _answers;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_answers);
  }

  @override
  String toString() {
    return 'QuizModel(id: $id, question: $question, information: $information, answers: $answers)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_QuizModel &&
            (identical(other.id, id) || other.id == id) &&
            const DeepCollectionEquality().equals(other._question, _question) &&
            const DeepCollectionEquality()
                .equals(other._information, _information) &&
            const DeepCollectionEquality().equals(other._answers, _answers));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      const DeepCollectionEquality().hash(_question),
      const DeepCollectionEquality().hash(_information),
      const DeepCollectionEquality().hash(_answers));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_QuizModelCopyWith<_$_QuizModel> get copyWith =>
      __$$_QuizModelCopyWithImpl<_$_QuizModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_QuizModelToJson(
      this,
    );
  }
}

abstract class _QuizModel implements QuizModel {
  const factory _QuizModel(
      {required final String id,
      required final Map<String, String> question,
      required final Map<String, String> information,
      required final List<Map<String, String>> answers}) = _$_QuizModel;

  factory _QuizModel.fromJson(Map<String, dynamic> json) =
      _$_QuizModel.fromJson;

  @override
  String get id;
  @override
  Map<String, String> get question;
  @override
  Map<String, String> get information;
  @override
  List<Map<String, String>> get answers;
  @override
  @JsonKey(ignore: true)
  _$$_QuizModelCopyWith<_$_QuizModel> get copyWith =>
      throw _privateConstructorUsedError;
}
