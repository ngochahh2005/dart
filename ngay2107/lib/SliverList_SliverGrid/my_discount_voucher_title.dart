import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// 3. SliverToBoxAdapter: Tiêu đề "Ưu đãi cho bạn".

class MyDiscountVoucherTitle extends StatelessWidget {
  const MyDiscountVoucherTitle({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.fromLTRB(16, 20, 16, 8),
        child: Row(
          spacing: 4,
          children: [
            Icon(CupertinoIcons.gift_fill, color: Colors.pink[100],),
            Text(
              'Mã giảm giá cho bạn',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ],
        )
      ),
    );
  }
}