import 'package:events_hub/core/constants/app_strings.dart';
import 'package:events_hub/core/routes/app_routes.dart';
import 'package:events_hub/core/theme/app_theme.dart';
import 'package:events_hub/presentation/auth/sign_in/sign_in_screen.dart';
import 'package:events_hub/presentation/auth/sign_up/sign_up_screen.dart';
import 'package:events_hub/presentation/events/event_details/event_details_screen.dart';
import 'package:events_hub/presentation/events/events_list/events_list_screen.dart';
import 'package:events_hub/presentation/home/home_screen.dart';
import 'package:events_hub/presentation/onboarding/onboarding_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const EventsHubApp());
}

class EventsHubApp extends StatelessWidget {
  const EventsHubApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppStrings.appName,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      initialRoute: AppRoutes.onboarding,
      routes: {
        AppRoutes.onboarding: (_) => const OnboardingScreen(),
        AppRoutes.signIn: (_) => const SignInScreen(),
        AppRoutes.signUp: (_) => const SignUpScreen(),
        AppRoutes.home: (_) => const HomeScreen(),
        AppRoutes.eventsList: (_) => const EventsListScreen(),
        AppRoutes.eventDetails: (_) => const EventDetailsScreen(),
      },
    );
  }
}
