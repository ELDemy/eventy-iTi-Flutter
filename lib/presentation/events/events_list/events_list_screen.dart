import 'package:events_hub/core/constants/app_strings.dart';
import 'package:events_hub/core/routes/app_routes.dart';
import 'package:events_hub/core/theme/AppIcons.dart';
import 'package:events_hub/core/theme/app_colors.dart';
import 'package:events_hub/core/theme/app_text_styles.dart';
import 'package:events_hub/presentation/events/events_list/cubit/events_filter_cubit.dart';
import 'package:events_hub/presentation/events/events_list/cubit/events_filter_state.dart';
import 'package:events_hub/presentation/events/events_list/cubit/events_list_cubit.dart';
import 'package:events_hub/presentation/events/events_list/cubit/events_list_state.dart';
import 'package:events_hub/presentation/events/events_list/widgets/event_controls.dart';
import 'package:events_hub/presentation/events/events_list/widgets/events_filter_sheet.dart';
import 'package:events_hub/presentation/events/events_list/widgets/events_list.dart';
import 'package:events_hub/presentation/events/events_list/widgets/events_tab_bar.dart';
import 'package:events_hub/presentation/favorites/cubit/favorites_cubit.dart';
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

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => EventsFilterCubit()),
        BlocProvider(create: (_) => EventsListCubit()),
      ],
      child: BlocBuilder<EventsListCubit, EventsListState>(
        builder: (context, listState) {
          return BlocBuilder<EventsFilterCubit, EventsFilterState>(
            builder: (context, filterState) {
              final filteredEvents = context
                  .read<EventsFilterCubit>()
                  .applyFilters(listState.events);
              final favoritesCubit = context.watch<FavoritesCubit>();
              final visibleEvents =
                  favoritesCubit.applyFavorites(filteredEvents);
              return Scaffold(
                appBar: AppBar(
                  centerTitle: false,
                  title:
                      Text(AppStrings.events, style: AppTextStyles.signInTitle),
                  actions: [
                    GestureDetector(
                      onTap: () {
                        AppNavigator.goToSearchEvents(context);
                      },
                      child: SvgPicture.asset(AppIcons.search,
                          width: 24, height: 24),
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
                        onSearchChanged: (value) => context
                            .read<EventsFilterCubit>()
                            .setSearchQuery(value),
                        onFilterPressed: () =>
                            _showFilterSheet(context, filterState),
                        showTabs: true,
                        tabs: EventsTabBar(
                          selectedTab: listState.selectedTab,
                          onTabChanged: context.read<EventsListCubit>().loadTab,
                        ),
                      ),
                      const SizedBox(height: 24),
                      if (listState.isLoading)
                        const Expanded(
                          child: Center(child: CircularProgressIndicator()),
                        )
                      else if (listState.errorMessage != null)
                        Expanded(
                          child: _EventsErrorView(
                            message: listState.errorMessage!,
                            onRetry: context.read<EventsListCubit>().retry,
                          ),
                        )
                      else
                        EventsList(
                          events: visibleEvents,
                          onBookmarkTap: favoritesCubit.toggleFavorite,
                          isLoadingMore: listState.isLoadingMore,
                          onLoadMore: context.read<EventsListCubit>().loadMore,
                        ),
                    ],
                  ),
                ),
              );
            },
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

class _EventsErrorView extends StatelessWidget {
  const _EventsErrorView({
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
