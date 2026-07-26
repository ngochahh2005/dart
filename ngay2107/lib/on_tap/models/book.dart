enum BookStatus { reading, finished, wishlist }

abstract class Book {
  final String id;
  final String title;
  final int pages;
  BookStatus status;
  static int totalBooks = 0;
  double _rating = 0.0;

  double get rating => _rating;

  set rating(double rating) {
    if (rating < 0.0 || rating > 5.0) {
      throw Exception('Rating phải nằm trong khoảng từ 0 đến 5');
    }
    _rating = rating;
  }

  Book({
    required this.id,
    required this.title,
    required this.pages,
    required this.status,
  }) {
    totalBooks++;
  }

  Book.wishList({required this.title, this.id = '', this.pages = 0})
    : status = BookStatus.wishlist {
    totalBooks++;
  }

  String describe();
}

typedef BookFilter = bool Function(Book);

List<Book> filterBooks(List<Book> books, BookFilter test) {
  return books.where(test).toList();
}