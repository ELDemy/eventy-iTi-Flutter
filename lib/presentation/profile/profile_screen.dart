import 'package:events_hub/core/theme/app_colors.dart';
import 'package:events_hub/core/theme/app_text_styles.dart';
import 'package:events_hub/domain/models/mock_events.dart';
import 'package:events_hub/presentation/events/events_list/widgets/event_card.dart';
import 'package:events_hub/presentation/profile/widgets/review_tile.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: DefaultTabController(
          length: 3,
          child: Column(
            children: [
              // _buildTopBar(context),
              const SizedBox(height: 12),
              _buildProfileHeader(),
              const SizedBox(height: 8),
              _buildCounts(),
              const SizedBox(height: 16),
              _buildActions(),
              const SizedBox(height: 12),
              _buildTabBar(),
              const SizedBox(height: 8),
              Expanded(child: _buildTabBarView()),
            ],
          ),
        ),
      ),
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

  Widget _buildProfileHeader() {
    return Column(
      children: [
        CircleAvatar(
          radius: 44,
          backgroundImage: const AssetImage('assets/images/avatar_1.png'),
          backgroundColor: AppColors.surface,
        ),
        const SizedBox(height: 12),
        Text('David Silbia', style: AppTextStyles.signInTitle),
      ],
    );
  }

  Widget _buildCounts() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 48),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              children: const [
                Text('350', style: AppTextStyles.goingLabel),
                SizedBox(height: 4),
                Text('Following', style: AppTextStyles.infoSubtitle),
              ],
            ),
          ),
          Container(height: 36, width: 1, color: AppColors.divider),
          Expanded(
            child: Column(
              children: const [
                Text('346', style: AppTextStyles.goingLabel),
                SizedBox(height: 4),
                Text('Followers', style: AppTextStyles.infoSubtitle),
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

  Widget _buildTabBarView() {
    return TabBarView(
      children: [
        _buildAboutTab(),
        _buildEventTab(),
        _buildReviewsTab(),
      ],
    );
  }

  Widget _buildAboutTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text(
            'Enjoy your favorite dishe and a lovely your friends and family and have a great time. Food from local food trucks will be available for purchase.',
            style: AppTextStyles.aboutBody,
          ),
          SizedBox(height: 6),
          Text('Read More', style: AppTextStyles.readMore),
        ],
      ),
    );
  }

  Widget _buildEventTab() {
    final events = MockEvents.upcoming;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListView.builder(
        itemCount: events.length,
        itemBuilder: (context, index) => EventCard(event: events[index]),
      ),
    );
  }

  Widget _buildReviewsTab() {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      children: const [
        ReviewTile(
          avatar: 'assets/images/avatar_1.png',
          name: 'Rocks Velkeinjen',
          date: '10 Feb',
          rating: 4,
          review:
              "Cinemas is the ultimate experience to see new movies in Gold Class or Vmax. Find a cinema near you.",
        ),
        SizedBox(height: 12),
        ReviewTile(
          avatar: 'assets/images/avatar_2.png',
          name: 'Angelina Zolly',
          date: '10 Feb',
          rating: 4,
          review:
              "Cinemas is the ultimate experience to see new movies in Gold Class or Vmax. Find a cinema near you.",
        ),
        SizedBox(height: 12),
        ReviewTile(
          avatar: 'assets/images/avatar_3.png',
          name: 'Zenifero Bolex',
          date: '10 Feb',
          rating: 4,
          review:
              "Cinemas is the ultimate experience to see new movies in Gold Class or Vmax. Find a cinema near you.",
        ),
      ],
    );
  }
}
