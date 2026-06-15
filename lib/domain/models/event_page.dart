import 'package:equatable/equatable.dart';
import 'package:events_hub/domain/models/event.dart';

class EventPage extends Equatable {
  const EventPage({
    required this.events,
    required this.currentPage,
    required this.totalPages,
  });

  final List<Event> events;
  final int currentPage;
  final int totalPages;

  bool get hasMore => currentPage < totalPages - 1;

  @override
  List<Object?> get props => [events, currentPage, totalPages];
}
