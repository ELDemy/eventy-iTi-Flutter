import 'package:events_hub/domain/models/event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'events_filter_state.dart';

class EventsFilterCubit extends Cubit<EventsFilterState> {
  EventsFilterCubit() : super(const EventsFilterState());

  void setSearchQuery(String query) {
    emit(state.copyWith(searchQuery: query));
  }

  void toggleCategory(String category) {
    final nextCategories = Set<String>.from(state.categories);
    if (nextCategories.contains(category)) {
      nextCategories.remove(category);
    } else {
      nextCategories.add(category);
    }
    emit(state.copyWith(categories: nextCategories.toList()));
  }

  void setDateFilter(DateFilter dateFilter) {
    emit(state.copyWith(dateFilter: dateFilter));
  }

  void setPriceRange(RangeValues range) {
    emit(state.copyWith(priceRange: range));
  }

  List<Event> applyFilters(List<Event> events) {
    return events.where((event) {
      final query = state.searchQuery.toLowerCase();
      final matchesSearch = query.isEmpty ||
          event.title.toLowerCase().contains(query) ||
          event.location.toLowerCase().contains(query);

      final matchesCategory = state.categories.isEmpty ||
          state.categories.contains(event.category.name);

      final matchesPrice = event.price == null ||
          (event.price! >= state.priceRange.start.toInt() &&
              event.price! <= state.priceRange.end.toInt());

      final matchesDate = _matchesDateFilter(event);

      return matchesSearch && matchesCategory && matchesPrice && matchesDate;
    }).toList();
  }

  bool _matchesDateFilter(Event event) {
    final date = event.date;
    if (date == null || state.dateFilter == DateFilter.any) {
      return true;
    }

    final now = DateTime.now();
    switch (state.dateFilter) {
      case DateFilter.any:
        return true;
      case DateFilter.today:
        return date.year == now.year &&
            date.month == now.month &&
            date.day == now.day;
      case DateFilter.tomorrow:
        final tomorrow = now.add(const Duration(days: 1));
        return date.year == tomorrow.year &&
            date.month == tomorrow.month &&
            date.day == tomorrow.day;
      case DateFilter.thisWeek:
        final weekEnd = now.add(const Duration(days: 7));
        return date.isAfter(now.subtract(const Duration(days: 1))) &&
            date.isBefore(weekEnd.add(const Duration(days: 1)));
    }
  }

  void clearFilters() {
    emit(const EventsFilterState());
  }
}
