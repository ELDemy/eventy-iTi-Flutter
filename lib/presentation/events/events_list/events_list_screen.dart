import 'package:events_hub/core/constants/app_strings.dart';
import 'package:events_hub/core/routes/app_routes.dart';
import 'package:events_hub/core/theme/AppIcons.dart';
import 'package:events_hub/core/theme/app_colors.dart';
import 'package:events_hub/core/theme/app_text_styles.dart';
import 'package:events_hub/domain/models/event.dart';
import 'package:events_hub/domain/models/mock_events.dart';
import 'package:events_hub/presentation/events/events_list/cubit/events_filter_cubit.dart';
import 'package:events_hub/presentation/events/events_list/cubit/events_filter_state.dart';
import 'package:events_hub/presentation/events/events_list/widgets/event_controls.dart';
import 'package:events_hub/presentation/events/events_list/widgets/events_list.dart';
import 'package:events_hub/presentation/events/events_list/widgets/events_tab_bar.dart';
import 'package:events_hub/presentation/events/events_list/widgets/events_filter_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class EventsListScreen extends StatefulWidget {
  const EventsListScreen({super.key});

  @override
  State<EventsListScreen> createState() => _EventsListScreenState();
}

class _EventsListScreenState extends State<EventsListScreen> {
  final TextEditingController _searchController = TextEditingController();
  EventsTab _selectedTab = EventsTab.upcoming;

  List<Event> get _events {
    return switch (_selectedTab) {
      EventsTab.upcoming => MockEvents.upcoming,
      EventsTab.past => MockEvents.past,
    };
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => EventsFilterCubit(),
      child: BlocBuilder<EventsFilterCubit, EventsFilterState>(
        builder: (context, state) {
          final filteredEvents = context.read<EventsFilterCubit>().applyFilters(_events);

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
                  EventControls(
                    searchController: _searchController,
                    onSearchChanged: (value) => context.read<EventsFilterCubit>().setSearchQuery(value),
                    onFilterPressed: () => _showFilterSheet(context, state),
                    showTabs: true,
                    tabs: EventsTabBar(
                      selectedTab: _selectedTab,
                      onTabChanged: (tab) => setState(() => _selectedTab = tab),
                    ),
                  ),
                  const SizedBox(height: 24),
                  EventsList(events: filteredEvents),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void _showFilterSheet(BuildContext context, EventsFilterState state) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) {
        return EventsFilterSheet(
          state: state,
          onCategoryTap: context.read<EventsFilterCubit>().toggleCategory,
          onDateFilterTap: context.read<EventsFilterCubit>().setDateFilter,
          onPriceChanged: context.read<EventsFilterCubit>().setPriceRange,
          onClear: () => context.read<EventsFilterCubit>().clearFilters(),
          onApply: () => Navigator.of(context).pop(),
        );
      },
    );
  }
}
