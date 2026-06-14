import 'package:events_hub/core/theme/AppIcons.dart';
import 'package:events_hub/core/theme/app_colors.dart';
import 'package:events_hub/core/theme/app_text_styles.dart';
import 'package:events_hub/domain/models/event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class EventCard extends StatelessWidget {
  const EventCard({
    super.key,
    required this.event,
    this.onTap,
    this.onBookmarkTap,
  });

  final Event event;
  final VoidCallback? onTap;
  final VoidCallback? onBookmarkTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 106,
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(16),
          boxShadow: const [
            BoxShadow(
              color: AppColors.cardShadow,
              offset: Offset(0, 10),
              blurRadius: 35,
            ),
          ],
        ),
        child: Row(
          children: [
            const SizedBox(width: 8),
            _buildImage(),
            const SizedBox(width: 18),
            Expanded(child: _buildContent()),
            const SizedBox(width: 8),
          ],
        ),
      ),
    );
  }

  Widget _buildImage() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Container(
        width: 79,
        height: 92,
        color: AppColors.eventCardImageFallback,
        child: Image.asset(
          event.imageAsset,
          fit: BoxFit.cover,
          errorBuilder: (_, __, ___) => const Icon(
            Icons.image_outlined,
            color: AppColors.textSub,
          ),
        ),
      ),
    );
  }

  Widget _buildContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Text(
                event.title,
                style: AppTextStyles.eventCardTitle,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            GestureDetector(
              onTap: onBookmarkTap,
              child: SvgPicture.asset(
                AppIcons.bookmarkOutline,
                width: 16,
                height: 16,
                colorFilter: ColorFilter.mode(
                  event.isBookmarked ? AppColors.primary : AppColors.textSub,
                  BlendMode.srcIn,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        Text(event.dateTime, style: AppTextStyles.eventCardDate),
        const SizedBox(height: 6),
        Row(
          children: [
            SvgPicture.asset(AppIcons.mapPin, width: 14, height: 14),
            const SizedBox(width: 6),
            Expanded(
              child: Text(
                event.location,
                style: AppTextStyles.eventCardLocation,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
