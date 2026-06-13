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

  // Events list card title
  static const TextStyle eventCardTitle = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w500,
    color: AppColors.textPrimary,
    height: 1.0,
  );

  static const TextStyle eventCardDate = TextStyle(
    fontSize: 13,
    fontWeight: FontWeight.w400,
    color: AppColors.primary,
    height: 1.0,
  );

  static const TextStyle eventCardLocation = TextStyle(
    fontSize: 13,
    fontWeight: FontWeight.w400,
    color: AppColors.textSub,
    height: 1.0,
  );

  static const TextStyle tabActive = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w400,
    color: AppColors.primary,
    height: 25 / 15,
  );

  static const TextStyle tabInactive = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w400,
    color: AppColors.tabInactiveText,
    height: 25 / 15,
  );

  static const TextStyle emptyEventsTitle = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w500,
    color: AppColors.textPrimary,
    height: 1.0,
  );

  static const TextStyle emptyEventsDescription = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: AppColors.textSub,
    height: 25 / 16,
  );

  // Home
  static const TextStyle homeSectionTitle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w500,
    color: AppColors.textPrimary,
    height: 34 / 18,
  );

  static const TextStyle homeSeeAll = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.textSub,
    height: 23 / 14,
  );

  static const TextStyle homeLocationLabel = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: AppColors.textOnPrimary,
    height: 1.0,
  );

  static const TextStyle homeLocationValue = TextStyle(
    fontSize: 13,
    fontWeight: FontWeight.w500,
    color: AppColors.headerLocationText,
    height: 1.0,
  );

  static const TextStyle homeSearchHint = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w400,
    color: AppColors.textOnPrimary,
    letterSpacing: -1,
  );

  static const TextStyle homeFilterLabel = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: AppColors.textOnPrimary,
    height: 1.0,
  );

  static const TextStyle categoryChipLabel = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w400,
    color: AppColors.textOnPrimary,
    height: 25 / 15,
  );

  static const TextStyle featuredCardTitle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w500,
    color: AppColors.textPrimary,
    height: 1.0,
  );

  static const TextStyle featuredCardLocation = TextStyle(
    fontSize: 13,
    fontWeight: FontWeight.w400,
    color: AppColors.featuredLocation,
    height: 1.0,
  );

  static const TextStyle featuredGoingCount = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    color: AppColors.goingCount,
    height: 19.236 / 12,
  );

  static const TextStyle dateBadgeDay = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w700,
    color: AppColors.dateBadge,
    height: 1.0,
  );

  static const TextStyle dateBadgeMonth = TextStyle(
    fontSize: 10,
    fontWeight: FontWeight.w500,
    color: AppColors.dateBadge,
    height: 13.7 / 10,
  );

  static const TextStyle scheduleLabel = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    color: AppColors.primary,
    height: 1.0,
    letterSpacing: 0,
  );

  static const TextStyle promoTitle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w500,
    color: AppColors.textPrimary,
    height: 34 / 18,
  );

  static const TextStyle promoSubtitle = TextStyle(
    fontSize: 13,
    fontWeight: FontWeight.w400,
    color: AppColors.promoSubtitle,
    height: 1.0,
  );

  static const TextStyle inviteButton = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    color: AppColors.textOnPrimary,
    letterSpacing: 0,
    height: 23 / 12,
  );

  static const TextStyle navLabelActive = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: AppColors.primary,
    height: 1.0,
  );

  static const TextStyle navLabelInactive = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: AppColors.navInactive,
    height: 1.0,
  );
}
