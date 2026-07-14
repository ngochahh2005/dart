import 'package:flutter/material.dart';
import 'package:get/get.dart';

/*
  1. Giới thiệu về GetX
  - GetX là một giải pháp all-in-one cực kỳ nhẹ và mạnh mẽ cho Flutter, kết hợp 3 tính năng chính trong một gói duy nhất:
    + Quản lý trạng thái (State Management): Hiệu suất cao, không dùng Streams hay ChangeNotifier
    + Dependency Injection: Nạp phụ thuộc thông minh, tự động lazy-load
    + Quản lý Route (Navigation): Điều hướng không cần context
  - Ba nguyên tắc cốt lõi của GetX: PRODUCTIVITY (năng suất), PERFORMANCE (hiệu suất) và ORGANIZATION (tổ chức)

  2. Cài đặt
  Bước 1: Thêm vào pubspec.yaml
    dependencies:
      get: ^4.7.3  # hoặc phiên bản mới nhất
  Bước 2: Chạy lệnh
    flutter pub get
  Bước 3: Import trong file Dart
    import 'package:get/get.dart';

  3. Quản lý trạng thái (State Management)
  GetX có hai loại quản lý trạng thái: Simple (GetBuilder) và Reactive (Obx/GetX).
  3.1. Simple State Management (getBuilder):
  Sử dụng GetBuilder + update(). Phù hợp với các trạng thái đơn giản, ít thay đổi
*/

// Tao controller
class CounterController extends GetxController {
  int cnt = 0;

  void increment() {
    cnt++;
    update(); // goi update() de cap nhat UI
  }
}

// Su dung trong View
class CounterPage extends StatelessWidget {
  final controller = Get.put(CounterController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('GetBuilder App'),
        backgroundColor: Colors.lime,
      ),
      body: Center(
        child: GetBuilder<CounterController>(
          builder: (context) => Text('Count ${controller.cnt}'),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: controller.increment,
        child: Icon(Icons.add),
      ),
    );
  }
}

/*
  3.2. Reactive State Management (Phản ứng)
  Sử dụng khi bạn muốn giao diện tự động cập nhật khi dữ liệu thay đổi.
  - Bước 1: Khai báo biến với .obs
    var count = 0.obs;
  - Bước 2: Sử dụng Obx để hiển thị
    Obx(() => Text("${count.value}"))
  - Bước 3: Cập nhật giá trị
    count++; // Tự động trigger UI update
*/

// Tao controller voi bien .obs
class ReactiveController extends GetxController {
  var cnt = 0.obs; // .obs lam cho bien tro thanh reactive

  void increment() => cnt++;
}

// Su dung trong View
class ReactivePage extends StatelessWidget {
  final controller = Get.put(ReactiveController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reactive app'),
        backgroundColor: Colors.yellow,
      ),
      body: Center(child: Obx(() => Text('Count ${controller.cnt}'))),
      floatingActionButton: FloatingActionButton(
        onPressed: controller.increment,
        child: Icon(Icons.add),
      ),
    );
  }
}
// So sánh nhanh: GetBuilder nhẹ hơn, chỉ rebuild khi gọi update().
// Obx tiện lợi hơn, tự động rebuild khi biến .obs thay đổi.

/*
  4. Dependency Injection (Quản lý phụ thuộc)
  - Giúp tách biệt logic khỏi giao diện và quản lý vòng đời của Controller.
  - Các phương thức chính:
    + Get.put(): Khởi tạo và đăng ký instance ngay lập tức
    + Get.lazyPut(): Khởi tạo khi lần đầu được gọi (lazy-load)
    + Get.find(): Tìm và trả về instance đã đăng ký
    + Get.delete(): Xóa instance khỏi bộ nhớ
*/

// Khoi tao controller
class ProductController extends GetxController {
  var products = <String>[].obs;

  @override
  void onInit() {
    super.onInit();
    // gia lap load du lieu tu api
    fetchProducts();
  }

  void fetchProducts() {
    products.addAll(['Laptop', 'Smart Phone', 'Tablet']);
  } // danh sach san pham (reactive)
}

// Binding (Cầu nối - "Nơi khai báo")
// Thay vì khởi tạo Controller ngay trong UI, ta tạo một file binding. Điều này giúp tách biệt code logic và UI.
class ProductBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ProductController());
  }
}

// View (Giao diện - "Nơi sử dụng")
// Bây giờ, tại View, bạn không cần truyền controller qua Constructor. Bạn chỉ việc "tìm" (find) nó.
class ProductView extends StatelessWidget {
  final ProductController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Dependency injection app')),
      body: Obx(
        () => ListView.builder(
          itemCount: controller.products.length,
          itemBuilder: (context, index) =>
              ListTile(title: Text(controller.products[index])),
        ),
      ),
    );
  }
}

/*
  5. Quản lý Route (Navigation)
  Để sử dụng tính năng này, cần đổi MaterialApp thành GetMaterialApp.
  - Chuyển trang: Get.to(NextPage());/Get.toNamed('<tên_route>');
  - Chuyển trang và xóa trang cũ: Get.off(NextPage()); (VD: từ Login -> Home thì ko thể về lại login)
  - Chuyển trang và xóa toàn bộ stack: Get.offAll(NextPage()); (VD: sau khi đăng xuất xong -> xóa toàn bộ stack)
  - Quay lại: Get.back();
 */
class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Home page'),
            ElevatedButton(
              onPressed: () {
                Get.toNamed('/products');
              },
              child: Text('Xem san pham'),
            ),
          ],
        ),
      ),
    );
  }
}
