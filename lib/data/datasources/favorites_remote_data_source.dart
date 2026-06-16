import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:events_hub/data/models/favorite_event_model.dart';
import 'package:events_hub/domain/models/event.dart';

abstract class FavoritesRemoteDataSource {
  Stream<List<Event>> watchFavorites(String uid);

  Future<void> toggleFavorite({
    required String uid,
    required Event event,
    required bool isFavorite,
  });
}

class FavoritesRemoteDataSourceImpl implements FavoritesRemoteDataSource {
  const FavoritesRemoteDataSourceImpl(this._firestore);

  final FirebaseFirestore _firestore;

  CollectionReference<Map<String, dynamic>> _favorites(String uid) {
    return _firestore.collection('users').doc(uid).collection('favorites');
  }

  @override
  Stream<List<Event>> watchFavorites(String uid) {
    return _favorites(uid)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map(FavoriteEventModel.fromFirestore)
              .map((model) => model.event)
              .toList(),
        );
  }

  @override
  Future<void> toggleFavorite({
    required String uid,
    required Event event,
    required bool isFavorite,
  }) async {
    final doc = _favorites(uid).doc(event.id);
    if (isFavorite) {
      await doc.delete();
    } else {
      await doc.set(FavoriteEventModel.fromEntity(event).toJson());
    }
  }
}
