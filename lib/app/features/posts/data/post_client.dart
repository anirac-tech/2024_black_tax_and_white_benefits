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

  @GET('/posts?_embed=true&per_page=10')
  Future<HttpResponse<List<Post>>> getPosts(
    @Query('page') int page,
    @CancelRequest() CancelToken cancelToken,
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
FutureOr<PostResponse> getPosts(GetPostsRef ref, PostQueryData postQueryData) async {
  final client = ref.watch(postClientProvider);

  final cancelToken = CancelToken();
  // When a page is no-longer used, keep it in the cache.
  final link = ref.keepAlive();
  // a timer to be used by the callbacks below
  Timer? timer;
  // When the provider is destroyed, cancel the http request and the timer
  ref.onDispose(() {
    cancelToken.cancel();
    timer?.cancel();
  });
  // When the last listener is removed, start a timer to dispose the cached data
  ref.onCancel(() {
    // start a timer
    timer = Timer(const Duration(minutes: 2), () {
      // dispose on timeout
      link.close();
    });
  });
  // If the provider is listened again after it was paused, cancel the timer
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
