import 'package:drift/drift.dart' as drift;
import 'package:freezed_annotation/freezed_annotation.dart';

part 'post.freezed.dart';
part 'post.g.dart';

@freezed
class Post with _$Post {
  const factory Post({
    required int id,
    required Renderable title,
    Renderable? content,
    Renderable? excerpt,
    String? date,
    String? imageUrl,
  }) = _Post;

  factory Post.fromJson(Map<String, Object?> json) => _$PostFromJson(json);

  static drift.TypeConverter<Post, String> converter = drift.TypeConverter.json(
    fromJson: (json) => Post.fromJson(json as Map<String, Object?>),
    toJson: (pref) => pref.toJson(),
  );
}

@freezed
class Renderable with _$Renderable {
  const factory Renderable({
    required String rendered,
  }) = _Renderable;

  factory Renderable.fromJson(Map<String, Object?> json) => _$RenderableFromJson(json);
}
