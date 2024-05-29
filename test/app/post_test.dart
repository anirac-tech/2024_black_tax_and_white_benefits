import 'package:black_tax_and_white_benefits/app/domain/post.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Test Post fromJson', () {
    test('Decode Json', () {
      final json = <String, Object?>{
        'id': 1,
        'title': <String, Object?>{
          'rendered': 'Tax',
        },
      };

      final value = Post.fromJson(json);

      expect(value, const Post(id: 1, title: Renderable(rendered: 'Tax')));
    });
  });
}
