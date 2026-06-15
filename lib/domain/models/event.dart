import 'package:events_hub/domain/models/event_category.dart';

class Event {
  const Event({
    required this.id,
    required this.title,
    required this.dateTime,
    required this.location,
    this.imageAsset,
    this.imageUrl,
    this.category = EventCategory.all,
    this.scheduleLabel,
    this.goingCount,
    this.date,
    this.localTime,
    this.price,
    this.ticketUrl,
    this.statusCode,
    this.statusLabel,
    this.venueName,
    this.organizerName,
    this.about,
    this.images = const [],
    this.isBookmarked = false,
  });

  final String id;
  final String title;
  final String dateTime;
  final String location;
  final String? imageAsset;
  final String? imageUrl;
  final EventCategory category;
  final String? scheduleLabel;
  final String? goingCount;
  final DateTime? date;
  final String? localTime;
  final int? price;
  final String? ticketUrl;
  final String? statusCode;
  final String? statusLabel;
  final String? venueName;
  final String? organizerName;
  final String? about;
  final List<EventImage> images;
  final bool isBookmarked;

  Event copyWith({
    String? id,
    String? title,
    String? dateTime,
    String? location,
    String? imageAsset,
    String? imageUrl,
    EventCategory? category,
    String? scheduleLabel,
    String? goingCount,
    DateTime? date,
    String? localTime,
    int? price,
    String? ticketUrl,
    String? statusCode,
    String? statusLabel,
    String? venueName,
    String? organizerName,
    String? about,
    List<EventImage>? images,
    bool? isBookmarked,
  }) {
    return Event(
      id: id ?? this.id,
      title: title ?? this.title,
      dateTime: dateTime ?? this.dateTime,
      location: location ?? this.location,
      imageAsset: imageAsset ?? this.imageAsset,
      imageUrl: imageUrl ?? this.imageUrl,
      category: category ?? this.category,
      scheduleLabel: scheduleLabel ?? this.scheduleLabel,
      goingCount: goingCount ?? this.goingCount,
      date: date ?? this.date,
      localTime: localTime ?? this.localTime,
      price: price ?? this.price,
      ticketUrl: ticketUrl ?? this.ticketUrl,
      statusCode: statusCode ?? this.statusCode,
      statusLabel: statusLabel ?? this.statusLabel,
      venueName: venueName ?? this.venueName,
      organizerName: organizerName ?? this.organizerName,
      about: about ?? this.about,
      images: images ?? this.images,
      isBookmarked: isBookmarked ?? this.isBookmarked,
    );
  }
}

class EventImage {
  const EventImage({
    required this.url,
    this.ratio,
    this.width,
    this.height,
    this.fallback,
  });

  final String url;
  final String? ratio;
  final int? width;
  final int? height;
  final bool? fallback;
}
