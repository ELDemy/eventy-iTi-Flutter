import 'package:events_hub/core/constants/app_strings.dart';
import 'package:events_hub/core/routes/app_routes.dart';
import 'package:events_hub/core/theme/AppIcons.dart';
import 'package:events_hub/core/theme/app_colors.dart';
import 'package:events_hub/core/theme/app_text_styles.dart';
import 'package:events_hub/core/widgets/auth_background.dart';
import 'package:events_hub/core/widgets/auth_text_field.dart';
import 'package:events_hub/core/widgets/social_login_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  bool _rememberMe = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: AuthBackground(
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 28),
            child: Column(
              children: [
                const SizedBox(height: 24),
                _buildLogo(),
                const SizedBox(height: 36),
                Align(
                  alignment: Alignment.centerLeft,
                  child:
                      Text(AppStrings.signIn, style: AppTextStyles.signInTitle),
                ),
                const SizedBox(height: 21),
                const AuthTextField(
                  hint: AppStrings.emailHint,
                  prefixIconAsset: AppIcons.mail,
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 19),
                const AuthTextField(
                  hint: AppStrings.passwordHint,
                  prefixIconAsset: AppIcons.lock,
                  suffixIconAsset: AppIcons.lock,
                  obscureText: true,
                ),
                const SizedBox(height: 20),
                _buildRememberForgotRow(),
                const SizedBox(height: 36),
                _buildSignInButton(context),
                const SizedBox(height: 24),
                Text(AppStrings.or, style: AppTextStyles.orDivider),
                const SizedBox(height: 5),
                SocialLoginButton(
                  label: AppStrings.loginWithGoogle,
                  iconAsset: AppIcons.google,
                  onPressed: () {},
                ),
                const SizedBox(height: 17),
                SocialLoginButton(
                  label: AppStrings.loginWithFacebook,
                  iconAsset: AppIcons.facebook,
                  onPressed: () {},
                ),
                const SizedBox(height: 20),
                _buildSignUpFooter(context),
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

  Widget _buildRememberForgotRow() {
    return Row(
      children: [
        GestureDetector(
          onTap: () => setState(() => _rememberMe = !_rememberMe),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width: 32,
            height: 19,
            decoration: BoxDecoration(
              color: _rememberMe ? AppColors.primary : AppColors.inputBorder,
              borderRadius: BorderRadius.circular(95),
            ),
            child: AnimatedAlign(
              duration: const Duration(milliseconds: 200),
              alignment:
                  _rememberMe ? Alignment.centerRight : Alignment.centerLeft,
              child: Container(
                width: 15,
                height: 15,
                margin: const EdgeInsets.symmetric(horizontal: 2),
                decoration: const BoxDecoration(
                  color: AppColors.textOnPrimary,
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(width: 8),
        Text(AppStrings.rememberMe, style: AppTextStyles.body3),
        const Spacer(),
        GestureDetector(
          onTap: () {},
          child: Text(AppStrings.forgotPassword, style: AppTextStyles.body3),
        ),
      ],
    );
  }

  Widget _buildSignInButton(BuildContext context) {
    return SizedBox(
      height: 58,
      width: double.infinity,
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          boxShadow: const [
            BoxShadow(
              color: AppColors.primaryButtonShadow,
              offset: Offset(0, 10),
              blurRadius: 35,
            ),
          ],
        ),
        child: ElevatedButton(
          onPressed: () =>
              Navigator.pushReplacementNamed(context, AppRoutes.eventsList),
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            foregroundColor: AppColors.textOnPrimary,
            elevation: 0,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            padding: const EdgeInsets.symmetric(horizontal: 20),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(AppStrings.signInButton, style: AppTextStyles.buttonLabel),
              const Spacer(),
              Container(
                width: 30,
                height: 30,
                decoration: const BoxDecoration(
                  color: AppColors.textOnPrimary,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.arrow_forward,
                  size: 16,
                  color: AppColors.primary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSignUpFooter(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, AppRoutes.signUp),
      child: RichText(
        text: TextSpan(
          style: AppTextStyles.body2,
          children: [
            TextSpan(text: AppStrings.noAccountPrefix),
            TextSpan(text: AppStrings.signUp, style: AppTextStyles.link),
          ],
        ),
      ),
    );
  }
}
