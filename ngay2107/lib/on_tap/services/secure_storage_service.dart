import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageService {
  final _storage = FlutterSecureStorage();
  static const String _tokenKey = 'auth_token';

  Future<void> saveAuthToken(String authToken) async {
    await _storage.write(key: _tokenKey, value: authToken);
  }

  Future<String?> getAuthToken() async {
    return await _storage.read(key: _tokenKey);
  }

  Future<void> deleteToken() async {
    await _storage.delete(key: _tokenKey);
  }
}