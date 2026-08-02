import 'package:dio/dio.dart';
import 'package:recipeify/core/constants/api_constants.dart';

class DioClient {
  DioClient._internal();

  static final _instance = DioClient._internal();

  factory DioClient() => _instance;

  late final Dio dio;

  DioClient init() {
    dio = Dio(
      BaseOptions(
        baseUrl: ApiConstants.baseUrl,
        connectTimeout: ApiConstants.connectTimeout,
        receiveTimeout: ApiConstants.receiveTimeout,
        headers: {
          'Content-Type': 'application/json'
        }
      )
    );

    return this;
  }
}
