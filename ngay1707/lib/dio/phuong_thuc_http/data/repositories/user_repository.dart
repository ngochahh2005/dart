import '../../services/auth_service.dart';
import '../network/dio_client.dart';
import '../models/user.dart';
import 'package:dio/dio.dart';

class UserRepository {
  final _dioClient = DioClient();
  final _authService = AuthService();

  // GET Request
  // lay danh sach user co phan trang
  Future<List<User>> getUsers({int page = 1, int size = 20}) async {
    try {
      final resp = await _dioClient.dio.get(
        'users',
        queryParameters: {
          'page': page,
          'size': size,
        }
      );

      // response.data la Map<String, dynamic>
      final List<dynamic> data = resp.data['data'];
      return data.map((json) => User.fromJson(json)).toList();
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // POST request
  // tao User moi
  Future<User> createUser(User user) async {
    try {
      final resp = await _dioClient.dio.post(
        '/users',
        data: user.toJson(),
      );
      return User.fromJson(resp.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // PUT & DELETE
  // cap nhat user
  Future<User> updateUser(int id, User user) async {
    final resp = await _dioClient.dio.put(
      'users/$id',
      data: user.toJson(),
    );
    return User.fromJson(resp.data['data']);
  }

  // xoa user
  Future<void> deleteUser(int id) async {
    await _dioClient.dio.delete('/users/$id');
  }

  // Request voi Options tuy chinh
  // Gui request voi header va query parameters tuy chinh
  Future<Response> fetchWithCustomOptions() async {
    final resp = await _dioClient.dio.get(
      '/protected-data',
      options: Options(
        headers: {
          'Authorization': 'Bearer ${_authService.getAccessToken()}',
        }
      ),
      queryParameters: {
        'filter': 'active'
      }
    );
    return resp;
  }

  _handleError(DioException e) {}
}