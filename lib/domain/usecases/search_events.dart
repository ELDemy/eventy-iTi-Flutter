import 'package:dartz/dartz.dart';
import 'package:events_hub/core/error/failures.dart';
import 'package:events_hub/domain/models/event_page.dart';
import 'package:events_hub/domain/repositories/events_repository.dart';

class SearchEvents {
  const SearchEvents(this._repository);

  final EventsRepository _repository;

  Future<Either<Failure, EventPage>> call(SearchEventsParams params) {
    return _repository.searchEvents(
      keyword: params.keyword,
      city: params.city,
      classificationName: params.classificationName,
      startDateTime: params.startDateTime,
      endDateTime: params.endDateTime,
      size: params.size,
    );
  }
}

class SearchEventsParams {
  const SearchEventsParams({
    this.keyword,
    this.city,
    this.classificationName,
    this.startDateTime,
    this.endDateTime,
    this.size = 20,
  });

  final String? keyword;
  final String? city;
  final String? classificationName;
  final DateTime? startDateTime;
  final DateTime? endDateTime;
  final int size;
}
