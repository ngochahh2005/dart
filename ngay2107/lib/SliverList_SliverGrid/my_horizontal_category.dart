import 'package:flutter/material.dart';

// 2.2. SliverToBoxAdapter: Danh mục hàng ngang (Horizontal ListView)

class MyHorizontalCategory extends StatelessWidget {
  const MyHorizontalCategory({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: SizedBox(
        height: 100.0,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          itemCount: 8,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Column(
                children: [
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: Colors.primaries[index % Colors.primaries.length],
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    child: const Icon(Icons.category, color: Colors.white),
                  ),
                  const SizedBox(height: 4),
                  Text('Danh mục ${index + 1}', style: const TextStyle(fontSize: 11, fontFamily: 'k2d')),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}