import 'package:equatable/equatable.dart';

class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object?> get props => [];
}

class HomeLoadDefaultMeals extends HomeEvent {}

class HomeSearchMeals extends HomeEvent {
  final String query;

  const HomeSearchMeals(this.query);

  @override
  List<Object?> get props => [query];
}

class HomeClearMeals extends HomeEvent {}