import 'dart:math';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageService {
  SecureStorageService._internal();
  static final _instance = SecureStorageService._internal();
  factory SecureStorageService() => _instance;

  final _storage = const FlutterSecureStorage();
  AndroidOptions? _getAndroidOptions() => const AndroidOptions(encryptedSharedPreferences: true);

  static const _keyAuthToken = 'auth_token';
  static const _keyUserId = 'auth_uid';
  static const _keyEmail = 'auth_email';

  Future<void> saveAuthToken(String token) async {
    await _storage.write(key: _keyAuthToken, value: token, aOptions: _getAndroidOptions());
  }

  Future<String?> getAuthToken() async {
    return await _storage.read(key: _keyAuthToken, aOptions: _getAndroidOptions());
  }
  
  Future<void> saveUserInfo({required String email, required String userId}) async {
    await _storage.write(key: _keyEmail, value: email, aOptions: _getAndroidOptions());
    await _storage.write(key: _keyUserId, value: userId, aOptions: _getAndroidOptions());
  }

  Future<String?> getUserId() async {
    return await _storage.read(key: _keyUserId);
  }

  Future<String?> getUserEmail() async {
    return await _storage.read(key: _keyEmail);
  }

  Future<void> clearAll() async {
    await _storage.deleteAll(aOptions: _getAndroidOptions());
  }
  
  Future<void> clearAuthToken() async {
    await _storage.delete(key: _keyAuthToken, aOptions: _getAndroidOptions());
  }

  Future<void> clearUserInfo() async {
    await _storage.delete(key: _keyUserId);
    await _storage.delete(key: _keyEmail);
  }

  Future<bool> hasAuthToken() async {
    final token = await getAuthToken();
    return token != null && token.isNotEmpty;
  }
}