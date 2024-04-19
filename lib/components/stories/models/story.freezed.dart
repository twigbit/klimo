// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'story.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Story _$StoryFromJson(Map<String, dynamic> json) {
  return _Story.fromJson(json);
}

/// @nodoc
mixin _$Story {
  String get id => throw _privateConstructorUsedError;
  Map<String, String> get title => throw _privateConstructorUsedError;
  Map<String, String>? get content => throw _privateConstructorUsedError;
  Map<String, String>? get subtitle => throw _privateConstructorUsedError;
  Attachement get image => throw _privateConstructorUsedError;
  Map<String, String>? get overline => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $StoryCopyWith<Story> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StoryCopyWith<$Res> {
  factory $StoryCopyWith(Story value, $Res Function(Story) then) =
      _$StoryCopyWithImpl<$Res, Story>;
  @useResult
  $Res call(
      {String id,
      Map<String, String> title,
      Map<String, String>? content,
      Map<String, String>? subtitle,
      Attachement image,
      Map<String, String>? overline});

  $AttachementCopyWith<$Res> get image;
}

/// @nodoc
class _$StoryCopyWithImpl<$Res, $Val extends Story>
    implements $StoryCopyWith<$Res> {
  _$StoryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? content = freezed,
    Object? subtitle = freezed,
    Object? image = null,
    Object? overline = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as Map<String, String>,
      content: freezed == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as Map<String, String>?,
      subtitle: freezed == subtitle
          ? _value.subtitle
          : subtitle // ignore: cast_nullable_to_non_nullable
              as Map<String, String>?,
      image: null == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as Attachement,
      overline: freezed == overline
          ? _value.overline
          : overline // ignore: cast_nullable_to_non_nullable
              as Map<String, String>?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $AttachementCopyWith<$Res> get image {
    return $AttachementCopyWith<$Res>(_value.image, (value) {
      return _then(_value.copyWith(image: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_StoryCopyWith<$Res> implements $StoryCopyWith<$Res> {
  factory _$$_StoryCopyWith(_$_Story value, $Res Function(_$_Story) then) =
      __$$_StoryCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      Map<String, String> title,
      Map<String, String>? content,
      Map<String, String>? subtitle,
      Attachement image,
      Map<String, String>? overline});

  @override
  $AttachementCopyWith<$Res> get image;
}

/// @nodoc
class __$$_StoryCopyWithImpl<$Res> extends _$StoryCopyWithImpl<$Res, _$_Story>
    implements _$$_StoryCopyWith<$Res> {
  __$$_StoryCopyWithImpl(_$_Story _value, $Res Function(_$_Story) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? content = freezed,
    Object? subtitle = freezed,
    Object? image = null,
    Object? overline = freezed,
  }) {
    return _then(_$_Story(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value._title
          : title // ignore: cast_nullable_to_non_nullable
              as Map<String, String>,
      content: freezed == content
          ? _value._content
          : content // ignore: cast_nullable_to_non_nullable
              as Map<String, String>?,
      subtitle: freezed == subtitle
          ? _value._subtitle
          : subtitle // ignore: cast_nullable_to_non_nullable
              as Map<String, String>?,
      image: null == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as Attachement,
      overline: freezed == overline
          ? _value._overline
          : overline // ignore: cast_nullable_to_non_nullable
              as Map<String, String>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Story with DiagnosticableTreeMixin implements _Story {
  _$_Story(
      {required this.id,
      required final Map<String, String> title,
      final Map<String, String>? content,
      final Map<String, String>? subtitle,
      required this.image,
      final Map<String, String>? overline})
      : _title = title,
        _content = content,
        _subtitle = subtitle,
        _overline = overline;

  factory _$_Story.fromJson(Map<String, dynamic> json) =>
      _$$_StoryFromJson(json);

  @override
  final String id;
  final Map<String, String> _title;
  @override
  Map<String, String> get title {
    if (_title is EqualUnmodifiableMapView) return _title;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_title);
  }

  final Map<String, String>? _content;
  @override
  Map<String, String>? get content {
    final value = _content;
    if (value == null) return null;
    if (_content is EqualUnmodifiableMapView) return _content;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  final Map<String, String>? _subtitle;
  @override
  Map<String, String>? get subtitle {
    final value = _subtitle;
    if (value == null) return null;
    if (_subtitle is EqualUnmodifiableMapView) return _subtitle;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  final Attachement image;
  final Map<String, String>? _overline;
  @override
  Map<String, String>? get overline {
    final value = _overline;
    if (value == null) return null;
    if (_overline is EqualUnmodifiableMapView) return _overline;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Story(id: $id, title: $title, content: $content, subtitle: $subtitle, image: $image, overline: $overline)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'Story'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('title', title))
      ..add(DiagnosticsProperty('content', content))
      ..add(DiagnosticsProperty('subtitle', subtitle))
      ..add(DiagnosticsProperty('image', image))
      ..add(DiagnosticsProperty('overline', overline));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Story &&
            (identical(other.id, id) || other.id == id) &&
            const DeepCollectionEquality().equals(other._title, _title) &&
            const DeepCollectionEquality().equals(other._content, _content) &&
            const DeepCollectionEquality().equals(other._subtitle, _subtitle) &&
            (identical(other.image, image) || other.image == image) &&
            const DeepCollectionEquality().equals(other._overline, _overline));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      const DeepCollectionEquality().hash(_title),
      const DeepCollectionEquality().hash(_content),
      const DeepCollectionEquality().hash(_subtitle),
      image,
      const DeepCollectionEquality().hash(_overline));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_StoryCopyWith<_$_Story> get copyWith =>
      __$$_StoryCopyWithImpl<_$_Story>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_StoryToJson(
      this,
    );
  }
}

abstract class _Story implements Story {
  factory _Story(
      {required final String id,
      required final Map<String, String> title,
      final Map<String, String>? content,
      final Map<String, String>? subtitle,
      required final Attachement image,
      final Map<String, String>? overline}) = _$_Story;

  factory _Story.fromJson(Map<String, dynamic> json) = _$_Story.fromJson;

  @override
  String get id;
  @override
  Map<String, String> get title;
  @override
  Map<String, String>? get content;
  @override
  Map<String, String>? get subtitle;
  @override
  Attachement get image;
  @override
  Map<String, String>? get overline;
  @override
  @JsonKey(ignore: true)
  _$$_StoryCopyWith<_$_Story> get copyWith =>
      throw _privateConstructorUsedError;
}

StoryDetails _$StoryDetailsFromJson(Map<String, dynamic> json) {
  return _StoryDetails.fromJson(json);
}

/// @nodoc
mixin _$StoryDetails {
  String get id => throw _privateConstructorUsedError;
  Map<String, String> get title => throw _privateConstructorUsedError;
  Map<String, String>? get content => throw _privateConstructorUsedError;
  Map<String, String>? get subtitle => throw _privateConstructorUsedError;
  Attachement get image => throw _privateConstructorUsedError;
  Map<String, String>? get overline => throw _privateConstructorUsedError;
  List<StoryPageModel> get pages => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $StoryDetailsCopyWith<StoryDetails> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StoryDetailsCopyWith<$Res> {
  factory $StoryDetailsCopyWith(
          StoryDetails value, $Res Function(StoryDetails) then) =
      _$StoryDetailsCopyWithImpl<$Res, StoryDetails>;
  @useResult
  $Res call(
      {String id,
      Map<String, String> title,
      Map<String, String>? content,
      Map<String, String>? subtitle,
      Attachement image,
      Map<String, String>? overline,
      List<StoryPageModel> pages});

  $AttachementCopyWith<$Res> get image;
}

/// @nodoc
class _$StoryDetailsCopyWithImpl<$Res, $Val extends StoryDetails>
    implements $StoryDetailsCopyWith<$Res> {
  _$StoryDetailsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? content = freezed,
    Object? subtitle = freezed,
    Object? image = null,
    Object? overline = freezed,
    Object? pages = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as Map<String, String>,
      content: freezed == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as Map<String, String>?,
      subtitle: freezed == subtitle
          ? _value.subtitle
          : subtitle // ignore: cast_nullable_to_non_nullable
              as Map<String, String>?,
      image: null == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as Attachement,
      overline: freezed == overline
          ? _value.overline
          : overline // ignore: cast_nullable_to_non_nullable
              as Map<String, String>?,
      pages: null == pages
          ? _value.pages
          : pages // ignore: cast_nullable_to_non_nullable
              as List<StoryPageModel>,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $AttachementCopyWith<$Res> get image {
    return $AttachementCopyWith<$Res>(_value.image, (value) {
      return _then(_value.copyWith(image: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_StoryDetailsCopyWith<$Res>
    implements $StoryDetailsCopyWith<$Res> {
  factory _$$_StoryDetailsCopyWith(
          _$_StoryDetails value, $Res Function(_$_StoryDetails) then) =
      __$$_StoryDetailsCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      Map<String, String> title,
      Map<String, String>? content,
      Map<String, String>? subtitle,
      Attachement image,
      Map<String, String>? overline,
      List<StoryPageModel> pages});

  @override
  $AttachementCopyWith<$Res> get image;
}

/// @nodoc
class __$$_StoryDetailsCopyWithImpl<$Res>
    extends _$StoryDetailsCopyWithImpl<$Res, _$_StoryDetails>
    implements _$$_StoryDetailsCopyWith<$Res> {
  __$$_StoryDetailsCopyWithImpl(
      _$_StoryDetails _value, $Res Function(_$_StoryDetails) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? content = freezed,
    Object? subtitle = freezed,
    Object? image = null,
    Object? overline = freezed,
    Object? pages = null,
  }) {
    return _then(_$_StoryDetails(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value._title
          : title // ignore: cast_nullable_to_non_nullable
              as Map<String, String>,
      content: freezed == content
          ? _value._content
          : content // ignore: cast_nullable_to_non_nullable
              as Map<String, String>?,
      subtitle: freezed == subtitle
          ? _value._subtitle
          : subtitle // ignore: cast_nullable_to_non_nullable
              as Map<String, String>?,
      image: null == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as Attachement,
      overline: freezed == overline
          ? _value._overline
          : overline // ignore: cast_nullable_to_non_nullable
              as Map<String, String>?,
      pages: null == pages
          ? _value._pages
          : pages // ignore: cast_nullable_to_non_nullable
              as List<StoryPageModel>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_StoryDetails with DiagnosticableTreeMixin implements _StoryDetails {
  _$_StoryDetails(
      {required this.id,
      required final Map<String, String> title,
      final Map<String, String>? content,
      final Map<String, String>? subtitle,
      required this.image,
      final Map<String, String>? overline,
      final List<StoryPageModel> pages = const []})
      : _title = title,
        _content = content,
        _subtitle = subtitle,
        _overline = overline,
        _pages = pages;

  factory _$_StoryDetails.fromJson(Map<String, dynamic> json) =>
      _$$_StoryDetailsFromJson(json);

  @override
  final String id;
  final Map<String, String> _title;
  @override
  Map<String, String> get title {
    if (_title is EqualUnmodifiableMapView) return _title;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_title);
  }

  final Map<String, String>? _content;
  @override
  Map<String, String>? get content {
    final value = _content;
    if (value == null) return null;
    if (_content is EqualUnmodifiableMapView) return _content;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  final Map<String, String>? _subtitle;
  @override
  Map<String, String>? get subtitle {
    final value = _subtitle;
    if (value == null) return null;
    if (_subtitle is EqualUnmodifiableMapView) return _subtitle;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  final Attachement image;
  final Map<String, String>? _overline;
  @override
  Map<String, String>? get overline {
    final value = _overline;
    if (value == null) return null;
    if (_overline is EqualUnmodifiableMapView) return _overline;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  final List<StoryPageModel> _pages;
  @override
  @JsonKey()
  List<StoryPageModel> get pages {
    if (_pages is EqualUnmodifiableListView) return _pages;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_pages);
  }

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'StoryDetails(id: $id, title: $title, content: $content, subtitle: $subtitle, image: $image, overline: $overline, pages: $pages)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'StoryDetails'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('title', title))
      ..add(DiagnosticsProperty('content', content))
      ..add(DiagnosticsProperty('subtitle', subtitle))
      ..add(DiagnosticsProperty('image', image))
      ..add(DiagnosticsProperty('overline', overline))
      ..add(DiagnosticsProperty('pages', pages));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_StoryDetails &&
            (identical(other.id, id) || other.id == id) &&
            const DeepCollectionEquality().equals(other._title, _title) &&
            const DeepCollectionEquality().equals(other._content, _content) &&
            const DeepCollectionEquality().equals(other._subtitle, _subtitle) &&
            (identical(other.image, image) || other.image == image) &&
            const DeepCollectionEquality().equals(other._overline, _overline) &&
            const DeepCollectionEquality().equals(other._pages, _pages));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      const DeepCollectionEquality().hash(_title),
      const DeepCollectionEquality().hash(_content),
      const DeepCollectionEquality().hash(_subtitle),
      image,
      const DeepCollectionEquality().hash(_overline),
      const DeepCollectionEquality().hash(_pages));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_StoryDetailsCopyWith<_$_StoryDetails> get copyWith =>
      __$$_StoryDetailsCopyWithImpl<_$_StoryDetails>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_StoryDetailsToJson(
      this,
    );
  }
}

abstract class _StoryDetails implements StoryDetails {
  factory _StoryDetails(
      {required final String id,
      required final Map<String, String> title,
      final Map<String, String>? content,
      final Map<String, String>? subtitle,
      required final Attachement image,
      final Map<String, String>? overline,
      final List<StoryPageModel> pages}) = _$_StoryDetails;

  factory _StoryDetails.fromJson(Map<String, dynamic> json) =
      _$_StoryDetails.fromJson;

  @override
  String get id;
  @override
  Map<String, String> get title;
  @override
  Map<String, String>? get content;
  @override
  Map<String, String>? get subtitle;
  @override
  Attachement get image;
  @override
  Map<String, String>? get overline;
  @override
  List<StoryPageModel> get pages;
  @override
  @JsonKey(ignore: true)
  _$$_StoryDetailsCopyWith<_$_StoryDetails> get copyWith =>
      throw _privateConstructorUsedError;
}

StoryPageModel _$StoryPageModelFromJson(Map<String, dynamic> json) {
  return _StoryPageModel.fromJson(json);
}

/// @nodoc
mixin _$StoryPageModel {
  Map<String, String> get title => throw _privateConstructorUsedError;
  Map<String, String>? get content => throw _privateConstructorUsedError;
  Map<String, String>? get subtitle => throw _privateConstructorUsedError;
  String get id => throw _privateConstructorUsedError;
  Attachement get image => throw _privateConstructorUsedError;
  Attachement? get illustration => throw _privateConstructorUsedError;
  List<String> get challenges => throw _privateConstructorUsedError;
  Map<String, String>? get overline => throw _privateConstructorUsedError;
  QuizModel? get quiz => throw _privateConstructorUsedError;
  int get order => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $StoryPageModelCopyWith<StoryPageModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StoryPageModelCopyWith<$Res> {
  factory $StoryPageModelCopyWith(
          StoryPageModel value, $Res Function(StoryPageModel) then) =
      _$StoryPageModelCopyWithImpl<$Res, StoryPageModel>;
  @useResult
  $Res call(
      {Map<String, String> title,
      Map<String, String>? content,
      Map<String, String>? subtitle,
      String id,
      Attachement image,
      Attachement? illustration,
      List<String> challenges,
      Map<String, String>? overline,
      QuizModel? quiz,
      int order});

  $AttachementCopyWith<$Res> get image;
  $AttachementCopyWith<$Res>? get illustration;
  $QuizModelCopyWith<$Res>? get quiz;
}

/// @nodoc
class _$StoryPageModelCopyWithImpl<$Res, $Val extends StoryPageModel>
    implements $StoryPageModelCopyWith<$Res> {
  _$StoryPageModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? content = freezed,
    Object? subtitle = freezed,
    Object? id = null,
    Object? image = null,
    Object? illustration = freezed,
    Object? challenges = null,
    Object? overline = freezed,
    Object? quiz = freezed,
    Object? order = null,
  }) {
    return _then(_value.copyWith(
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as Map<String, String>,
      content: freezed == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as Map<String, String>?,
      subtitle: freezed == subtitle
          ? _value.subtitle
          : subtitle // ignore: cast_nullable_to_non_nullable
              as Map<String, String>?,
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      image: null == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as Attachement,
      illustration: freezed == illustration
          ? _value.illustration
          : illustration // ignore: cast_nullable_to_non_nullable
              as Attachement?,
      challenges: null == challenges
          ? _value.challenges
          : challenges // ignore: cast_nullable_to_non_nullable
              as List<String>,
      overline: freezed == overline
          ? _value.overline
          : overline // ignore: cast_nullable_to_non_nullable
              as Map<String, String>?,
      quiz: freezed == quiz
          ? _value.quiz
          : quiz // ignore: cast_nullable_to_non_nullable
              as QuizModel?,
      order: null == order
          ? _value.order
          : order // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $AttachementCopyWith<$Res> get image {
    return $AttachementCopyWith<$Res>(_value.image, (value) {
      return _then(_value.copyWith(image: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $AttachementCopyWith<$Res>? get illustration {
    if (_value.illustration == null) {
      return null;
    }

    return $AttachementCopyWith<$Res>(_value.illustration!, (value) {
      return _then(_value.copyWith(illustration: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $QuizModelCopyWith<$Res>? get quiz {
    if (_value.quiz == null) {
      return null;
    }

    return $QuizModelCopyWith<$Res>(_value.quiz!, (value) {
      return _then(_value.copyWith(quiz: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_StoryPageModelCopyWith<$Res>
    implements $StoryPageModelCopyWith<$Res> {
  factory _$$_StoryPageModelCopyWith(
          _$_StoryPageModel value, $Res Function(_$_StoryPageModel) then) =
      __$$_StoryPageModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {Map<String, String> title,
      Map<String, String>? content,
      Map<String, String>? subtitle,
      String id,
      Attachement image,
      Attachement? illustration,
      List<String> challenges,
      Map<String, String>? overline,
      QuizModel? quiz,
      int order});

  @override
  $AttachementCopyWith<$Res> get image;
  @override
  $AttachementCopyWith<$Res>? get illustration;
  @override
  $QuizModelCopyWith<$Res>? get quiz;
}

/// @nodoc
class __$$_StoryPageModelCopyWithImpl<$Res>
    extends _$StoryPageModelCopyWithImpl<$Res, _$_StoryPageModel>
    implements _$$_StoryPageModelCopyWith<$Res> {
  __$$_StoryPageModelCopyWithImpl(
      _$_StoryPageModel _value, $Res Function(_$_StoryPageModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? content = freezed,
    Object? subtitle = freezed,
    Object? id = null,
    Object? image = null,
    Object? illustration = freezed,
    Object? challenges = null,
    Object? overline = freezed,
    Object? quiz = freezed,
    Object? order = null,
  }) {
    return _then(_$_StoryPageModel(
      title: null == title
          ? _value._title
          : title // ignore: cast_nullable_to_non_nullable
              as Map<String, String>,
      content: freezed == content
          ? _value._content
          : content // ignore: cast_nullable_to_non_nullable
              as Map<String, String>?,
      subtitle: freezed == subtitle
          ? _value._subtitle
          : subtitle // ignore: cast_nullable_to_non_nullable
              as Map<String, String>?,
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      image: null == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as Attachement,
      illustration: freezed == illustration
          ? _value.illustration
          : illustration // ignore: cast_nullable_to_non_nullable
              as Attachement?,
      challenges: null == challenges
          ? _value._challenges
          : challenges // ignore: cast_nullable_to_non_nullable
              as List<String>,
      overline: freezed == overline
          ? _value._overline
          : overline // ignore: cast_nullable_to_non_nullable
              as Map<String, String>?,
      quiz: freezed == quiz
          ? _value.quiz
          : quiz // ignore: cast_nullable_to_non_nullable
              as QuizModel?,
      order: null == order
          ? _value.order
          : order // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_StoryPageModel
    with DiagnosticableTreeMixin
    implements _StoryPageModel {
  _$_StoryPageModel(
      {required final Map<String, String> title,
      final Map<String, String>? content,
      final Map<String, String>? subtitle,
      required this.id,
      required this.image,
      this.illustration,
      final List<String> challenges = const [],
      final Map<String, String>? overline,
      this.quiz,
      this.order = 1000})
      : _title = title,
        _content = content,
        _subtitle = subtitle,
        _challenges = challenges,
        _overline = overline;

  factory _$_StoryPageModel.fromJson(Map<String, dynamic> json) =>
      _$$_StoryPageModelFromJson(json);

  final Map<String, String> _title;
  @override
  Map<String, String> get title {
    if (_title is EqualUnmodifiableMapView) return _title;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_title);
  }

  final Map<String, String>? _content;
  @override
  Map<String, String>? get content {
    final value = _content;
    if (value == null) return null;
    if (_content is EqualUnmodifiableMapView) return _content;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  final Map<String, String>? _subtitle;
  @override
  Map<String, String>? get subtitle {
    final value = _subtitle;
    if (value == null) return null;
    if (_subtitle is EqualUnmodifiableMapView) return _subtitle;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  final String id;
  @override
  final Attachement image;
  @override
  final Attachement? illustration;
  final List<String> _challenges;
  @override
  @JsonKey()
  List<String> get challenges {
    if (_challenges is EqualUnmodifiableListView) return _challenges;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_challenges);
  }

  final Map<String, String>? _overline;
  @override
  Map<String, String>? get overline {
    final value = _overline;
    if (value == null) return null;
    if (_overline is EqualUnmodifiableMapView) return _overline;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  final QuizModel? quiz;
  @override
  @JsonKey()
  final int order;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'StoryPageModel(title: $title, content: $content, subtitle: $subtitle, id: $id, image: $image, illustration: $illustration, challenges: $challenges, overline: $overline, quiz: $quiz, order: $order)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'StoryPageModel'))
      ..add(DiagnosticsProperty('title', title))
      ..add(DiagnosticsProperty('content', content))
      ..add(DiagnosticsProperty('subtitle', subtitle))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('image', image))
      ..add(DiagnosticsProperty('illustration', illustration))
      ..add(DiagnosticsProperty('challenges', challenges))
      ..add(DiagnosticsProperty('overline', overline))
      ..add(DiagnosticsProperty('quiz', quiz))
      ..add(DiagnosticsProperty('order', order));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_StoryPageModel &&
            const DeepCollectionEquality().equals(other._title, _title) &&
            const DeepCollectionEquality().equals(other._content, _content) &&
            const DeepCollectionEquality().equals(other._subtitle, _subtitle) &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.image, image) || other.image == image) &&
            (identical(other.illustration, illustration) ||
                other.illustration == illustration) &&
            const DeepCollectionEquality()
                .equals(other._challenges, _challenges) &&
            const DeepCollectionEquality().equals(other._overline, _overline) &&
            (identical(other.quiz, quiz) || other.quiz == quiz) &&
            (identical(other.order, order) || other.order == order));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_title),
      const DeepCollectionEquality().hash(_content),
      const DeepCollectionEquality().hash(_subtitle),
      id,
      image,
      illustration,
      const DeepCollectionEquality().hash(_challenges),
      const DeepCollectionEquality().hash(_overline),
      quiz,
      order);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_StoryPageModelCopyWith<_$_StoryPageModel> get copyWith =>
      __$$_StoryPageModelCopyWithImpl<_$_StoryPageModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_StoryPageModelToJson(
      this,
    );
  }
}

abstract class _StoryPageModel implements StoryPageModel {
  factory _StoryPageModel(
      {required final Map<String, String> title,
      final Map<String, String>? content,
      final Map<String, String>? subtitle,
      required final String id,
      required final Attachement image,
      final Attachement? illustration,
      final List<String> challenges,
      final Map<String, String>? overline,
      final QuizModel? quiz,
      final int order}) = _$_StoryPageModel;

  factory _StoryPageModel.fromJson(Map<String, dynamic> json) =
      _$_StoryPageModel.fromJson;

  @override
  Map<String, String> get title;
  @override
  Map<String, String>? get content;
  @override
  Map<String, String>? get subtitle;
  @override
  String get id;
  @override
  Attachement get image;
  @override
  Attachement? get illustration;
  @override
  List<String> get challenges;
  @override
  Map<String, String>? get overline;
  @override
  QuizModel? get quiz;
  @override
  int get order;
  @override
  @JsonKey(ignore: true)
  _$$_StoryPageModelCopyWith<_$_StoryPageModel> get copyWith =>
      throw _privateConstructorUsedError;
}
