import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:ngay1707/dio/exception/error_handler.dart';

class AuthService {
  final _secureStorage = const FlutterSecureStorage();

  static final _instance = AuthService._internal();
  factory AuthService() => _instance;
  AuthService._internal();

  static const String _accessTokenKey = 'access_token';
  static const String _refreshTokenKey = 'refresh_token';

  Future<void> saveTokens(String accessToken, String refeshToken) async {
    await _secureStorage.write(key: _accessTokenKey, value: accessToken);
    await _secureStorage.write(key: _refreshTokenKey, value: refeshToken);
  }

  Future<String?> getAccessToken() => _secureStorage.read(key: _accessTokenKey);
  Future<String?> getRefreshToken() => _secureStorage.read(key: _refreshTokenKey);

  Future<void> clearTokens() async {
    await _secureStorage.delete(key: _accessTokenKey);
    await _secureStorage.delete(key: _refreshTokenKey);
  }

  // Xử lý lỗi trong business logic
  Future<T> safeApiCall<T>(Future<T> Function() apiCall) async {
    try {
      return await apiCall();
    } on DioException catch (e) {
      final errorMsg = NetworkError.handle(e);
      throw Exception(errorMsg);
    } catch (e) {
      throw Exception('Đã có lỗi không xác định xảy ra');
    }
  }
}