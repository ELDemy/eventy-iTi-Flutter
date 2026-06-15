import 'package:dartz/dartz.dart';
import 'package:events_hub/core/error/failures.dart';
import 'package:events_hub/domain/models/event_page.dart';
import 'package:events_hub/domain/repositories/events_repository.dart';

class GetNearbyEvents {
  const GetNearbyEvents(this._repository);

  final EventsRepository _repository;

  Future<Either<Failure, EventPage>> call(GetNearbyEventsParams params) {
    return _repository.getNearbyEvents(
      latLong: params.latLong,
      radius: params.radius,
      unit: params.unit,
      size: params.size,
    );
  }
}

class GetNearbyEventsParams {
  const GetNearbyEventsParams({
    required this.latLong,
    this.radius = 20,
    this.unit = 'km',
    this.size = 10,
  });

  final String latLong;
  final int radius;
  final String unit;
  final int size;
}
