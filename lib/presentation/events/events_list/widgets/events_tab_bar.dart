import 'package:flutter/material.dart';
import 'package:events_hub/core/constants/app_strings.dart';
import 'package:events_hub/core/theme/app_colors.dart';
import 'package:events_hub/core/theme/app_text_styles.dart';

enum EventsTab { upcoming, past }

class EventsTabBar extends StatelessWidget {
  const EventsTabBar({
    super.key,
    required this.selectedTab,
    required this.onTabChanged,
  });

  final EventsTab selectedTab;
  final ValueChanged<EventsTab> onTabChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45,
      margin: const EdgeInsets.symmetric(horizontal: 40),
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: AppColors.tabBackground,
        borderRadius: BorderRadius.circular(100),
      ),
      child: Row(
        children: [
          _TabItem(
            label: AppStrings.upcoming,
            isSelected: selectedTab == EventsTab.upcoming,
            onTap: () => onTabChanged(EventsTab.upcoming),
          ),
          _TabItem(
            label: AppStrings.pastEvents,
            isSelected: selectedTab == EventsTab.past,
            onTap: () => onTabChanged(EventsTab.past),
          ),
        ],
      ),
    );
  }
}

class _TabItem extends StatelessWidget {
  const _TabItem({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: isSelected ? AppColors.surface : Colors.transparent,
            borderRadius: BorderRadius.circular(100),
            boxShadow: isSelected
                ? const [
                    BoxShadow(
                      color: Color(0x1A000000),
                      offset: Offset(0, 5),
                      blurRadius: 20,
                    ),
                  ]
                : null,
          ),
          child: Text(
            label,
            style: isSelected ? AppTextStyles.tabActive : AppTextStyles.tabInactive,
          ),
        ),
      ),
    );
  }
}
