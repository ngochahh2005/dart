import 'package:flutter_bloc/flutter_bloc.dart';
import '../../favorites/bloc/favorite_bloc.dart';
import '../../../services/api/cat_api_service.dart';
import '../../favorites/bloc/favorite_event.dart';
import 'home_event.dart';
import 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState>{
  final CatApiService _apiService;
  final FavoriteBloc _favoriteBloc;

  HomeBloc(this._apiService, this._favoriteBloc) : super(HomeInitial()) {
    on<HomeLoad> ((event, emit) async {
      emit(HomeLoading());
      try {
        final catBreeds = await _apiService.fetchBreeds();
        emit(HomeLoaded(catBreeds));
      } catch (e) {
        emit(HomeError(e.toString()));
      }
    });

    on<HomeRefresh> ((event, emit) async {
      add(HomeLoad());
    });

    on<HomeToggleFavorite> ((event, emit) async {
      try {
        _favoriteBloc.add(FavoriteToggle(catBreed: event.catBreed));
      } catch (e) {
        emit(HomeError(e.toString()));
      }
    });
  }
}