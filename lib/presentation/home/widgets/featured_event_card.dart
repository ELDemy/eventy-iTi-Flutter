import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:events_hub/core/theme/AppIcons.dart';
import 'package:events_hub/core/theme/app_colors.dart';
import 'package:events_hub/core/theme/app_text_styles.dart';
import 'package:events_hub/domain/models/event.dart';

class FeaturedEventCard extends StatelessWidget {
  const FeaturedEventCard({
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
    final dateParts = _parseDateBadge(event.dateTime);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 237,
        height: 255,
        margin: const EdgeInsets.only(right: 16),
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(9, 9, 9, 0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: SizedBox(
                      height: 131,
                      width: double.infinity,
                      child: Image.asset(
                        event.imageAsset,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => ColoredBox(
                          color: AppColors.eventCardImageFallback,
                          child: const Icon(Icons.image_outlined),
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 17,
                  left: 17,
                  child: _DateBadge(
                    day: dateParts.$1,
                    month: dateParts.$2,
                  ),
                ),
                Positioned(
                  top: 17,
                  right: 17,
                  child: _BookmarkButton(
                    isBookmarked: event.isBookmarked,
                    onTap: onBookmarkTap,
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
              child: Text(
                event.title,
                style: AppTextStyles.featuredCardTitle,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
              child: Row(
                children: [
                  _AttendeeAvatars(),
                  const SizedBox(width: 8),
                  if (event.goingCount != null)
                    Text(
                      event.goingCount!,
                      style: AppTextStyles.featuredGoingCount,
                    ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
              child: Row(
                children: [
                  SvgPicture.asset(
                    AppIcons.mapPin,
                    width: 16,
                    height: 16,
                    colorFilter: ColorFilter.mode(
                      AppColors.featuredLocation.withValues(alpha: 0.5),
                      BlendMode.srcIn,
                    ),
                  ),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Text(
                      event.location,
                      style: AppTextStyles.featuredCardLocation.copyWith(
                        color: AppColors.featuredLocation.withValues(alpha: 0.5),
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  (String, String) _parseDateBadge(String dateTime) {
    final beforeBullet = dateTime.split('•').first.trim();
    final segments = beforeBullet.split(RegExp(r'\s+'));
    if (segments.length >= 3) {
      return (segments.last, segments[segments.length - 2]);
    }
    return ('10', 'June');
  }
}

class _DateBadge extends StatelessWidget {
  const _DateBadge({required this.day, required this.month});

  final String day;
  final String month;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 45,
      height: 45,
      decoration: BoxDecoration(
        color: AppColors.surface.withValues(alpha: 0.7),
        borderRadius: BorderRadius.circular(10),
      ),
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(day, style: AppTextStyles.dateBadgeDay),
          Text(month.toUpperCase(), style: AppTextStyles.dateBadgeMonth),
        ],
      ),
    );
  }
}

class _BookmarkButton extends StatelessWidget {
  const _BookmarkButton({
    required this.isBookmarked,
    this.onTap,
  });

  final bool isBookmarked;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
          color: AppColors.surface.withValues(alpha: 0.7),
          borderRadius: BorderRadius.circular(7),
        ),
        alignment: Alignment.center,
        child: SvgPicture.asset(
          isBookmarked ? AppIcons.bookmarkFilled : AppIcons.bookmarkOutline,
          width: 16,
          height: 16,
        ),
      ),
    );
  }
}

class _AttendeeAvatars extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    const avatars = [
      AppIcons.avatar1,
      AppIcons.avatar2,
      AppIcons.avatar3,
    ];

    return SizedBox(
      width: 58,
      height: 25,
      child: Stack(
        children: [
          for (var i = 0; i < avatars.length; i++)
            Positioned(
              left: i * 16.0,
              child: Container(
                width: 25,
                height: 25,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.surface, width: 2),
                  image: DecorationImage(
                    image: AssetImage(avatars[i]),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
