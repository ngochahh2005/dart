import 'package:dio/dio.dart';
import '../../core/constants/api_endpoints.dart';
import '../../models/cat_breed.dart';

class CatApiService {
  CatApiService._internal() {
    _initDio();
  }
  static final _instance = CatApiService._internal();
  factory CatApiService() => _instance;

  late Dio _dio;

  void _initDio() {
    _dio = Dio(
      BaseOptions(
        baseUrl: ApiEndpoints.baseUrl,
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
        headers: {'Content-Type': 'application/json'},
      ),
    );

    _dio.interceptors.add(
      InterceptorsWrapper(
          onRequest: (options, handler) {
            print('[CatApi] ${options.method} ${options.uri}');
            return handler.next(options);
          },
          onResponse: (response, handler) {
            print('[CatApi] ${response.statusCode}');
            return handler.next(response);
          },
          onError: (error, handler) {
            print('[CatApi] ${error.message}');
            return handler.next(error);
          }
      ),
    );
  }

  Future<List<CatBreed>> fetchBreeds() async {
    try {
      final resp = await _dio.get(ApiEndpoints.breeds);

      if (resp.statusCode == 200) {
        final List<dynamic> data = resp.data;
        return data.map((json) => CatBreed.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load breeds: ${resp.statusCode}');
      }
    } on DioException catch (e) {
      throw Exception('Network error: ${e.message}');
    } catch (e) {
      throw Exception('Unknown exception: $e');
    }
  }
  
  Future<CatBreed> fetchBreedById(String breedId) async {
    try {
      final resp = await _dio.get('${ApiEndpoints.breeds}/$breedId');
      if (resp.statusCode == 200) {
        return CatBreed.fromJson(resp.data);
      } else {
        throw Exception('Failed to load breed details');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}
