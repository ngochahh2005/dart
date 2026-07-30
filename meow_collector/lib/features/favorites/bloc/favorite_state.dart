import 'package:equatable/equatable.dart';
import 'package:meow_collector/models/favorite_cat.dart';

class FavoriteState extends Equatable {
  @override
  List<Object?> get props => [];

  const FavoriteState();
}

class FavoriteInitial extends FavoriteState {}

class FavoriteLoading extends FavoriteState {}

class FavoriteLoaded extends FavoriteState {
  final List<FavoriteCat> favorites;

  const FavoriteLoaded({required this.favorites});

  @override
  List<Object?> get props => [favorites];
}

class FavoriteError extends FavoriteState {
  final String message;

  const FavoriteError({required this.message});

  @override
  List<Object?> get props => [message];
}

class FavoriteCheckResult extends FavoriteState {
  final bool isFavorite;

  const FavoriteCheckResult({required this.isFavorite});

  @override
  List<Object?> get props => [isFavorite];
}
