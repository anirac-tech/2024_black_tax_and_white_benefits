import 'package:black_tax_and_white_benefits/app/features/posts/domain/post.dart';
import 'package:json_annotation/json_annotation.dart';

part 'test_data.g.dart';

@JsonLiteral('post_data.json')
List<Map<String, Object?>> get postData => _$postDataJsonLiteral;
List<Post> get mockPosts => postData
    .map(
      (e) => Post.fromJson(e),
    )
    .toList();
