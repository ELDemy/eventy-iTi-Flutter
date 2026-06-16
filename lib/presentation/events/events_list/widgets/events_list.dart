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
    this.onBookmarkTap,
    this.onLoadMore,
    this.isLoadingMore = false,
  });

  final List<Event> events;
  final Function(Event)? onEventTap;
  final Function(Event)? onBookmarkTap;
  final VoidCallback? onLoadMore;
  final bool isLoadingMore;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: events.isEmpty
          ? EmptyEventsView(onExploreEvents: () {})
          : _buildEventsList(context, events),
    );
  }

  Widget _buildEventsList(BuildContext context, List<Event> events) {
    return NotificationListener<ScrollNotification>(
      onNotification: (notification) {
        final triggerOffset = notification.metrics.maxScrollExtent * 0.8;
        if (notification.metrics.pixels >= triggerOffset) {
          onLoadMore?.call();
        }
        return false;
      },
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        itemCount: events.length + (isLoadingMore ? 1 : 0),
        itemBuilder: (context, index) {
          if (index >= events.length) {
            return const Padding(
              padding: EdgeInsets.symmetric(vertical: 16),
              child: Center(child: CircularProgressIndicator()),
            );
          }

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
            onBookmarkTap: () => onBookmarkTap?.call(event),
          );
        },
      ),
    );
  }
}
