import 'package:events_hub/core/constants/app_strings.dart';
import 'package:events_hub/core/theme/AppIcons.dart';
import 'package:events_hub/core/theme/app_colors.dart';
import 'package:events_hub/core/theme/app_text_styles.dart';
import 'package:events_hub/presentation/home/cubit/home_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeBottomNav extends StatelessWidget {
  const HomeBottomNav({
    super.key,
    required this.selectedTab,
    required this.onTabSelected,
    this.onFabTap,
  });

  final HomeNavTab selectedTab;
  final ValueChanged<HomeNavTab> onTabSelected;
  final VoidCallback? onFabTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        boxShadow: [
          BoxShadow(
            color: AppColors.textPrimary.withValues(alpha: 0.06),
            offset: const Offset(0, -4),
            blurRadius: 16,
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: SizedBox(
          height: 72,
          child: Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.topCenter,
            children: [
              Row(
                children: [
                  _NavItem(
                    label: AppStrings.explore,
                    iconAsset: AppIcons.compass,
                    isActive: selectedTab == HomeNavTab.explore,
                    onTap: () => onTabSelected(HomeNavTab.explore),
                  ),
                  _NavItem(
                    label: AppStrings.events,
                    iconAsset: AppIcons.navCalendar,
                    isActive: selectedTab == HomeNavTab.events,
                    onTap: () => onTabSelected(HomeNavTab.events),
                  ),
                  const Expanded(child: SizedBox()),
                  _NavItem(
                    label: AppStrings.map,
                    iconAsset: AppIcons.mapPin,
                    isActive: selectedTab == HomeNavTab.map,
                    onTap: () => onTabSelected(HomeNavTab.map),
                  ),
                  _NavItem(
                    label: AppStrings.profile,
                    iconAsset: AppIcons.navProfile,
                    isActive: selectedTab == HomeNavTab.profile,
                    onTap: () => onTabSelected(HomeNavTab.profile),
                  ),
                ],
              ),
              Positioned(
                top: -22,
                child: GestureDetector(
                  onTap: onFabTap,
                  child: Container(
                    width: 56,
                    height: 56,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.primary,
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.primary.withValues(alpha: 0.35),
                          offset: const Offset(0, 8),
                          blurRadius: 24,
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.add,
                      color: AppColors.textOnPrimary,
                      size: 28,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  const _NavItem({
    required this.label,
    required this.iconAsset,
    required this.isActive,
    required this.onTap,
  });

  final String label;
  final String iconAsset;
  final bool isActive;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final color = isActive ? AppColors.primary : AppColors.navInactive;
    final opacity = isActive ? 1.0 : 0.2;

    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.opaque,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Opacity(
              opacity: opacity,
              child: SvgPicture.asset(
                iconAsset,
                width: 24,
                height: 24,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: isActive
                  ? AppTextStyles.navLabelActive
                  : AppTextStyles.navLabelInactive.copyWith(
                      color: AppColors.navInactive.withValues(alpha: 0.2),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
