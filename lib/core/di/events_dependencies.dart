import 'package:events_hub/core/network/dio_client.dart';
import 'package:events_hub/data/datasources/events_remote_data_source.dart';
import 'package:events_hub/data/repositories/events_repository_impl.dart';
import 'package:events_hub/domain/repositories/events_repository.dart';
import 'package:events_hub/domain/usecases/get_categories.dart';
import 'package:events_hub/domain/usecases/get_event_details.dart';
import 'package:events_hub/domain/usecases/get_nearby_events.dart';
import 'package:events_hub/domain/usecases/get_past_events.dart';
import 'package:events_hub/domain/usecases/get_upcoming_events.dart';
import 'package:events_hub/domain/usecases/search_events.dart';

abstract final class EventsDependencies {
  static final DioClient _dioClient = DioClient();
  static final EventsRemoteDataSource _remoteDataSource =
      EventsRemoteDataSourceImpl(_dioClient);
  static final EventsRepository repository =
      EventsRepositoryImpl(_remoteDataSource);

  static GetUpcomingEvents get getUpcomingEvents =>
      GetUpcomingEvents(repository);

  static GetNearbyEvents get getNearbyEvents => GetNearbyEvents(repository);

  static GetPastEvents get getPastEvents => GetPastEvents(repository);

  static SearchEvents get searchEvents => SearchEvents(repository);

  static GetEventDetails get getEventDetails => GetEventDetails(repository);

  static GetCategories get getCategories => GetCategories(repository);
}
