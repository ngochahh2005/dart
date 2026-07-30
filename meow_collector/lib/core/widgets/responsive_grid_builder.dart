import 'package:flutter/material.dart';
import '../../models/cat_breed.dart';
import 'cat_card.dart';

class ResponsiveGridBuilder extends StatelessWidget {
  final List<CatBreed> breeds;

  const ResponsiveGridBuilder({super.key, required this.breeds});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final maxWidth = constraints.maxWidth;
        int crossAxisCount;
        if (maxWidth < 600) {
          crossAxisCount = 2;
        } else if (maxWidth < 1200) {
          crossAxisCount = 3;
        } else {
          crossAxisCount = 4;
        }
        return GridView.builder(
          padding: const EdgeInsets.all(8),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            childAspectRatio: 0.7,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
          ),
          itemCount: breeds.length,
          itemBuilder: (context, index) {
            final breed = breeds[index];
            return CatCard(breed: breed);
          },
        );
      },
    );
  }
}