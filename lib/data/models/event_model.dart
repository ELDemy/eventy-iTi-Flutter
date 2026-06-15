import 'package:collection/collection.dart';
import 'package:events_hub/core/utils/date_formatter.dart';
import 'package:events_hub/core/utils/image_picker_util.dart';
import 'package:events_hub/data/models/attraction_model.dart';
import 'package:events_hub/data/models/classification_model.dart';
import 'package:events_hub/data/models/event_image_model.dart';
import 'package:events_hub/data/models/price_range_model.dart';
import 'package:events_hub/data/models/venue_model.dart';
import 'package:events_hub/domain/models/event.dart';
import 'package:events_hub/domain/models/event_category.dart';

class EventModel {
  const EventModel({
    required this.id,
    required this.name,
    this.url,
    this.images = const [],
    this.classifications = const [],
    this.venues = const [],
    this.attractions = const [],
    this.priceRanges = const [],
    this.localDate,
    this.localTime,
    this.dateTime,
    this.statusCode,
  });

  final String id;
  final String name;
  final String? url;
  final List<EventImageModel> images;
  final List<ClassificationModel> classifications;
  final List<VenueModel> venues;
  final List<AttractionModel> attractions;
  final List<PriceRangeModel> priceRanges;
  final String? localDate;
  final String? localTime;
  final DateTime? dateTime;
  final String? statusCode;

  factory EventModel.fromJson(Map<String, Object?> json) {
    final dates = json['dates'];
    final start = dates is Map<String, Object?> ? dates['start'] : null;
    final status = dates is Map<String, Object?> ? dates['status'] : null;
    final embedded = json['_embedded'];

    return EventModel(
      id: json['id'] as String? ?? '',
      name: json['name'] as String? ?? 'Untitled event',
      url: json['url'] as String?,
      images: _models(json['images'], EventImageModel.fromJson),
      classifications: _models(json['classifications'], ClassificationModel.fromJson),
      venues: embedded is Map<String, Object?> ? _models(embedded['venues'], VenueModel.fromJson) : const [],
      attractions: embedded is Map<String, Object?> ? _models(embedded['attractions'], AttractionModel.fromJson) : const [],
      priceRanges: _models(json['priceRanges'], PriceRangeModel.fromJson),
      localDate: start is Map<String, Object?> ? start['localDate'] as String? : null,
      localTime: start is Map<String, Object?> ? start['localTime'] as String? : null,
      dateTime: start is Map<String, Object?> ? DateTime.tryParse(start['dateTime'] as String? ?? '') : null,
      statusCode: status is Map<String, Object?> ? status['code'] as String? : null,
    );
  }

  Map<String, Object?> toJson() {
    return {
      'id': id,
      'name': name,
      'url': url,
      'images': images.map((image) => image.toJson()).toList(),
      'classifications': classifications.map((classification) => classification.toJson()).toList(),
      'priceRanges': priceRanges.map((priceRange) => priceRange.toJson()).toList(),
      'dates': {
        'start': {
          'localDate': localDate,
          'localTime': localTime,
          'dateTime': dateTime?.toIso8601String(),
        },
        'status': {'code': statusCode},
      },
      '_embedded': {
        'venues': venues.map((venue) => venue.toJson()).toList(),
        'attractions': attractions.map((attraction) => attraction.toJson()).toList(),
      },
    };
  }

  Event toEntity() {
    final eventImages = images.map((image) => image.toEntity()).toList();
    final parsedLocalDate = DateTime.tryParse(localDate ?? '') ?? dateTime;
    final classification = classifications.firstOrNull;
    final venue = venues.firstOrNull;
    final attraction = attractions.firstOrNull;
    final price = priceRanges.firstOrNull?.displayPrice;

    return Event(
      id: id,
      title: name,
      dateTime: DateFormatter.eventDateTime(parsedLocalDate, localTime),
      location: venue?.displayLocation ?? 'Location to be announced',
      imageUrl: getBestImage(eventImages),
      category: classification?.toCategory() ?? EventCategory.all,
      scheduleLabel: DateFormatter.scheduleLabel(parsedLocalDate, localTime),
      date: parsedLocalDate,
      localTime: localTime,
      price: price,
      ticketUrl: url,
      statusCode: statusCode,
      statusLabel: _statusLabel(statusCode),
      venueName: venue?.name,
      organizerName: attraction?.name,
      about: _about(classification, venue),
      images: eventImages,
    );
  }

  static String _statusLabel(String? code) {
    return switch (code) {
      'onsale' => 'On Sale',
      'offsale' => 'Off Sale',
      'cancelled' => 'Cancelled',
      'postponed' => 'Postponed',
      'rescheduled' => 'Rescheduled',
      _ => 'Unavailable',
    };
  }

  String _about(ClassificationModel? classification, VenueModel? venue) {
    final category = classification?.segmentName ?? 'Event';
    final genre = classification?.genreName;
    final place = venue?.displayLocation;
    final parts = [
      if (genre != null && genre.isNotEmpty) '$category • $genre' else category,
      if (place != null && place.isNotEmpty) place,
    ];
    return parts.join('\n');
  }

  static List<T> _models<T>(
    Object? value,
    T Function(Map<String, Object?> json) fromJson,
  ) {
    if (value is! List) return const [];
    return value.whereType<Map<String, Object?>>().map(fromJson).toList();
  }
}
