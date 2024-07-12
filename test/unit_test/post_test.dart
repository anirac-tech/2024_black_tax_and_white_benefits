import 'package:black_tax_and_white_benefits/app/features/posts/domain/post.dart';
import 'package:flutter_test/flutter_test.dart';

import '../data/test_data.dart';

void main() {
  group('Test Post methods', () {
    testWidgets('converter', (tester) async {
      final post = mockPosts.first;
      final String sql = Post.converter.toSql(post);

      print(sql);
      expect(Post.converter.fromSql(sql), post);
    });
  });
}
