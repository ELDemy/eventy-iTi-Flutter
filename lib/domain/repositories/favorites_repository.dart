import 'package:events_hub/domain/models/event.dart';

abstract class FavoritesRepository {
  Stream<List<Event>> watchFavorites(String uid);

  Future<void> toggleFavorite({
    required String uid,
    required Event event,
    required bool isFavorite,
  });
}
