import 'package:flutter/material.dart';

class MyDiscountVoucher extends StatelessWidget {
  const MyDiscountVoucher({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
            (context, index) {
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
            color: Colors.white,
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.green.shade100,
                child: Text('${index + 1}', style: const TextStyle(color: Colors.green)),
              ),
              title: Text('Giảm ${(index + 1) * 5}% cho đơn hàng ${(index + 1) * 100}k',),
              subtitle: const Text('Hạn sử dụng: 31/12/2026'),
              trailing: const Chip(
                label: Text('Lấy mã', style: TextStyle(color: Colors.white)),
                backgroundColor: Colors.red,
              ),
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Đã sao chép mã giảm giá!')),
                );
              },
            ),
          );
        },
        childCount: 10, // 10 mã giảm giá
        addAutomaticKeepAlives: true,
      ),
    );
  }
}