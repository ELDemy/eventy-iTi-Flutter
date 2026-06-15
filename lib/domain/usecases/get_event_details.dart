import 'package:dartz/dartz.dart';
import 'package:events_hub/core/error/failures.dart';
import 'package:events_hub/domain/models/event.dart';
import 'package:events_hub/domain/repositories/events_repository.dart';

class GetEventDetails {
  const GetEventDetails(this._repository);

  final EventsRepository _repository;

  Future<Either<Failure, Event>> call(String eventId) {
    return _repository.getEventDetails(eventId);
  }
}
