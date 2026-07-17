import '../xu_ly_response_va_model/services/api_service.dart';

void main() async {
  print(await ApiService().getPosts());
  print(await ApiService().getPost(1));
}