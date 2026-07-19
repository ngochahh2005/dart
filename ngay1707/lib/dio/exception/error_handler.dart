// lib/network/error_handler.dart
import 'package:dio/dio.dart';

class NetworkError {
  static String handle(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
        return 'Kết nối đến server quá thời gian. Vui lòng thử lại';
      case DioExceptionType.sendTimeout:
        return 'Gửi dữ liệu quá thời gian. Vui lòng thử lại';
      case DioExceptionType.receiveTimeout:
        return 'Nhận dữ liệu quá thời gian. Vui lòng thử lại';
      case DioExceptionType.badResponse:
        return _handleStatusCode(error.response?.statusCode);
      case DioExceptionType.cancel:
        return 'Yêu cầu đã bị hủy!';
      case DioExceptionType.connectionError:
        return 'Không thể kết nối đến server. Kiểm tra kết nối mạng';
      default:
        return 'Đã có lỗi xảy ra, vui lòng thử lại!';
    }
  }

  static String _handleStatusCode(int? statusCode) {
    switch (statusCode) {
      case 400:
        return 'Yêu cầu không hợp lệ';
      case 401:
        return 'Không được phép truy cập. Vui lòng đăng nhập lại.';
      case 403:
        return 'Bạn không có quyền truy cập';
      case 404:
        return 'Không tìm thấy tài nguyên';
      case 500:
        return 'Lỗi server nội bộ. Vui lòng thử lại sau.';
      default:
        return 'Đã có lỗi xảy ra (Mã lỗi: $statusCode';
    }
  }
}