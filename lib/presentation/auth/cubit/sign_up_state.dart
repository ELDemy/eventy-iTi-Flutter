import 'package:equatable/equatable.dart';

class SignUpState extends Equatable {
  const SignUpState({
    this.isLoading = false,
    this.errorMessage,
    this.isAuthenticated = false,
  });

  final bool isLoading;
  final String? errorMessage;
  final bool isAuthenticated;

  SignUpState copyWith({
    bool? isLoading,
    String? errorMessage,
    bool? isAuthenticated,
    bool clearError = false,
  }) {
    return SignUpState(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: clearError ? null : errorMessage ?? this.errorMessage,
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
    );
  }

  @override
  List<Object?> get props => [isLoading, errorMessage, isAuthenticated];
}
