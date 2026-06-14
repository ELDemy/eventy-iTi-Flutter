import 'package:events_hub/core/theme/AppIcons.dart';

class OnboardingPageData {
  final String contentImage;

  final String title;
  final String description;

  const OnboardingPageData({
    required this.contentImage,
    required this.title,
    required this.description,
  });

  static const pages = [
    OnboardingPageData(
      contentImage: AppIcons.onboarding1,
      title: 'Explore Upcoming and Nearby Events',
      description:
          'In publishing and graphic design, Lorem is a placeholder text commonly',
    ),
    OnboardingPageData(
      contentImage: AppIcons.onboarding2,
      title: 'Web Have Modern Events Calendar Feature',
      description:
          'In publishing and graphic design, Lorem is a placeholder text commonly',
    ),
    OnboardingPageData(
      contentImage: AppIcons.onboarding3,
      title: 'To Look Up More Events or Activities Nearby By Map',
      description:
          'In publishing and graphic design, Lorem is a placeholder text commonly',
    ),
  ];
}
