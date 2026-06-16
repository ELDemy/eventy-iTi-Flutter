import 'package:equatable/equatable.dart';

class SignInState extends Equatable {
  const SignInState({
    this.rememberMe = false,
    this.rememberedEmail,
    this.isLoading = false,
    this.errorMessage,
    this.isAuthenticated = false,
  });

  final bool rememberMe;
  final String? rememberedEmail;
  final bool isLoading;
  final String? errorMessage;
  final bool isAuthenticated;

  SignInState copyWith({
    bool? rememberMe,
    String? rememberedEmail,
    bool? isLoading,
    String? errorMessage,
    bool? isAuthenticated,
    bool clearError = false,
  }) {
    return SignInState(
      rememberMe: rememberMe ?? this.rememberMe,
      rememberedEmail: rememberedEmail ?? this.rememberedEmail,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: clearError ? null : errorMessage ?? this.errorMessage,
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
    );
  }

  @override
  List<Object?> get props => [
        rememberMe,
        rememberedEmail,
        isLoading,
        errorMessage,
        isAuthenticated,
      ];
}
