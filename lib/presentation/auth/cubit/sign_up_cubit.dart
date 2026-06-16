import 'package:events_hub/core/di/app_dependencies.dart';
import 'package:events_hub/domain/repositories/auth_repository.dart';
import 'package:events_hub/presentation/auth/cubit/sign_up_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit({
    AuthRepository? authRepository,
  })  : _authRepository = authRepository ?? AppDependencies.authRepository,
        super(const SignUpState());

  final AuthRepository _authRepository;

  Future<void> signUp({
    required String fullName,
    required String email,
    required String password,
    required String confirmPassword,
  }) async {
    if (fullName.trim().isEmpty ||
        email.trim().isEmpty ||
        password.isEmpty ||
        confirmPassword.isEmpty) {
      emit(state.copyWith(errorMessage: 'Fill in all fields.'));
      return;
    }

    if (password != confirmPassword) {
      emit(state.copyWith(errorMessage: 'Passwords do not match.'));
      return;
    }

    emit(state.copyWith(isLoading: true, clearError: true));
    try {
      await _authRepository.signUp(
        fullName: fullName.trim(),
        email: email.trim(),
        password: password,
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
          errorMessage: error.message ?? 'Unable to create account.',
        ),
      );
    } catch (_) {
      emit(
        state.copyWith(
          isLoading: false,
          errorMessage: 'Unable to create account. Please try again.',
        ),
      );
    }
  }
}
