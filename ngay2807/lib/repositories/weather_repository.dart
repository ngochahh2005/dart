import 'package:dio/dio.dart';
import '../core/constants/app_constants.dart';
import '../models/weather.dart';

class WeatherRepository {
  final _dio = Dio(
    BaseOptions(
      connectTimeout: const Duration(milliseconds: AppConstants.connectTimeout),
      receiveTimeout: const Duration(milliseconds: AppConstants.receiveTimeout),
    ),
  );

  Future<Weather> getWeather(String cityName) async {
    try {
      final geoResp = await _dio.get(
        '${AppConstants.geocodingBaseUrl}/search',
        queryParameters: {'name': cityName, 'count': 1},
      );

      if (geoResp.statusCode != 200 ||
          geoResp.data['results'] == null ||
          geoResp.data['results'].isEmpty) {
        throw Exception('Không tìm thấy thành phố $cityName');
      }

      final res = geoResp.data['results'][0];
      final latitude = res['latitude'].toString();
      final longitude = res['longitude'].toString();

      final weatherResp = await _dio.get(
        '${AppConstants.weatherBaseUrl}/forecast',
        queryParameters: {
          'latitude': latitude,
          'longitude': longitude,
          'current': AppConstants.defaultCurrentParams,
        },
      );

      if (weatherResp.statusCode != 200) {
        throw Exception('Không thể lấy dữ liệu thời tiết');
      }

      return Weather.fromJson(weatherResp.data, cityName);
    } on DioException catch (e) {
      throw Exception('Lỗi mạng: ${e.message}');
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
