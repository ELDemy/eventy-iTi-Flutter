import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:events_hub/core/constants/app_strings.dart';
import 'package:events_hub/core/theme/AppIcons.dart';
import 'package:events_hub/core/theme/app_colors.dart';
import 'package:events_hub/core/theme/app_text_styles.dart';

class EmptyEventsView extends StatelessWidget {
  const EmptyEventsView({
    super.key,
    this.onExploreEvents,
  });

  final VoidCallback? onExploreEvents;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 202,
                height: 202,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    SvgPicture.asset(AppIcons.emptyCircle, width: 202, height: 202),
                    SvgPicture.asset(AppIcons.emptySchedule, width: 140, height: 140),
                  ],
                ),
              ),
              const SizedBox(height: 31),
              Text(
                AppStrings.noUpcomingEvent,
                style: AppTextStyles.emptyEventsTitle,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 54),
                child: Text(
                  AppStrings.emptyEventsDescription,
                  style: AppTextStyles.emptyEventsDescription,
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(52, 0, 52, 32),
          child: SizedBox(
            height: 58,
            width: double.infinity,
            child: DecoratedBox(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                boxShadow: const [
                  BoxShadow(
                    color: AppColors.primaryButtonShadow,
                    offset: Offset(0, 10),
                    blurRadius: 35,
                  ),
                ],
              ),
              child: ElevatedButton(
                onPressed: onExploreEvents,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: AppColors.textOnPrimary,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(AppStrings.exploreEvents, style: AppTextStyles.buttonLabel),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
