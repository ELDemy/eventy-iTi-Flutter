import 'package:events_hub/domain/models/event.dart';

/// Mock data — replace with API integration later.
abstract final class MockEvents {
  static const List<Event> upcoming = [
    Event(
      id: '1',
      title: "Jo Malone London's Mother's Day Presents",
      dateTime: 'Wed, Apr 28 • 5:30 PM',
      location: 'Radius Gallery • Santa Cruz, CA',
      imageAsset: 'assets/images/event_1.png',
    ),
    Event(
      id: '2',
      title: 'A Virtual Evening of Smooth Jazz',
      dateTime: 'Sat, May 1 • 2:00 PM',
      location: 'Lot 13 • Oakland, CA',
      imageAsset: 'assets/images/event_2.png',
    ),
    Event(
      id: '3',
      title: "Women's Leadership Conference 2021",
      dateTime: 'Sat, Apr 24 • 1:30 PM',
      location: '53 Bush St • San Francisco, CA',
      imageAsset: 'assets/images/event_3.png',
    ),
    Event(
      id: '4',
      title: 'International Kids Safe Parents Night Out',
      dateTime: 'Fri, Apr 23 • 6:00 PM',
      location: 'Lot 13 • Oakland, CA',
      imageAsset: 'assets/images/event_4.png',
    ),
    Event(
      id: '5',
      title: 'Collectivity Plays the Music of Jimi',
      dateTime: 'Mon, Jun 21 • 10:00 PM',
      location: 'Longboard Margarita Bar',
      imageAsset: 'assets/images/event_5.png',
    ),
    Event(
      id: '6',
      title: 'International Gala Music Festival',
      dateTime: 'Sun, Apr 25 • 10:15 AM',
      location: '36 Guild Street London, UK',
      imageAsset: 'assets/images/event_6.png',
    ),
  ];

  static const List<Event> past = [];
}
