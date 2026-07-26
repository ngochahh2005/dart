import 'readable.dart';
import 'book.dart';

class PhysicalBook extends Book implements Readable {
  String shelfLocation;

  PhysicalBook({
    required this.shelfLocation,
    required super.id,
    required super.title,
    required super.pages,
    required super.status,
  });

  @override
  String describe() {
    return 'Sách vật ly: $title - Nằm ở kệ: $shelfLocation (Trạng thái: $status)';
  }

  @override
  void markAsRead() {
    status = BookStatus.finished;
  }
}
