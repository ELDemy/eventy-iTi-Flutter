import 'package:events_hub/core/theme/app_colors.dart';
import 'package:events_hub/core/theme/app_text_styles.dart';
import 'package:flutter/material.dart';

class ReviewTile extends StatelessWidget {
  const ReviewTile({
    super.key,
    required this.avatar,
    required this.name,
    required this.date,
    required this.rating,
    required this.review,
  });

  final String avatar;
  final String name;
  final String date;
  final int rating;
  final String review;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(
          radius: 20,
          backgroundImage: AssetImage(avatar),
          backgroundColor: AppColors.surface,
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(name, style: AppTextStyles.organizerName),
                  ),
                  Text(date, style: AppTextStyles.infoSubtitle),
                ],
              ),
              const SizedBox(height: 6),
              Row(
                children: List.generate(
                  5,
                  (i) => Icon(
                    Icons.star,
                    size: 14,
                    color: i < rating ? Colors.amber : AppColors.textSub,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Text(review, style: AppTextStyles.body3),
            ],
          ),
        ),
      ],
    );
  }
}
