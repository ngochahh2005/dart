import 'package:equatable/equatable.dart';
import 'package:meow_collector/models/cat_breed.dart';

class HomeEvent extends Equatable{

  @override
  List<Object?> get props => [];

  const HomeEvent();
}

class HomeLoad extends HomeEvent {}

class HomeRefresh extends HomeEvent {}

class HomeToggleFavorite extends HomeEvent {
  final CatBreed catBreed;

  const HomeToggleFavorite(this.catBreed);

  @override
  List<Object?> get props => [catBreed];
}