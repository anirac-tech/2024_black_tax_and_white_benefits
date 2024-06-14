import 'package:dio/dio.dart';

import 'test_data.dart';

// to be used later
class FakeDio implements Dio {
  FakeDio();

  @override
  Future<Response<T>> get<T>(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    switch (path) {
      case 'https://blacktaxandwhitebenefits.com/wp-json/wp/v2/posts?_embed=true&per_page=100':
        return FakeResponse(postData) as Response<T>;
      default:
        break;
    }
    throw UnimplementedError();
  }

  @override
  void noSuchMethod(Invocation invocation) {
    throw UnimplementedError();
  }
}

class FakeResponse implements Response<List<Map<String, Object?>>> {
  FakeResponse(this.data);

  @override
  final List<Map<String, Object?>> data;

  @override
  void noSuchMethod(Invocation invocation) {
    throw UnimplementedError();
  }
}
