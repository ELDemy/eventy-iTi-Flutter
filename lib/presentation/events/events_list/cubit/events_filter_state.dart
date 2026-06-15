import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';

enum DateFilter { any, today, tomorrow, thisWeek }

class EventsFilterState extends Equatable {
  const EventsFilterState({
    this.searchQuery = '',
    this.categories = const [],
    this.dateFilter = DateFilter.any,
    this.priceRange = const RangeValues(0, 200),
  });

  final String searchQuery;
  final List<String> categories;
  final DateFilter dateFilter;
  final RangeValues priceRange;

  EventsFilterState copyWith({
    String? searchQuery,
    List<String>? categories,
    DateFilter? dateFilter,
    RangeValues? priceRange,
  }) {
    return EventsFilterState(
      searchQuery: searchQuery ?? this.searchQuery,
      categories: categories ?? this.categories,
      dateFilter: dateFilter ?? this.dateFilter,
      priceRange: priceRange ?? this.priceRange,
    );
  }

  @override
  List<Object?> get props => [searchQuery, categories, dateFilter, priceRange];
}
