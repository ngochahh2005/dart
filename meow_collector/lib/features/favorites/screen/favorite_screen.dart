import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meow_collector/core/widgets/favorite_cat_card.dart';
import 'package:meow_collector/features/favorites/bloc/favorite_bloc.dart';

import '../bloc/favorite_state.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Favorite Screen')),
      body: BlocConsumer<FavoriteBloc, FavoriteState>(
        listener: (context, state) {
          if (state is FavoriteError) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        builder: (context, state) {
          if (state is FavoriteLoading) {
            return const Center(child: CircularProgressIndicator(),);
          }

          if (state is FavoriteLoaded) {
            final favorites = state.favorites;
            if (favorites.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  spacing: 24,
                  children: [
                    Text('No favorites yet!'),
                    Text('Send some love to your beloved cats!')
                  ],
                ),
              );
            }
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
                  itemCount: favorites.length,
                  itemBuilder: (context, index) {
                    final favoriteCat = favorites[index];
                    return FavoriteCatCard(favoriteCat: favoriteCat,);
                  },
                );
              },
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}
