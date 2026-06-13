import 'package:flutter/material.dart';
import 'package:events_hub/core/constants/app_strings.dart';
import 'package:events_hub/core/theme/AppIcons.dart';
import 'package:events_hub/core/theme/app_colors.dart';
import 'package:events_hub/core/theme/app_text_styles.dart';

class HomePromoBanner extends StatelessWidget {
  const HomePromoBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 8, 24, 24),
      child: Container(
        height: 120,
        decoration: BoxDecoration(
          color: AppColors.promoBannerBg,
          borderRadius: BorderRadius.circular(12),
        ),
        clipBehavior: Clip.antiAlias,
        child: Stack(
          children: [
            Positioned(
              right: -20,
              top: -10,
              bottom: -10,
              child: Image.asset(
                AppIcons.promoBanner,
                fit: BoxFit.cover,
                width: 180,
                errorBuilder: (_, __, ___) => const SizedBox.shrink(),
              ),
            ),
            Positioned(
              left: 18,
              top: 16,
              right: 120,
              child: Text(
                AppStrings.inviteFriends,
                style: AppTextStyles.promoTitle,
              ),
            ),
            Positioned(
              left: 18,
              top: 52,
              right: 120,
              child: Text(
                AppStrings.inviteReward,
                style: AppTextStyles.promoSubtitle,
              ),
            ),
            Positioned(
              left: 18,
              bottom: 16,
              child: Container(
                height: 32,
                padding: const EdgeInsets.symmetric(horizontal: 14),
                decoration: BoxDecoration(
                  color: AppColors.promoCyan,
                  borderRadius: BorderRadius.circular(5),
                ),
                alignment: Alignment.center,
                child: Text(
                  AppStrings.invite.toUpperCase(),
                  style: AppTextStyles.inviteButton,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
