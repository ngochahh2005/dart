/*
  1. Shared Preferences là gì? (Lý thuyết nền tảng)
  - Định nghĩa: Shared Preferences là một hệ thống lưu trữ dạng Key-Value (cặp khóa - giá trị) đơn giản,
    cho phép ứng dụng Flutter lưu giữ một lượng nhỏ dữ liệu cục bộ trên thiết bị.
  - Nguyên lý hoạt động: Dữ liệu được lưu dưới dạng file cấu trúc nhẹ
    (trên Android là SharedPreferences dạng XML, trên iOS là NSUserDefaults).
    Plugin shared_preferences đóng vai trò là cầu nối (Platform Channel) giữa Dart và native code.
  - Đặc điểm quan trọng:
    + Lưu trữ bền vững (Persistent): Dữ liệu vẫn tồn tại ngay cả khi tắt ứng dụng hoặc khởi động lại thiết bị.
    + Bất đồng bộ (Asynchronous): Các thao tác đọc/ghi đều là Future, cần dùng async/await.
    + Giới hạn dung lượng: Chỉ dành cho dữ liệu đơn giản, kích thước nhỏ (vài trăm KB đến vài MB).
    + Không dùng để lưu ảnh, video, danh sách dài, hoặc dữ liệu nhạy cảm (mật khẩu, token quan trọng).
  - Các kiểu dữ liệu hỗ trợ:
    + int (setInt, getInt)
    + double (setDouble, getDouble)
    + bool (setBool, getBool)
    + String (setString, getString)
    + List<String> (setStringList, getStringList)

  2. Cài đặt và Khởi tạo
  - Bước 1: Thêm package vào pubspec.yaml
    dependencies:
      flutter:
        sdk: flutter
      shared_preferences: ^2.5.5  # Luôn dùng phiên bản mới nhất
    Chạy lệnh: flutter pub get
  - Bước 2: Khởi tạo Instance (Singleton Pattern - Khuyến nghị)
    + Việc gọi getInstance() mỗi lần là tốn kém. Do đó, ta tạo một Singleton quản lý toàn bộ.
    + Singleton là một mẫu thiết kế (design pattern) đảm bảo một class chỉ có duy nhất một thể hiện (instance)
    duy nhất trong suốt vòng đời của ứng dụng và cung cấp một điểm truy cập toàn cục tới thể hiện đó.
 */

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PreferenceService {
  // _internal() (Private constructor): Ngăn chặn việc người khác khởi tạo class này bằng cách
  // dùng PreferenceService(). Chỉ có chính class này mới có thể khởi tạo bản thân nó.
  PreferenceService._internal();

  // static instance cua Singleton: Đảm bảo chỉ có một bản thể duy nhất của PreferenceService tồn tại
  // trong suốt quá trình chạy ứng dụng (đây là cốt lõi của Singleton).
  static final PreferenceService _instance = PreferenceService._internal();

  // factory constructor: Trả về luôn cái _instance đã tạo sẵn.
  // Khi bạn viết PreferenceService(), nó sẽ luôn trả về cùng một đối tượng.
  factory PreferenceService() => _instance;

  // bien luu SharedPreferences instance: Từ khóa late báo hiệu cho Dart biết rằng biến này sẽ
  // được khởi tạo trước khi nó được sử dụng, giúp ta không phải kiểm tra null liên tục.
  late SharedPreferences _prefs;

  // ham khoi tao bat dong bo (goi 1 lan khi app start): Hàm này dùng để nạp (load) instance từ
  // native code vào biến _prefs. Đây là bước bắt buộc vì việc đọc từ ổ cứng phải thực hiện bất đồng bộ.
  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // getter de lay instance (dung ben trong class)
  SharedPreferences get prefs => _prefs;

  // 3. Các thao tác cơ bản (CRUD)
  // 3.1. Ghi dữ liệu (Write + Set)
  // Dùng các hàm: setInt, setDouble, setBool, setString, setStringList
  // VD: Lưu dữ liệu người dùng
  Future<void> saveUserInfo(String name, int age, bool isVip) async {
    await _prefs.setString('user_name', name);
    await _prefs.setInt('user_age', age);
    await _prefs.setBool('is_vip', isVip);
  }

  // VD: Lưu danh sách yêu thích
  Future<void> setFavourites(List<String> items) async {
    await _prefs.setStringList('favourites', items);
  }

  // 3.2. Đọc dữ liệu (Read - Get)
  // Các hàm: getInt, getDouble, getBool, getString, getStringList
  // Lưu ý: Nếu key không tồn tại, các hàm này trả về null. Vì vậy, luôn dùng toán tử ?? để gán giá trị mặc định
  // Đọc dữ liệu (có giá trị mặc định)
  String getUserName() => _prefs.getString('user_name') ?? 'Guest';

  int getUserAge() => _prefs.getInt('user_age') ?? 0;

  bool getIsVip() => _prefs.getBool('is_vip') ?? false;

  List<String> getFavourites() => _prefs.getStringList('favourites') ?? [];

  // 3.3. Kiểm tra sự tồn tại (Contains Key)
  // Đôi khi vần biết key đã tồn tại hay chưa (VD: lần đầu chạy app)
  bool isFirstLaunch() {
    return _prefs.containsKey('is_first_launch') ==
        false; // neu chua co --> lan dau
  }

  Future<void> setFirstLaunchDone() async {
    await _prefs.setBool('is_first_launch', false); // luu trang thai da chay
  }

  // 3.4. Xóa dữ liệu (Delete)
  // - remove(String key): Xóa cặp key-value
  // - clear(): Xóa TOÀN BỘ dữ liệu SharedPreferences. Cực kì cẩn thận! Chỉ dùng khi logout hoặc reset app
  // VD: Xóa 1 trường cụ thể (ví dụ cóa token cữ)
  Future<void> removeToken() async {
    await _prefs.remove('auth_token');
  }

  // Xóa toàn bộ (dùng khi đăng xuất)
  Future<void> clearAll() async {
    await _prefs.clear();
  }

  // 4. Lưu trữ Object phức tạp (JSON)
  // Bước 2: Ghi và Đọc trong PreferenceService
  // Lưu Object User
  Future<void> saveCurrentUser(User user) async {
    String jsonString = jsonEncode(user.toJson());
    await _prefs.setString('current_user', jsonString);
  }

  // Đọc Object User (trả về null nếu chưa có)
  User? getCurrentUser() {
    String? jsonString = _prefs.getString('current_user');
    if (jsonString == null) return null;
    Map<String, dynamic> map = jsonDecode(jsonString);
    return User.fromJSon(map);
  }
}

// 4. Lưu trữ Object phức tạp (JSON)
// Shared Preferences không hỗ trợ lưu Object trực tiếp. Giải pháp là mã hóa Object thành chuỗi JSON và lưu dưới dạng String.
// Ứng dụng thực tế: Lưu thông tin profile người dùng sau khi đăng nhập thành công.
// - Bước 1: Tạo Model và hỗ trợ JSON
class User {
  final String id;
  final String email;
  final int level;

  User({required this.id, required this.email, required this.level});

  // chuyen oject -> Mao (de encode JSON)
  Map<String, dynamic> toJson() =>
      {
        'id': id,
        'email': email,
        'level': level
      };

  // chuyen map -> object (de decode JSON)
  factory User.fromJSon(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      email: json['email'],
      level: json['level']
    );
  }
}

// Ứng dụng thực tế: Gọi await PreferenceService().init();
// ngay trong main() hoặc runApp để đảm bảo mọi nơi đều có thể dùng được ngay.
void main() async {
  // Đảm bảo các binding của Flutter được khởi tạo trước khi gọi code native
  WidgetsFlutterBinding.ensureInitialized();

  // Khởi tạo PreferenceService (Singleton)
  await PreferenceService().init();

  // runApp(MyApp());
}
