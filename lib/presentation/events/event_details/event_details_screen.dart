import 'package:events_hub/core/constants/app_strings.dart';
import 'package:events_hub/core/routes/app_routes.dart';
import 'package:events_hub/core/theme/AppIcons.dart';
import 'package:events_hub/core/theme/app_colors.dart';
import 'package:events_hub/core/theme/app_text_styles.dart';
import 'package:events_hub/domain/models/event.dart';
import 'package:events_hub/presentation/events/event_details/widgets/attendees_floating_card.dart';
import 'package:events_hub/presentation/events/event_details/widgets/event_info_row.dart';
import 'package:events_hub/presentation/events/event_details/widgets/organizer_row.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class EventDetailsScreen extends StatelessWidget {
  const EventDetailsScreen({super.key, required this.event});

  final Event event;

  static const double _heroHeight = 244;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              SliverToBoxAdapter(child: _buildHeroSection()),
              SliverToBoxAdapter(child: _buildBody(context)),
            ],
          ),
          _buildTopBar(context),
          _buildBottomBar(context),
        ],
      ),
    );
  }

  Widget _buildHeroSection() {
    return SizedBox(
      height: _heroHeight + 48,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          SizedBox(
            height: _heroHeight,
            width: double.infinity,
            child: Stack(
              fit: StackFit.expand,
              children: [
                Image.asset(AppIcons.eventHero, fit: BoxFit.cover),
                const DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Color(0x96000000),
                        Color(0x00000000),
                      ],
                      stops: [0.0, 1.0],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            top: _heroHeight - 30,
            child: AttendeesFloatingCard(
              goingLabel: event.goingCount ?? "0",
              onInvite: () {},
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTopBar(BuildContext context) {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
          child: Row(
            children: [
              _NavIconButton(
                iconAsset: AppIcons.back,
                onTap: () => AppNavigator.goBack(context),
              ),
              Expanded(
                child: Text(
                  AppStrings.eventDetails,
                  textAlign: TextAlign.center,
                  style: AppTextStyles.eventAppBarTitle,
                ),
              ),
              _NavIconButton(
                iconAsset: AppIcons.bookmarkOutline,
                onTap: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 8, 24, 120),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(event.title, style: AppTextStyles.eventTitle),
          const SizedBox(height: 24),
          EventInfoRow(
            iconAsset: AppIcons.calendar,
            title: event.dateTime,
            subtitle: event.dateTime,
          ),
          const SizedBox(height: 16),
          EventInfoRow(
            iconAsset: AppIcons.location,
            iconBackgroundOpacity: 0.12,
            title: event.location,
            subtitle: event.location,
          ),
          const SizedBox(height: 24),
          OrganizerRow(
            name: "organizerName",
            role: AppStrings.organizer,
            onFollow: () {},
          ),
          const SizedBox(height: 28),
          Text(AppStrings.aboutEvent, style: AppTextStyles.sectionTitle),
          const SizedBox(height: 12),
          RichText(
            text: TextSpan(
              style: AppTextStyles.aboutBody,
              children: [
                TextSpan(text: event.category.label),
                TextSpan(
                    text: AppStrings.readMore, style: AppTextStyles.readMore),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomBar(BuildContext context) {
    return Positioned(
      left: 0,
      right: 0,
      bottom: 0,
      child: DecoratedBox(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0x00FFFFFF),
              Color(0xFFFFFFFF),
            ],
          ),
        ),
        child: SafeArea(
          top: false,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(52, 16, 52, 20),
            child: SizedBox(
              height: 58,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: const [
                    BoxShadow(
                      color: AppColors.primaryButtonShadow,
                      offset: Offset(0, 10),
                      blurRadius: 35,
                    ),
                  ],
                ),
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: AppColors.textOnPrimary,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '${AppStrings.buyTicket} "30\$"',
                        style: AppTextStyles.buttonLabel,
                      ),
                      const Spacer(),
                      Container(
                        width: 30,
                        height: 30,
                        decoration: const BoxDecoration(
                          color: AppColors.textOnPrimary,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.arrow_forward,
                          size: 16,
                          color: AppColors.primary,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _NavIconButton extends StatelessWidget {
  const _NavIconButton({required this.iconAsset, required this.onTap});

  final String iconAsset;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 44,
        height: 44,
        decoration: BoxDecoration(
          color: AppColors.navButtonSurface,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: SvgPicture.asset(
            iconAsset,
            width: 22,
            height: 22,
            colorFilter:
                ColorFilter.mode(AppColors.textOnPrimary, BlendMode.srcIn),
          ),
        ),
      ),
    );
  }
}
