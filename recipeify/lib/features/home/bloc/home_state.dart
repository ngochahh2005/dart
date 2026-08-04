import 'package:equatable/equatable.dart';
import 'package:recipeify/data/models/meal.dart';

class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object?> get props => [];
}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeLoaded extends HomeState {
  final List<Meal> meals;

  const HomeLoaded(this.meals);

  @override
  List<Object?> get props => [meals];
}

class HomeError extends HomeState {
  final String message;

  const HomeError(this.message);

  @override
  // TODO: implement props
  List<Object?> get props => [message];
}