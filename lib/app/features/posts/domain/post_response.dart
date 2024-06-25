import 'package:black_tax_and_white_benefits/app/features/posts/domain/post.dart';
import 'package:retrofit/retrofit.dart';

class PostResponse {
  const PostResponse({
    required this.posts,
    required this.totalPages,
    required this.totalResults,
  });

  final List<Post> posts;
  final int totalPages;
  final int totalResults;

  factory PostResponse.fromHttpResponse(HttpResponse<List<Post>> http) {
    final totalPages = int.parse(http.response.headers.value('X-WP-TotalPages')!);
    final totalResults = int.parse(http.response.headers.value('X-WP-Total')!);
    return PostResponse(totalPages: totalPages, totalResults: totalResults, posts: http.data);
  }
}
