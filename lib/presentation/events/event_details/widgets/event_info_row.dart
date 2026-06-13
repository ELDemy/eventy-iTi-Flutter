import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:events_hub/core/theme/app_colors.dart';
import 'package:events_hub/core/theme/app_text_styles.dart';

class EventInfoRow extends StatelessWidget {
  const EventInfoRow({
    super.key,
    required this.iconAsset,
    this.iconBackgroundOpacity = 0.10,
    required this.title,
    required this.subtitle,
  });

  final String iconAsset;
  final double iconBackgroundOpacity;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: AppColors.primary.withValues(alpha: iconBackgroundOpacity),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Center(
            child: SvgPicture.asset(iconAsset, width: 24, height: 24),
          ),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: AppTextStyles.infoTitle),
              const SizedBox(height: 2),
              Text(subtitle, style: AppTextStyles.infoSubtitle),
            ],
          ),
        ),
      ],
    );
  }
}
