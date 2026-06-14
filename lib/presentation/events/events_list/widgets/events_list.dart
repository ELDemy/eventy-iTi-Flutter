import 'package:events_hub/core/routes/app_routes.dart';
import 'package:events_hub/domain/models/event.dart';
import 'package:flutter/material.dart';

import 'empty_events_view.dart';
import 'event_card.dart';

class EventsList extends StatelessWidget {
  const EventsList({
    super.key,
    required this.events,
    this.onEventTap,
  });

  final List<Event> events;
  final Function(Event)? onEventTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: events.isEmpty
          ? EmptyEventsView(onExploreEvents: () {})
          : _buildEventsList(context, events),
    );
  }

  Widget _buildEventsList(BuildContext context, List<Event> events) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      itemCount: events.length,
      itemBuilder: (context, index) {
        final event = events[index];
        return EventCard(
          event: event,
          onTap: () {
            if (onEventTap != null) {
              onEventTap!(event);
            } else {
              AppNavigator.goToEventDetails(context, event);
            }
          },
          onBookmarkTap: () {},
        );
      },
    );
  }
}
