// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'post.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Post _$PostFromJson(Map<String, dynamic> json) {
  return _Post.fromJson(json);
}

/// @nodoc
mixin _$Post {
  int get id => throw _privateConstructorUsedError;
  Renderable get title => throw _privateConstructorUsedError;
  Renderable? get content => throw _privateConstructorUsedError;
  Renderable? get excerpt => throw _privateConstructorUsedError;
  String? get date => throw _privateConstructorUsedError;
  String? get link => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PostCopyWith<Post> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PostCopyWith<$Res> {
  factory $PostCopyWith(Post value, $Res Function(Post) then) = _$PostCopyWithImpl<$Res, Post>;
  @useResult
  $Res call(
      {int id,
      Renderable title,
      Renderable? content,
      Renderable? excerpt,
      String? date,
      String? link});

  $RenderableCopyWith<$Res> get title;
  $RenderableCopyWith<$Res>? get content;
  $RenderableCopyWith<$Res>? get excerpt;
}

/// @nodoc
class _$PostCopyWithImpl<$Res, $Val extends Post> implements $PostCopyWith<$Res> {
  _$PostCopyWithImpl(this._value, this._then);

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
    Object? excerpt = freezed,
    Object? date = freezed,
    Object? link = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as Renderable,
      content: freezed == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as Renderable?,
      excerpt: freezed == excerpt
          ? _value.excerpt
          : excerpt // ignore: cast_nullable_to_non_nullable
              as Renderable?,
      date: freezed == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as String?,
      link: freezed == link
          ? _value.link
          : link // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $RenderableCopyWith<$Res> get title {
    return $RenderableCopyWith<$Res>(_value.title, (value) {
      return _then(_value.copyWith(title: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $RenderableCopyWith<$Res>? get content {
    if (_value.content == null) {
      return null;
    }

    return $RenderableCopyWith<$Res>(_value.content!, (value) {
      return _then(_value.copyWith(content: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $RenderableCopyWith<$Res>? get excerpt {
    if (_value.excerpt == null) {
      return null;
    }

    return $RenderableCopyWith<$Res>(_value.excerpt!, (value) {
      return _then(_value.copyWith(excerpt: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$PostImplCopyWith<$Res> implements $PostCopyWith<$Res> {
  factory _$$PostImplCopyWith(_$PostImpl value, $Res Function(_$PostImpl) then) =
      __$$PostImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      Renderable title,
      Renderable? content,
      Renderable? excerpt,
      String? date,
      String? link});

  @override
  $RenderableCopyWith<$Res> get title;
  @override
  $RenderableCopyWith<$Res>? get content;
  @override
  $RenderableCopyWith<$Res>? get excerpt;
}

/// @nodoc
class __$$PostImplCopyWithImpl<$Res> extends _$PostCopyWithImpl<$Res, _$PostImpl>
    implements _$$PostImplCopyWith<$Res> {
  __$$PostImplCopyWithImpl(_$PostImpl _value, $Res Function(_$PostImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? content = freezed,
    Object? excerpt = freezed,
    Object? date = freezed,
    Object? link = freezed,
  }) {
    return _then(_$PostImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as Renderable,
      content: freezed == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as Renderable?,
      excerpt: freezed == excerpt
          ? _value.excerpt
          : excerpt // ignore: cast_nullable_to_non_nullable
              as Renderable?,
      date: freezed == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as String?,
      link: freezed == link
          ? _value.link
          : link // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PostImpl implements _Post {
  const _$PostImpl(
      {required this.id, required this.title, this.content, this.excerpt, this.date, this.link});

  factory _$PostImpl.fromJson(Map<String, dynamic> json) => _$$PostImplFromJson(json);

  @override
  final int id;
  @override
  final Renderable title;
  @override
  final Renderable? content;
  @override
  final Renderable? excerpt;
  @override
  final String? date;
  @override
  final String? link;

  @override
  String toString() {
    return 'Post(id: $id, title: $title, content: $content, excerpt: $excerpt, date: $date, link: $link)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PostImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.content, content) || other.content == content) &&
            (identical(other.excerpt, excerpt) || other.excerpt == excerpt) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.link, link) || other.link == link));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, title, content, excerpt, date, link);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PostImplCopyWith<_$PostImpl> get copyWith =>
      __$$PostImplCopyWithImpl<_$PostImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PostImplToJson(
      this,
    );
  }
}

abstract class _Post implements Post {
  const factory _Post(
      {required final int id,
      required final Renderable title,
      final Renderable? content,
      final Renderable? excerpt,
      final String? date,
      final String? link}) = _$PostImpl;

  factory _Post.fromJson(Map<String, dynamic> json) = _$PostImpl.fromJson;

  @override
  int get id;
  @override
  Renderable get title;
  @override
  Renderable? get content;
  @override
  Renderable? get excerpt;
  @override
  String? get date;
  @override
  String? get link;
  @override
  @JsonKey(ignore: true)
  _$$PostImplCopyWith<_$PostImpl> get copyWith => throw _privateConstructorUsedError;
}

Renderable _$RenderableFromJson(Map<String, dynamic> json) {
  return _Renderable.fromJson(json);
}

/// @nodoc
mixin _$Renderable {
  String get rendered => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $RenderableCopyWith<Renderable> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RenderableCopyWith<$Res> {
  factory $RenderableCopyWith(Renderable value, $Res Function(Renderable) then) =
      _$RenderableCopyWithImpl<$Res, Renderable>;
  @useResult
  $Res call({String rendered});
}

/// @nodoc
class _$RenderableCopyWithImpl<$Res, $Val extends Renderable> implements $RenderableCopyWith<$Res> {
  _$RenderableCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? rendered = null,
  }) {
    return _then(_value.copyWith(
      rendered: null == rendered
          ? _value.rendered
          : rendered // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$RenderableImplCopyWith<$Res> implements $RenderableCopyWith<$Res> {
  factory _$$RenderableImplCopyWith(_$RenderableImpl value, $Res Function(_$RenderableImpl) then) =
      __$$RenderableImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String rendered});
}

/// @nodoc
class __$$RenderableImplCopyWithImpl<$Res> extends _$RenderableCopyWithImpl<$Res, _$RenderableImpl>
    implements _$$RenderableImplCopyWith<$Res> {
  __$$RenderableImplCopyWithImpl(_$RenderableImpl _value, $Res Function(_$RenderableImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? rendered = null,
  }) {
    return _then(_$RenderableImpl(
      rendered: null == rendered
          ? _value.rendered
          : rendered // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$RenderableImpl implements _Renderable {
  const _$RenderableImpl({required this.rendered});

  factory _$RenderableImpl.fromJson(Map<String, dynamic> json) => _$$RenderableImplFromJson(json);

  @override
  final String rendered;

  @override
  String toString() {
    return 'Renderable(rendered: $rendered)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RenderableImpl &&
            (identical(other.rendered, rendered) || other.rendered == rendered));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, rendered);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$RenderableImplCopyWith<_$RenderableImpl> get copyWith =>
      __$$RenderableImplCopyWithImpl<_$RenderableImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$RenderableImplToJson(
      this,
    );
  }
}

abstract class _Renderable implements Renderable {
  const factory _Renderable({required final String rendered}) = _$RenderableImpl;

  factory _Renderable.fromJson(Map<String, dynamic> json) = _$RenderableImpl.fromJson;

  @override
  String get rendered;
  @override
  @JsonKey(ignore: true)
  _$$RenderableImplCopyWith<_$RenderableImpl> get copyWith => throw _privateConstructorUsedError;
}
