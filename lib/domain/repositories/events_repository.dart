import 'package:dartz/dartz.dart';
import 'package:events_hub/core/error/failures.dart';
import 'package:events_hub/domain/models/event.dart';
import 'package:events_hub/domain/models/event_category.dart';
import 'package:events_hub/domain/models/event_page.dart';

abstract class EventsRepository {
  Future<Either<Failure, EventPage>> getUpcomingEvents({
    required String city,
    required int size,
    required int page,
  });

  Future<Either<Failure, EventPage>> getNearbyEvents({
    required String latLong,
    required int radius,
    required String unit,
    required int size,
  });

  Future<Either<Failure, EventPage>> getPastEvents({
    required String city,
    required DateTime endDateTime,
    required int size,
    required int page,
  });

  Future<Either<Failure, EventPage>> searchEvents({
    required String? keyword,
    required String? city,
    required String? classificationName,
    required DateTime? startDateTime,
    required DateTime? endDateTime,
    required int size,
  });

  Future<Either<Failure, Event>> getEventDetails(String eventId);

  Future<Either<Failure, List<EventCategory>>> getCategories();
}
