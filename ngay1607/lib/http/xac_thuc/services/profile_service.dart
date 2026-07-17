import 'package:http/http.dart' as http;
import 'package:ngay1607/http/xac_thuc/services/auth_service.dart';

class ProfileService {
  Future<void> getSecretData() async {
    final auth = AuthService();
    final token = await auth.getToken();
    
    if (token == null) {
      throw Exception('Nguoi dung chua dang nhap!');
    }
    
    final resp = await http.get(
      Uri.parse('http://10.0.2.2:8080/profile'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json'
      }
    );

    print('Du lieu bao mat: ${resp.body}');
  }
}