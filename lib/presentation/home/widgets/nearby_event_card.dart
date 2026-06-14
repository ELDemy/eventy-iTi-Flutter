import 'package:events_hub/core/theme/AppIcons.dart';
import 'package:events_hub/core/theme/app_colors.dart';
import 'package:events_hub/core/theme/app_text_styles.dart';
import 'package:events_hub/domain/models/event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NearbyEventCard extends StatelessWidget {
  const NearbyEventCard({
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
        height: 112,
        margin: const EdgeInsets.fromLTRB(24, 0, 24, 16),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(18),
          boxShadow: const [
            BoxShadow(
              color: AppColors.homeCardShadow,
              offset: Offset(0, 8),
              blurRadius: 30,
            ),
          ],
        ),
        child: Row(
          children: [
            const SizedBox(width: 8),
            _buildImage(),
            const SizedBox(width: 18),
            Expanded(child: _buildContent()),
            _buildBookmark(),
            const SizedBox(width: 12),
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
        if (event.scheduleLabel != null) ...[
          Text(
            event.scheduleLabel!.toUpperCase(),
            style: AppTextStyles.scheduleLabel,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 6),
        ],
        Text(
          event.title,
          style: AppTextStyles.eventCardTitle,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: 6),
        Row(
          children: [
            SvgPicture.asset(AppIcons.mapPin, width: 16, height: 16),
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

  Widget _buildBookmark() {
    return GestureDetector(
      onTap: onBookmarkTap,
      child: SvgPicture.asset(
        event.isBookmarked ? AppIcons.bookmarkFilled : AppIcons.bookmarkOutline,
        width: 16,
        height: 16,
      ),
    );
  }
}
