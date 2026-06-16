import 'package:events_hub/data/datasources/auth_local_data_source.dart';
import 'package:events_hub/data/datasources/auth_remote_data_source.dart';
import 'package:events_hub/domain/models/app_user.dart';
import 'package:events_hub/domain/repositories/auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthRepositoryImpl implements AuthRepository {
  const AuthRepositoryImpl({
    required AuthRemoteDataSource remoteDataSource,
    required AuthLocalDataSource localDataSource,
  })  : _remoteDataSource = remoteDataSource,
        _localDataSource = localDataSource;

  final AuthRemoteDataSource _remoteDataSource;
  final AuthLocalDataSource _localDataSource;

  @override
  Stream<User?> authStateChanges() => _remoteDataSource.authStateChanges();

  @override
  User? get currentFirebaseUser => _remoteDataSource.currentFirebaseUser;

  @override
  Future<AppUser?> getCurrentUserProfile() async {
    return (await _remoteDataSource.getCurrentUserProfile())?.toEntity();
  }

  @override
  Future<AppUser> signIn({
    required String email,
    required String password,
    required bool rememberMe,
  }) async {
    final user = await _remoteDataSource.signIn(
      email: email,
      password: password,
    );
    if (rememberMe) {
      await _localDataSource.saveRememberedEmail(email);
    } else {
      await _localDataSource.clearRememberedEmail();
      await _localDataSource.setSessionOnlyLogin(true);
    }
    return user.toEntity();
  }

  @override
  Future<AppUser> signUp({
    required String fullName,
    required String email,
    required String password,
  }) async {
    return (await _remoteDataSource.signUp(
      fullName: fullName,
      email: email,
      password: password,
    ))
        .toEntity();
  }

  @override
  Future<void> signOut() async {
    await _localDataSource.setSessionOnlyLogin(false);
    await _remoteDataSource.signOut();
  }

  @override
  Future<bool> getRememberMe() => _localDataSource.getRememberMe();

  @override
  Future<String?> getRememberedEmail() => _localDataSource.getRememberedEmail();

  @override
  Future<bool> getSessionOnlyLogin() =>
      _localDataSource.getSessionOnlyLogin();

  @override
  Future<void> clearSessionOnlyLogin() =>
      _localDataSource.setSessionOnlyLogin(false);

  @override
  Future<bool> hasSeenOnboarding() => _localDataSource.hasSeenOnboarding();

  @override
  Future<void> markOnboardingSeen() => _localDataSource.markOnboardingSeen();
}
