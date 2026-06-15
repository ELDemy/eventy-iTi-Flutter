import 'package:events_hub/data/models/event_model.dart';
import 'package:events_hub/data/models/page_meta_model.dart';
import 'package:events_hub/domain/models/event_page.dart';

class EventsPageModel {
  const EventsPageModel({
    required this.events,
    required this.page,
  });

  final List<EventModel> events;
  final PageMetaModel page;

  factory EventsPageModel.fromJson(Map<String, Object?> json) {
    final embedded = json['_embedded'];
    final eventsJson = embedded is Map<String, Object?> ? embedded['events'] : null;

    return EventsPageModel(
      events: _eventModels(eventsJson),
      page: json['page'] is Map<String, Object?>
          ? PageMetaModel.fromJson(json['page'] as Map<String, Object?>)
          : const PageMetaModel(size: 0, totalElements: 0, totalPages: 0, number: 0),
    );
  }

  EventPage toEntity() {
    return EventPage(
      events: events.map((event) => event.toEntity()).toList(),
      currentPage: page.number,
      totalPages: page.totalPages,
    );
  }

  static List<EventModel> _eventModels(Object? value) {
    if (value is! List) return const [];
    return value.whereType<Map<String, Object?>>().map(EventModel.fromJson).toList();
  }
}
