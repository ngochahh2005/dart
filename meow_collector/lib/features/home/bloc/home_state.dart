import 'package:equatable/equatable.dart';
import 'package:meow_collector/models/cat_breed.dart';

class HomeState extends Equatable {
  @override
  List<Object?> get props => [];

  const HomeState();
}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeLoaded extends HomeState {
  final List<CatBreed> breed;

  const HomeLoaded(this.breed);

  @override
  List<Object?> get props => [breed];
}

class HomeError extends HomeState {
  final String message;

  const HomeError(this.message);

  @override
  List<Object?> get props => [message];
}