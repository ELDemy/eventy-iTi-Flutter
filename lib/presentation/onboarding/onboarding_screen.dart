import 'package:events_hub/core/routes/app_routes.dart';
import 'package:events_hub/core/theme/app_colors.dart';
import 'package:events_hub/core/theme/app_text_styles.dart';
import 'package:flutter/material.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  int _page = 0;

  static const _pages = [
    _OnboardingPageData(
      contentImage: 'assets/images/onboarding_1_screen.png',
      shadowImage: 'assets/images/onboarding_shadow.png',
      title: 'Explore Upcoming and Nearby Events',
      description:
          'In publishing and graphic design, Lorem is a placeholder text commonly',
    ),
    _OnboardingPageData(
      contentImage: 'assets/images/onboarding_2_screen.png',
      shadowImage: 'assets/images/onboarding_2_shadow.png',
      title: 'Web Have Modern Events Calendar Feature',
      description:
          'In publishing and graphic design, Lorem is a placeholder text commonly',
    ),
    _OnboardingPageData(
      contentImage: 'assets/images/onboarding_3_screen.png',
      overlayImage: 'assets/images/onboarding_3_map.png',
      shadowImage: 'assets/images/onboarding_shadow_3.png',
      title: 'To Look Up More Events or Activities Nearby By Map',
      description:
          'In publishing and graphic design, Lorem is a placeholder text commonly',
    ),
  ];

  void _onNext() {
    if (_page < _pages.length - 1) {
      _controller.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      Navigator.of(context).pushReplacementNamed(AppRoutes.home);
    }
  }

  void _onSkip() {
    Navigator.of(context).pushReplacementNamed(AppRoutes.home);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                height: 340,
                decoration: const BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(48),
                    topRight: Radius.circular(48),
                  ),
                ),
              ),
            ),
            Column(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        onPressed: _onSkip,
                        style: TextButton.styleFrom(
                          foregroundColor: Colors.black.withOpacity(0.7),
                          textStyle: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        child: const Text('Skip'),
                      ),
                      TextButton(
                        onPressed: _onNext,
                        style: TextButton.styleFrom(
                          foregroundColor: AppColors.textOnPrimary,
                          textStyle: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        child: const Text('Next'),
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
                      return _buildPage(_pages[index]);
                    },
                  ),
                ),
              ],
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 28, vertical: 32),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      _pages[_page].title,
                      textAlign: TextAlign.center,
                      style: AppTextStyles.sectionTitle.copyWith(
                        color: AppColors.textOnPrimary,
                        fontSize: 24,
                        height: 1.42,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      _pages[_page].description,
                      textAlign: TextAlign.center,
                      style: AppTextStyles.body2.copyWith(
                        color: AppColors.textOnPrimary.withOpacity(0.88),
                        height: 1.75,
                      ),
                    ),
                    const SizedBox(height: 32),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                          onPressed: _onSkip,
                          style: TextButton.styleFrom(
                            foregroundColor: AppColors.textOnPrimary
                                .withOpacity(0.85),
                            textStyle: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          child: const Text('Skip'),
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: List.generate(
                            _pages.length,
                            (index) => Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 5),
                              child: _buildDot(isActive: _page == index),
                            ),
                          ),
                        ),
                        TextButton(
                          onPressed: _onNext,
                          style: TextButton.styleFrom(
                            foregroundColor: AppColors.textOnPrimary,
                            textStyle: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          child: Text(_page == _pages.length - 1
                              ? 'Get Started'
                              : 'Next'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPage(_OnboardingPageData data) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: [
          const SizedBox(height: 24),
          Expanded(
            child: Center(
              child: SizedBox(
                width: 320,
                height: 520,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Positioned(
                      bottom: 24,
                      child: Image.asset(
                        data.shadowImage,
                        width: 300,
                        fit: BoxFit.contain,
                      ),
                    ),
                    Positioned(
                      top: 20,
                      child: Container(
                        width: 280,
                        height: 520,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(44),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.08),
                              blurRadius: 32,
                              offset: const Offset(0, 18),
                            ),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(44),
                          child: Stack(
                            fit: StackFit.expand,
                            children: [
                              Image.asset(
                                data.contentImage,
                                fit: BoxFit.cover,
                              ),
                              if (data.overlayImage != null)
                                Image.asset(
                                  data.overlayImage!,
                                  fit: BoxFit.cover,
                                ),
                              Align(
                                alignment: Alignment.topCenter,
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 24),
                                  child: Image.asset(
                                    'assets/images/onboarding_phone_shape.png',
                                    width: 280,
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildDot({required bool isActive}) {
    return Container(
      width: isActive ? 24 : 10,
      height: 10,
      decoration: BoxDecoration(
        color: isActive ? Colors.white : Colors.white54,
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}

class _OnboardingPageData {
  final String contentImage;
  final String shadowImage;
  final String title;
  final String description;
  final String? overlayImage;

  const _OnboardingPageData({
    required this.contentImage,
    required this.shadowImage,
    required this.title,
    required this.description,
    this.overlayImage,
  });
}
