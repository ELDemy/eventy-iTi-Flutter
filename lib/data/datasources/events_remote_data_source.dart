import 'package:dio/dio.dart';
import 'package:events_hub/core/constants/api_constants.dart';
import 'package:events_hub/core/error/exceptions.dart';
import 'package:events_hub/core/network/dio_client.dart';
import 'package:events_hub/data/models/classification_model.dart';
import 'package:events_hub/data/models/event_model.dart';
import 'package:events_hub/data/models/events_page_model.dart';

abstract class EventsRemoteDataSource {
  Future<EventsPageModel> getUpcomingEvents({
    required String city,
    required int size,
    required int page,
  });

  Future<EventsPageModel> getNearbyEvents({
    required String latLong,
    required int radius,
    required String unit,
    required int size,
  });

  Future<EventsPageModel> getPastEvents({
    required String city,
    required DateTime endDateTime,
    required int size,
    required int page,
  });

  Future<EventsPageModel> searchEvents({
    required String? keyword,
    required String? city,
    required String? classificationName,
    required DateTime? startDateTime,
    required DateTime? endDateTime,
    required int size,
  });

  Future<EventModel> getEventDetails(String eventId);

  Future<List<ClassificationModel>> getCategories();
}

class EventsRemoteDataSourceImpl implements EventsRemoteDataSource {
  const EventsRemoteDataSourceImpl(this._client);

  final DioClient _client;

  Dio get _dio => _client.dio;

  @override
  Future<EventsPageModel> getUpcomingEvents({
    required String city,
    required int size,
    required int page,
  }) {
    return _getEvents({
      'city': city,
      'sort': 'date,asc',
      'size': size,
      'page': page,
    });
  }

  @override
  Future<EventsPageModel> getNearbyEvents({
    required String latLong,
    required int radius,
    required String unit,
    required int size,
  }) {
    return _getEvents({
      'latlong': latLong,
      'radius': radius,
      'unit': unit,
      'sort': 'distance,asc',
      'size': size,
    });
  }

  @override
  Future<EventsPageModel> getPastEvents({
    required String city,
    required DateTime endDateTime,
    required int size,
    required int page,
  }) {
    return _getEvents({
      'city': city,
      'endDateTime': _utcIso(endDateTime),
      'sort': 'date,desc',
      'size': size,
      'page': page,
    });
  }

  @override
  Future<EventsPageModel> searchEvents({
    required String? keyword,
    required String? city,
    required String? classificationName,
    required DateTime? startDateTime,
    required DateTime? endDateTime,
    required int size,
  }) {
    return _getEvents({
      if (keyword != null && keyword.trim().isNotEmpty)
        'keyword': keyword.trim(),
      if (city != null && city.trim().isNotEmpty) 'city': city.trim(),
      if (classificationName != null && classificationName.trim().isNotEmpty)
        'classificationName': classificationName.trim(),
      if (startDateTime != null) 'startDateTime': _utcIso(startDateTime),
      if (endDateTime != null) 'endDateTime': _utcIso(endDateTime),
      'sort': 'date,asc',
      'size': size,
    });
  }

  @override
  Future<EventModel> getEventDetails(String eventId) async {
    try {
      final response = await _dio.get<Map<String, Object?>>(
        ApiConstants.eventDetails(eventId),
      );
      final data = response.data;
      if (data == null) {
        throw const ServerException(
            message: 'Event details response was empty.');
      }
      return EventModel.fromJson(data);
    } on DioException catch (error) {
      throw _client.mapDioException(error);
    }
  }

  @override
  Future<List<ClassificationModel>> getCategories() async {
    try {
      final response = await _dio.get<Map<String, Object?>>(
        ApiConstants.classifications,
      );
      final embedded = response.data?['_embedded'];
      final classifications =
          embedded is Map<String, Object?> ? embedded['classifications'] : null;
      if (classifications is! List) return const [];

      return classifications
          .whereType<Map<String, Object?>>()
          .map(ClassificationModel.fromJson)
          .toList();
    } on DioException catch (error) {
      throw _client.mapDioException(error);
    }
  }

  Future<EventsPageModel> _getEvents(
      Map<String, Object?> queryParameters) async {
    try {
      final response = await _dio.get<Map<String, Object?>>(
        ApiConstants.events,
        queryParameters: queryParameters,
      );
      final data = response.data;
      if (data == null) {
        throw const ServerException(message: 'Events response was empty.');
      }
      return EventsPageModel.fromJson(data);
    } on DioException catch (error) {
      throw _client.mapDioException(error);
    }
  }

  String _utcIso(DateTime value) {
    return "${value.toIso8601String().split('.').first}Z";
  }
}
