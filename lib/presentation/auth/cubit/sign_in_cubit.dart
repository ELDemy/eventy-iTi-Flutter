import 'package:events_hub/core/di/app_dependencies.dart';
import 'package:events_hub/domain/repositories/auth_repository.dart';
import 'package:events_hub/presentation/auth/cubit/sign_in_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignInCubit extends Cubit<SignInState> {
  SignInCubit({
    AuthRepository? authRepository,
  })  : _authRepository = authRepository ?? AppDependencies.authRepository,
        super(const SignInState()) {
    loadRememberedEmail();
  }

  final AuthRepository _authRepository;

  Future<void> loadRememberedEmail() async {
    final rememberMe = await _authRepository.getRememberMe();
    final rememberedEmail = await _authRepository.getRememberedEmail();
    emit(
      state.copyWith(
        rememberMe: rememberMe,
        rememberedEmail: rememberMe ? rememberedEmail : null,
      ),
    );
  }

  void setRememberMe(bool value) {
    emit(state.copyWith(rememberMe: value, clearError: true));
  }

  Future<void> signIn({
    required String email,
    required String password,
  }) async {
    if (email.trim().isEmpty || password.isEmpty) {
      emit(state.copyWith(errorMessage: 'Enter your email and password.'));
      return;
    }

    emit(state.copyWith(isLoading: true, clearError: true));
    try {
      await _authRepository.signIn(
        email: email.trim(),
        password: password,
        rememberMe: state.rememberMe,
      );
      emit(
        state.copyWith(
          isLoading: false,
          isAuthenticated: true,
          clearError: true,
        ),
      );
    } on FirebaseAuthException catch (error) {
      emit(
        state.copyWith(
          isLoading: false,
          errorMessage: error.message ?? 'Unable to sign in.',
        ),
      );
    } catch (_) {
      emit(
        state.copyWith(
          isLoading: false,
          errorMessage: 'Unable to sign in. Please try again.',
        ),
      );
    }
  }
}
