import 'package:equatable/equatable.dart';
import 'package:events_hub/domain/models/event.dart';

class EventDetailsState extends Equatable {
  const EventDetailsState({
    required this.event,
    this.isLoading = false,
    this.errorMessage,
  });

  final Event event;
  final bool isLoading;
  final String? errorMessage;

  EventDetailsState copyWith({
    Event? event,
    bool? isLoading,
    String? errorMessage,
    bool clearError = false,
  }) {
    return EventDetailsState(
      event: event ?? this.event,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: clearError ? null : errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [event, isLoading, errorMessage];
}
