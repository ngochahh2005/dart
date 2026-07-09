import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/*
  ShellRoute - Điều hướng với giao diện cố định
  ShellRoute là một loại route đặc biệt dùng để tạo giao diện khung (shell) bao quanh các route con.
  Rất hữu ích cho BottomNavigationBar hoặc Sidebar.
 */

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Trang chủ')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Chào mừng bạn đến với ứng dụng!',
              style: TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Điều hướng đến Profile (mặc định sẽ vào settings vì không có route con nào được chỉ định)
                // ShellRoute sẽ hiển thị route con đầu tiên trong danh sách (settings)
                context.go('/profile/settings');
              },
              child: const Text('Xem Profile'),
            ),
          ],
        ),
      ),
    );
  }
}

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(16.0),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.settings, size: 60, color: Colors.blue),
            SizedBox(height: 16),
            Text(
              'Trang Cài đặt',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text('Đây là nội dung của màn hình Cài đặt.'),
          ],
        ),
      ),
    );
  }
}

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(16.0),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.shopping_bag, size: 60, color: Colors.green),
            SizedBox(height: 16),
            Text(
              'Trang Đơn hàng',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text('Danh sách đơn hàng của bạn sẽ xuất hiện ở đây.'),
          ],
        ),
      ),
    );
  }
}

class ProfileScreen extends StatefulWidget {
  final Widget child;

  const ProfileScreen({super.key, required this.child});

  @override
  State<StatefulWidget> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool isSidebarExpanded = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hồ sơ cá nhân'),
        backgroundColor: Colors.blueGrey,
        leading: IconButton(
          alignment: Alignment.centerLeft,
          onPressed: () {
            context.go('/');
          },
          icon: Icon(Icons.arrow_back_ios_new),
        ),
        actions: [
          IconButton(
            icon: Icon(isSidebarExpanded ? Icons.menu_open : Icons.menu),
            onPressed: () {
              setState(() {
                isSidebarExpanded = !isSidebarExpanded; // Đảo ngược trạng thái
              });
            },
          ),
        ],
      ),
      body: Row(
        children: [
          // Sidebar (hoặc menu điều hướng bên trong Profile)
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            width: isSidebarExpanded ? 200 : 0,
            clipBehavior: Clip.hardEdge, // Cắt bỏ mọi thứ dư thừa khi thu hẹp
            color: Colors.grey.shade200,
            child:
            isSidebarExpanded
            ? Column(
              children: [
                const SizedBox(height: 20),
                // Nút đi đến Settings
                ListTile(
                  leading: const Icon(Icons.settings),
                  title: const Text('Cài đặt'),
                  onTap: () {
                    // Điều hướng đến route con settings
                    context.go('/profile/settings');
                  },
                ),
                // Nút đi đến Orders
                ListTile(
                  leading: const Icon(Icons.shopping_bag),
                  title: const Text('Đơn hàng'),
                  onTap: () {
                    // Điều hướng đến route con orders
                    context.go('/profile/orders');
                  },
                ),
              ],
            ) : const SizedBox.shrink(),  // Trả về widget rỗng khi đóng
          ),
          // Phần nội dung chính (hiển thị route con)
          Expanded(
            child: widget.child, // child là SettingsScreen hoặc OrdersScreen
          ),
        ],
      ),
    );
  }
}


