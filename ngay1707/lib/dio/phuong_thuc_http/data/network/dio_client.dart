import 'package:dio/dio.dart';
import 'package:ngay1707/dio/interceptors/auth_interceptor.dart';
import 'package:ngay1707/dio/interceptors/token_interceptor.dart';

class DioClient {
  static final _instance = DioClient._internal();
  factory DioClient() => _instance;
  late final Dio dio;

  DioClient._internal() {
    dio = Dio(
      BaseOptions(
        baseUrl: 'https://api.example.com/v1',
        connectTimeout: Duration(seconds: 5),
        receiveTimeout: Duration(seconds: 30),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json'
        }
      )
    );

    dio.interceptors.add(AuthInterceptor());

    dio.interceptors.add(TokenInterceptor(dio));

    dio.interceptors.add(LogInterceptor(
      request: true,
      requestHeader: true,
      requestBody: true,
      responseHeader: true,
      responseBody: true
    ));
  }
}