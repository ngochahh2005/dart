/*
  Ví dụ chi tiết: Chuyển đổi mã màu (Color)
  Giả sử ứng dụng của bạn cần lưu trữ đối tượng Product,
  và API trả về mã màu dưới dạng String (ví dụ: "#FF0000"),
  nhưng trong Flutter bạn muốn sử dụng Color object để hiển thị.
 */

// 1. Tao Convert
// Tao 1 class thuc thi JsonConverter<Color, String>, trong do:
// - Color: kieu trong App
// - String: kieu trong Json

import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

class ColorConverter implements JsonConverter<Color, String>{
  const ColorConverter();

  // chuyen tu JSON (String) --> App (Color)
  @override
  Color fromJson(String json) => Color(int.parse(json.replaceFirst('#', '0xff')));

  // chuyen tu App (Color) --> JSON (String)
  @override
  String toJson(Color object) => '#${object.value.toRadixString(16).substring(2)}';

}