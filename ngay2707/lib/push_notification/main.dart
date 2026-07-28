import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:ngay2707/firebase_options.dart';
import 'package:ngay2707/push_notification/services/notification_service.dart';
import '../push_notification/screen/home_screen.dart';
import '../push_notification/screen/detail_screen.dart';

// khai bao NavigatorKey toan cuc de co the chuyen trang tu Service
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // khoi tao firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );

  // dang ky background handler
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandle);

  // khoi tao cau hinh thong bao khac
  await NotificationService().initNotifications();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Push Notification',
      navigatorKey: navigatorKey,
      theme: ThemeData(
        primarySwatch: Colors.blue
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => HomeScreen(),
        '/detail': (context) => DetailScreen()
      },
    );
  }
}

