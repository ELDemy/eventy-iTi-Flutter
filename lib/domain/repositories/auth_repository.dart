import 'package:events_hub/domain/models/app_user.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthRepository {
  Stream<User?> authStateChanges();

  User? get currentFirebaseUser;

  Future<AppUser?> getCurrentUserProfile();

  Future<AppUser> signIn({
    required String email,
    required String password,
    required bool rememberMe,
  });

  Future<AppUser> signUp({
    required String fullName,
    required String email,
    required String password,
  });

  Future<void> signOut();

  Future<bool> getRememberMe();

  Future<String?> getRememberedEmail();
}
