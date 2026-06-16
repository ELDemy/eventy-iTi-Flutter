import 'package:events_hub/data/datasources/favorites_remote_data_source.dart';
import 'package:events_hub/domain/models/event.dart';
import 'package:events_hub/domain/repositories/favorites_repository.dart';

class FavoritesRepositoryImpl implements FavoritesRepository {
  const FavoritesRepositoryImpl(this._remoteDataSource);

  final FavoritesRemoteDataSource _remoteDataSource;

  @override
  Stream<List<Event>> watchFavorites(String uid) {
    return _remoteDataSource.watchFavorites(uid);
  }

  @override
  Future<void> toggleFavorite({
    required String uid,
    required Event event,
    required bool isFavorite,
  }) {
    return _remoteDataSource.toggleFavorite(
      uid: uid,
      event: event,
      isFavorite: isFavorite,
    );
  }
}
