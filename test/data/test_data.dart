import 'package:black_tax_and_white_benefits/app/features/posts/domain/post.dart';
import 'package:black_tax_and_white_benefits/app/features/posts/domain/post_response.dart';
import 'package:black_tax_and_white_benefits/app/features/posts/view/posts_view.dart';
import 'package:dio/dio.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:retrofit/retrofit.dart' as rf;

part 'test_data.g.dart';

@JsonLiteral('post_data.json')
List<Map<String, Object?>> get postData => _$postDataJsonLiteral;

List<Post> get mockPosts => postData
    .map(
      (e) => Post.fromJson(e),
    )
    .toList();

rf.HttpResponse<List<Post>> get mockHttpResponse {
  final headers = Headers();
  headers.add('X-WP-TotalPages', '${mockPosts.length ~/ PostsView.pageSize + 1}');
  headers.add('X-WP-Total', '${mockPosts.length}');
  return rf.HttpResponse(
    mockPosts,
    Response<dynamic>(requestOptions: RequestOptions(), headers: headers),
  );
}

PostResponse get mockPostResponse => PostResponse(
    posts: mockPosts,
    totalPages: mockPosts.length ~/ PostsView.pageSize + 1,
    totalResults: mockPosts.length);
