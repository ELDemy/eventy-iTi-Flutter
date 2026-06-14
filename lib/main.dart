import 'package:events_hub/core/constants/app_strings.dart';
import 'package:events_hub/core/routes/app_routes.dart';
import 'package:events_hub/core/theme/app_theme.dart';
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
      routes: AppRoutes.buildRoutes,
    );
  }
}
