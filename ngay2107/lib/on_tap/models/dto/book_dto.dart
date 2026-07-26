import 'package:freezed_annotation/freezed_annotation.dart';
import '../book.dart';

part 'book_dto.freezed.dart';
part 'book_dto.g.dart';

@freezed
abstract class BookDto with _$BookDto{
  const factory BookDto({
    required int id,
    required String title,
  }) = _BookDto;

  factory BookDto.fromJson(Map<String, dynamic> json) => _$BookDtoFromJson(json);
}