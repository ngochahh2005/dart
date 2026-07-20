import 'dart:core';

import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:retrofit/retrofit.dart';
import '../models/user.dart';
import '../models/post.dart';

part 'api_client.g.dart';
part 'api_client.freezed.dart';

// annotation dinh nghia base url cho toan bo api
@RestApi(baseUrl: 'https://jsonplaceholder.typicode.com/')
abstract class ApiClient {
  // factory constructor - retrofit de sinh class _ApiClient
  factory ApiClient(Dio dio, {String? baseUrl}) = _ApiClient;

  // get requests

  // get /users - lay danh sach user
  // @GET('/users')
  // Future<List<User>> getUsers();

  // get /users/{id} - lay user theo id
  @GET('/users/{id}')
  // Biến từ khóa {id} trong URL sẽ được thay thế bằng giá trị của biến id truyền vào hàm.
  Future<User> getUserById(@Path('id') int id);

  // get voi query parameters
  @GET('/posts')
  Future<List<Post>> getPosts({
    // Khi gọi hàm getPosts(userId: 1, limit: 10), URL tự động sinh ra sẽ là: /posts?userId=1&_limit=10.
    @Query('userId') int? userId,
    @Query('_limit') int? limit,
  });

  // post requests

  // post voi request body (Json)
  @POST('/users')
  // Chuyển đổi toàn bộ đối tượng User thành một chuỗi JSON nằm trong phần Body của HTTP Request để gửi lên server.
  Future<User> createUser(@Body() User user);

  // put requests
  @PUT('/users/{id}')
  // Dùng @PUT('/users/{id}') kết hợp @Path và @Body để cập nhật nguyên một bản ghi dựa trên ID.
  Future<User> updateUser(@Path('id') int id, @Body() User user);

  // patch requests
  @PATCH('/users/{id}')
  // Thường dùng kiểu dữ liệu Map<String, dynamic> ở @Body khi bạn chỉ muốn sửa một vài trường dữ liệu lẻ tẻ thay vì toàn bộ object.
  Future<User> patchUser(@Path('id') int id, @Body() Map<String, dynamic> data);

  // delete requests
  @DELETE('/users/{id}')
  // Thường trả về Future<void> vì khi xóa thành công server ít khi trả về dữ liệu nội dung, chỉ cần biết mã trạng thái thành công
  // (ví dụ 200/204).
  Future<void> deleteUser(@Path('id') int id);

  // form data (x-www-form-urlencoded)
  @POST('/login')
  @FormUrlEncoded() // chỉ định rằng request gửi lên server sẽ có kiểu dữ liệu là application/x-www-form-urlencoded.
  Future<void> login({
    // Dùng để gửi dữ liệu dạng form-urlencoded (giống như gửi một form HTML truyền thống: username=abc&password=123).
    @Field('username') required String username,
    @Field('password') required String password,
  });

  // multipart (upload file)
  @POST('/upload')
  @MultiPart()
  Future<void> uploadFile({
    @Part() required MultipartFile
    file, // Dùng để upload file (hình ảnh, tài liệu,...) lên server.
    @Part(name: 'description') String? description,
    // Gửi kèm các trường dữ liệu dạng text thông thường bên trong request đa phần (multipart request).
  });

  // header tuy chinh
  @GET('/protected-data')
  Future<List<Post>> getProtectedData(@Header('Authorization') String token,
      @Header('Custom-Header') String custom,);

  // response voi http status code
  @GET('/users')
  Future<HttpResponse<List<User>>> getUserWithResponse();

  // API Wrapper class cho response
  @GET('/users')
  Future<ApiResponse<List<User>>> getUsers();
}

@Freezed(genericArgumentFactories: true)
abstract class ApiResponse<T> with _$ApiResponse<T>{
  const factory ApiResponse({
    required bool success,
    required String message,
    T? data
  }) = _ApiResponse;

  factory ApiResponse.fromJson(Map<String, dynamic> json,
      T Function(Object? json) fromJsonT,) =>
      _$ApiResponseFromJson(json, fromJsonT);
}
