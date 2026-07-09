import 'package:flutter/material.dart';
import 'GoRouter_2.dart';
import 'package:go_router/go_router.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final GoRouter _goRouter = GoRouter(
    routes: [
    //   GoRoute(
    //     path: '/',
        // builder: (context, state) => HomeScreen(),
        // Hoặc dùng pageBuilder để tùy chỉnh hiệu ứng chuyển tiếp
      //   pageBuilder: (context, state) {
      //     return CustomTransitionPage(
      //       key: state.pageKey,
      //       child: HomeScreen(),
      //       transitionsBuilder:
      //           (context, animation, secondaryAnimation, child) {
      //             return FadeTransition(
      //               opacity: CurveTween(
      //                 curve: Curves.easeInOut,
      //               ).animate(animation),
      //               child: child,
      //             );
      //           },
      //     );
      //   },
      // ),

      // GoRoute(
      //   path: '/product/:id',
      //   builder: (context, state) {
      //     final id = state.pathParameters['id'] ?? '';
      //     final filterValue = state.uri.queryParameters['filter'];
      //     return ProductScreen(productId: id, filter: filterValue,);
      //   },
      // ),
      // GoRoute(
      //   path: '/profile',
      //   builder: (context, state) {
      //     return ProfileScreen();
      //   },
      // ),
    ],
  );

  // GoRouter lồng nhau (Nested Routes)
  // Khi một màn hình có các màn hình con bên trong (ví dụ: TabBar trong Profile), bạn dùng nested routes:
  final GoRouter _goRouter2 = GoRouter(
    initialLocation: '/',
    routes: [
      // Route Home
      GoRoute(path: '/', builder: (context, state) => HomeScreen()),

      // // ShellRoute cho Profile (bao gồm các route con: settings, orders)
      ShellRoute(
        builder: (context, state, child) {
          // Widget "shell" bao quanh các route con bên trong Profile
          return ProfileScreen(child: child);
        },
        routes: [
          // Route con: Settings
          GoRoute(
            path: '/profile/settings',
            builder: (context, state) => SettingsScreen(),
          ),

          // Route con: Orders
          GoRoute(path: '/profile/orders', builder: (context, state) => OrdersScreen()),
        ],
      ),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(routerConfig: _goRouter2, title: 'Nested Routes with ShellRoute');
  }

  // @override
  // Widget build(BuildContext context) {
  // return MaterialApp(
  //   title: 'Flutter Demo',
  //   theme: ThemeData(
  //     colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
  //   ),
  // Không dùng 'routes' nữa, mà dùng 'onGenerateRoute'
  // onGenerateRoute: RouteGenerator.generateRoute,
  // initialRoute: '/',

  // Khai báo trong MaterialApp
  // routes: {
  //   '/': (context) => MyHomePage(),
  //   '/second': (context) => SecondPage(),
  // },
  // );
  // }
}
