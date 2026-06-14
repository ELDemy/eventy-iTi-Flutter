import 'package:events_hub/core/constants/app_strings.dart';
import 'package:events_hub/core/routes/app_routes.dart';
import 'package:events_hub/core/theme/AppIcons.dart';
import 'package:events_hub/core/theme/app_colors.dart';
import 'package:events_hub/core/theme/app_text_styles.dart';
import 'package:events_hub/domain/models/event.dart';
import 'package:events_hub/domain/models/mock_events.dart';
import 'package:events_hub/presentation/events/events_list/widgets/events_list.dart';
import 'package:events_hub/presentation/events/events_list/widgets/events_tab_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
      appBar: AppBar(
        centerTitle: false,
        title: Text(AppStrings.events, style: AppTextStyles.signInTitle),
        actions: [
          GestureDetector(
            onTap: () {
              AppNavigator.goToSearchEvents(context);
            },
            child: SvgPicture.asset(AppIcons.search, width: 24, height: 24),
          ),
          const SizedBox(width: 16),
          SvgPicture.asset(AppIcons.more, width: 22, height: 22),
        ],
      ),
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            EventsTabBar(
              selectedTab: _selectedTab,
              onTabChanged: (tab) => setState(() => _selectedTab = tab),
            ),
            const SizedBox(height: 24),
            EventsList(events: events)
          ],
        ),
      ),
    );
  }
}
