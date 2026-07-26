import 'package:ngay2107/on_tap/models/timestampable.dart';

import 'readable.dart';
import 'book.dart';

class EBook extends Book with Timestampable implements Readable{
  final double fileSizeMb;

  EBook({
    required this.fileSizeMb,
    required super.id,
    required super.title,
    required super.pages,
    required super.status,
  });

  @override
  String describe() {
    return 'Sách điện tử: $title - Dung lượng: $fileSizeMb (Tạo lúc: $createdAt)';
  }

  @override
  void markAsRead() {
    status = BookStatus.finished;
  }
}
