import 'package:equatable/equatable.dart';
import 'package:meow_collector/models/cat_breed.dart';

class FavoriteEvent extends Equatable {
  @override
  List<Object?> get props => throw UnimplementedError();

  const FavoriteEvent();
}

class FavoriteLoad extends FavoriteEvent {}

class FavoriteToggle extends FavoriteEvent {
  final CatBreed catBreed;

  const FavoriteToggle({required this.catBreed});

  @override
  List<Object?> get props => [catBreed];
}

class FavoriteCheck extends FavoriteEvent {
  final String breedId;

  const FavoriteCheck({required this.breedId});

  @override
  List<Object?> get props => [breedId];
}

class FavoriteRemove extends FavoriteEvent {
  final String catId;

  const FavoriteRemove({required this.catId});

  @override
  List<Object?> get props => [catId];
}

class FavoriteClearAll extends FavoriteEvent {}