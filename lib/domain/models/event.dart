import 'package:events_hub/domain/models/event_category.dart';

class Event {
  const Event({
    required this.id,
    required this.title,
    required this.dateTime,
    required this.location,
    required this.imageAsset,
    this.category = EventCategory.all,
    this.scheduleLabel,
    this.goingCount,
    this.isBookmarked = false,
  });

  final String id;
  final String title;
  final String dateTime;
  final String location;
  final String imageAsset;
  final EventCategory category;
  final String? scheduleLabel;
  final String? goingCount;
  final bool isBookmarked;

  Event copyWith({
    String? id,
    String? title,
    String? dateTime,
    String? location,
    String? imageAsset,
    EventCategory? category,
    String? scheduleLabel,
    String? goingCount,
    bool? isBookmarked,
  }) {
    return Event(
      id: id ?? this.id,
      title: title ?? this.title,
      dateTime: dateTime ?? this.dateTime,
      location: location ?? this.location,
      imageAsset: imageAsset ?? this.imageAsset,
      category: category ?? this.category,
      scheduleLabel: scheduleLabel ?? this.scheduleLabel,
      goingCount: goingCount ?? this.goingCount,
      isBookmarked: isBookmarked ?? this.isBookmarked,
    );
  }
}
