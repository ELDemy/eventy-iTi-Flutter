import 'package:events_hub/core/theme/AppIcons.dart';
import 'package:events_hub/domain/models/event.dart';
import 'package:events_hub/domain/models/event_category.dart';

/// Mock home data — replace with API integration later.
abstract final class MockHomeData {
  static const String location = 'New York, USA';

  static const List<Event> popularEvents = [
    Event(
      id: 'p1',
      title: 'International Band Music Concert',
      dateTime: 'Sun, Apr 25 • 10:15 AM',
      location: '36 Guild Street London, UK',
      imageAsset: AppIcons.eventHero,
      category: EventCategory.music,
      goingCount: '+20 Going',
    ),
    Event(
      id: 'p2',
      title: "Jo Malone London's Mother's Day",
      dateTime: 'Wed, Apr 28 • 5:30 PM',
      location: 'Radius Gallery • Santa Cruz, CA',
      imageAsset: AppIcons.event1,
      category: EventCategory.art,
      goingCount: '+20 Going',
    ),
  ];

  static const Event promoEvent = Event(
    id: 'promo',
    title: 'International Gala Music Festival',
    dateTime: '',
    location: '41 Madison Ave, New York',
    imageAsset: AppIcons.promoBanner,
    category: EventCategory.music,
  );

  static const List<Event> nearbyEvents = [
    Event(
      id: 'n1',
      title: "Women's leadership conference",
      dateTime: 'Sat, May 1 • 2:00 PM',
      scheduleLabel: '1st  May- Sat -2:00 PM',
      location: 'Radius Gallery • Santa Cruz',
      imageAsset: AppIcons.event3,
      category: EventCategory.art,
      isBookmarked: true,
    ),
    Event(
      id: 'n2',
      title: 'International kids safe parents night out',
      dateTime: 'Fri, Apr 23 • 6:00 PM',
      scheduleLabel: '1st  May- Sat -2:00 PM',
      location: 'Radius Gallery • Santa Cruz',
      imageAsset: AppIcons.event4,
      category: EventCategory.sports,
    ),
  ];
}
