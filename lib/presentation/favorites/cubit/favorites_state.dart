import 'package:equatable/equatable.dart';
import 'package:events_hub/domain/models/event.dart';

class FavoritesState extends Equatable {
  const FavoritesState({
    this.events = const [],
    this.isLoading = false,
    this.errorMessage,
  });

  final List<Event> events;
  final bool isLoading;
  final String? errorMessage;

  Set<String> get ids => events.map((event) => event.id).toSet();

  FavoritesState copyWith({
    List<Event>? events,
    bool? isLoading,
    String? errorMessage,
    bool clearError = false,
  }) {
    return FavoritesState(
      events: events ?? this.events,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: clearError ? null : errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [events, isLoading, errorMessage];
}
