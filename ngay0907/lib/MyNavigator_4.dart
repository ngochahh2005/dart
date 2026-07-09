import 'package:flutter/material.dart';

/*
  4. NÂNG CAO: onGenerateRoute (XỬ LÝ ROUTE ĐỘNG VÀ BẢO VỆ)
  Đây là cách mạnh mẽ nhất dành cho ứng dụng thực tế. Nó cho phép:
  - Xử lý các route không tồn tại (404).
  - Chuyển hướng dựa trên trạng thái đăng nhập (Auth Guard).
  - Parse tham số từ URL phức tạp (ví dụ: /product/123).
 */

enum AppRoute {
  home('/'),
  product('/product'),
  login('/login'),
  profile('profile');

  final String path;
  const AppRoute(this.path);
}

class RouteGenerator {
  // Ham tinh xu ly moi route
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // Tìm kiếm enum dựa trên tên route truyền vào
    // Nếu không tìm thấy (null), mặc định là home
    final route = AppRoute.values.firstWhere(
        (e) => e.path == settings.name,
      orElse: () => AppRoute.home
    );

    // lay arguments (neu co)
    final args = settings.arguments;

    switch (route) {
      case AppRoute.home:
        return MaterialPageRoute(builder: (context) => HomePage());

      case AppRoute.product:
        // Giả sử bạn truyền vào đây là một Map hoặc Object
        if (args is String) {
          return MaterialPageRoute(
            builder: (context) => ProductDetailPage(productId: args),
          );
        }
        // neu sai kieu du lieu, quay ve loi
        return _errorRoute();

      case AppRoute.profile:
        // VD: kiem tra dang nhap (Auth Guard)
        bool isLoggedIn = false; // gia su chua dang nhap
        if (isLoggedIn) {
          return MaterialPageRoute(builder: (_) => ProfilePage());
        }
        // Chua dang nhap -> chuyen ve login
        return MaterialPageRoute(builder: (_) => LoginPage());

      default:
        // route khong ton tai -> ve trang 404
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(
      builder: (context) {
        return Scaffold(
          appBar: AppBar(title: Text('Error')),
          body: Center(child: Text('Not found page!')),
        );
      },
    );
  }
}

class LoginPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login page'),),
    );
  }
}

class ProfilePage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Profile page'),),
    );
  }
}

class ProductDetailPage extends StatelessWidget {
  final String _productId;

  const ProductDetailPage({super.key, required this._productId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Product Detail page'),),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Home page'),),
    );
  }
}
