import 'package:events_hub/core/constants/app_strings.dart';
import 'package:events_hub/core/routes/app_routes.dart';
import 'package:events_hub/core/theme/app_colors.dart';
import 'package:events_hub/domain/models/event_category.dart';
import 'package:events_hub/presentation/home/cubit/home_cubit.dart';
import 'package:events_hub/presentation/home/cubit/home_state.dart';
import 'package:events_hub/presentation/home/widgets/featured_event_card.dart';
import 'package:events_hub/presentation/home/widgets/home_header.dart';
import 'package:events_hub/presentation/home/widgets/home_promo_banner.dart';
import 'package:events_hub/presentation/home/widgets/home_section_header.dart';
import 'package:events_hub/presentation/home/widgets/nearby_event_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    super.key,
    this.onMenuTap,
  });

  final VoidCallback? onMenuTap;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => HomeCubit(),
      child: Builder(builder: (context) {
        return _HomeView(
          cubit: context.read<HomeCubit>(),
          state: context.watch<HomeCubit>().state,
          onMenuTap: onMenuTap,
        );
      }),
    );
  }
}

class _HomeView extends StatelessWidget {
  final HomeState state;
  final HomeCubit cubit;
  final VoidCallback? onMenuTap;

  const _HomeView({
    required this.state,
    required this.cubit,
    this.onMenuTap,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          HomeHeader(
            location: state.location,
            selectedCategory: state.selectedCategory,
            categories: state.categories.isEmpty
                ? EventCategory.homeFilters
                : state.categories,
            onCategorySelected: cubit.selectCategory,
            onMenuTap: onMenuTap ?? () {},
          ),
          Expanded(
            child: state.isLoading
                ? const Center(child: CircularProgressIndicator())
                : state.errorMessage != null
                    ? _HomeErrorView(
                        message: state.errorMessage!,
                        onRetry: cubit.loadHome,
                      )
                : SingleChildScrollView(
                    padding: const EdgeInsets.only(top: 16, bottom: 100),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        HomeSectionHeader(
                          title: AppStrings.upcomingEventsSection,
                          onSeeAllTap: () {},
                        ),
                        SizedBox(
                          height: 255,
                          child: state.popularEvents.isEmpty
                              ? const _HomeEmptyView()
                              : ListView.builder(
                            scrollDirection: Axis.horizontal,
                            padding: const EdgeInsets.only(left: 24),
                            itemCount: state.popularEvents.length,
                            itemBuilder: (context, index) {
                              final event = state.popularEvents[index];
                              return FeaturedEventCard(
                                event: event,
                                onBookmarkTap: () =>
                                    cubit.toggleBookmark(event.id),
                                onTap: () => AppNavigator.goToEventDetails(
                                    context, event),
                              );
                            },
                          ),
                        ),
                        const HomePromoBanner(),
                        HomeSectionHeader(
                          title: AppStrings.nearbyYou,
                          onSeeAllTap: () {},
                        ),
                        if (state.nearbyEvents.isEmpty)
                          const _HomeEmptyView()
                        else
                          ...state.nearbyEvents.map(
                            (event) => NearbyEventCard(
                              event: event,
                              onBookmarkTap: () =>
                                  cubit.toggleBookmark(event.id),
                              onTap: () => AppNavigator.goToEventDetails(
                                  context, event)),
                          ),
                      ],
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}

class _HomeErrorView extends StatelessWidget {
  const _HomeErrorView({
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
              style: const TextStyle(color: AppColors.textSecondary),
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

class _HomeEmptyView extends StatelessWidget {
  const _HomeEmptyView();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      child: Text(
        'No events found.',
        style: TextStyle(color: AppColors.textSecondary),
      ),
    );
  }
}
