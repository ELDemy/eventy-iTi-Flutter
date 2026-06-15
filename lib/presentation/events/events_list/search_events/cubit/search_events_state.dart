import 'package:equatable/equatable.dart';
import 'package:events_hub/domain/models/event.dart';
import 'package:events_hub/presentation/events/events_list/cubit/events_filter_state.dart';
import 'package:flutter/material.dart';

class SearchEventsState extends Equatable {
  const SearchEventsState({
    this.query = '',
    this.categories = const [],
    this.dateFilter = DateFilter.any,
    this.priceRange = const RangeValues(0, 200),
    this.events = const [],
    this.isLoading = false,
    this.errorMessage,
  });

  final String query;
  final List<String> categories;
  final DateFilter dateFilter;
  final RangeValues priceRange;
  final List<Event> events;
  final bool isLoading;
  final String? errorMessage;

  SearchEventsState copyWith({
    String? query,
    List<String>? categories,
    DateFilter? dateFilter,
    RangeValues? priceRange,
    List<Event>? events,
    bool? isLoading,
    String? errorMessage,
    bool clearError = false,
  }) {
    return SearchEventsState(
      query: query ?? this.query,
      categories: categories ?? this.categories,
      dateFilter: dateFilter ?? this.dateFilter,
      priceRange: priceRange ?? this.priceRange,
      events: events ?? this.events,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: clearError ? null : errorMessage ?? this.errorMessage,
    );
  }

  EventsFilterState toFilterState() {
    return EventsFilterState(
      searchQuery: query,
      categories: categories,
      dateFilter: dateFilter,
      priceRange: priceRange,
    );
  }

  @override
  List<Object?> get props => [
        query,
        categories,
        dateFilter,
        priceRange,
        events,
        isLoading,
        errorMessage,
      ];
}
