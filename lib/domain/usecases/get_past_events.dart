import 'package:dartz/dartz.dart';
import 'package:events_hub/core/error/failures.dart';
import 'package:events_hub/domain/models/event_page.dart';
import 'package:events_hub/domain/repositories/events_repository.dart';

class GetPastEvents {
  const GetPastEvents(this._repository);

  final EventsRepository _repository;

  Future<Either<Failure, EventPage>> call(GetPastEventsParams params) {
    return _repository.getPastEvents(
      city: params.city,
      endDateTime: params.endDateTime,
      size: params.size,
      page: params.page,
    );
  }
}

class GetPastEventsParams {
  const GetPastEventsParams({
    required this.city,
    required this.endDateTime,
    this.size = 20,
    this.page = 0,
  });

  final String city;
  final DateTime endDateTime;
  final int size;
  final int page;
}
