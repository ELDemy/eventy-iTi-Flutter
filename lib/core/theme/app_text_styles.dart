import 'package:flutter/material.dart';
import 'package:events_hub/core/theme/app_colors.dart';

/// Typography tokens from Figma design system.
abstract final class AppTextStyles {
  static const String fontFamily = 'Roboto';

  // H4- Eventhub — Sign in title
  static const TextStyle signInTitle = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w500,
    color: AppColors.textPrimary,
    height: 1.0,
  );

  // EventHub logo
  static const TextStyle brandLogo = TextStyle(
    fontSize: 35,
    fontWeight: FontWeight.w500,
    color: AppColors.brandName,
    height: 1.382,
  );

  // Body 3 — 14px
  static const TextStyle body3 = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.textPrimary,
    height: 23 / 14,
  );

  // Body 2 — 15px
  static const TextStyle body2 = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w400,
    color: AppColors.textPrimary,
    height: 25 / 15,
  );

  // Main Body — 16px
  static const TextStyle mainBody = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: AppColors.textPrimary,
    height: 25 / 16,
  );

  // Title 2 — OR divider
  static const TextStyle orDivider = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: AppColors.textMuted,
    height: 34 / 16,
  );

  // Button — uppercase sign in
  static const TextStyle buttonLabel = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: AppColors.textOnPrimary,
    letterSpacing: 1,
  );

  static const TextStyle inputHint = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.textSub,
    height: 23 / 14,
  );

  static const TextStyle link = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w400,
    color: AppColors.primary,
    height: 25 / 15,
  );

  // Event details — H2
  static const TextStyle eventTitle = TextStyle(
    fontSize: 35,
    fontWeight: FontWeight.w400,
    color: AppColors.textPrimary,
    height: 1.0,
  );

  // H4 white app bar title
  static const TextStyle eventAppBarTitle = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w500,
    color: AppColors.textOnPrimary,
    height: 1.0,
  );

  // Title 2 — date/location title
  static const TextStyle infoTitle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: AppColors.textPrimary,
    height: 34 / 16,
  );

  // SubTitle 2
  static const TextStyle infoSubtitle = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: AppColors.textSub,
    height: 1.0,
  );

  // Title 3 — +20 Going
  static const TextStyle goingLabel = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w500,
    color: AppColors.goingCount,
    height: 1.0,
  );

  // Title 1 — About Event
  static const TextStyle sectionTitle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w500,
    color: AppColors.textPrimary,
    height: 34 / 18,
  );

  // About body
  static const TextStyle aboutBody = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: AppColors.textPrimary,
    height: 28 / 16,
  );

  static const TextStyle readMore = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: AppColors.primary,
    height: 28 / 16,
  );

  static const TextStyle chipButton = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    height: 1.0,
  );

  static const TextStyle organizerName = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w400,
    color: AppColors.organizerName,
    height: 25 / 15,
  );

  static const TextStyle organizerRole = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: AppColors.organizerRole,
    height: 1.0,
  );
}
