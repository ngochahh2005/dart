import 'package:dio/dio.dart';
import 'package:ngay1707/dio/phuong_thuc_http/services/auth_service.dart';

class TokenInterceptor extends Interceptor {
  final Dio dio; // truyen instance cua Dio vao de dung cho refresh token
  final AuthService _authService = AuthService();

  TokenInterceptor(this.dio);

  static const String _accessTokenKey = 'access_token';
  static const String _refreshTokenKey = 'refresh_token';

  @override
  void onRequest(RequestOptions options,
      RequestInterceptorHandler handler) async {
    // lay token tu storage
    final accessToken = await _authService.getAccessToken();
    if (accessToken != null) {
      options.headers['Authorization'] = 'Bearer $accessToken';
    }
    super.onRequest(options, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    // neu loi 401 - token het han
    if (err.response?.statusCode == 401) {
      try {
        // lay refresh token
        final refreshToken = await _authService.getRefreshToken();
        if (refreshToken != null) {
          // goi refreshToken bang 1 instance Dio khac de tranh lap vo tan
          final refreshDio = Dio(
              BaseOptions(baseUrl: 'https://api.example.com/v1')
          );
          final resp = await refreshDio.post('/auth/refresh', data: {
            'refresh_token': refreshToken
          });

          final newAccessToken = resp.data[_accessTokenKey];
          final newRefreshToken = resp.data[_refreshTokenKey];

          await _authService.saveTokens(newAccessToken, newRefreshToken);

          // retry lai requet cu
          final opts = err.requestOptions;
          opts.headers['Authorization'] = 'Bearer $newAccessToken}';
          final retryResp = await dio.fetch(opts);

          return handler.resolve(retryResp);
        }
      } catch (e) {
        await _authService.clearTokens();
        // co the kick hoat event bus/dung navigatorKey
        // de dieu huong nguoi dung ve man hinh login
      }
    }
    super.onError(err, handler);
  }
}