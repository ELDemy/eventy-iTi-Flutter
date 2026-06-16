import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:events_hub/domain/models/event.dart';
import 'package:events_hub/domain/models/event_category.dart';

class FavoriteEventModel {
  const FavoriteEventModel({
    required this.event,
  });

  final Event event;

  factory FavoriteEventModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
  ) {
    final data = snapshot.data() ?? const <String, dynamic>{};
    return FavoriteEventModel(
      event: Event(
        id: snapshot.id,
        title: data['title'] as String? ?? 'Untitled event',
        dateTime: data['dateTime'] as String? ?? 'Date to be announced',
        location: data['location'] as String? ?? 'Location to be announced',
        imageUrl: data['imageUrl'] as String?,
        imageAsset: data['imageAsset'] as String?,
        category: _category(data['category'] as String?),
        scheduleLabel: data['scheduleLabel'] as String?,
        date: DateTime.tryParse(data['date'] as String? ?? ''),
        localTime: data['localTime'] as String?,
        price: data['price'] as int?,
        ticketUrl: data['ticketUrl'] as String?,
        statusCode: data['statusCode'] as String?,
        statusLabel: data['statusLabel'] as String?,
        venueName: data['venueName'] as String?,
        organizerName: data['organizerName'] as String?,
        about: data['about'] as String?,
        isBookmarked: true,
      ),
    );
  }

  factory FavoriteEventModel.fromEntity(Event event) {
    return FavoriteEventModel(event: event);
  }

  Map<String, Object?> toJson() {
    return {
      'title': event.title,
      'dateTime': event.dateTime,
      'location': event.location,
      'imageUrl': event.imageUrl,
      'imageAsset': event.imageAsset,
      'category': event.category.name,
      'scheduleLabel': event.scheduleLabel,
      'date': event.date?.toIso8601String(),
      'localTime': event.localTime,
      'price': event.price,
      'ticketUrl': event.ticketUrl,
      'statusCode': event.statusCode,
      'statusLabel': event.statusLabel,
      'venueName': event.venueName,
      'organizerName': event.organizerName,
      'about': event.about,
      'createdAt': FieldValue.serverTimestamp(),
    };
  }

  static EventCategory _category(String? name) {
    return EventCategory.values.firstWhere(
      (category) => category.name == name,
      orElse: () => EventCategory.all,
    );
  }
}
