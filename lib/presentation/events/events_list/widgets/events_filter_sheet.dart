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

  int get _activeFilterCount {
    var count = 0;
    if (state.categories.isNotEmpty) count++;
    if (state.dateFilter != DateFilter.any) count++;
    if (state.priceRange.start > 0 || state.priceRange.end < 200) count++;
    return count;
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.72,
      minChildSize: 0.45,
      maxChildSize: 0.92,
      builder: (context, scrollController) {
        return Container(
          decoration: const BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
          ),
          child: Column(
            children: [
              const SizedBox(height: 10),
              Container(
                width: 38,
                height: 4,
                decoration: BoxDecoration(
                  color: AppColors.divider,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 18, 16, 10),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Filters', style: AppTextStyles.homeSectionTitle),
                          const SizedBox(height: 4),
                          Text(
                            _activeFilterCount == 0
                                ? 'Refine event results'
                                : '$_activeFilterCount active filter${_activeFilterCount == 1 ? '' : 's'}',
                            style: AppTextStyles.infoSubtitle,
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      onPressed: () => Navigator.of(context).pop(),
                      icon: const Icon(Icons.close),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView(
                  controller: scrollController,
                  padding: const EdgeInsets.fromLTRB(24, 8, 24, 20),
                  children: [
                    _FilterSection(
                      title: 'Category',
                      child: Wrap(
                        spacing: 10,
                        runSpacing: 10,
                        children: EventCategory.homeFilters.map((category) {
                          final selected =
                              state.categories.contains(category.name);
                          return _FilterChipButton(
                            label: category.label,
                            selected: selected,
                            onTap: () => onCategoryTap(category.name),
                          );
                        }).toList(),
                      ),
                    ),
                    const SizedBox(height: 22),
                    _FilterSection(
                      title: 'Time & Date',
                      child: Wrap(
                        spacing: 10,
                        runSpacing: 10,
                        children: DateFilter.values.map((filter) {
                          return _FilterChipButton(
                            label: _dateFilterLabel(filter),
                            selected: state.dateFilter == filter,
                            onTap: () => onDateFilterTap(filter),
                          );
                        }).toList(),
                      ),
                    ),
                    const SizedBox(height: 22),
                    _FilterSection(
                      title: 'Price Range',
                      trailing: Text(
                        '\$${state.priceRange.start.toInt()} - \$${state.priceRange.end.toInt()}',
                        style: AppTextStyles.infoSubtitle.copyWith(
                          color: AppColors.primary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      child: Column(
                        children: [
                          RangeSlider(
                            values: state.priceRange,
                            min: 0,
                            max: 200,
                            divisions: 20,
                            activeColor: AppColors.primary,
                            inactiveColor: AppColors.tabBackground,
                            labels: RangeLabels(
                              '\$${state.priceRange.start.toInt()}',
                              '\$${state.priceRange.end.toInt()}',
                            ),
                            onChanged: onPriceChanged,
                          ),
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('\$0', style: AppTextStyles.infoSubtitle),
                              Text('\$200+', style: AppTextStyles.infoSubtitle),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SafeArea(
                top: false,
                child: Container(
                  padding: const EdgeInsets.fromLTRB(24, 14, 24, 18),
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.textPrimary.withValues(alpha: 0.08),
                        blurRadius: 18,
                        offset: const Offset(0, -8),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: onClear,
                          style: OutlinedButton.styleFrom(
                            foregroundColor: AppColors.primary,
                            side: const BorderSide(color: AppColors.primary),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 15),
                          ),
                          child: const Text('Clear All'),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: onApply,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                            foregroundColor: AppColors.textOnPrimary,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 15),
                          ),
                          child: const Text('Apply Filters'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
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

class _FilterSection extends StatelessWidget {
  const _FilterSection({
    required this.title,
    required this.child,
    this.trailing,
  });

  final String title;
  final Widget child;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(child: Text(title, style: AppTextStyles.infoTitle)),
            if (trailing != null) trailing!,
          ],
        ),
        const SizedBox(height: 12),
        child,
      ],
    );
  }
}

class _FilterChipButton extends StatelessWidget {
  const _FilterChipButton({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(18),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 11),
        decoration: BoxDecoration(
          color: selected
              ? AppColors.primary.withValues(alpha: 0.12)
              : AppColors.tabBackground,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: selected ? AppColors.primary : Colors.transparent,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (selected) ...[
              const Icon(Icons.check, size: 16, color: AppColors.primary),
              const SizedBox(width: 6),
            ],
            Text(
              label,
              style: selected ? AppTextStyles.tabActive : AppTextStyles.tabInactive,
            ),
          ],
        ),
      ),
    );
  }
}
