import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageService {
  SecureStorageService._internal();
  static final _instance = SecureStorageService._internal();
  factory SecureStorageService() => _instance;

  final _storage = FlutterSecureStorage();

  static const _keyEmail = 'auth_email';
  static const _keyUid = 'auth_uid';
  static const _keyPin = 'auth_pin';

  Future<void> saveUserInfo({required String email, required String uid}) async {
    await _storage.write(key: _keyEmail, value: email);
    await _storage.write(key: _keyUid, value: uid);
  }

  Future<void> clearUserInfo() async {
    await _storage.delete(key: _keyEmail);
    await _storage.delete(key: _keyUid);
  }

  Future<void> savePin({required String pin}) async {
    await _storage.write(key: _keyPin, value: pin);
  }

  Future<String?> getPin() async {
    return await _storage.read(key: _keyPin);
  }

  Future<void> clearPin() async {
    return await _storage.delete(key: _keyPin);
  }
}