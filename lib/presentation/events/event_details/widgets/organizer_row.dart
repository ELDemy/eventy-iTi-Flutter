import 'package:flutter/material.dart';
import 'package:events_hub/core/constants/app_strings.dart';
import 'package:events_hub/core/theme/AppIcons.dart';
import 'package:events_hub/core/theme/app_colors.dart';
import 'package:events_hub/core/theme/app_text_styles.dart';

class OrganizerRow extends StatelessWidget {
  const OrganizerRow({
    super.key,
    required this.name,
    required this.role,
    this.onFollow,
  });

  final String name;
  final String role;
  final VoidCallback? onFollow;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 44,
          height: 44,
          decoration: const BoxDecoration(shape: BoxShape.circle),
          child: ClipOval(
            child: Image.asset(AppIcons.organizer, fit: BoxFit.cover),
          ),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(name, style: AppTextStyles.organizerName),
              Text(role, style: AppTextStyles.organizerRole),
            ],
          ),
        ),
        GestureDetector(
          onTap: onFollow,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            decoration: BoxDecoration(
              color: AppColors.primarySurface12,
              borderRadius: BorderRadius.circular(7),
            ),
            child: Text(
              AppStrings.follow,
              style: AppTextStyles.chipButton.copyWith(color: AppColors.primary),
            ),
          ),
        ),
      ],
    );
  }
}
