import 'package:json_annotation/json_annotation.dart';

part 'test_data.g.dart';

@JsonLiteral('post_data.json')
List<Map<String, Object?>> get postData => _$postDataJsonLiteral;
