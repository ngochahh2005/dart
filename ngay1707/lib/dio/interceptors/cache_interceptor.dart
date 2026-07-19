import 'package:dio/dio.dart';

class CacheInterceptor extends Interceptor {
  final Map<String, Response> _cache = {};
  final Duration cacheDuration;

  CacheInterceptor({this.cacheDuration = const Duration(minutes: 5)});

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final cacheKey = options.uri.toString();
    if (_cache.containsKey(cacheKey)) {
      final cacheResp = _cache[cacheKey]!;
      final age = DateTime.now().difference(cacheResp.extra['timestamp']);

      if (age < cacheDuration) {
        // tra ve cached response
        handler.resolve(cacheResp);
        return;
      }

      super.onRequest(options, handler);
    }
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    final cacheKey = response.requestOptions.uri.toString();
    response.extra['timestamp'] = DateTime.now();
    _cache[cacheKey] = response;
    super.onResponse(response, handler);
  }
}