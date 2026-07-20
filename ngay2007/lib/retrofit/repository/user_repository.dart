import 'package:dio/dio.dart';
import '../models/user.dart';
import '../models/post.dart';
import '../network/api_client.dart';
import '../network/dio_client.dart';

class UserRepository {
  late final ApiClient _apiClient;
  
  UserRepository({String? baseUrl}) {
    // khoi tao dio client
    final dio = DioClient().init(
        baseUrl: baseUrl ?? 'https://jsonplaceholder.typicode.com/',
    ).client;

    // tao ApiClient voi Dio instance
    _apiClient = ApiClient(dio);
  }

  Future<ApiResponse<List<User>>> getUsers() async {
    try {
      return await _apiClient.getUsers();
    } on DioException catch(e) {
      throw _handleError(e);
    }
  }

  _handleError(DioException e) {}
}