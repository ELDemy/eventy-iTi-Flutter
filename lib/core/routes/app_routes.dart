import 'package:events_hub/presentation/auth/sign_up/sign_up_screen.dart';
import 'package:events_hub/presentation/events/event_details/event_details_screen.dart';
import 'package:events_hub/presentation/events/events_list/events_list_screen.dart';
import 'package:events_hub/presentation/home/home_screen.dart';
import 'package:events_hub/presentation/onboarding/onboarding_screen.dart';

import '../../presentation/auth/sign_in/sign_in_screen.dart';

abstract final class AppRoutes {
  static const String signIn = '/sign-in';
  static const String signUp = '/sign-up';
  static const String home = '/home';
  static const String eventsList = '/events';
  static const String eventDetails = '/event-details';
  static const String onboarding = '/onboarding';

  static final buildRoutes = {
    AppRoutes.onboarding: (_) => const OnboardingScreen(),
    AppRoutes.signIn: (_) => const SignInScreen(),
    AppRoutes.signUp: (_) => const SignUpScreen(),
    AppRoutes.home: (_) => const HomeScreen(),
    AppRoutes.eventsList: (_) => const EventsListScreen(),
    AppRoutes.eventDetails: (_) => const EventDetailsScreen(),
  };
}
