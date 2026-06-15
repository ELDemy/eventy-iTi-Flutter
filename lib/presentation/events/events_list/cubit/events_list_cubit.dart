import 'package:events_hub/core/di/events_dependencies.dart';
import 'package:events_hub/domain/usecases/get_past_events.dart';
import 'package:events_hub/domain/usecases/get_upcoming_events.dart';
import 'package:events_hub/presentation/events/events_list/cubit/events_list_state.dart';
import 'package:events_hub/presentation/events/events_list/widgets/events_tab_bar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EventsListCubit extends Cubit<EventsListState> {
  EventsListCubit({
    GetUpcomingEvents? getUpcomingEvents,
    GetPastEvents? getPastEvents,
  })  : _getUpcomingEvents =
            getUpcomingEvents ?? EventsDependencies.getUpcomingEvents,
        _getPastEvents = getPastEvents ?? EventsDependencies.getPastEvents,
        super(const EventsListState()) {
    loadTab(EventsTab.upcoming);
  }

  static const String _defaultCity = 'London';
  static const int _pageSize = 20;

  final GetUpcomingEvents _getUpcomingEvents;
  final GetPastEvents _getPastEvents;

  Future<void> loadTab(EventsTab tab) async {
    emit(
      state.copyWith(
        selectedTab: tab,
        events: const [],
        currentPage: 0,
        hasMore: false,
        isLoading: true,
        isLoadingMore: false,
        clearError: true,
      ),
    );
    await _loadPage(page: 0, append: false);
  }

  Future<void> retry() => loadTab(state.selectedTab);

  Future<void> loadMore() async {
    if (state.isLoading || state.isLoadingMore || !state.hasMore) return;
    emit(state.copyWith(isLoadingMore: true, clearError: true));
    await _loadPage(page: state.currentPage + 1, append: true);
  }

  Future<void> _loadPage({
    required int page,
    required bool append,
  }) async {
    final result = state.selectedTab == EventsTab.upcoming
        ? await _getUpcomingEvents(
            GetUpcomingEventsParams(
              city: _defaultCity,
              size: _pageSize,
              page: page,
            ),
          )
        : await _getPastEvents(
            GetPastEventsParams(
              city: _defaultCity,
              endDateTime: DateTime.now().toUtc(),
              size: _pageSize,
              page: page,
            ),
          );

    result.fold(
      (failure) => emit(
        state.copyWith(
          isLoading: false,
          isLoadingMore: false,
          errorMessage: failure.message,
        ),
      ),
      (eventPage) {
        final events =
            append ? [...state.events, ...eventPage.events] : eventPage.events;
        emit(
          state.copyWith(
            events: events,
            currentPage: eventPage.currentPage,
            hasMore: eventPage.hasMore,
            isLoading: false,
            isLoadingMore: false,
            clearError: true,
          ),
        );
      },
    );
  }
}
