import 'package:events_hub/core/di/app_dependencies.dart';
import 'package:events_hub/domain/repositories/auth_repository.dart';
import 'package:events_hub/presentation/profile/cubit/profile_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit({
    AuthRepository? authRepository,
  })  : _authRepository = authRepository ?? AppDependencies.authRepository,
        super(const ProfileState()) {
    loadProfile();
  }

  final AuthRepository _authRepository;

  Future<void> loadProfile() async {
    emit(state.copyWith(isLoading: true, clearError: true));
    try {
      final user = await _authRepository.getCurrentUserProfile();
      emit(
        state.copyWith(
          user: user,
          isLoading: false,
          clearError: true,
        ),
      );
    } catch (_) {
      emit(
        state.copyWith(
          isLoading: false,
          errorMessage: 'Unable to load your profile.',
        ),
      );
    }
  }
}
