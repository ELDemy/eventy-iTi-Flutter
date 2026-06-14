import 'package:events_hub/core/constants/app_strings.dart';
import 'package:events_hub/core/routes/app_routes.dart';
import 'package:events_hub/core/theme/AppIcons.dart';
import 'package:events_hub/core/theme/app_colors.dart';
import 'package:events_hub/core/theme/app_text_styles.dart';
import 'package:events_hub/domain/models/event_category.dart';
import 'package:events_hub/domain/models/event_category_style.dart';
import 'package:events_hub/presentation/home/widgets/category_chip.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({
    super.key,
    required this.location,
    required this.selectedCategory,
    required this.onCategorySelected,
    required this.onMenuTap,
  });

  final String location;
  final EventCategory selectedCategory;
  final ValueChanged<EventCategory> onCategorySelected;
  final VoidCallback onMenuTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.headerPrimary,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(33),
          bottomRight: Radius.circular(33),
        ),
      ),
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 16, 24, 20),
          child: Column(
            children: [
              _buildTopRow(),
              const SizedBox(height: 20),
              _buildSearchRow(context),
              const SizedBox(height: 18),
              _buildCategoryRow(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTopRow() {
    return Row(
      children: [
        InkWell(
          onTap: onMenuTap,
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: const EdgeInsets.all(6),
            child: SvgPicture.asset(AppIcons.menu, width: 20, height: 20),
          ),
        ),
        Expanded(child: _buildLocation()),
        _buildNotification(),
      ],
    );
  }

  Widget _buildLocation() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              AppStrings.currentLocation,
              style: AppTextStyles.homeLocationLabel.copyWith(
                color: AppColors.textOnPrimary.withValues(alpha: 0.7),
              ),
            ),
            const SizedBox(width: 4),
            Icon(
              Icons.keyboard_arrow_down_rounded,
              size: 14,
              color: AppColors.textOnPrimary.withValues(alpha: 0.7),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Text(location, style: AppTextStyles.homeLocationValue),
      ],
    );
  }

  Widget _buildNotification() {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.surface.withValues(alpha: 0.15),
          ),
          alignment: Alignment.center,
          child: Icon(
            Icons.notifications_none,
            color: AppColors.textOnPrimary.withValues(alpha: 0.7),
          ),
        ),
        Positioned(
          top: 8,
          right: 8,
          child: Container(
            width: 5,
            height: 5,
            decoration: const BoxDecoration(
              color: AppColors.categorySports,
              shape: BoxShape.circle,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSearchRow(BuildContext context) {
    return GestureDetector(
      onTap: () {
        AppNavigator.goToSearchEvents(context);
      },
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 32,
              alignment: Alignment.centerLeft,
              child: Row(
                children: [
                  SvgPicture.asset(AppIcons.searchWhite, width: 24, height: 24),
                  Container(
                    width: 1,
                    height: 20,
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    color: AppColors.textOnPrimary.withValues(alpha: 0.3),
                  ),
                  Text(
                    AppStrings.searchHint,
                    style: AppTextStyles.homeSearchHint.copyWith(
                      color: AppColors.textOnPrimary.withValues(alpha: 0.3),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            height: 32,
            padding: const EdgeInsets.symmetric(horizontal: 8),
            decoration: BoxDecoration(
              color: AppColors.headerFilter,
              borderRadius: BorderRadius.circular(50),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                SvgPicture.asset(AppIcons.filter, width: 24, height: 24),
                const SizedBox(width: 4),
                Text(AppStrings.filters, style: AppTextStyles.homeFilterLabel),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryRow() {
    return SizedBox(
      height: 40,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: EventCategory.homeFilters.length,
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemBuilder: (context, index) {
          final category = EventCategory.homeFilters[index];
          return CategoryChip(
            label: category.label,
            iconAsset: category.iconAsset,
            color: category.chipColor,
            isSelected: selectedCategory == category,
            onTap: () => onCategorySelected(category),
          );
        },
      ),
    );
  }
}
