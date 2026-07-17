import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthService {
  final _secureStorage = const FlutterSecureStorage();

  AndroidOptions? _getAndroidOptions() =>
      const AndroidOptions(encryptedSharedPreferences: true);

  // Dang nhap va luu token
  Future<void> login(String username, String password) async {
    // final resp = await http.post(
    //   Uri.parse('https://api.example.com/login'),
    //   headers: {'Content-Type': 'application/json'},
    //   body: jsonEncode({'username': username, 'password': password}),
    // );
    //
    // if (resp.statusCode == 200) {
    //   final token = jsonDecode(resp.body)['token'];
    //   await _secureStorage.write(
    //     key: 'auth_token',
    //     value: token,
    //     aOptions: _getAndroidOptions(),
    //   );
    // } else {
    //   throw Exception('Dang nhap that bai');
    // }

    // gia lap token da duoc tra ve
    print('Dang gia lap dang nhap');
    await Future.delayed(Duration(seconds: 1));
    await _secureStorage.write(
      key: 'auth_token',
      value: 'fake_jwt_token_12345',
      aOptions: _getAndroidOptions(),
    );
  }

  // lay token tu bo nho may
  Future<String?> getToken() async {
    var token = await _secureStorage.read(
      key: 'auth_token',
      aOptions: _getAndroidOptions(),
    );
    return token;
  }

  // xoa token
  Future<void> logout() async {
    await _secureStorage.delete(
      key: 'auth_token',
      aOptions: _getAndroidOptions(),
    );
  }
}
