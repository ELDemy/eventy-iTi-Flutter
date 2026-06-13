import 'package:flutter/material.dart';
import 'package:events_hub/core/constants/app_strings.dart';
import 'package:events_hub/core/theme/AppIcons.dart';
import 'package:events_hub/core/theme/app_colors.dart';
import 'package:events_hub/core/theme/app_text_styles.dart';

class AttendeesFloatingCard extends StatelessWidget {
  const AttendeesFloatingCard({
    super.key,
    required this.goingLabel,
    this.onInvite,
  });

  final String goingLabel;
  final VoidCallback? onInvite;

  static const List<String> _avatars = [
    AppIcons.avatar3,
    AppIcons.avatar2,
    AppIcons.avatar1,
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      margin: const EdgeInsets.symmetric(horizontal: 40),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: AppColors.attendeeCardSurface,
        borderRadius: BorderRadius.circular(30),
        boxShadow: const [
          BoxShadow(
            color: AppColors.attendeeCardShadow,
            offset: Offset(0, 20),
            blurRadius: 20,
          ),
        ],
      ),
      child: Row(
        children: [
          SizedBox(
            width: 72,
            height: 36,
            child: Stack(
              children: [
                for (var i = 0; i < _avatars.length; i++)
                  Positioned(
                    left: i * 18.0,
                    child: Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: AppColors.surface, width: 2),
                      ),
                      child: ClipOval(
                        child: Image.asset(_avatars[i], fit: BoxFit.cover),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Text(goingLabel, style: AppTextStyles.goingLabel),
          const Spacer(),
          _InviteButton(onPressed: onInvite),
        ],
      ),
    );
  }
}

class _InviteButton extends StatelessWidget {
  const _InviteButton({this.onPressed});

  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.circular(7),
          boxShadow: [
            BoxShadow(
              color: const Color(0x144AD2E4),
              offset: const Offset(0, 8),
              blurRadius: 20,
            ),
          ],
        ),
        child: Text(
          AppStrings.invite,
          style: AppTextStyles.chipButton.copyWith(color: AppColors.textOnPrimary),
        ),
      ),
    );
  }
}
