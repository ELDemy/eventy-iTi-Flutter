import 'package:events_hub/core/theme/app_colors.dart';
import 'package:events_hub/core/theme/app_text_styles.dart';
import 'package:events_hub/domain/models/event_category.dart';
import 'package:events_hub/presentation/events/events_list/cubit/events_filter_state.dart';
import 'package:flutter/material.dart';

class EventsFilterSheet extends StatelessWidget {
  const EventsFilterSheet({
    super.key,
    required this.state,
    required this.onCategoryTap,
    required this.onDateFilterTap,
    required this.onPriceChanged,
    required this.onClear,
    required this.onApply,
  });

  final EventsFilterState state;
  final ValueChanged<String> onCategoryTap;
  final ValueChanged<DateFilter> onDateFilterTap;
  final ValueChanged<RangeValues> onPriceChanged;
  final VoidCallback onClear;
  final VoidCallback onApply;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
      decoration: const BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.vertical(top: Radius.circular(26)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.center,
            child: Container(
              width: 36,
              height: 4,
              decoration: BoxDecoration(
                color: AppColors.divider,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Text('Filter', style: AppTextStyles.homeSectionTitle),
          const SizedBox(height: 20),
          Text('Category', style: AppTextStyles.infoTitle),
          const SizedBox(height: 12),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: EventCategory.homeFilters.map((category) {
              final selected = state.categories.contains(category.name);
              return ChoiceChip(
                label: Text(category.label),
                selected: selected,
                selectedColor: AppColors.primary.withValues(alpha: 0.12),
                backgroundColor: AppColors.surface,
                labelStyle: selected
                    ? AppTextStyles.tabActive
                    : AppTextStyles.tabInactive,
                onSelected: (_) => onCategoryTap(category.name),
              );
            }).toList(),
          ),
          const SizedBox(height: 24),
          Text('Time & Date', style: AppTextStyles.infoTitle),
          const SizedBox(height: 12),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: DateFilter.values.map((filter) {
              return ChoiceChip(
                label: Text(_dateFilterLabel(filter)),
                selected: state.dateFilter == filter,
                selectedColor: AppColors.primary.withValues(alpha: 0.12),
                backgroundColor: AppColors.surface,
                labelStyle: state.dateFilter == filter
                    ? AppTextStyles.tabActive
                    : AppTextStyles.tabInactive,
                onSelected: (_) => onDateFilterTap(filter),
              );
            }).toList(),
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Price range', style: AppTextStyles.infoTitle),
              Text('\$${state.priceRange.start.toInt()} - \$${state.priceRange.end.toInt()}',
                  style: AppTextStyles.infoSubtitle),
            ],
          ),
          const SizedBox(height: 12),
          RangeSlider(
            values: state.priceRange,
            min: 0,
            max: 200,
            divisions: 20,
            activeColor: AppColors.primary,
            inactiveColor: AppColors.tabBackground,
            onChanged: onPriceChanged,
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: onClear,
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColors.primary,
                    side: const BorderSide(color: AppColors.primary),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: const Text('Clear'),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ElevatedButton(
                  onPressed: onApply,
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: const Text('Apply'),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  String _dateFilterLabel(DateFilter filter) {
    return switch (filter) {
      DateFilter.any => 'Any',
      DateFilter.today => 'Today',
      DateFilter.tomorrow => 'Tomorrow',
      DateFilter.thisWeek => 'This Week',
    };
  }
}
