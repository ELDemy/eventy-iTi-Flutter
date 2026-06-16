import 'package:events_hub/core/constants/app_strings.dart';
import 'package:events_hub/core/theme/app_colors.dart';
import 'package:events_hub/core/widgets/app_primary_button.dart';
import 'package:events_hub/core/widgets/app_text_field.dart';
import 'package:events_hub/presentation/auth/components/TopLogo.dart';
import 'package:events_hub/presentation/auth/cubit/sign_up_cubit.dart';
import 'package:events_hub/presentation/auth/cubit/sign_up_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/widgets/auth_background.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SignUpCubit(),
      child: BlocListener<SignUpCubit, SignUpState>(
        listener: (context, state) {
          if (state.isAuthenticated) {
            Navigator.pop(context);
          }
        },
        child: BlocBuilder<SignUpCubit, SignUpState>(
          builder: (context, state) {
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
                          style: Theme.of(context)
                              .textTheme
                              .headlineMedium
                              ?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: AppColors.textPrimary,
                              ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          AppStrings.signUpSubtitle,
                          style:
                              Theme.of(context).textTheme.bodyLarge?.copyWith(
                                    color: AppColors.textSecondary,
                                  ),
                        ),
                        const SizedBox(height: 32),
                        AppTextField(
                          controller: _fullNameController,
                          label: AppStrings.fullName,
                          hint: AppStrings.fullNameHint,
                          prefixIcon: const Icon(
                            Icons.person_outline,
                            color: AppColors.textHint,
                          ),
                        ),
                        const SizedBox(height: 20),
                        AppTextField(
                          controller: _emailController,
                          label: AppStrings.email,
                          hint: AppStrings.emailHint,
                          keyboardType: TextInputType.emailAddress,
                          prefixIcon: const Icon(
                            Icons.email_outlined,
                            color: AppColors.textHint,
                          ),
                        ),
                        const SizedBox(height: 20),
                        AppTextField(
                          controller: _passwordController,
                          label: AppStrings.password,
                          hint: AppStrings.passwordHint,
                          obscureText: true,
                          prefixIcon: const Icon(
                            Icons.lock_outline,
                            color: AppColors.textHint,
                          ),
                          suffixIcon: const Icon(
                            Icons.visibility_off_outlined,
                            color: AppColors.textHint,
                          ),
                        ),
                        const SizedBox(height: 20),
                        AppTextField(
                          controller: _confirmPasswordController,
                          label: AppStrings.confirmPassword,
                          hint: AppStrings.confirmPasswordHint,
                          obscureText: true,
                          prefixIcon: const Icon(
                            Icons.lock_outline,
                            color: AppColors.textHint,
                          ),
                          suffixIcon: const Icon(
                            Icons.visibility_off_outlined,
                            color: AppColors.textHint,
                          ),
                        ),
                        if (state.errorMessage != null) ...[
                          const SizedBox(height: 16),
                          Text(
                            state.errorMessage!,
                            textAlign: TextAlign.center,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(color: AppColors.categorySports),
                          ),
                        ],
                        const SizedBox(height: 32),
                        AppPrimaryButton(
                          label: state.isLoading
                              ? 'Creating account...'
                              : AppStrings.signUp,
                          onPressed: state.isLoading
                              ? null
                              : () => context.read<SignUpCubit>().signUp(
                                    fullName: _fullNameController.text,
                                    email: _emailController.text,
                                    password: _passwordController.text,
                                    confirmPassword:
                                        _confirmPasswordController.text,
                                  ),
                        ),
                        const SizedBox(height: 6),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              AppStrings.haveAccount,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(
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
          },
        ),
      ),
    );
  }
}
