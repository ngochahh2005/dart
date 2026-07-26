import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ngay2107/on_tap/models/dto/book_dto.dart';
import 'package:retrofit/retrofit.dart';

part 'book_api_service.g.dart';

@RestApi(baseUrl: 'https://jsonplaceholder.typicode.com/')
abstract class BookApiService {
  factory BookApiService(Dio dio, {String baseUrl}) = _BookApiService;

  // lay danh sach tu dong parse
  @GET('/posts')
  Future<List<BookDto>> getPosts();

  // lay chuoi JSON tho
  @GET('/posts')
  @DioResponseType(ResponseType.plain)
  Future<String> getRawBooksJson();
}