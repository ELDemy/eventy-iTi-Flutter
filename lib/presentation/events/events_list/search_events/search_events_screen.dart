import 'package:events_hub/core/constants/app_strings.dart';
import 'package:events_hub/core/theme/app_colors.dart';
import 'package:events_hub/core/theme/app_text_styles.dart';
import 'package:events_hub/presentation/events/events_list/widgets/event_controls.dart';
import 'package:events_hub/presentation/events/events_list/widgets/events_filter_sheet.dart';
import 'package:events_hub/presentation/events/events_list/widgets/events_list.dart';
import 'package:events_hub/presentation/events/events_list/search_events/cubit/search_events_cubit.dart';
import 'package:events_hub/presentation/events/events_list/search_events/cubit/search_events_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchEventsScreen extends StatefulWidget {
  const SearchEventsScreen({super.key});

  @override
  State<SearchEventsScreen> createState() => _SearchEventsScreenState();
}

class _SearchEventsScreenState extends State<SearchEventsScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SearchEventsCubit(),
      child: BlocBuilder<SearchEventsCubit, SearchEventsState>(
        builder: (context, state) {
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
                    onSearchChanged: context.read<SearchEventsCubit>().setSearchQuery,
                    onFilterPressed: () => _showFilterSheet(context, state),
                  ),
                  const SizedBox(height: 24),
                  if (state.isLoading)
                    const Expanded(
                      child: Center(child: CircularProgressIndicator()),
                    )
                  else if (state.errorMessage != null)
                    Expanded(
                      child: _SearchErrorView(
                        message: state.errorMessage!,
                        onRetry: context.read<SearchEventsCubit>().retry,
                      ),
                    )
                  else
                    EventsList(events: state.events),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void _showFilterSheet(BuildContext context, SearchEventsState state) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) {
        return EventsFilterSheet(
          state: state.toFilterState(),
          onCategoryTap: context.read<SearchEventsCubit>().toggleCategory,
          onDateFilterTap: context.read<SearchEventsCubit>().setDateFilter,
          onPriceChanged: context.read<SearchEventsCubit>().setPriceRange,
          onClear: context.read<SearchEventsCubit>().clearFilters,
          onApply: () {
            Navigator.of(context).pop();
            context.read<SearchEventsCubit>().applyFilters();
          },
        );
      },
    );
  }
}

class _SearchErrorView extends StatelessWidget {
  const _SearchErrorView({
    required this.message,
    required this.onRetry,
  });

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              message,
              textAlign: TextAlign.center,
              style: AppTextStyles.infoSubtitle,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: onRetry,
              child: const Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }
}
