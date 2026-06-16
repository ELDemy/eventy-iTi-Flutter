import 'package:events_hub/core/di/app_dependencies.dart';
import 'package:events_hub/core/theme/app_colors.dart';
import 'package:events_hub/presentation/auth/auth_gate.dart';
import 'package:events_hub/presentation/onboarding/components/on_boarding_rounded_container.dart';
import 'package:flutter/material.dart';

import 'data/onboarding_page_data.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  int _page = 0;
  static const _pages = OnboardingPageData.pages;

  Future<void> _finishOnboarding() async {
    await AppDependencies.authRepository.markOnboardingSeen();
    if (!mounted) return;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const AuthGate()),
    );
  }

  void _onNext() {
    if (_page < _pages.length - 1) {
      _controller.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      _finishOnboarding();
    }
  }

  void _onPrevious() {
    if (_page > 0) {
      _controller.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOutBack,
      );
    }
  }

  void _onSkip() {
    _finishOnboarding();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF00142E),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: _onSkip,
                    style: TextButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          side: BorderSide(color: AppColors.primary),
                          borderRadius: BorderRadius.circular(24)),
                      foregroundColor: AppColors.primary,
                      textStyle: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    child: const Text('Skip'),
                  ),
                ],
              ),
            ),
            Expanded(
              child: PageView.builder(
                controller: _controller,
                itemCount: _pages.length,
                onPageChanged: (index) => setState(() => _page = index),
                itemBuilder: (context, index) {
                  return Image.asset(_pages[index].contentImage);
                },
              ),
            ),
            OnBoardingRoundedContainer(
              page: _page,
              pages: _pages,
              onNext: _onNext,
              onPrevious: _onPrevious,
            ),
          ],
        ),
      ),
    );
  }
}
