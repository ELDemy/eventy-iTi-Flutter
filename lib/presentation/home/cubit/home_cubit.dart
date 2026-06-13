import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:events_hub/domain/models/event.dart';
import 'package:events_hub/domain/models/event_category.dart';
import 'package:events_hub/domain/models/mock_home_data.dart';
import 'package:events_hub/presentation/home/cubit/home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(const HomeState()) {
    loadHome();
  }

  List<Event> _allPopular = [];
  List<Event> _allNearby = [];

  Future<void> loadHome() async {
    emit(state.copyWith(isLoading: true));
    _allPopular = List<Event>.from(MockHomeData.popularEvents);
    _allNearby = List<Event>.from(MockHomeData.nearbyEvents);
    emit(
      state.copyWith(
        location: MockHomeData.location,
        popularEvents: _filterByCategory(_allPopular, state.selectedCategory),
        nearbyEvents: _filterByCategory(_allNearby, state.selectedCategory),
        promoEvent: MockHomeData.promoEvent,
        isLoading: false,
      ),
    );
  }

  void selectCategory(EventCategory category) {
    final nextCategory = state.selectedCategory == category
        ? EventCategory.all
        : category;
    emit(
      state.copyWith(
        selectedCategory: nextCategory,
        popularEvents: _filterByCategory(_allPopular, nextCategory),
        nearbyEvents: _filterByCategory(_allNearby, nextCategory),
      ),
    );
  }

  void selectNavTab(HomeNavTab tab) {
    emit(state.copyWith(selectedNavTab: tab));
  }

  void toggleBookmark(String eventId) {
    _allPopular = _toggleInList(_allPopular, eventId);
    _allNearby = _toggleInList(_allNearby, eventId);
    emit(
      state.copyWith(
        popularEvents: _filterByCategory(_allPopular, state.selectedCategory),
        nearbyEvents: _filterByCategory(_allNearby, state.selectedCategory),
      ),
    );
  }

  List<Event> _filterByCategory(List<Event> events, EventCategory category) {
    if (category == EventCategory.all) return events;
    return events.where((e) => e.category == category).toList();
  }

  List<Event> _toggleInList(List<Event> events, String eventId) {
    return events
        .map(
          (e) => e.id == eventId ? e.copyWith(isBookmarked: !e.isBookmarked) : e,
        )
        .toList();
  }
}
