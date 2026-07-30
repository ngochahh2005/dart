import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../features/favorites/bloc/favorite_bloc.dart';
import '../../features/favorites/bloc/favorite_state.dart';
import '../../features/home/bloc/home_bloc.dart';
import '../../features/home/bloc/home_event.dart';
import '../../models/cat_breed.dart';
import '../../routes/app_router.dart';

class CatCard extends StatelessWidget {
  final CatBreed breed;

  const CatCard({super.key, required this.breed});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () {
          context.push(
            AppRoute.detail.path.replaceFirst(':id', breed.id),
            extra: breed,
          );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Hero(
                tag: 'cat-image-${breed.id}',
                child: breed.thumbnailUrl != null
                    ? CachedNetworkImage(
                        imageUrl: breed.thumbnailUrl!,
                        fit: BoxFit.cover,
                        placeholder: (context, url) => Container(
                          color: Colors.grey[300],
                          child: const Icon(Icons.pets, size: 40),
                        ),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.broken_image, size: 40),
                      )
                    : Container(
                        color: Colors.grey[300],
                        child: const Icon(Icons.image_not_supported, size: 40),
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
                      breed.name,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  IconButton(
                    icon: BlocBuilder<FavoriteBloc, FavoriteState>(
                      builder: (context, state) {
                        bool isFav = false;
                        if (state is FavoriteLoaded) {
                          isFav = state.favorites.any((f) => f.id == breed.id);
                        }
                        return Icon(
                          isFav ? Icons.favorite : Icons.favorite_border,
                          color: isFav ? Colors.red : null,
                        );
                      },
                    ),
                    onPressed: () {
                      context.read<HomeBloc>().add(HomeToggleFavorite(breed));
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
