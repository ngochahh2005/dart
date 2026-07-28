import 'package:flutter/material.dart';
import '../services/notification_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<StatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    // goi ham lang nghe su kien bam thong bao khi man hinh chinh load len
    NotificationService().setupInteractions();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home Screen'),),
      body: const Center(child: Text('Doi thong bao...'),),
    );
  }
}