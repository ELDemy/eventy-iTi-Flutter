import 'package:events_hub/core/di/app_dependencies.dart';
import 'package:events_hub/presentation/onboarding/onboarding_screen.dart';
import 'package:events_hub/presentation/auth/sign_in/sign_in_screen.dart';
import 'package:events_hub/presentation/favorites/cubit/favorites_cubit.dart';
import 'package:events_hub/presentation/navbar/MyNavBar.dart';
import 'package:events_hub/presentation/profile/cubit/profile_cubit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<_AuthGateStartup>(
      future: _startup(),
      builder: (context, startupSnapshot) {
        if (!startupSnapshot.hasData) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (!startupSnapshot.data!.hasSeenOnboarding) {
          return const OnboardingScreen();
        }

        return StreamBuilder<User?>(
          initialData: AppDependencies.authRepository.currentFirebaseUser,
          stream: AppDependencies.authRepository.authStateChanges(),
          builder: (context, snapshot) {
            final user = snapshot.data;
            if (user == null) return const SignInScreen();

            return MultiBlocProvider(
              providers: [
                BlocProvider(create: (_) => ProfileCubit()),
                BlocProvider(create: (_) => FavoritesCubit()),
              ],
              child: const MyNavBar(),
            );
          },
        );
      },
    );
  }

  Future<_AuthGateStartup> _startup() async {
    final repository = AppDependencies.authRepository;
    final hasSeenOnboarding = await repository.hasSeenOnboarding();
    final sessionOnlyLogin = await repository.getSessionOnlyLogin();
    if (repository.currentFirebaseUser != null && sessionOnlyLogin) {
      await repository.signOut();
    }
    return _AuthGateStartup(hasSeenOnboarding: hasSeenOnboarding);
  }
}

class _AuthGateStartup {
  const _AuthGateStartup({required this.hasSeenOnboarding});

  final bool hasSeenOnboarding;
}
