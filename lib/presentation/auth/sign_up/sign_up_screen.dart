import 'package:events_hub/core/constants/app_strings.dart';
import 'package:events_hub/core/theme/app_colors.dart';
import 'package:events_hub/core/widgets/app_primary_button.dart';
import 'package:events_hub/core/widgets/app_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../core/theme/AppIcons.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/widgets/auth_background.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AuthBackground(
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _buildLogo(),
                const SizedBox(height: 16),
                Text(
                  AppStrings.signUpTitle,
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                      ),
                ),
                const SizedBox(height: 8),
                Text(
                  AppStrings.signUpSubtitle,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: AppColors.textSecondary,
                      ),
                ),
                const SizedBox(height: 32),
                const AppTextField(
                  label: AppStrings.fullName,
                  hint: AppStrings.fullNameHint,
                  prefixIcon:
                      Icon(Icons.person_outline, color: AppColors.textHint),
                ),
                const SizedBox(height: 20),
                const AppTextField(
                  label: AppStrings.email,
                  hint: AppStrings.emailHint,
                  keyboardType: TextInputType.emailAddress,
                  prefixIcon:
                      Icon(Icons.email_outlined, color: AppColors.textHint),
                ),
                const SizedBox(height: 20),
                const AppTextField(
                  label: AppStrings.password,
                  hint: AppStrings.passwordHint,
                  obscureText: true,
                  prefixIcon:
                      Icon(Icons.lock_outline, color: AppColors.textHint),
                  suffixIcon: Icon(Icons.visibility_off_outlined,
                      color: AppColors.textHint),
                ),
                const SizedBox(height: 20),
                const AppTextField(
                  label: AppStrings.confirmPassword,
                  hint: AppStrings.confirmPasswordHint,
                  obscureText: true,
                  prefixIcon:
                      Icon(Icons.lock_outline, color: AppColors.textHint),
                  suffixIcon: Icon(Icons.visibility_off_outlined,
                      color: AppColors.textHint),
                ),
                const SizedBox(height: 32),
                AppPrimaryButton(
                  label: AppStrings.signUp,
                  onPressed: () => Navigator.pop(context),
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      AppStrings.haveAccount,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: AppColors.textSecondary,
                          ),
                    ),
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text(AppStrings.signIn),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLogo() {
    return Column(
      children: [
        SvgPicture.asset(AppIcons.appLogo, width: 56, height: 58),
        const SizedBox(height: 8),
        Text(AppStrings.appName, style: AppTextStyles.brandLogo),
      ],
    );
  }
}
