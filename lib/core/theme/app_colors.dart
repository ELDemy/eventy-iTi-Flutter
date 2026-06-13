import 'package:flutter/material.dart';

/// Color tokens from Figma design system.
abstract final class AppColors {
  // Brand — Color/ Primary/ Blue
  static const Color primary = Color(0xFF5669FF);

  // Backgrounds
  static const Color background = Color(0xFFFFFFFF);
  static const Color surface = Color(0xFFFFFFFF);

  // Color/ Typography/ Title
  static const Color textPrimary = Color(0xFF120D26);

  // Color/ Typography/ Sub-Color
  static const Color textSub = Color(0xFF747688);

  // Brand name
  static const Color brandName = Color(0xFF37364A);

  // OR divider
  static const Color textMuted = Color(0xFF9D9898);

  static const Color textOnPrimary = Color(0xFFFFFFFF);

  // Input border
  static const Color inputBorder = Color(0xFFE4DFDF);
  static const Color divider = Color(0xFFF3F4F6);

  // Decorative blobs
  static const Color blobPurple = Color(0xFFB8BFFF);
  static const Color blobLavender = Color(0xFFD4D0FF);

  // Shadows
  static const Color primaryButtonShadow = Color(0x406F7EC9);
  static const Color socialButtonShadow = Color(0x40D3D4E2);

  // Semantic
  static const Color error = Color(0xFFEF4444);
  static const Color success = Color(0xFF10B981);

  static const Color iconDefault = Color(0xFFAAAAAA);

  // Reused across other screens
  static const Color border = inputBorder;
  static const Color textSecondary = textSub;
  static const Color textHint = textSub;
  static const Color surfaceVariant = Color(0xFFF1F3F8);
  static const Color chipBackground = Color(0xFFEDE9FE);
  static const Color chipText = primary;
  static const Color cardShadow = Color(0x0F575C8A);
  static const Color emptyIconBackground = Color(0xFFEDE9FE);
  static const Color tabBackground = Color(0x08000000);
  static const Color tabInactiveText = Color(0xFF9B9B9B);
  static const Color eventCardImageFallback = Color(0xFFFFCD6C);

  // Event details
  static const Color goingCount = Color(0xFF3F38DD);
  static const Color organizerName = Color(0xFF0D0C26);
  static const Color organizerRole = Color(0xFF706E8F);
  static const Color attendeeCardSurface = Color(0xFFFEFEFF);
  static const Color attendeeCardShadow = Color(0x1A5A5A5A);
  static const Color navOverlay = Color(0x96000000);

  static Color get primarySurface10 => primary.withValues(alpha: 0.10);
  static Color get primarySurface12 => primary.withValues(alpha: 0.12);
  static Color get navButtonSurface => surface.withValues(alpha: 0.30);
}
