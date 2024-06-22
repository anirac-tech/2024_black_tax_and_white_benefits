// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_client.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps,no_leading_underscores_for_local_identifiers

class _PostClient implements PostClient {
  _PostClient(
    this._dio, {
    this.baseUrl,
  }) {
    baseUrl ??= 'https://blacktaxandwhitebenefits.com/wp-json/wp/v2/';
  }

  final Dio _dio;

  String? baseUrl;

  @override
  Future<List<Post>> getPosts(int n) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'per_page': n};
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _result = await _dio.fetch<List<dynamic>>(_setStreamType<List<Post>>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
        .compose(
          _dio.options,
          '/posts?_embed=true',
          queryParameters: queryParameters,
          data: _data,
        )
        .copyWith(
            baseUrl: _combineBaseUrls(
          _dio.options.baseUrl,
          baseUrl,
        ))));
    var value = _result.data!.map((dynamic i) => Post.fromJson(i as Map<String, dynamic>)).toList();
    return value;
  }

  RequestOptions _setStreamType<T>(RequestOptions requestOptions) {
    if (T != dynamic &&
        !(requestOptions.responseType == ResponseType.bytes ||
            requestOptions.responseType == ResponseType.stream)) {
      if (T == String) {
        requestOptions.responseType = ResponseType.plain;
      } else {
        requestOptions.responseType = ResponseType.json;
      }
    }
    return requestOptions;
  }

  String _combineBaseUrls(
    String dioBaseUrl,
    String? baseUrl,
  ) {
    if (baseUrl == null || baseUrl.trim().isEmpty) {
      return dioBaseUrl;
    }

    final url = Uri.parse(baseUrl);

    if (url.isAbsolute) {
      return url.toString();
    }

    return Uri.parse(dioBaseUrl).resolveUri(url).toString();
  }
}

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$postClientHash() => r'1cb22ed93a34b0ff4fa5151e3f4e92cadde3e846';

/// See also [postClient].
@ProviderFor(postClient)
final postClientProvider = AutoDisposeProvider<PostClient>.internal(
  postClient,
  name: r'postClientProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product') ? null : _$postClientHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef PostClientRef = AutoDisposeProviderRef<PostClient>;
String _$getPostsHash() => r'7bf5779563164308b87f3095d82296678086f475';

/// See also [getPosts].
@ProviderFor(getPosts)
final getPostsProvider = AutoDisposeFutureProvider<List<Post>>.internal(
  getPosts,
  name: r'getPostsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product') ? null : _$getPostsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef GetPostsRef = AutoDisposeFutureProviderRef<List<Post>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, inference_failure_on_uninitialized_variable, inference_failure_on_function_return_type, inference_failure_on_untyped_parameter, deprecated_member_use_from_same_package
