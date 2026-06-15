import 'package:dartz/dartz.dart';
import 'package:events_hub/core/error/failures.dart';
import 'package:events_hub/domain/models/event_category.dart';
import 'package:events_hub/domain/repositories/events_repository.dart';

class GetCategories {
  const GetCategories(this._repository);

  final EventsRepository _repository;

  Future<Either<Failure, List<EventCategory>>> call() {
    return _repository.getCategories();
  }
}
