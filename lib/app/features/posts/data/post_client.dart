import 'package:black_tax_and_white_benefits/app/features/posts/domain/post.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';
import 'package:retrofit/retrofit.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'post_client.g.dart';

@RestApi(baseUrl: 'https://blacktaxandwhitebenefits.com/wp-json/wp/v2/')
abstract class PostClient {
  factory PostClient(Dio dio, {String baseUrl}) = _PostClient;

  @GET('/posts?_embed=true')
  Future<List<Post>> getPosts(
    @Query('per_page') int n,
  );
}

// coverage:ignore-start
@riverpod
FutureOr<List<Post>> getPosts(GetPostsRef ref) async {
  final dio = Dio();
  final client = PostClient(dio);

  final posts = await client.getPosts(100);
  return posts;
}
// coverage:ignore-end
