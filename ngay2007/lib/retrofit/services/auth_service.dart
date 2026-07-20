import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthService {
  final _storage = FlutterSecureStorage();

  static final _instance = AuthService._internal();
  factory AuthService() => _instance;
  AuthService._internal();

  static const String _accessToken = 'access_token';
  static const String _refreshToken = 'refresh_token';

  Future<void> saveTokens(String accessToken, String refreshToken) async {
    await _storage.write(key: _accessToken, value: accessToken);
    await _storage.write(key: _refreshToken, value: refreshToken);
  }

  Future<String?> getAccessToken() async => await _storage.read(key: _accessToken);
  Future<String?> getRefreshToken() async => await _storage.read(key: _refreshToken);

  Future<void> clearTokens() async {
    await _storage.delete(key: _accessToken);
    await _storage.delete(key: _refreshToken);
  }
}