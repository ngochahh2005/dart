import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../models/favorite_cat.dart';
import '../../../services/database/database_service.dart';
import 'favorite_event.dart';
import 'favorite_state.dart';

class FavoriteBloc extends Bloc<FavoriteEvent, FavoriteState> {
  final DatabaseService _databaseService;

  FavoriteBloc(this._databaseService) : super(FavoriteInitial()) {
    on<FavoriteLoad>((event, emit) async {
      emit(FavoriteLoading());
      try {
        final favorites = await _databaseService.getAllFavorites();
        emit(FavoriteLoaded(favorites: favorites));
      } catch (e) {
        emit(FavoriteError(message: e.toString()));
      }
    });

    on<FavoriteToggle>((event, emit) async {
      try {
        final isFavorite = await _databaseService.isFavorite(event.catBreed.id);
        if (isFavorite) {
          await _databaseService.deleteFavoriteCat(event.catBreed.id);
        } else {
          final favoriteCat = FavoriteCat(
            id: event.catBreed.id,
            breedName: event.catBreed.name,
            imageUrl: event.catBreed.thumbnailUrl ?? '',
            breedType: 'cat',
          );
          await _databaseService.insertFavoriteCat(favoriteCat);
        }
        add(FavoriteLoad());
      } catch (e) {
        emit(FavoriteError(message: e.toString()));
      }
    });

    on<FavoriteCheck>((event, emit) async {
      try {
        final isFav = await _databaseService.isFavorite(event.breedId);
        emit(FavoriteCheckResult(isFavorite: isFav));
      } catch (e) {
        emit(FavoriteError(message: e.toString()));
      }
    });

    on<FavoriteClearAll>((event, emit) async {
      try {
        await _databaseService.deleteAllFavorite();
        add(FavoriteLoad());
      } catch (e) {
        emit(FavoriteError(message: e.toString()));
      }
    });

    on<FavoriteRemove> ((event, emit) async {
      try {
        await _databaseService.deleteFavoriteCat(event.catId);
        add(FavoriteLoad());
      } catch (e) {
        emit(FavoriteError(message: e.toString()));
      }
    });
  }
}
