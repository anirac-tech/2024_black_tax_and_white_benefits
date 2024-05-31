// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PostImpl _$$PostImplFromJson(Map<String, dynamic> json) => _$PostImpl(
      id: (json['id'] as num).toInt(),
      title: Renderable.fromJson(json['title'] as Map<String, dynamic>),
      content: json['content'] == null
          ? null
          : Renderable.fromJson(json['content'] as Map<String, dynamic>),
      excerpt: json['excerpt'] == null
          ? null
          : Renderable.fromJson(json['excerpt'] as Map<String, dynamic>),
      date: json['date'] as String?,
      link: json['link'] as String?,
    );

Map<String, dynamic> _$$PostImplToJson(_$PostImpl instance) {
  final val = <String, dynamic>{
    'id': instance.id,
    'title': instance.title.toJson(),
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('content', instance.content?.toJson());
  writeNotNull('excerpt', instance.excerpt?.toJson());
  writeNotNull('date', instance.date);
  writeNotNull('link', instance.link);
  return val;
}

_$RenderableImpl _$$RenderableImplFromJson(Map<String, dynamic> json) => _$RenderableImpl(
      rendered: json['rendered'] as String,
    );

Map<String, dynamic> _$$RenderableImplToJson(_$RenderableImpl instance) => <String, dynamic>{
      'rendered': instance.rendered,
    };
