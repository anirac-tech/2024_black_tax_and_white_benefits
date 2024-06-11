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

//coverage:ignore-start
@riverpod
PostClient postClient(PostClientRef _) {
  final dio = Dio();
  return PostClient(dio);
}
//coverage:ignore-end

@riverpod
FutureOr<List<Post>> getPosts(GetPostsRef ref) async {
  final client = ref.watch(postClientProvider);
  return client.getPosts(100);
}
