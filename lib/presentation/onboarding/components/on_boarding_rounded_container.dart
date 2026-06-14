import 'package:events_hub/core/theme/app_colors.dart';
import 'package:events_hub/core/theme/app_text_styles.dart';
import 'package:flutter/material.dart';

import '../data/onboarding_page_data.dart';

class OnBoardingRoundedContainer extends StatelessWidget {
  const OnBoardingRoundedContainer({
    super.key,
    required this.page,
    required this.pages,
    required this.onNext,
    required this.onPrevious,
  });

  final int page;
  final List<OnboardingPageData> pages;
  final VoidCallback onNext;
  final VoidCallback onPrevious;

  @override
  Widget build(BuildContext context) {
    return Container(
      // decoration: const BoxDecoration(
      //   color: AppColors.primary,
      //   borderRadius: BorderRadius.only(
      //     topLeft: Radius.circular(48),
      //     topRight: Radius.circular(48),
      //   ),
      // ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 16),
            Text(
              pages[page].title,
              textAlign: TextAlign.center,
              style: AppTextStyles.sectionTitle.copyWith(
                color: AppColors.textOnPrimary,
                fontSize: 24,
                height: 1.42,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              pages[page].description,
              textAlign: TextAlign.center,
              style: AppTextStyles.body2.copyWith(
                color: AppColors.textOnPrimary.withValues(alpha: 0.88),
                height: 1.75,
              ),
            ),
            const SizedBox(height: 48),
            _pagesController(),
          ],
        ),
      ),
    );
  }

  Row _pagesController() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TextButton(
          onPressed: onPrevious,
          style: TextButton.styleFrom(
            foregroundColor: (page > 0)
                ? AppColors.textOnPrimary.withValues(alpha: 0.85)
                : Colors.transparent,
            textStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          child: const Text('Previous'),
        ),
        Row(
          mainAxisSize: MainAxisSize.max,
          children: List.generate(
            pages.length,
            (index) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: _buildDot(isActive: page == index),
            ),
          ),
        ),
        TextButton(
          onPressed: onNext,
          style: TextButton.styleFrom(
            foregroundColor: AppColors.textOnPrimary,
            textStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          child: Text(page == pages.length - 1 ? 'Get Started' : 'Next'),
        ),
      ],
    );
  }

  Widget _buildDot({required bool isActive}) {
    return Container(
      width: isActive ? 24 : 10,
      height: 10,
      decoration: BoxDecoration(
        color: isActive ? Colors.white : Colors.white54,
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}
