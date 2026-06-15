import 'package:events_hub/core/di/events_dependencies.dart';
import 'package:events_hub/domain/models/event.dart';
import 'package:events_hub/domain/usecases/get_event_details.dart';
import 'package:events_hub/presentation/events/event_details/cubit/event_details_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EventDetailsCubit extends Cubit<EventDetailsState> {
  EventDetailsCubit({
    required Event initialEvent,
    GetEventDetails? getEventDetails,
  })  : _getEventDetails = getEventDetails ?? EventsDependencies.getEventDetails,
        super(EventDetailsState(event: initialEvent)) {
    load();
  }

  final GetEventDetails _getEventDetails;

  Future<void> load() async {
    emit(state.copyWith(isLoading: true, clearError: true));
    final result = await _getEventDetails(state.event.id);
    result.fold(
      (failure) => emit(
        state.copyWith(
          isLoading: false,
          errorMessage: failure.message,
        ),
      ),
      (event) => emit(
        state.copyWith(
          event: event.copyWith(isBookmarked: state.event.isBookmarked),
          isLoading: false,
          clearError: true,
        ),
      ),
    );
  }
}
