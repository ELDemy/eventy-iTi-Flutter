import 'package:flutter/material.dart';
import 'package:events_hub/core/constants/app_strings.dart';
import 'package:events_hub/core/routes/app_routes.dart';
import 'package:events_hub/core/theme/app_colors.dart';
import 'package:events_hub/presentation/events/events_list/widgets/empty_events_view.dart';
import 'package:events_hub/presentation/events/events_list/widgets/event_card.dart';

class EventsListScreen extends StatelessWidget {
  const EventsListScreen({super.key});

  // TODO: replace with API data
  static const bool _showEmptyState = true;

  static const List<Map<String, String>> _mockEvents = [
    {
      'title': 'Flutter Conference 2026',
      'date': 'Jun 15, 2026 · 10:00 AM',
      'location': 'Cairo Convention Center',
      'category': 'Technology',
    },
    {
      'title': 'Design Systems Workshop',
      'date': 'Jul 3, 2026 · 2:00 PM',
      'location': 'Alexandria Tech Hub',
      'category': 'Design',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.events),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.notifications_outlined),
            onPressed: () {},
          ),
        ],
      ),
      body: _showEmptyState ? const EmptyEventsView() : _buildEventsList(context),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: AppColors.primary,
        child: const Icon(Icons.add, color: AppColors.textOnPrimary),
      ),
    );
  }

  Widget _buildEventsList(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(20),
      itemCount: _mockEvents.length,
      itemBuilder: (context, index) {
        final event = _mockEvents[index];
        return EventCard(
          title: event['title']!,
          date: event['date']!,
          location: event['location']!,
          category: event['category']!,
          onTap: () => Navigator.pushNamed(context, AppRoutes.eventDetails),
        );
      },
    );
  }
}
