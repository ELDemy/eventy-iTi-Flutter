enum EventCategory {
  all,
  sports,
  music,
  food,
  art;

  String get label => switch (this) {
        EventCategory.all => 'All',
        EventCategory.sports => 'Sports',
        EventCategory.music => 'Music',
        EventCategory.food => 'Food',
        EventCategory.art => 'Art',
      };

  static const List<EventCategory> homeFilters = [
    EventCategory.sports,
    EventCategory.music,
    EventCategory.food,
    EventCategory.art,
  ];
}
