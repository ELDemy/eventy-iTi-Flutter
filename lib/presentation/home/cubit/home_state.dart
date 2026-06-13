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
    this.promoEvent,
    this.isLoading = false,
  });

  final String location;
  final EventCategory selectedCategory;
  final HomeNavTab selectedNavTab;
  final List<Event> popularEvents;
  final List<Event> nearbyEvents;
  final Event? promoEvent;
  final bool isLoading;

  HomeState copyWith({
    String? location,
    EventCategory? selectedCategory,
    HomeNavTab? selectedNavTab,
    List<Event>? popularEvents,
    List<Event>? nearbyEvents,
    Event? promoEvent,
    bool? isLoading,
  }) {
    return HomeState(
      location: location ?? this.location,
      selectedCategory: selectedCategory ?? this.selectedCategory,
      selectedNavTab: selectedNavTab ?? this.selectedNavTab,
      popularEvents: popularEvents ?? this.popularEvents,
      nearbyEvents: nearbyEvents ?? this.nearbyEvents,
      promoEvent: promoEvent ?? this.promoEvent,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  List<Object?> get props => [
        location,
        selectedCategory,
        selectedNavTab,
        popularEvents,
        nearbyEvents,
        promoEvent,
        isLoading,
      ];
}
