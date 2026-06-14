import 'package:events_hub/presentation/navbar/MyNavBar.dart';
import 'package:flutter/material.dart';

import 'core/constants/app_strings.dart';
import 'core/theme/app_theme.dart';

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
      home: const MyNavBar(),
    );
  }
}
