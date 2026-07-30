import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meow_collector/models/cat_breed.dart';
import 'package:meow_collector/services/api/cat_api_service.dart';

class DetailScreen extends StatefulWidget {
  final CatBreed? initialData;
  final String breedId;

  const DetailScreen({super.key, required this.breedId, this.initialData});

  @override
  State<StatefulWidget> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  late Future<CatBreed> _breed;

  @override
  void initState() {
    super.initState();
    _breed = CatApiService().fetchBreedById(widget.breedId);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<CatBreed>(
      future: _breed,
      initialData: widget.initialData,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        final breed = snapshot.data!;
        return Scaffold(
          appBar: AppBar(title: Text(breed.name)),
          body: SingleChildScrollView(
            child: Column(
              spacing: 12,
              children: [
                Hero(
                  tag: 'cat-image-${widget.breedId}',
                  child: breed.thumbnailUrl != null
                      ? CachedNetworkImage(
                          imageUrl: breed.thumbnailUrl!,
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: MediaQuery.of(context).size.height / 3,
                          placeholder: (context, url) => Container(
                            color: Colors.grey[300],
                            child: const Icon(Icons.pets, size: 40),
                          ),
                          errorWidget: (context, url, error) => Container(
                            width: double.infinity,
                            height: MediaQuery.of(context).size.height / 3,
                            color: Colors.grey[300],
                            child: const Icon(Icons.broken_image, size: 40),
                          ),
                        )
                      : Container(
                          width: double.infinity,
                          height: MediaQuery.of(context).size.height / 3,
                          color: Colors.grey[300],
                          child: const Icon(
                            Icons.image_not_supported,
                            size: 40,
                          ),
                        ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 8,
                    children: [
                      Text(
                        breed.name,
                        style: Theme.of(context).textTheme.headlineMedium
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Temperament: ${breed.temperament ?? 'No temperament'}',
                      ),
                      Text('Origin: ${breed.origin ?? 'No origin'}'),
                      Text('Life span: ${breed.lifeSpan ?? 'No life span'}'),
                      Text(
                        'Description: ${breed.description ?? 'No description'}',
                      ),
                      Text('Origin: ${breed.origin}'),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
