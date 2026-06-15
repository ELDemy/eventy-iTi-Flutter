import 'package:dartz/dartz.dart';
import 'package:events_hub/core/error/failures.dart';
import 'package:events_hub/domain/models/event_page.dart';
import 'package:events_hub/domain/repositories/events_repository.dart';

class GetUpcomingEvents {
  const GetUpcomingEvents(this._repository);

  final EventsRepository _repository;

  Future<Either<Failure, EventPage>> call(GetUpcomingEventsParams params) {
    return _repository.getUpcomingEvents(
      city: params.city,
      size: params.size,
      page: params.page,
    );
  }
}

class GetUpcomingEventsParams {
  const GetUpcomingEventsParams({
    required this.city,
    this.size = 20,
    this.page = 0,
  });

  final String city;
  final int size;
  final int page;
}
