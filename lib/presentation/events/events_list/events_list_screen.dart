import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:events_hub/core/constants/app_strings.dart';
import 'package:events_hub/core/routes/app_routes.dart';
import 'package:events_hub/core/theme/AppIcons.dart';
import 'package:events_hub/core/theme/app_colors.dart';
import 'package:events_hub/core/theme/app_text_styles.dart';
import 'package:events_hub/domain/models/event.dart';
import 'package:events_hub/domain/models/mock_events.dart';
import 'package:events_hub/presentation/events/events_list/widgets/empty_events_view.dart';
import 'package:events_hub/presentation/events/events_list/widgets/event_card.dart';
import 'package:events_hub/presentation/events/events_list/widgets/events_tab_bar.dart';

class EventsListScreen extends StatefulWidget {
  const EventsListScreen({super.key});

  @override
  State<EventsListScreen> createState() => _EventsListScreenState();
}

class _EventsListScreenState extends State<EventsListScreen> {
  EventsTab _selectedTab = EventsTab.upcoming;

  List<Event> get _events {
    return switch (_selectedTab) {
      EventsTab.upcoming => MockEvents.upcoming,
      EventsTab.past => MockEvents.past,
    };
  }

  @override
  Widget build(BuildContext context) {
    final events = _events;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildAppBar(context),
            const SizedBox(height: 20),
            EventsTabBar(
              selectedTab: _selectedTab,
              onTabChanged: (tab) => setState(() => _selectedTab = tab),
            ),
            const SizedBox(height: 24),
            Expanded(
              child: events.isEmpty
                  ? EmptyEventsView(onExploreEvents: () {})
                  : _buildEventsList(context, events),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 8, 24, 0),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Navigator.maybePop(context),
            child: SvgPicture.asset(AppIcons.back, width: 22, height: 22),
          ),
          const SizedBox(width: 11),
          Text(AppStrings.events, style: AppTextStyles.signInTitle),
          const Spacer(),
          SvgPicture.asset(AppIcons.search, width: 24, height: 24),
          const SizedBox(width: 16),
          SvgPicture.asset(AppIcons.more, width: 22, height: 22),
        ],
      ),
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
          onTap: () => Navigator.pushNamed(context, AppRoutes.eventDetails),
          onBookmarkTap: () {},
        );
      },
    );
  }
}
