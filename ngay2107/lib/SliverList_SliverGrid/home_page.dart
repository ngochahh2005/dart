import 'package:flutter/material.dart';
import 'my_sliver_app_bar.dart';
import 'my_banner.dart';
import 'my_horizontal_category.dart';
import 'my_discount_voucher_title.dart';
import 'my_discount_voucher.dart';
import 'my_product_grid.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  List<Map<String, String>> generateProducts() {
    return List.generate(50, (index) {
      return {
        'name': "Sản phẩm ${index + 1}",
        'price': '${(index + 1) * 10}.000đ',
        'color': Colors.primaries[index % Colors.primaries.length].value
            .toRadixString(16),
      };
    });
  }

  @override
  Widget build(BuildContext context) {
    final products = generateProducts();
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: CustomScrollView(
        // Tùy chỉnh vật lý cuộn (giống iOS hay Android)
        physics: const BouncingScrollPhysics(),
        slivers: [
          MySliverAppBar(),

          MyBanner(),

          MyHorizontalCategory(),

          MyDiscountVoucherTitle(),

          MyDiscountVoucher(),

          // 5. SliverToBoxAdapter: Tiêu đề "Gợi ý hôm nay"
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    spacing: 4,
                    children: [
                      Icon(Icons.recommend, color: Colors.pink[100]),
                      const Text(
                        'Gợi ý hôm nay',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      'Xem tất cả',
                      style: TextStyle(color: Colors.blue),
                    ),
                  ),
                ],
              ),
            ),
          ),

          MyProductGrid(products: products),

          // Khoảng trống cuối trang (Padding bottom)
          const SliverToBoxAdapter(child: SizedBox(height: 40.0)),
        ],
      ),
    );
  }
}