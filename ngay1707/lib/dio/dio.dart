// 3. Khởi tạo Dio Instance
// 3.1. Cách tạo instance cơ bản

import 'package:dio/dio.dart';

// Cach 1: Khoi tao truc tiep
final Dio dio1 = Dio();

// Cach 2: Khoi tao voi BaseOptions
final Dio dio2 = Dio(
  BaseOptions(
    baseUrl: 'https://api.example.com/v1',
    connectTimeout: Duration(seconds: 5),
    receiveTimeout: Duration(seconds: 30),
    headers: {
      'Content-Type': 'application/json',
      'User-Agent': 'Flutter-Dio-Client',
    },
    responseType: ResponseType.json
  )
);

// 3.2. Sử dụng Singleton Pattern
// Trong dự án thực tế, nên sử dụng 1 instance Dio duy nhất để dễ dàng quản lý cấu hình global:
// lib/network/dio_client.dart
class DioClient {
  // static final DioClient _instance: Tạo ra một thực thể tĩnh, duy nhất của lớp.
  static final _instance = DioClient._internal();
  // Constructor đặc biệt. Khi gọi DioClient(), nó sẽ luôn trả về cùng một đối tượng _instance đã tạo trước đó, thay vì tạo mới.
  factory DioClient() => _instance;

  late final dio;

  // constructor ẩn (private) dùng để khởi tạo cấu hình cho Dio chỉ một lần duy nhất.
  DioClient._internal() {
    dio = Dio(
      BaseOptions(
        baseUrl: 'https://api/example.com/v1',
        connectTimeout: Duration(seconds: 10),
        receiveTimeout: Duration(seconds: 30),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json'
        }
      )
    );

    // them interceptors
    // LogInterceptor: Đây là một trình chặn (interceptor) được tích hợp sẵn trong Dio.
    // Nó tự động in ra màn hình console mọi thông tin về request (địa chỉ, headers, body)
    // và response (trạng thái, dữ liệu trả về).
    dio.interceptors.add(LogInterceptor(
      request: true,
      requestHeader: true,
      requestBody: true,
      responseHeader: true,
      responseBody: true
    ));
  }
}