import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:ngay2707/push_notification/main.dart';

// Xu ly Background message
// Hàm xử lý background phải là top-level function (không nằm trong class)
// Phải gọi Firebase.initializeApp() bên trong handler
@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandle(RemoteMessage msg) async {
  // BAT BUOC: khoi tao firebase trong isolate background
  await Firebase.initializeApp();

  print('Xu ly message o background');
  print('Data: ${msg.data}');

  if (msg.notification != null) {
    print('Title: ${msg.notification?.title}');
    print('Body: ${msg.notification?.body}');
  }
}

class NotificationService {
  NotificationService._internal();

  static final _instance = NotificationService._internal();

  factory NotificationService() => _instance;

  // tao instance cua FirebaseMessaging
  final _firebaseMessaging = FirebaseMessaging.instance;

  // instance cho local notifications (dung de tao channel)
  final _plugin = FlutterLocalNotificationsPlugin();

  // khoi tao toan bo cau hinh thong bao
  Future<void> initNotifications() async {
    const initializationSettingsAndroid = AndroidInitializationSettings('ic_notification');
    const initializstionSettings = InitializationSettings(android: initializationSettingsAndroid);
    await _plugin.initialize(settings: initializstionSettings);

    // xin quyen thong bao
    await requestNotificationPermission();

    // tao channel cho android
    await createNotificationChannel();

    await setupForegroundMessageHandler();

    // lay fcm token lan dau khi mo app
    await getFCMToken();

    // lang nghe neu he thong firebase tu dong doi token
    listenTokenRefresh();
  }

  // xin quyen thong bao (iOS & Android 13+)
  Future<void> requestNotificationPermission() async {
    final settings = await _firebaseMessaging.requestPermission(
      alert: true,
      // cho phep hien thi alert
      badge: true,
      // cho phep hien thi badge
      sound: true,
      // cho phep phat am thanh
      provisional: false,
      // cho phep thong bao tam thoi (iOS)
      carPlay: false,
      // cho phep hien thi tren CarPlay
      criticalAlert: false,
      // cho phep alert quan trong (iOS)
      announcement: false, // cho phep thong bao dang announcement (iOS)
    );

    print('User granted permission: ${settings.authorizationStatus}');

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User da cho phep thong bao');
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      print('User cho phep tam thoi (provisional)');
    } else {
      print('User tu choi thong bao');
    }
  }

  // Tạo Notification Channel (Dành riêng cho Android)
  // Bắt buộc trên Android - không có channel, thông báo có thể không hiển thị hoặc hiển thị âm thầm.
  Future<void> createNotificationChannel() async {
    const channel = AndroidNotificationChannel(
      'high_importance_channel', // id cua channel - phai la duy nhat
      'High Importance Notifications', // ten hien thi
      description: 'Channel cho cac thong bao quan trong',
      importance: Importance.high, // muc do quan trong
      playSound: true,
      showBadge: true,
    );

    await _plugin
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >()
        ?.createNotificationChannel(channel);
  }

  // Cau hinh hien thi Foreground tren iOS
  Future<void> setupForegroundNotification() async {
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
          alert: true, // hien thi thong bao khi app dang foreground
          badge: true,
          sound: true,
        );
  }

  // Xu ly Foreground Message
  // FCM KHÔNG tự động hiển thị thông báo khi app đang ở foreground. Phải xử lý thủ công.
  Future<void> setupForegroundMessageHandler() async {
    FirebaseMessaging.onMessage.listen((RemoteMessage msg) {
      print('Nhan message khi app dang foreground!');
      print('Data: ${msg.data}');

      // kiem tra xem notification co payload khong
      if (msg.notification != null) {
        print('Title: ${msg.notification?.title}');
        print('Body: ${msg.notification?.body}');

        // hien thi thu cong bang local notificaiton
        _showLocalNotification(
          title: msg.notification?.title ?? 'Thong bao',
          body: msg.notification?.body ?? '',
          payload: msg.data,
        );
      }
    });
  }

  Future<void> _showLocalNotification({
    required String title,
    required String body,
    Map<String, dynamic>? payload,
  }) async {
    final androidDetails = AndroidNotificationDetails(
      'high_importance_channel', // phai khop voi channel da tao
      'High Importance Notifications',
      importance: Importance.max,
      priority: Priority.high,
      showWhen: true,
    );

    final details = NotificationDetails(android: androidDetails);

    await _plugin.show(
      id: 0, // id - nen la unique
      title: title,
      body: body,
      notificationDetails: details,
    );
  }

  // Xu ly khi nguoi dung bam vao thong bao
  // Hàm lắng nghe sự kiện bấm thông báo khi màn hình chính load lên
  Future<void> setupInteractions() async {
    await handleInitialMessage();
    handleNotifications();
  }

  // Kich ban 1: App dang o background --> nguoi dung bam thong bao --> app mo len foreground
  Future<void> handleNotifications() async {
    // lang nghe su kien khi app duoc mo tu thong bao (background -> foreground)
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage msg) {
      print('Nguoi dung bam vao thong bao khi app dang background!');
      _handleNavigation(msg.data);
    });
  }

  // Kich ban 2: App da bi terminated -> bam thong bao -> khoi dong lai
  Future<void> handleInitialMessage() async {
    RemoteMessage? msg = await _firebaseMessaging.getInitialMessage();

    if (msg != null) {
      print('App da duoc mo tu trang thai terminate qua thong bao!');
      // dung postFrameCallBack de dam bao UI da render xong xuoi roi moi chuyen trang
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _handleNavigation(msg.data);
      });
    }
  }

  // xu ly dieu huong tu payload
  void _handleNavigation(Map<String, dynamic> data) {
    // lay thong tin tu payload
    String? screen = data['screen'];
    String? id = data['id'];

    print('Dieu huong den: $screen voi id: $id');

    // vi du: dieu huong den man hinh chi tiet
    if (screen == 'detail' && id != null) {
      navigatorKey.currentState?.pushNamed('/detail', arguments: id);
    }
  }

  Future<void> getFCMToken() async {
    try {
      String? token = await _firebaseMessaging.getToken();
      print('FCM Token: $token');

      if (token != null) {
        // TODO: Bắn token này qua REST API để lưu vào database.
        // Ví dụ: Khi user đăng nhập thành công, gửi token này kèm user_id
        // lên server Spring Boot để hệ thống biết máy nào của user nào.
        // await apiService.saveTokenToServer(token);
      }
    } catch (e) {
      print('Loi khi lay FCM Token: $e');
    }
  }

  // lang nghe su kien token bi thay doi
  void listenTokenRefresh() {
    _firebaseMessaging.onTokenRefresh
        .listen((String newToken) {
          // TODO: Khi nhận được token mới, cần gọi API cập nhật ngay
          // để các luồng gửi thông báo từ server không bị gián đoạn.
          // await apiService.updateTokenOnServer(newToken);
        })
        .onError((error) {
          print('Loi khi refresh token: $error');
        });
  }
}
