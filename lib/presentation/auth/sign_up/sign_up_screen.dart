import 'package:flutter/material.dart';
import 'package:events_hub/core/constants/app_strings.dart';
import 'package:events_hub/core/routes/app_routes.dart';
import 'package:events_hub/core/theme/app_colors.dart';
import 'package:events_hub/core/widgets/app_primary_button.dart';
import 'package:events_hub/core/widgets/app_text_field.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
                prefixIcon: Icon(Icons.person_outline, color: AppColors.textHint),
              ),
              const SizedBox(height: 20),
              const AppTextField(
                label: AppStrings.email,
                hint: AppStrings.emailHint,
                keyboardType: TextInputType.emailAddress,
                prefixIcon: Icon(Icons.email_outlined, color: AppColors.textHint),
              ),
              const SizedBox(height: 20),
              const AppTextField(
                label: AppStrings.password,
                hint: AppStrings.passwordHint,
                obscureText: true,
                prefixIcon: Icon(Icons.lock_outline, color: AppColors.textHint),
                suffixIcon: Icon(Icons.visibility_off_outlined, color: AppColors.textHint),
              ),
              const SizedBox(height: 20),
              const AppTextField(
                label: AppStrings.confirmPassword,
                hint: AppStrings.confirmPasswordHint,
                obscureText: true,
                prefixIcon: Icon(Icons.lock_outline, color: AppColors.textHint),
                suffixIcon: Icon(Icons.visibility_off_outlined, color: AppColors.textHint),
              ),
              const SizedBox(height: 32),
              AppPrimaryButton(
                label: AppStrings.signUp,
                onPressed: () => Navigator.pushReplacementNamed(context, AppRoutes.eventsList),
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
    );
  }
}
