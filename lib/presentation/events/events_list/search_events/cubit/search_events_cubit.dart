import 'dart:async';

import 'package:events_hub/core/di/events_dependencies.dart';
import 'package:events_hub/domain/models/event.dart';
import 'package:events_hub/domain/usecases/search_events.dart';
import 'package:events_hub/presentation/events/events_list/cubit/events_filter_state.dart';
import 'package:events_hub/presentation/events/events_list/search_events/cubit/search_events_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchEventsCubit extends Cubit<SearchEventsState> {
  SearchEventsCubit({
    SearchEvents? searchEvents,
  })  : _searchEvents = searchEvents ?? EventsDependencies.searchEvents,
        super(const SearchEventsState()) {
    search();
  }

  static const String _defaultCity = 'London';
  static const int _pageSize = 20;

  final SearchEvents _searchEvents;
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
          events: _filterByPrice(page.events),
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

  List<Event> _filterByPrice(List<Event> events) {
    return events.where((event) {
      final price = event.price;
      return price == null ||
          (price >= state.priceRange.start.toInt() &&
              price <= state.priceRange.end.toInt());
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
