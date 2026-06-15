import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:events_hub/core/di/events_dependencies.dart';
import 'package:events_hub/domain/models/event.dart';
import 'package:events_hub/domain/models/event_category.dart';
import 'package:events_hub/domain/usecases/get_categories.dart';
import 'package:events_hub/domain/usecases/get_nearby_events.dart';
import 'package:events_hub/domain/usecases/get_upcoming_events.dart';
import 'package:events_hub/presentation/home/cubit/home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit({
    GetUpcomingEvents? getUpcomingEvents,
    GetNearbyEvents? getNearbyEvents,
    GetCategories? getCategories,
  })  : _getUpcomingEvents =
            getUpcomingEvents ?? EventsDependencies.getUpcomingEvents,
        _getNearbyEvents = getNearbyEvents ?? EventsDependencies.getNearbyEvents,
        _getCategories = getCategories ?? EventsDependencies.getCategories,
        super(const HomeState()) {
    loadHome();
  }

  static const String _defaultCity = 'London';
  static const String _defaultLatLong = '51.5074,-0.1278';

  final GetUpcomingEvents _getUpcomingEvents;
  final GetNearbyEvents _getNearbyEvents;
  final GetCategories _getCategories;

  List<Event> _allPopular = [];
  List<Event> _allNearby = [];

  Future<void> loadHome() async {
    emit(state.copyWith(isLoading: true, clearError: true));

    final upcomingResult = await _getUpcomingEvents(
      const GetUpcomingEventsParams(city: _defaultCity, size: 10),
    );
    final nearbyResult = await _getNearbyEvents(
      const GetNearbyEventsParams(latLong: _defaultLatLong, size: 10),
    );
    final categoriesResult = await _getCategories();

    final failure = upcomingResult.fold((failure) => failure, (_) => null) ??
        nearbyResult.fold((failure) => failure, (_) => null) ??
        categoriesResult.fold((failure) => failure, (_) => null);

    if (failure != null) {
      emit(
        state.copyWith(
          location: _defaultCity,
          isLoading: false,
          errorMessage: failure.message,
        ),
      );
      return;
    }

    _allPopular = upcomingResult.fold((_) => const <Event>[], (page) => page.events);
    _allNearby = nearbyResult.fold((_) => const <Event>[], (page) => page.events);
    final categories = categoriesResult.fold(
      (_) => EventCategory.homeFilters,
      (items) => items.isEmpty ? EventCategory.homeFilters : items,
    );

    emit(
      state.copyWith(
        location: _defaultCity,
        popularEvents: _filterByCategory(_allPopular, state.selectedCategory),
        nearbyEvents: _filterByCategory(_allNearby, state.selectedCategory),
        categories: categories,
        isLoading: false,
        clearError: true,
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
