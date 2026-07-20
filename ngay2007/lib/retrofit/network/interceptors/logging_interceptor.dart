import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

class LoggingInterceptor extends Interceptor {
  final Logger _logger = Logger(
    printer: PrettyPrinter(
      methodCount: 0,       // Không hiển thị số lượng dòng stack trace không cần thiết
      errorMethodCount: 5,  // Nếu có lỗi, hiển thị 5 dòng vết lỗi (stack trace) chi tiết
      lineLength: 120,      // Độ dài tối đa của dòng kẻ khung log
      colors: true,         // Bật màu sắc cho terminal (đỏ cho lỗi, xanh cho thành công...)
      printEmojis: true,    // Bật biểu tượng cảm xúc để dễ phân biệt trực quan
      printTime: true       // In kèm thời gian xảy ra request
    )
  );

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // .i(): info - dùng để ghi lại các sự kiện mang tính thông tin chung hoặc các mốc quan trọng trong ứng dụng
    _logger.i('''
    ┌─────────────────────────────────────────────────────
    │ REQUEST: ${options.method} ${options.uri}
    │ Headers: ${options.headers}
    │ Body: ${options.data}
    └─────────────────────────────────────────────────────
    ''');
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    // .d(): debug - dùng để in ra các dữ liệu phục vụ cho quá trình kiểm tra, gỡ lỗi chi tiết mà không ảnh hưởng đến logic chương trình.
    _logger.d('''
    ┌─────────────────────────────────────────────────────
    │ RESPONSE: ${response.statusCode} ${response.requestOptions.uri}
    │ Data: ${response.data}
    └─────────────────────────────────────────────────────
    ''');
    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    // .e(): error - dùng chuyên biệt để ghi lại các sự cố, ngoại lệ (exception) hoặc các lỗi nghiêm trọng xảy ra trong ứng dụng.
    _logger.e('''
    ┌─────────────────────────────────────────────────────
    │ ERROR: ${err.response?.statusCode} ${err.requestOptions.uri}
    │ Message: ${err.message}
    │ Data: ${err.response?.data}
    └─────────────────────────────────────────────────────
    ''');
    super.onError(err, handler);
  }
}