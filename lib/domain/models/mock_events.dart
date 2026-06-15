import 'package:events_hub/domain/models/event.dart';

import 'event_category.dart';

/// Mock data — replace with API integration later.
abstract final class MockEvents {
  static List<Event> upcoming = [
    Event(
      id: '1',
      title: "Jo Malone London's Mother's Day Presents",
      dateTime: 'Fri, Jun 20 • 5:30 PM',
      location: 'Radius Gallery • Santa Cruz, CA',
      imageAsset: 'assets/images/event_1.png',
      category: EventCategory.music,
      date: DateTime(2026, 6, 20, 17, 30),
      price: 78,
    ),
    Event(
      id: '2',
      title: 'A Virtual Evening of Smooth Jazz',
      dateTime: 'Sat, May 1 • 2:00 PM',
      location: 'Lot 13 • Oakland, CA',
      imageAsset: 'assets/images/event_2.png',
      category: EventCategory.music,
      date: DateTime(2025, 5, 1, 14, 0),
      price: 55,
    ),
    Event(
      id: '3',
      title: "Women's Leadership Conference 2021",
      dateTime: 'Sat, Apr 24 • 1:30 PM',
      location: '53 Bush St • San Francisco, CA',
      imageAsset: 'assets/images/event_3.png',
      category: EventCategory.art,
      date: DateTime(2025, 4, 24, 13, 30),
      price: 120,
    ),
    Event(
      id: '4',
      title: 'International Kids Safe Parents Night Out',
      dateTime: 'Fri, Apr 23 • 6:00 PM',
      location: 'Lot 13 • Oakland, CA',
      imageAsset: 'assets/images/event_4.png',
      category: EventCategory.sports,
      date: DateTime(2025, 4, 23, 18, 0),
      price: 42,
    ),
    Event(
      id: '5',
      title: 'Collectivity Plays the Music of Jimi',
      dateTime: 'Mon, Jun 21 • 10:00 PM',
      location: 'Longboard Margarita Bar',
      imageAsset: 'assets/images/event_5.png',
      category: EventCategory.music,
      date: DateTime(2026, 6, 21, 22, 0),
      price: 98,
    ),
    Event(
      id: '6',
      title: 'International Gala Music Festival',
      dateTime: 'Sun, Jun 25 • 10:15 AM',
      location: '36 Guild Street London, UK',
      imageAsset: 'assets/images/event_6.png',
      category: EventCategory.art,
      date: DateTime(2026, 6, 25, 10, 15),
      price: 150,
    ),
  ];

  static const List<Event> past = [];
}
