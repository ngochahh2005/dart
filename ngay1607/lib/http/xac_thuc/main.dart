import 'package:flutter/cupertino.dart';
import 'package:ngay1607/http/xac_thuc/services/auth_service.dart';
import 'package:ngay1607/http/xac_thuc/services/profile_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final auth = AuthService();
  final profile = ProfileService();

  print('1. Dang thu dang nhap...');
  try {
    await auth.login('ptit_user', 'password123');
    print('Dang nhap thanh cong, da luu token');

    print('\n2. Dang goi API bao mat...');
    await profile.getSecretData();
    print('Test thanh cong!');
  } catch (e) {
    print('Loi trong qua trinh test $e');
  }
}