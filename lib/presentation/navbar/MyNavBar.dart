import 'package:events_hub/core/di/app_dependencies.dart';
import 'package:events_hub/core/constants/app_strings.dart';
import 'package:events_hub/core/theme/AppIcons.dart';
import 'package:events_hub/core/theme/app_text_styles.dart';
import 'package:events_hub/presentation/add/add_screen.dart';
import 'package:events_hub/presentation/events/events_list/events_list_screen.dart';
import 'package:events_hub/presentation/home/home_screen.dart';
import 'package:events_hub/presentation/map/map_screen.dart';
import 'package:events_hub/presentation/navbar/app_drawer.dart';
import 'package:events_hub/presentation/profile/profile_screen.dart';
import 'package:events_hub/presentation/profile/cubit/profile_cubit.dart';
import 'package:events_hub/presentation/profile/cubit/profile_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';

import '../../core/theme/app_colors.dart';

class MyNavBar extends StatefulWidget {
  const MyNavBar({super.key});

  @override
  State<MyNavBar> createState() => _MyNavBarState();
}

class _MyNavBarState extends State<MyNavBar> {
  late PersistentTabController _tabController;
  final AdvancedDrawerController _drawerController = AdvancedDrawerController();
  int _lastAvailableIndex = 0;

  @override
  void initState() {
    super.initState();
    _tabController = PersistentTabController(initialIndex: 0);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _toggleDrawer() {
    _drawerController.value.visible
        ? _drawerController.hideDrawer()
        : _drawerController.showDrawer();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, profileState) {
        return AdvancedDrawer(
          backdropColor: Colors.black.withValues(alpha: 0.2),
          controller: _drawerController,
          animationCurve: Curves.easeInOut,
          animationDuration: const Duration(milliseconds: 300),
          animateChildDecoration: true,
          rtlOpening: false,
          childDecoration: const BoxDecoration(
            borderRadius: BorderRadius.zero,
          ),
          drawer: AppDrawer(
            user: profileState.user,
            onClose: _drawerController.hideDrawer,
            onProfileTap: () {
              _selectAvailableTab(4);
            },
            onMassageTap: () {},
            onCalendarTap: () {},
            onBookmarkTap: () {},
            onContactUsTap: () {},
            onSettingsTap: () {},
            onHelpTap: () {},
            onSignOutTap: () async {
              await AppDependencies.authRepository.signOut();
            },
          ),
          child: PersistentTabView(
            context,
            controller: _tabController,
            navBarStyle: NavBarStyle.style15,
            backgroundColor: AppColors.surface,
            navBarHeight: 76,
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
            decoration: NavBarDecoration(
              boxShadow: [
                BoxShadow(
                  color: AppColors.textPrimary.withValues(alpha: 0.08),
                  offset: const Offset(0, -4),
                  blurRadius: 20,
                  spreadRadius: 0,
                ),
              ],
              border: Border(
                top: BorderSide(
                  color: AppColors.textPrimary.withValues(alpha: 0.06),
                  width: 0.5,
                ),
              ),
            ),
            onItemSelected: _handleTabSelected,
            items: [
              _buildNavItem(
                icon: AppIcons.compass,
                title: AppStrings.explore,
                index: 0,
              ),
              _buildNavItem(
                icon: AppIcons.navCalendar,
                title: AppStrings.events,
                index: 1,
              ),
              _buildFabItem(),
              _buildNavItem(
                icon: AppIcons.location,
                title: AppStrings.map,
                index: 3,
              ),
              _buildNavItem(
                icon: AppIcons.navProfile,
                title: AppStrings.profile,
                index: 4,
              ),
            ],
            screens: [
              HomeScreen(
                onMenuTap: _toggleDrawer,
                onSeeAllEvents: () => _selectAvailableTab(1),
              ),
              const EventsListScreen(),
              const AddScreen(),
              const MapScreen(),
              const ProfileScreen(),
            ],
          ),
        );
      },
    );
  }

  void _handleTabSelected(int index) {
    if (index == 2 || index == 3) {
      _tabController.index = _lastAvailableIndex;
      setState(() {});
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!mounted) return;
        _tabController.index = _lastAvailableIndex;
        setState(() {});
      });
      _showComingSoonDialog(index == 2 ? 'Add Event' : 'Map');
      return;
    }
    _lastAvailableIndex = index;
    setState(() {});
  }

  void _selectAvailableTab(int index) {
    _lastAvailableIndex = index;
    _tabController.index = index;
    setState(() {});
  }

  void _showComingSoonDialog(String featureName) {
    showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
          title: Text('$featureName is coming soon'),
          content: const Text(
            'This feature is not available yet, but it is already on the roadmap.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Got it'),
            ),
          ],
        );
      },
    );
  }

  PersistentBottomNavBarItem _buildNavItem({
    required String icon,
    required String title,
    required int index,
  }) {
    final bool isActive = _tabController.index == index;

    return PersistentBottomNavBarItem(
      icon: _NavItemContent(
        icon: icon,
        label: title,
        isActive: isActive,
      ),
      activeColorPrimary: AppColors.primary,
      inactiveColorPrimary: AppColors.navInactive,
      textStyle: const TextStyle(fontSize: 0, height: 0),
    );
  }

  PersistentBottomNavBarItem _buildFabItem() {
    return PersistentBottomNavBarItem(
      icon: Container(
        width: 52,
        height: 52,
        decoration: BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: AppColors.primary.withValues(alpha: 0.45),
              blurRadius: 16,
              offset: const Offset(0, 4),
              spreadRadius: 0,
            ),
          ],
        ),
        child: Center(
          child: SvgPicture.asset(
            AppIcons.addBox,
            width: 24,
            height: 24,
            colorFilter: const ColorFilter.mode(
              Colors.white,
              BlendMode.srcIn,
            ),
          ),
        ),
      ),
      activeColorPrimary: Colors.white,
      inactiveColorPrimary: Colors.white,
    );
  }
}

class _NavItemContent extends StatelessWidget {
  const _NavItemContent({
    required this.icon,
    required this.label,
    required this.isActive,
  });

  final String icon;
  final String label;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Top active indicator bar
        AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOut,
          height: 3,
          width: isActive ? 24 : 0,
          decoration: BoxDecoration(
            color: AppColors.primary,
            borderRadius: const BorderRadius.vertical(
              bottom: Radius.circular(3),
            ),
          ),
        ),
        const SizedBox(height: 6),
        // Icon with soft active background pill
        AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOut,
          width: 36,
          height: 30,
          decoration: BoxDecoration(
            color: isActive
                ? AppColors.primary.withValues(alpha: 0.10)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: SvgPicture.asset(
              icon,
              width: 22,
              height: 22,
              colorFilter: ColorFilter.mode(
                isActive ? AppColors.primary : AppColors.navInactive,
                BlendMode.srcIn,
              ),
            ),
          ),
        ),
        const SizedBox(height: 4),
        // Label always directly under the icon
        AnimatedDefaultTextStyle(
          duration: const Duration(milliseconds: 200),
          style: AppTextStyles.navLabelActive.copyWith(
            color: isActive ? AppColors.primary : AppColors.navInactive,
            fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
            fontSize: 10,
          ),
          child: Text(label),
        ),
        const SizedBox(height: 6),
      ],
    );
  }
}
