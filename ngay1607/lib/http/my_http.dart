/*
  3. LÝ THUYẾT CỐT LÕI
  3.1. Future và Async/Await
  HTTP requests là các hoạt động bất đồng bộ. Dart sử dụng Future để đại diện cho 1 giá trị sẽ có trong tương lai
 */

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

// Cách 1: Dùng async/await
Future<void> fetchData() async {
  try {
    final respone = await http.get(Uri.parse('https://api.example.com/data'));
    // Xu ly respone
    // kiem tra ma trang thai (statusCode)
    if (respone.statusCode == 200) {
      print('Du lieu nhan duoc: ${respone.body}');
    } else {
      // xu ly cac truong hop loi tu server (nhu 404, 500)
      print('Loi tu server voi ma: ${respone.statusCode}');
    }
  } catch (e) {
    // neu co loi xay ra (mat mang, timeout...), code se nhay vao day
    print('Da xay ra loi ket noi: $e');
  } finally {
    // Doan luon chay bat ke thanh cong hay thay bai
    print('Tien trinh fetch da ket thuc');
  }
}

// Cách 2: Dùng then()
void fetchData2() {
  http
      .get(Uri.parse('https://api.example.com/data'))
      // then: Khối sẽ được thực thi ngay khi http.get hoàn tất việc tải dữ liệu.
      // Biến response chính là kết quả trả về từ server.
      .then((response) {
        // xu ly khi thanh cong (thanh cong = server phan hoi)
        if (response.statusCode == 200) {
          print('Du lieu lay duoc: ${response.body}');
        } else {
          print('Loi server: ${response.statusCode}');
        }
      })
      // .catchError(): Đây là "vùng an toàn". Nếu đường truyền mạng của người dùng bị mất hoặc URL sai
      // khiến request bị lỗi, toàn bộ lỗi sẽ rơi vào đây để bạn xử lý (tránh việc ứng dụng bị crash).
      .catchError((error) {
        print('Da xay ra loi: $error');
      })
      // .whenComplete(): (Không bắt buộc) Khối này luôn luôn chạy sau khi xong cả .then() hoặc .catchError().
      // Thường dùng để tắt các vòng xoay loading (loading spinner) trên giao diện.
      .whenComplete(() {
        print('Ket thuc tien trinh lay du lieu');
      });
}
