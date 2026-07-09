import 'package:flutter/material.dart';

/*
  5. HIỆU ỨNG CHUYỂN TIẾP TÙY CHỈNH (CUSTOM TRANSITIONS)
  Mặc định MaterialPageRoute là trượt từ phải sang trái.
  Bạn có thể dùng PageRouteBuilder để tạo hiệu ứng riêng.
 */

enum AppRoute {
  home('/'),
  product('/product'),
  login('/login'),
  profile('/profile');

  final String path;
  const AppRoute(this.path);
}

class RouteGenerator {
  static Route _createRoute(Widget page) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        // Hieu ung fade
        // return FadeTransition(opacity: animation, child: child,);

        // Hieu ung Slide

        // "bắt đầu từ cạnh phải màn hình" (x=1.0 theo chiều ngang, y=0 theo chiều dọc).
        // Khi bắt đầu hiệu ứng, màn hình mới sẽ nằm hoàn toàn bên ngoài mép phải màn hình cũ.
        const begin = Offset(1.0, 0);

        // Offset.zero tương đương với Offset(0, 0).
        // Đây là vị trí "chính giữa màn hình".
        // Khi kết thúc hiệu ứng, màn hình mới sẽ nằm khớp ngay tại vị trí trung tâm.
        const end = Offset.zero;
        var tween = Tween(begin: begin, end: end);
        return SlideTransition(position: animation.drive(tween), child: child,);
      },
      transitionDuration: Duration(milliseconds: 500),
    );
  }

  static Route<dynamic> generateRoute(RouteSettings settings) {
    final route = AppRoute.values.firstWhere(
      (e) => e.path == settings.name,
      orElse: () => AppRoute.home,
    );

    // lay arguments (neu co)
    final args = settings.arguments;

    switch (route) {
      case AppRoute.home:
        return _createRoute(HomePage());

      case AppRoute.login:
        return _createRoute(LoginPage());

      case AppRoute.product:
        if (args is String) {
          return _createRoute(ProductDetailPage(productId: args));
        }
        return _errorRoute();

      case AppRoute.profile:
        bool isLoggedIn = false;
        if (isLoggedIn) {
          return _createRoute(ProfilePage());
        }
        return _createRoute(LoginPage());

      default:
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

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login page'), backgroundColor: Colors.orange),
    );
  }
}

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Profile page'), backgroundColor: Colors.lime),
    );
  }
}

class ProductDetailPage extends StatelessWidget {
  final String _productId;

  const ProductDetailPage({super.key, required this._productId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product Detail page'),
        backgroundColor: Colors.blue[100],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Product ID: $_productId'),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Go Back'),
            ),
          ],
        ),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home page'),
        backgroundColor: Colors.deepPurple[100],
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.pushNamed(
              context,
              AppRoute.product.path,
              arguments: '123',
            );
          },
          child: Text('Go to Product Detail'),
        ),
      ),
    );
  }
}
