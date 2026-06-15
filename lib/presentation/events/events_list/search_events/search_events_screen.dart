import 'package:events_hub/core/constants/app_strings.dart';
import 'package:events_hub/core/theme/app_colors.dart';
import 'package:events_hub/core/theme/app_text_styles.dart';
import 'package:events_hub/domain/models/event.dart';
import 'package:events_hub/domain/models/mock_events.dart';
import 'package:events_hub/presentation/events/events_list/cubit/events_filter_cubit.dart';
import 'package:events_hub/presentation/events/events_list/cubit/events_filter_state.dart';
import 'package:events_hub/presentation/events/events_list/widgets/event_controls.dart';
import 'package:events_hub/presentation/events/events_list/widgets/events_filter_sheet.dart';
import 'package:events_hub/presentation/events/events_list/widgets/events_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchEventsScreen extends StatefulWidget {
  const SearchEventsScreen({super.key});

  @override
  State<SearchEventsScreen> createState() => _SearchEventsScreenState();
}

class _SearchEventsScreenState extends State<SearchEventsScreen> {
  final TextEditingController _searchController = TextEditingController();

  List<Event> get _events {
    return [
      ...MockEvents.upcoming,
      ...MockEvents.past,
    ];
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
              title: Text(AppStrings.search, style: AppTextStyles.signInTitle),
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
