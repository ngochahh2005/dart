import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:meow_collector/features/favorites/bloc/favorite_event.dart';
import 'package:meow_collector/models/favorite_cat.dart';
import 'package:meow_collector/routes/app_router.dart';
import '../../features/favorites/bloc/favorite_bloc.dart';
import '../../features/favorites/bloc/favorite_state.dart';

class FavoriteCatCard extends StatelessWidget {
  final FavoriteCat favoriteCat;

  const FavoriteCatCard({required this.favoriteCat, super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      clipBehavior: Clip.antiAlias,
      child: GestureDetector(
        onTap: () {
          context.push(
            AppRoute.detail.path.replaceFirst(':id', favoriteCat.id),
            extra: favoriteCat,
          );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Hero(
                tag: 'cat-image-${favoriteCat.id}',
                child: CachedNetworkImage(
                  imageUrl: favoriteCat.imageUrl,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => Container(
                    color: Colors.grey[300],
                    child: const Icon(Icons.pets, size: 40),
                  ),
                  errorWidget: (context, url, error) =>
                      const Icon(Icons.broken_image, size: 40),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      favoriteCat.breedName,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  IconButton(
                    icon: BlocBuilder<FavoriteBloc, FavoriteState>(
                      builder: (context, state) {
                        bool isFav = true;
                        if (state is FavoriteLoaded) {
                          isFav = state.favorites.any(
                            (f) => f.id == favoriteCat.id,
                          );
                        }
                        return Icon(
                          isFav ? Icons.favorite : Icons.favorite_border,
                          color: isFav ? Colors.red : null,
                        );
                      },
                    ),
                    onPressed: () {
                      context.read<FavoriteBloc>().add(
                        FavoriteRemove(catId: favoriteCat.id),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
