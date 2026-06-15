import 'package:events_hub/core/theme/app_colors.dart';
import 'package:events_hub/domain/models/event.dart';
import 'package:flutter/material.dart';

class EventImageView extends StatelessWidget {
  const EventImageView({
    super.key,
    required this.event,
    this.fit = BoxFit.cover,
    this.fallbackIconColor = AppColors.textSub,
  });

  final Event event;
  final BoxFit fit;
  final Color fallbackIconColor;

  @override
  Widget build(BuildContext context) {
    final imageUrl = event.imageUrl;
    final imageAsset = event.imageAsset;

    if (imageUrl != null && imageUrl.isNotEmpty) {
      return Image.network(
        imageUrl,
        fit: fit,
        errorBuilder: (_, __, ___) => _FallbackIcon(color: fallbackIconColor),
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return const ColoredBox(
            color: AppColors.eventCardImageFallback,
            child: Center(
              child: SizedBox(
                width: 18,
                height: 18,
                child: CircularProgressIndicator(strokeWidth: 2),
              ),
            ),
          );
        },
      );
    }

    if (imageAsset != null && imageAsset.isNotEmpty) {
      return Image.asset(
        imageAsset,
        fit: fit,
        errorBuilder: (_, __, ___) => _FallbackIcon(color: fallbackIconColor),
      );
    }

    return _FallbackIcon(color: fallbackIconColor);
  }
}

class _FallbackIcon extends StatelessWidget {
  const _FallbackIcon({required this.color});

  final Color color;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: AppColors.eventCardImageFallback,
      child: Icon(Icons.image_outlined, color: color),
    );
  }
}
