import 'dart:async';

import 'package:events_hub/core/di/events_dependencies.dart';
import 'package:events_hub/domain/models/event.dart';
import 'package:events_hub/domain/usecases/get_nearby_events.dart';
import 'package:events_hub/domain/usecases/search_events.dart';
import 'package:events_hub/presentation/events/events_list/cubit/events_filter_state.dart';
import 'package:events_hub/presentation/events/events_list/search_events/cubit/search_events_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchEventsCubit extends Cubit<SearchEventsState> {
  SearchEventsCubit({
    this.nearbyLondon = false,
    SearchEvents? searchEvents,
    GetNearbyEvents? getNearbyEvents,
  })  : _searchEvents = searchEvents ?? EventsDependencies.searchEvents,
        _getNearbyEvents = getNearbyEvents ?? EventsDependencies.getNearbyEvents,
        super(const SearchEventsState()) {
    search();
  }

  static const String _defaultCity = 'London';
  static const String _londonLatLong = '51.5074,-0.1278';
  static const int _pageSize = 20;

  final bool nearbyLondon;
  final SearchEvents _searchEvents;
  final GetNearbyEvents _getNearbyEvents;
  Timer? _debounce;

  void setSearchQuery(String query) {
    emit(state.copyWith(query: query, clearError: true));
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 300), search);
  }

  void toggleCategory(String category) {
    final nextCategories = Set<String>.from(state.categories);
    if (nextCategories.contains(category)) {
      nextCategories.remove(category);
    } else {
      nextCategories
        ..clear()
        ..add(category);
    }
    emit(state.copyWith(categories: nextCategories.toList(), clearError: true));
  }

  void setDateFilter(DateFilter dateFilter) {
    emit(state.copyWith(dateFilter: dateFilter, clearError: true));
  }

  void setPriceRange(RangeValues range) {
    emit(state.copyWith(priceRange: range, clearError: true));
  }

  void clearFilters() {
    emit(
      state.copyWith(
        categories: const [],
        dateFilter: DateFilter.any,
        priceRange: const RangeValues(0, 200),
        clearError: true,
      ),
    );
  }

  Future<void> applyFilters() => search();

  Future<void> retry() => search();

  Future<void> search() async {
    emit(state.copyWith(isLoading: true, clearError: true));

    if (nearbyLondon) {
      final result = await _getNearbyEvents(
        const GetNearbyEventsParams(latLong: _londonLatLong, size: _pageSize),
      );
      result.fold(
        (failure) => emit(
          state.copyWith(
            isLoading: false,
            errorMessage: failure.message,
          ),
        ),
        (page) => emit(
          state.copyWith(
            events: _applyClientFilters(page.events),
            isLoading: false,
            clearError: true,
          ),
        ),
      );
      return;
    }

    final range = _dateRange(state.dateFilter);
    final result = await _searchEvents(
      SearchEventsParams(
        keyword: state.query,
        city: _defaultCity,
        classificationName: _classificationName(state.categories),
        startDateTime: range?.start,
        endDateTime: range?.end,
        size: _pageSize,
      ),
    );

    result.fold(
      (failure) => emit(
        state.copyWith(
          isLoading: false,
          errorMessage: failure.message,
        ),
      ),
      (page) => emit(
        state.copyWith(
          events: _applyClientFilters(page.events),
          isLoading: false,
          clearError: true,
        ),
      ),
    );
  }

  @override
  Future<void> close() {
    _debounce?.cancel();
    return super.close();
  }

  List<Event> _applyClientFilters(List<Event> events) {
    final query = state.query.toLowerCase().trim();
    return events.where((event) {
      final price = event.price;
      final matchesPrice = price == null ||
          (price >= state.priceRange.start.toInt() &&
              price <= state.priceRange.end.toInt());
      final matchesCategory =
          state.categories.isEmpty || state.categories.contains(event.category.name);
      final matchesQuery = query.isEmpty ||
          event.title.toLowerCase().contains(query) ||
          event.location.toLowerCase().contains(query);
      return matchesPrice && matchesCategory && matchesQuery;
    }).toList();
  }

  String? _classificationName(List<String> categories) {
    if (categories.isEmpty) return null;
    return switch (categories.first) {
      'sports' => 'Sports',
      'music' => 'Music',
      'art' => 'Arts & Theatre',
      'food' => 'Miscellaneous',
      _ => null,
    };
  }

  _SearchDateRange? _dateRange(DateFilter filter) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    return switch (filter) {
      DateFilter.any => null,
      DateFilter.today => _SearchDateRange(
          today.toUtc(),
          today.add(const Duration(days: 1)).subtract(const Duration(seconds: 1)).toUtc(),
        ),
      DateFilter.tomorrow => _SearchDateRange(
          today.add(const Duration(days: 1)).toUtc(),
          today.add(const Duration(days: 2)).subtract(const Duration(seconds: 1)).toUtc(),
        ),
      DateFilter.thisWeek => _SearchDateRange(
          today.toUtc(),
          today.add(const Duration(days: 7)).toUtc(),
        ),
    };
  }
}

class _SearchDateRange {
  const _SearchDateRange(this.start, this.end);

  final DateTime start;
  final DateTime end;
}
