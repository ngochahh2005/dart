import 'package:dio/dio.dart';
import 'package:ngay2107/on_tap/models/dto/book_dto.dart';
import 'package:ngay2107/on_tap/services/book_api_service.dart';
import 'package:ngay2107/on_tap/utils/isolate_parser.dart';

class BookController {
  final BookApiService _apiService;

  // cac trang thai cua controller
  List<BookDto> books = [];
  bool _isLoading = false;
  String? errorMsg;

  BookController() : _apiService = BookApiService(Dio());

  Future<void> loadBooks() async {
    _isLoading = true;
    errorMsg = null;
    print('Bắt đầu tải dữ liệu...');

    try {
      final String rawJson = await _apiService.getRawBooksJson();

      books = await fetchBooksInIsolate(rawJson);
      print('Tải thành công ${books.length} cuốn sách');
    } catch (e) {
      errorMsg = 'Lối khi lấy dữ liệu sách: $e';
      print(errorMsg);
    } finally {
      _isLoading = false;
      print('Kết thúc tải dữ liệu');
    }
  }

  Stream<int> readingProgressStream() {
    int currentProgress = 0;
    return Stream.periodic(const Duration(seconds: 1), (count) {
      currentProgress += 10;
      return currentProgress;
    }).takeWhile(
      (progress) => progress <= 100,
    ); // tu dong ngat khi stream dat 100%
  }
}
