import 'dart:async';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:flutter/material.dart';

class NotificationService {
  // 1. single pattern - chi co 1 instance duy nhat
  NotificationService._internal();

  static final NotificationService _instance = NotificationService._internal();

  factory NotificationService() => _instance;

  // 2. instance cua plugin
  final _plugin = FlutterLocalNotificationsPlugin();

  // 3. Kenh Android (quan trong: chanel id la duy nhat)
  static const String channelId = 'my_notification_channel';
  static const String channelName = 'Thông báo ứng dụng';
  static const String channelDescription = 'Kênh nhận thông báo từ ứng dụng';

  // 4. Stream controller de lang nghe su kien notification duoc tap
  final StreamController<NotificationResponse> _onNotificationTapController =
      StreamController<NotificationResponse>.broadcast();

  Stream<NotificationResponse> get onNotificationTap =>
      _onNotificationTapController.stream;

  // khoi tao Notification Service - GOI 1 LAN DUY NHAT trong main()
  Future<void> init() async {
    // 4.1. Khoi tao cau hinh Android
    const androidSettings = AndroidInitializationSettings('ic_notification');

    // 4.2. Khoi tao cau hinh iOS
    const iosSettings = DarwinInitializationSettings(
      requestAlertPermission: true,
      // Xin quyền hiển thị nội dung thông báo trên màn hình của người dùng
      requestBadgePermission: true,
      // Xin quyền để báo hiệu số lượng thông báo chưa đọc.
      requestSoundPermission:
          true, // Xin quyền phát ra âm thanh báo hiệu khi có một thông báo mới gửi đến thiết bị.
    );

    const initSettings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );

    // 4.4. Khoi tao plugin voi callback xu ly khi tap
    await _plugin.initialize(
      settings: initSettings,
      onDidReceiveNotificationResponse: _onNotificationTap,
      onDidReceiveBackgroundNotificationResponse: _onNotificationTapBackground,
    );

    // 4.5. Khoi tao mui gio cho scheduling
    tz.initializeTimeZones();

    // 4.6. tao notification channel tren android
    await _createNotificationChannel();

    // 4.7. Xin quyen hien thi thong bao tren android 13.0+
    await _plugin
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >()
        ?.requestNotificationsPermission();
  }

  // tao notification channel (android 8.0+)
  Future<void> _createNotificationChannel() async {
    const channel = AndroidNotificationChannel(
      channelId,
      channelName,
      description: channelDescription,
      importance: Importance.high,
      playSound: true,
      enableVibration: true,
    );

    await _plugin
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >()
        ?.createNotificationChannel(channel);
  }

  // xu ly khi tap notification (app dang mo - foreground)
  void _onNotificationTap(NotificationResponse resp) {
    _onNotificationTapController.add(resp);
    _handleNotificaionTap(resp);
  }

  // xu ly khi tap notification (app dang chay ngam - background)
  static void _onNotificationTapBackground(NotificationResponse resp) {
    print('Background notification tapped: ${resp.payload}');
  }

  // xu ly logic khi tap notification (navigator, mo man hinh...)
  void _handleNotificaionTap(NotificationResponse resp) {
    final String? payload = resp.payload;
    if (payload != null && payload.isNotEmpty) {
      // phan tich payload de dieu huong man hinh phu hop
      // VD: payload = 'screen:detail&id=123'
      print('Dieu huong den: $payload');
    }
  }

  // huy service khi khong dung nua
  void dispose() {
    _onNotificationTapController.close();
  }

  // 5. Cac loai thong bao
  // 5.1. Thong bao co ban (Instant Notification)
  // Hien thi thong bao ngay lap tuc
  Future<void> showBasicNotification({
    required int id,
    required String title,
    required String body,
    String? payload,
    String? imagePath,
  }) async {
    // cau hinh cho android
    final androidDetails = AndroidNotificationDetails(
      channelId,
      channelName,
      channelDescription: channelDescription,
      importance: Importance.high,
      priority: Priority.high,
      playSound: true,
      enableVibration: true,
      styleInformation: imagePath != null
          ? BigPictureStyleInformation(
              FilePathAndroidBitmap(imagePath),
              largeIcon: FilePathAndroidBitmap(imagePath),
              contentTitle: title,
              summaryText: body,
            )
          : null,
    );

    const iosDetails = DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    final details = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );

    await _plugin.show(
      id: id,
      title: title,
      body: body,
      notificationDetails: details,
      payload: payload,
    );
  }

  // 5.2. Thong bao len lich (Scheduled Notification)
  // Len lich thong bao vao thoi diem cu the
  Future<void> scheduleNotification({
    required int id,
    required String title,
    required String body,
    required DateTime scheduleTime,
    String? payload,
  }) async {
    // xin quyen hen gio tren android
    final androidPlugin = _plugin
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >();

    if (androidPlugin != null) {
      final bool? hasPermission = await androidPlugin
          .canScheduleExactNotifications();
      if (hasPermission == false) {
        // yeu cau nguoi dung cap quyen
        await androidPlugin.requestExactAlarmsPermission();
        // neu ho van tu choi --> dung ham, khong hen gio nua de tranh crash
        final bool? recheck = await androidPlugin
            .canScheduleExactNotifications();
        if (recheck == false) {
          print('Nguoi dung tu choi cap quyen hen gio!');
          return;
        }
      }
    }

    // chuyen doi sang TZDateTime de ho tro mui gio
    final scheduleTZ = tz.TZDateTime.from(scheduleTime, tz.local);
    final androidDetails = AndroidNotificationDetails(
      channelId,
      channelName,
      channelDescription: channelDescription,
      importance: Importance.high,
      priority: Priority.high,
      playSound: true,
      enableVibration: true,
    );

    const iosDetails = DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    final details = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );

    await _plugin.zonedSchedule(
      id: id,
      title: title,
      body: body,
      scheduledDate: scheduleTZ,
      notificationDetails: details,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      payload: payload,
    );
  }

  // 5.3. Thong bao lap lai (repeat notification)
  // thong bao lap lai theo khoang thoi gian
  Future<void> showRepeatingNotification({
    required int id,
    required String title,
    required String body,
    required RepeatInterval repeatInterval,
    String? payload,
  }) async {
    final androidDetails = AndroidNotificationDetails(
      channelId,
      channelName,
      channelDescription: channelDescription,
      importance: Importance.high,
      priority: Priority.high,
      playSound: true,
      enableVibration: true,
    );

    const iosDetails = DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    final details = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );

    await _plugin.periodicallyShow(
      id: id,
      title: title,
      body: body,
      repeatInterval: repeatInterval,
      notificationDetails: details,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      payload: payload,
    );
  }

  // 5.4. Thong bao hang ngay vao gio co dinh
  // Len lich thong bao hang ngay vao gio cu the
  Future<void> scheduleDailyNotification({
    required int id,
    required String title,
    required String body,
    required int hour,
    required int minute,
    String? payload,
  }) async {
    // lay thoi gian hien tai
    final DateTime now = DateTime.now();

    // tao thoi gian dich trong ngay hom nay
    DateTime scheduleDate = DateTime(
      now.year,
      now.month,
      now.day,
      hour,
      minute,
    );

    // neu thoi gian da qua -> len lich cho ngay mai
    if (scheduleDate.isBefore(now)) {
      scheduleDate = scheduleDate.add(const Duration(days: 1));
    }

    final scheduleTZ = tz.TZDateTime.from(scheduleDate, tz.local);

    final andoirdDetails = AndroidNotificationDetails(
      channelId,
      channelName,
      channelDescription: channelDescription,
      importance: Importance.high,
      priority: Priority.high,
      playSound: true,
      enableVibration: true,
    );

    const iosDetails = DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    final details = NotificationDetails(
      android: andoirdDetails,
      iOS: iosDetails,
    );

    await _plugin.zonedSchedule(
      id: id,
      title: title,
      body: body,
      scheduledDate: scheduleTZ,
      notificationDetails: details,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      payload: payload,
      // repeatDaily de lap lai moi ngay
      matchDateTimeComponents: DateTimeComponents.time,
    );
  }

  // 6. Xin quyen hien thi thong bao
  // xin quyen hien thi thong bao
  Future<bool> requestPermissions() async {
    // Android 13+ can xin quyen POST_NOTIFICATIONS
    // iOS tu dong xin khi goi requestPermissions

    final bool? granted = await _plugin
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >()
        ?.requestNotificationsPermission();

    // iOS - goi requestPermissions neu can
    final bool? iosGranted = await _plugin
        .resolvePlatformSpecificImplementation<
          IOSFlutterLocalNotificationsPlugin
        >()
        ?.requestPermissions(alert: true, badge: true, sound: true);

    return granted == true || iosGranted == true;
  }

  // kiem tra xem da co quyen chua
  Future<bool> checkPermissions() async {
    final bool? androidGranted = await _plugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()?.areNotificationsEnabled();

    final NotificationsEnabledOptions? iosGranted = await _plugin.resolvePlatformSpecificImplementation<IOSFlutterLocalNotificationsPlugin>()?.checkPermissions();

    return androidGranted == true || iosGranted == true;
  }

  // 7. Huy thong bao
  // Huy thong bao theo id
  Future<void> cancelNotification(int id) async {
    await _plugin.cancel(id: id);
  }

  // Huy tat ca thong bao da len lich
  Future<void> cancelAllNotifications() async {
    await _plugin.cancelAll();
  }

  // Lay danh sach thong bao dang cho
  Future<List<PendingNotificationRequest>> getPendingNotifications() async {
    return await _plugin.pendingNotificationRequests();
  }
}
