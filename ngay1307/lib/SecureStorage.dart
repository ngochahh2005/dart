/*
  1. Tại sao nên dùng flutter_secure_storage?
  flutter_secure_storage là một plugin Flutter dùng để lưu trữ dữ liệu trong bộ nhớ an toàn (secure storage).
  Vậy bộ nhớ an toàn là gì và nó an toàn đến mức nào? Câu trả lời phụ thuộc vào nền tảng.
  - Trên Android: flutter_secure_storage lưu trữ dữ liệu trong EncryptedSharedPreferences –
    một loại SharedPreferences mã hóa cả khóa và giá trị. Nó sử dụng mã hóa AES để tạo một khóa bí mật,
    được mã hóa bằng RSA và lưu trữ trong KeyStore.
  - Trên iOS: plugin sử dụng KeyChain – một bộ nhớ an toàn dành riêng cho iOS, dùng để lưu trữ và
  truy cập các khóa mật mã chỉ trong ứng dụng của bạn.
  - Trên Web: plugin sử dụng API Web Cryptography (Web Crypto).

  2. So sánh Secure Storage vs SharedPreferences
  Tiêu chí                    Secure Storage	                          SharedPreferences
  Bảo mật	            Dữ liệu được mã hóa	                        Dữ liệu ở dạng văn bản thuần túy
  Mục đích	          Lưu thông tin nhạy cảm (token, mật khẩu)	  Lưu cấu hình không nhạy cảm
  Hiệu năng	          Chậm hơn do phải mã hóa/giải mã	            Nhanh và đơn giản
  Rủi ro khi lộ	      Mất tài khoản hoặc xâm phạm hệ thống	      Mất cài đặt UI, không ảnh hưởng nghiêm trọng
  ==> Nguyên tắc vàng: Nếu dữ liệu bị lộ có thể làm tổn hại đến tài khoản người dùng hoặc hệ thống backend,
  KHÔNG sử dụng SharedPreferences.

  3. Cài đặt
  Bước 1: Thêm dependency vào pubspec.yaml
    yaml
    dependencies:
      flutter_secure_storage: ^10.3.1
  Bước 2: Chạy lệnh cài đặt
    bash
    flutter pub get
  Bước 3: Khởi tạo Binding (quan trọng)
  Trong file main2.dart, gọi WidgetsFlutterBinding.ensureInitialized() trước khi sử dụng MethodChannel:
 */
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // runApp(MyApp());
}

// 4. Cấu hình và khởi tạo
// 4.1. Cấu hình cơ bản (khuyến nghị)
// Cấu hình hiện đại - sử dụng EncryptedSharedPreferences trên Android
final storage = FlutterSecureStorage(
  aOptions: AndroidOptions(
    // Bắt buộc để tránh hiệu năng kém[reference:19]
    encryptedSharedPreferences: true,
  )
);

// 4.2. Cấu hình với xác thực sinh trắc học
// Xác thực sinh trắc học với khả năng thoái lui (graceful degradation)
final storage2 = FlutterSecureStorage(
  aOptions: AndroidOptions.biometric(
    enforceBiometrics: false, // // Không bắt buộc, có thể dùng PIN/mật khẩu
    biometricPromptTitle: 'Xac thuc de truy quyen du lieu'
  )
);

// Bắt buộc xác thực sinh trắc học
final strictStorage = FlutterSecureStorage(
  aOptions: AndroidOptions(
    enforceBiometrics: true,  // Bắt buộc phải có sinh trắc học
    biometricPromptTitle: 'Yêu cầu xác thực'
  )
);