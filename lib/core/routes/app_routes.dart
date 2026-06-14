import 'package:events_hub/domain/models/event.dart';
import 'package:events_hub/presentation/auth/sign_up/sign_up_screen.dart';
import 'package:events_hub/presentation/events/event_details/event_details_screen.dart';
import 'package:events_hub/presentation/events/events_list/events_list_screen.dart';
import 'package:events_hub/presentation/events/events_list/search_events/search_events_screen.dart';
import 'package:events_hub/presentation/home/home_screen.dart';
import 'package:flutter/material.dart';

import '../../presentation/auth/sign_in/sign_in_screen.dart';

abstract final class AppNavigator {
  static Future<void> goToSignIn(BuildContext context) {
    return Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => const SignInScreen(),
      ),
    );
  }

  static Future<void> goToSignUp(BuildContext context) {
    return Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const SignUpScreen(),
      ),
    );
  }

  static Future<void> goToHome(BuildContext context) {
    return Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const HomeScreen(),
      ),
    );
  }

  static Future<void> goToEventsList(BuildContext context) {
    return Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const EventsListScreen(),
      ),
    );
  }

  static Future<void> goToEventDetails(
    BuildContext context,
    Event event,
  ) {
    return Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => EventDetailsScreen(
          event: event,
        ),
      ),
    );
  }

  static Future<void> goToSearchEvents(BuildContext context) {
    return Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const SearchEventsScreen(),
      ),
    );
  }

  static void goBack(BuildContext context, [dynamic result]) {
    Navigator.pop(context, result);
  }
}
