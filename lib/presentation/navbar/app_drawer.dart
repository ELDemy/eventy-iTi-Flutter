import 'package:events_hub/core/theme/app_colors.dart';
import 'package:events_hub/core/theme/app_text_styles.dart';
import 'package:events_hub/domain/models/app_user.dart';
import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({
    super.key,
    required this.onClose,
    this.user,
    this.onProfileTap,
    this.onMassageTap,
    this.onCalendarTap,
    this.onBookmarkTap,
    this.onContactUsTap,
    this.onSettingsTap,
    this.onHelpTap,
    this.onSignOutTap,
  });

  final VoidCallback onClose;
  final AppUser? user;
  final VoidCallback? onProfileTap;
  final VoidCallback? onMassageTap;
  final VoidCallback? onCalendarTap;
  final VoidCallback? onBookmarkTap;
  final VoidCallback? onContactUsTap;
  final VoidCallback? onSettingsTap;
  final VoidCallback? onHelpTap;
  final VoidCallback? onSignOutTap;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 28),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(context),
            const SizedBox(height: 30),
            _buildMenuItem(
              icon: Icons.person_outline,
              label: 'My Profile',
              onTap: onProfileTap,
            ),
            _buildMenuItem(
              icon: Icons.message_outlined,
              label: 'Massage',
              badge: '3',
              onTap: onMassageTap,
            ),
            _buildMenuItem(
              icon: Icons.calendar_today,
              label: 'Calender',
              onTap: onCalendarTap,
            ),
            _buildMenuItem(
              icon: Icons.bookmark_outline,
              label: 'Bookmark',
              onTap: onBookmarkTap,
            ),
            _buildMenuItem(
              icon: Icons.mail_outline,
              label: 'Contact Us',
              onTap: onContactUsTap,
            ),
            _buildMenuItem(
              icon: Icons.settings_outlined,
              label: 'Settings',
              onTap: onSettingsTap,
            ),
            _buildMenuItem(
              icon: Icons.help_outline,
              label: 'Helps & FAQs',
              onTap: onHelpTap,
            ),
            _buildMenuItem(
              icon: Icons.logout,
              label: 'Sign Out',
              onTap: onSignOutTap,
            ),
            const Spacer(),
            _buildUpgradeProCard(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CircleAvatar(
          radius: 28,
          backgroundImage: user?.photoUrl != null
              ? NetworkImage(user!.photoUrl!)
              : const AssetImage('assets/images/avatar_1.png')
                  as ImageProvider,
          backgroundColor: AppColors.surface,
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                user?.fullName ?? 'EventHub User',
                style: AppTextStyles.homeSectionTitle,
              ),
              const SizedBox(height: 4),
              Text('View profile', style: AppTextStyles.infoSubtitle),
            ],
          ),
        ),
        InkWell(
          onTap: onClose,
          borderRadius: BorderRadius.circular(12),
          child: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: AppColors.textPrimary.withOpacity(0.06),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: const Icon(Icons.close, size: 20),
          ),
        ),
      ],
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String label,
    String? badge,
    VoidCallback? onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 18),
      child: InkWell(
        onTap: () {
          onClose();
          onTap?.call();
        },
        borderRadius: BorderRadius.circular(16),
        child: Row(
          children: [
            Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(14),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.textPrimary.withOpacity(0.04),
                    blurRadius: 16,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Icon(icon, color: AppColors.textSub, size: 20),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Text(label, style: AppTextStyles.body2.copyWith(color: AppColors.textPrimary)),
            ),
            if (badge != null)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  badge,
                  style: AppTextStyles.infoTitle.copyWith(
                    color: AppColors.primary,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    height: 1,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildUpgradeProCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
      decoration: BoxDecoration(
        color: const Color(0xFFE8FCFF),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.12),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(Icons.workspace_premium, color: AppColors.primary),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text('Upgrade Pro', style: AppTextStyles.homeSectionTitle),
                SizedBox(height: 4),
                Text('Get unlimited access', style: AppTextStyles.infoSubtitle),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
