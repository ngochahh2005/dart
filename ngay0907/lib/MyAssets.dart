import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/*
  1. AssetBundle – đối tượng quản lý assets:
  Ứng dụng truy cập assets thông qua đối tượng AssetBundle.
  AssetBundle cung cấp hai phương thức chính:
  - loadString(): Tải asset dạng văn bản / chuỗi
  - load(): Tải asset dạng nhị phân (hình ảnh, dữ liệu thô)

  2. rootBundle – asset bundle mặc định
  Mỗi ứng dụng Flutter có một đối tượng rootBundle để truy cập dễ dàng vào asset bundle chính
 */

// CÁCH 1: Dùng rootBundle (không cần context, dùng ở bất cứ đâu)
Future<String> loadTitleString() async {
  return await rootBundle.loadString('assets/text/title.txt');
}

/*
  3. Nên dùng DefaultAssetBundle thay vì rootBundle trực tiếp
    Khuyến nghị: Nên sử dụng DefaultAssetBundle.of(context) thay vì dùng rootBundle trực tiếp.
    Lý do:
    - Cho phép widget cha thay thế AssetBundle khác trong thời gian chạy
    - Hữu ích cho việc localization (đa ngôn ngữ) và testing (kiểm thử)
    - Linh hoạt hơn so với việc phụ thuộc cứng vào rootBundle
 */
// CÁCH 2: Dùng DefaultAssetBundle (cần truyền context từ Widget)
Future<String> loadTitleWithContext(BuildContext context) async {
  return await DefaultAssetBundle.of(context).loadString('assets/text/title/txt');
}

class MyAssets extends StatelessWidget {
  const MyAssets({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('My assets'), backgroundColor: Colors.lime),

      body: Center(
        // Hoặc gọi trực tiếp ở trong Widget 
        child: FutureBuilder(
          future: DefaultAssetBundle.of(
            context,
          ).loadString('assets/text/title.txt'),
          builder: (context, snapshot) {
            if (snapshot.hasData) return Text(snapshot.data!);
            return SizedBox();
          },
        ),
      ),
    );
  }
}
