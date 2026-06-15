import 'package:dartz/dartz.dart';
import 'package:events_hub/core/error/exceptions.dart';
import 'package:events_hub/core/error/failures.dart';
import 'package:events_hub/data/datasources/events_remote_data_source.dart';
import 'package:events_hub/data/models/events_page_model.dart';
import 'package:events_hub/domain/models/event.dart';
import 'package:events_hub/domain/models/event_category.dart';
import 'package:events_hub/domain/models/event_page.dart';
import 'package:events_hub/domain/repositories/events_repository.dart';

class EventsRepositoryImpl implements EventsRepository {
  const EventsRepositoryImpl(this._remoteDataSource);

  final EventsRemoteDataSource _remoteDataSource;

  @override
  Future<Either<Failure, EventPage>> getUpcomingEvents({
    required String city,
    required int size,
    required int page,
  }) {
    return _guardPage(
      () => _remoteDataSource.getUpcomingEvents(city: city, size: size, page: page),
    );
  }

  @override
  Future<Either<Failure, EventPage>> getNearbyEvents({
    required String latLong,
    required int radius,
    required String unit,
    required int size,
  }) {
    return _guardPage(
      () => _remoteDataSource.getNearbyEvents(
        latLong: latLong,
        radius: radius,
        unit: unit,
        size: size,
      ),
    );
  }

  @override
  Future<Either<Failure, EventPage>> getPastEvents({
    required String city,
    required DateTime endDateTime,
    required int size,
    required int page,
  }) {
    return _guardPage(
      () => _remoteDataSource.getPastEvents(
        city: city,
        endDateTime: endDateTime,
        size: size,
        page: page,
      ),
    );
  }

  @override
  Future<Either<Failure, EventPage>> searchEvents({
    required String? keyword,
    required String? city,
    required String? classificationName,
    required DateTime? startDateTime,
    required DateTime? endDateTime,
    required int size,
  }) {
    return _guardPage(
      () => _remoteDataSource.searchEvents(
        keyword: keyword,
        city: city,
        classificationName: classificationName,
        startDateTime: startDateTime,
        endDateTime: endDateTime,
        size: size,
      ),
    );
  }

  @override
  Future<Either<Failure, Event>> getEventDetails(String eventId) async {
    try {
      final model = await _remoteDataSource.getEventDetails(eventId);
      return Right(model.toEntity());
    } on ServerException catch (error) {
      return Left(ServerFailure(error.message));
    }
  }

  @override
  Future<Either<Failure, List<EventCategory>>> getCategories() async {
    try {
      final models = await _remoteDataSource.getCategories();
      final categories = models
          .map((model) => model.toCategory())
          .where((category) => category != EventCategory.all)
          .toSet()
          .toList();
      return Right(categories);
    } on ServerException catch (error) {
      return Left(ServerFailure(error.message));
    }
  }

  Future<Either<Failure, EventPage>> _guardPage(
    Future<EventsPageModel> Function() request,
  ) async {
    try {
      final model = await request();
      return Right(model.toEntity());
    } on ServerException catch (error) {
      return Left(ServerFailure(error.message));
    }
  }
}
