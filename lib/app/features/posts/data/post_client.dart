import 'dart:async';

import 'package:black_tax_and_white_benefits/app/features/posts/domain/post.dart';
import 'package:black_tax_and_white_benefits/app/features/posts/domain/post_response.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'post_client.g.dart';

typedef PostQueryData = ({int page});

@RestApi(baseUrl: 'https://blacktaxandwhitebenefits.com/wp-json/wp/v2/')
abstract class PostClient {
  factory PostClient(Dio dio, {String baseUrl}) = _PostClient;

  static const postTimeout = Duration(minutes: 2);

  @GET('/posts')
  Future<HttpResponse<List<Post>>> getPosts(
    @Query('page') int page,
    @CancelRequest() CancelToken cancelToken, {
    @Query('per_page') int perPage = 10,
    @Query('_embed') bool embed = true,
    @Query('orderby') String orderBy = 'date',
    @Query('order') String order = 'desc',
  });
}

//coverage:ignore-start
@riverpod
PostClient postClient(PostClientRef _) {
  final dio = Dio();
  return PostClient(dio);
}
//coverage:ignore-end

@riverpod
FutureOr<PostResponse> getPosts(GetPostsRef ref, PostQueryData postQueryData) async {
  final client = ref.watch(postClientProvider);

  final cancelToken = CancelToken();
  final link = ref.keepAlive();

  Timer? timer;

  ref.onDispose(() {
    cancelToken.cancel();
    timer?.cancel();
  });
  ref.onCancel(() {
    timer = Timer(PostClient.postTimeout, () {
      // coverage:ignore-start
      link.close();
      // coverage:ignore-end
    });
  });
  ref.onResume(() {
    timer?.cancel();
  });

  return PostResponse.fromHttpResponse(
    await client.getPosts(
      postQueryData.page,
      cancelToken,
    ),
  );
}
