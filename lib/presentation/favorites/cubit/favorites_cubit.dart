import 'dart:async';

import 'package:events_hub/core/di/app_dependencies.dart';
import 'package:events_hub/domain/models/event.dart';
import 'package:events_hub/domain/repositories/auth_repository.dart';
import 'package:events_hub/domain/repositories/favorites_repository.dart';
import 'package:events_hub/presentation/favorites/cubit/favorites_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoritesCubit extends Cubit<FavoritesState> {
  FavoritesCubit({
    AuthRepository? authRepository,
    FavoritesRepository? favoritesRepository,
  })  : _authRepository = authRepository ?? AppDependencies.authRepository,
        _favoritesRepository =
            favoritesRepository ?? AppDependencies.favoritesRepository,
        super(const FavoritesState()) {
    watchFavorites();
  }

  final AuthRepository _authRepository;
  final FavoritesRepository _favoritesRepository;
  StreamSubscription<List<Event>>? _subscription;

  void watchFavorites() {
    final uid = _authRepository.currentFirebaseUser?.uid;
    if (uid == null) return;

    emit(state.copyWith(isLoading: true, clearError: true));
    _subscription?.cancel();
    _subscription = _favoritesRepository.watchFavorites(uid).listen(
      (events) {
        emit(
          state.copyWith(
            events: events,
            isLoading: false,
            clearError: true,
          ),
        );
      },
      onError: (_) {
        emit(
          state.copyWith(
            isLoading: false,
            errorMessage: 'Unable to load favorites.',
          ),
        );
      },
    );
  }

  Future<void> toggleFavorite(Event event) async {
    final uid = _authRepository.currentFirebaseUser?.uid;
    if (uid == null) return;

    final isFavorite = state.ids.contains(event.id);
    await _favoritesRepository.toggleFavorite(
      uid: uid,
      event: event.copyWith(isBookmarked: true),
      isFavorite: isFavorite,
    );
  }

  bool isFavorite(String eventId) => state.ids.contains(eventId);

  Event applyFavorite(Event event) {
    return event.copyWith(isBookmarked: isFavorite(event.id));
  }

  List<Event> applyFavorites(List<Event> events) {
    return events.map(applyFavorite).toList();
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}
