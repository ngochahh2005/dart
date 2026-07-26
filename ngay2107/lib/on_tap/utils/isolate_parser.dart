import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:ngay2107/on_tap/models/dto/book_dto.dart';

Future<List<BookDto>> fetchBooksInIsolate(String rawJson) async {
  return await compute(parseBooks, rawJson);
}

List<BookDto> parseBooks(String rawJson) {
  final List<dynamic> decodedList = jsonDecode(rawJson);
  return decodedList
      .map((item) => BookDto.fromJson(item as Map<String, dynamic>))
      .toList();
}
