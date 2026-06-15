import 'package:equatable/equatable.dart';
import 'package:events_hub/domain/models/event.dart';
import 'package:events_hub/presentation/events/events_list/widgets/events_tab_bar.dart';

class EventsListState extends Equatable {
  const EventsListState({
    this.selectedTab = EventsTab.upcoming,
    this.events = const [],
    this.currentPage = 0,
    this.hasMore = false,
    this.isLoading = false,
    this.isLoadingMore = false,
    this.errorMessage,
  });

  final EventsTab selectedTab;
  final List<Event> events;
  final int currentPage;
  final bool hasMore;
  final bool isLoading;
  final bool isLoadingMore;
  final String? errorMessage;

  EventsListState copyWith({
    EventsTab? selectedTab,
    List<Event>? events,
    int? currentPage,
    bool? hasMore,
    bool? isLoading,
    bool? isLoadingMore,
    String? errorMessage,
    bool clearError = false,
  }) {
    return EventsListState(
      selectedTab: selectedTab ?? this.selectedTab,
      events: events ?? this.events,
      currentPage: currentPage ?? this.currentPage,
      hasMore: hasMore ?? this.hasMore,
      isLoading: isLoading ?? this.isLoading,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      errorMessage: clearError ? null : errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
        selectedTab,
        events,
        currentPage,
        hasMore,
        isLoading,
        isLoadingMore,
        errorMessage,
      ];
}
