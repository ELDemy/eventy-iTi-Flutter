import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:events_hub/core/constants/app_strings.dart';
import 'package:events_hub/core/theme/AppIcons.dart';
import 'package:events_hub/core/theme/app_text_styles.dart';

class HomeSectionHeader extends StatelessWidget {
  const HomeSectionHeader({
    super.key,
    required this.title,
    this.onSeeAllTap,
  });

  final String title;
  final VoidCallback? onSeeAllTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 0, 24, 16),
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: AppTextStyles.homeSectionTitle,
            ),
          ),
          GestureDetector(
            onTap: onSeeAllTap,
            behavior: HitTestBehavior.opaque,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  AppStrings.seeAll,
                  style: AppTextStyles.homeSeeAll,
                ),
                const SizedBox(width: 4),
                SvgPicture.asset(
                  AppIcons.chevronRight,
                  width: 7,
                  height: 9,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
