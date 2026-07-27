import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import '../local_notification/services/notification_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NotificationService().init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Local Notification',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const HomePage()
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          spacing: 12,
          children: [
            ElevatedButton(
              onPressed: () async {
                await NotificationService().showBasicNotification(
                  id: 1,
                  title: 'Thông báo test mới!',
                  body: 'Chạm vào đây để xem chi tiết.',
                  payload: 'screen:order_detail&coffee_id=456',
                );
              },
              child: const Text('Bắn thông báo test'),
            ),

            ElevatedButton(
              onPressed: () async {
                final scheduleTime = DateTime.now().add(
                  const Duration(seconds: 5),
                );

                await NotificationService().scheduleNotification(
                  id: 2,
                  title: 'Bip bip! Da het 5 giay!',
                  body: 'Day la thong bao duoc len lich tu truoc',
                  scheduleTime: scheduleTime,
                  payload: 'screen:alarm',
                );
                print('Da dat lich thanh cong luc: $scheduleTime');
              },
              child: const Text('Hen gio thong bao (5 giay sau)'),
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () async {
                    await NotificationService().showRepeatingNotification(
                      id: 3,
                      title: 'Thong bao lap lai',
                      body: 'Cu dung 1 phut se hien ra 1 lan',
                      repeatInterval: RepeatInterval.everyMinute,
                      payload: 'screen:reminder',
                    );
                    print('Da bat thong bao lap lai moi phut');
                  },
                  child: const Text('Bat lap lai (moi phut)'),
                ),

                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.redAccent,
                  ),
                  onPressed: () async {
                    await NotificationService().cancelNotification(3);
                    print('Da tat thong bao lap lai');
                  },
                  child: const Text(
                    'Tat lap lai',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () async {
                    final now = DateTime.now();
                    final testTime = now.add(const Duration(minutes: 1));

                    await NotificationService().scheduleDailyNotification(
                      id: 4,
                      title: 'Nhac nho moi ngay',
                      body: 'Da den gio lam viec roi, mo app len thoi!',
                      hour: testTime.hour,
                      minute: testTime.minute,
                      payload: 'screen:daily_routine',
                    );

                    print(
                      'Da dat lich nhac lai hang ngay vao luc: $testTime}',
                    );
                  },
                  child: const Text('Bat nhac nho'),
                ),

                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.redAccent,
                  ),
                  onPressed: () async {
                    await NotificationService().cancelNotification(4);
                    print('Da tat thong bao lap lai hang ngay');
                  },
                  child: const Text(
                    'Tat lap lai hang ngay',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),

            const Divider(),

            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
              onPressed: () async {
                final isGranted = await NotificationService()
                    .checkPermissions();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      isGranted
                          ? 'Đã có quyền thông báo'
                          : 'Chưa có quyền thông báo',
                    ),
                    duration: const Duration(seconds: 2),
                  ),
                );
                print('Trang thai quyen hien tai: $isGranted');
              },
              child: const Text(
                'Kiem tra quyen',
                style: TextStyle(color: Colors.white),
              ),
            ),

            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
              onPressed: () async {
                final isGranted = await NotificationService()
                    .requestPermissions();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      isGranted
                          ? 'Cap quyen thanh cong'
                          : 'Bi tu choi cap quyen',
                    ),
                    duration: const Duration(seconds: 2),
                  ),
                );
                print('Ket qua xin cap quyen: $isGranted');
              },
              child: const Text(
                'Xin cap quyen ngay',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
