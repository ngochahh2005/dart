// 2. Su dung trong model
// Them annotation @ColorConverter() vao thuoc tinh tuong ung

import 'dart:ui';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'color_converter.dart';

part 'product.freezed.dart';

part 'product.g.dart';

@freezed
class Product with _$Product {
  const factory Product({
    required int id,
    required String name,
    @ColorConverter() required Color primaryColor,
  }) = _Product;

  factory Product.fromJson(Map<String, dynamic> json) =>
      _$ProductFromJson(json);
}
