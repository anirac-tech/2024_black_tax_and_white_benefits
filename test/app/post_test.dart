import 'package:black_tax_and_white_benefits/app/features/posts/domain/post.dart';
import 'package:flutter_test/flutter_test.dart';

import '../data/test_data.dart';

void main() {
  group('Test Post Json Serialization', () {
    test('fromJson', () {
      final value = Post.fromJson(postData.first);

      expect(
        value,
        const Post(
          id: 1,
          title: Renderable(
            rendered: 'Black Tax',
          ),
          content: Renderable(
            rendered: 'In my last blog article, I described God’s obvious love of great variety',
          ),
          excerpt: Renderable(
            rendered: 'In my last blog article, I described[...]',
          ),
        ),
      );
    });
  });
}
