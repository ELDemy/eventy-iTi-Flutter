import 'package:events_hub/domain/models/event.dart';

class EventImageModel {
  const EventImageModel({
    required this.url,
    this.ratio,
    this.width,
    this.height,
    this.fallback,
  });

  final String url;
  final String? ratio;
  final int? width;
  final int? height;
  final bool? fallback;

  factory EventImageModel.fromJson(Map<String, Object?> json) {
    return EventImageModel(
      url: json['url'] as String? ?? '',
      ratio: json['ratio'] as String?,
      width: json['width'] as int?,
      height: json['height'] as int?,
      fallback: json['fallback'] as bool?,
    );
  }

  Map<String, Object?> toJson() {
    return {
      'url': url,
      'ratio': ratio,
      'width': width,
      'height': height,
      'fallback': fallback,
    };
  }

  EventImage toEntity() {
    return EventImage(
      url: url,
      ratio: ratio,
      width: width,
      height: height,
      fallback: fallback,
    );
  }
}
