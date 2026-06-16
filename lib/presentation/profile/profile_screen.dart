import 'package:events_hub/core/routes/app_routes.dart';
import 'package:events_hub/core/theme/app_colors.dart';
import 'package:events_hub/core/theme/app_text_styles.dart';
import 'package:events_hub/domain/models/app_user.dart';
import 'package:events_hub/presentation/events/events_list/widgets/event_card.dart';
import 'package:events_hub/presentation/favorites/cubit/favorites_cubit.dart';
import 'package:events_hub/presentation/favorites/cubit/favorites_state.dart';
import 'package:events_hub/presentation/profile/cubit/profile_cubit.dart';
import 'package:events_hub/presentation/profile/cubit/profile_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, profileState) {
        return BlocBuilder<FavoritesCubit, FavoritesState>(
          builder: (context, favoritesState) {
            final user = profileState.user;

            return Scaffold(
              backgroundColor: AppColors.background,
              body: SafeArea(
                child: DefaultTabController(
                  length: 3,
                  child: Column(
                    children: [
                      const SizedBox(height: 12),
                      if (profileState.isLoading)
                        const LinearProgressIndicator(),
                      _buildProfileHeader(user),
                      const SizedBox(height: 8),
                      _buildCounts(user),
                      if (profileState.errorMessage != null) ...[
                        const SizedBox(height: 8),
                        Text(
                          profileState.errorMessage!,
                          style: AppTextStyles.infoSubtitle.copyWith(
                            color: AppColors.categorySports,
                          ),
                        ),
                        TextButton(
                          onPressed: context.read<ProfileCubit>().loadProfile,
                          child: const Text('Retry profile'),
                        ),
                      ],
                      const SizedBox(height: 16),
                      _buildActions(),
                      const SizedBox(height: 12),
                      _buildTabBar(),
                      const SizedBox(height: 8),
                      Expanded(
                        child: _buildTabBarView(
                          user: user,
                          favoritesState: favoritesState,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildTopBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: () => Navigator.of(context).pop(),
            child: const Icon(Icons.arrow_back_ios, size: 20),
          ),
          Row(children: const [Icon(Icons.more_vert, size: 20)]),
        ],
      ),
    );
  }

  Widget _buildProfileHeader(AppUser? user) {
    return Column(
      children: [
        CircleAvatar(
          radius: 44,
          backgroundImage: user?.photoUrl != null
              ? NetworkImage(user!.photoUrl!)
              : const AssetImage('assets/images/avatar_1.png') as ImageProvider,
          backgroundColor: AppColors.surface,
        ),
        const SizedBox(height: 12),
        Text(user?.fullName ?? 'EventHub User',
            style: AppTextStyles.signInTitle),
        if (user?.email.isNotEmpty ?? false) ...[
          const SizedBox(height: 4),
          Text(user!.email, style: AppTextStyles.infoSubtitle),
        ],
      ],
    );
  }

  Widget _buildCounts(AppUser? user) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 48),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              children: [
                Text('${user?.followingCount ?? 0}',
                    style: AppTextStyles.goingLabel),
                const SizedBox(height: 4),
                const Text('Following', style: AppTextStyles.infoSubtitle),
              ],
            ),
          ),
          Container(height: 36, width: 1, color: AppColors.divider),
          Expanded(
            child: Column(
              children: [
                Text('${user?.followersCount ?? 0}',
                    style: AppTextStyles.goingLabel),
                const SizedBox(height: 4),
                const Text('Followers', style: AppTextStyles.infoSubtitle),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActions() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.person_add_alt_1,
                  color: AppColors.textOnPrimary),
              label: const Text('Follow', style: AppTextStyles.buttonLabel),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                elevation: 6,
                shadowColor: AppColors.primaryButtonShadow,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: OutlinedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.chat_bubble_outline,
                  color: AppColors.primary),
              label: const Text('Massages',
                  style: TextStyle(color: AppColors.primary)),
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: AppColors.primary),
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabBar() {
    return TabBar(
      indicatorColor: AppColors.primary,
      indicatorWeight: 3,
      labelPadding: const EdgeInsets.symmetric(horizontal: 12),
      labelStyle: AppTextStyles.tabActive,
      unselectedLabelStyle: AppTextStyles.tabInactive,
      tabs: const [
        Tab(text: 'ABOUT'),
        Tab(text: 'EVENT'),
        Tab(text: 'REVIEWS'),
      ],
    );
  }

  Widget _buildTabBarView({
    required AppUser? user,
    required FavoritesState favoritesState,
  }) {
    return TabBarView(
      children: [
        _buildAboutTab(user),
        _buildEventTab(favoritesState),
        _buildReviewsTab(),
      ],
    );
  }

  Widget _buildAboutTab(AppUser? user) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            user?.about ??
                'Tell people about yourself and the events you love.',
            style: AppTextStyles.aboutBody,
          ),
        ],
      ),
    );
  }

  Widget _buildEventTab(FavoritesState state) {
    final events = state.events;
    if (state.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    if (events.isEmpty) {
      return const Center(
        child: Text(
          'No favorite events yet.',
          style: AppTextStyles.infoSubtitle,
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListView.builder(
        itemCount: events.length,
        itemBuilder: (context, index) {
          final event = events[index];
          return EventCard(
            event: event,
            onTap: () => AppNavigator.goToEventDetails(context, event),
            onBookmarkTap: () =>
                context.read<FavoritesCubit>().toggleFavorite(event),
          );
        },
      ),
    );
  }

  Widget _buildReviewsTab() {
    return const Center(
      child: Text(
        'No reviews yet.',
        style: AppTextStyles.infoSubtitle,
      ),
    );
  }
}
