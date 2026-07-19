// lib/network/interceptors/auth_interceptor.dart
import 'package:dio/dio.dart';
import 'package:ngay1707/dio/phuong_thuc_http/services/auth_service.dart';

class AuthInterceptor extends Interceptor {
  final AuthService _authService = AuthService();

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    //them token vao header truoc khi gui request
    options.headers['Authorization'] = 'Bearer ${_authService.getAccessToken()}';
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    // xu ly response truoc khi tra ve
    print('Response status: ${response.statusCode}');
    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    // xu ly loi global
    print('Error: ${err.message}');
    super.onError(err, handler);
  }
}