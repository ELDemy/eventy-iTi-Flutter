import 'package:events_hub/domain/models/event_category.dart';

class ClassificationModel {
  const ClassificationModel({
    this.segmentName,
    this.genreName,
  });

  final String? segmentName;
  final String? genreName;

  factory ClassificationModel.fromJson(Map<String, Object?> json) {
    final segment = json['segment'];
    final genre = json['genre'];
    return ClassificationModel(
      segmentName: segment is Map<String, Object?> ? segment['name'] as String? : null,
      genreName: genre is Map<String, Object?> ? genre['name'] as String? : null,
    );
  }

  Map<String, Object?> toJson() {
    return {
      'segment': {'name': segmentName},
      'genre': {'name': genreName},
    };
  }

  EventCategory toCategory() {
    return switch (segmentName?.toLowerCase()) {
      'sports' => EventCategory.sports,
      'music' => EventCategory.music,
      'arts & theatre' => EventCategory.art,
      'film' => EventCategory.art,
      _ => EventCategory.all,
    };
  }
}
