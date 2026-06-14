import 'package:events_hub/core/constants/app_strings.dart';
import 'package:events_hub/core/theme/app_colors.dart';
import 'package:events_hub/core/widgets/app_primary_button.dart';
import 'package:events_hub/core/widgets/app_text_field.dart';
import 'package:events_hub/presentation/auth/components/TopLogo.dart';
import 'package:flutter/material.dart';

import '../../../core/widgets/auth_background.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ColoredBackground(
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 24),
                TopLogo(),
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
                const SizedBox(height: 6),
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
