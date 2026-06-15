import 'package:equatable/equatable.dart';
import 'package:events_hub/domain/models/event.dart';
import 'package:events_hub/domain/models/event_category.dart';

enum HomeNavTab { explore, events, map, profile }

class HomeState extends Equatable {
  const HomeState({
    this.location = '',
    this.selectedCategory = EventCategory.all,
    this.selectedNavTab = HomeNavTab.explore,
    this.popularEvents = const [],
    this.nearbyEvents = const [],
    this.categories = const [],
    this.promoEvent,
    this.isLoading = false,
    this.errorMessage,
  });

  final String location;
  final EventCategory selectedCategory;
  final HomeNavTab selectedNavTab;
  final List<Event> popularEvents;
  final List<Event> nearbyEvents;
  final List<EventCategory> categories;
  final Event? promoEvent;
  final bool isLoading;
  final String? errorMessage;

  HomeState copyWith({
    String? location,
    EventCategory? selectedCategory,
    HomeNavTab? selectedNavTab,
    List<Event>? popularEvents,
    List<Event>? nearbyEvents,
    List<EventCategory>? categories,
    Event? promoEvent,
    bool? isLoading,
    String? errorMessage,
    bool clearError = false,
  }) {
    return HomeState(
      location: location ?? this.location,
      selectedCategory: selectedCategory ?? this.selectedCategory,
      selectedNavTab: selectedNavTab ?? this.selectedNavTab,
      popularEvents: popularEvents ?? this.popularEvents,
      nearbyEvents: nearbyEvents ?? this.nearbyEvents,
      categories: categories ?? this.categories,
      promoEvent: promoEvent ?? this.promoEvent,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: clearError ? null : errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
        location,
        selectedCategory,
        selectedNavTab,
        popularEvents,
        nearbyEvents,
        categories,
        promoEvent,
        isLoading,
        errorMessage,
      ];
}
