import 'package:dartz/dartz.dart';
import 'package:events_hub/core/error/failures.dart';
import 'package:events_hub/domain/models/event_page.dart';
import 'package:events_hub/domain/repositories/events_repository.dart';

class GetUpcomingEvents {
  const GetUpcomingEvents(this._repository);

  final EventsRepository _repository;

  Future<Either<Failure, EventPage>> call(
      GetUpcomingEventsParams params) async {
    var result = await _repository.getUpcomingEvents(
      city: params.city,
      size: params.size,
      page: params.page,
    );

    return result.fold(
      (failure) => Left(failure),
      (eventPage) {
        final now = DateTime.now();
        final startOfToday = DateTime(now.year, now.month, now.day);

        final events = eventPage.events
            .where((event) =>
                (event.date?.isAfter(startOfToday) ?? true) ||
                (event.date?.isAtSameMomentAs(startOfToday) ?? true))
            .toList();
        eventPage = eventPage.copyWith(events: events);
        return Right(eventPage);
      },
    );
  }
}

class GetUpcomingEventsParams {
  const GetUpcomingEventsParams({
    required this.city,
    this.size = 21,
    this.page = 0,
  });

  final String city;
  final int size;
  final int page;
}
