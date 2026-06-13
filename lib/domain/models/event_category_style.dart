import 'package:flutter/material.dart';
import 'package:events_hub/core/theme/AppIcons.dart';
import 'package:events_hub/core/theme/app_colors.dart';
import 'package:events_hub/domain/models/event_category.dart';

extension EventCategoryStyle on EventCategory {
  Color get chipColor => switch (this) {
        EventCategory.sports => AppColors.categorySports,
        EventCategory.music => AppColors.categoryMusic,
        EventCategory.food => AppColors.categoryFood,
        EventCategory.art => AppColors.categoryArt,
        EventCategory.all => AppColors.primary,
      };

  String get iconAsset => switch (this) {
        EventCategory.sports => AppIcons.categorySports,
        EventCategory.music => AppIcons.categoryMusic,
        EventCategory.food => AppIcons.categoryFood,
        EventCategory.art => AppIcons.categoryArt,
        EventCategory.all => AppIcons.compass,
      };
}
