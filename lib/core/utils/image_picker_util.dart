import 'package:collection/collection.dart';
import 'package:events_hub/domain/models/event.dart';

String? getBestImage(List<EventImage> images, {String ratio = '16_9'}) {
  final filtered = images.where((image) => image.ratio == ratio).toList()
    ..sort((a, b) => (b.width ?? 0).compareTo(a.width ?? 0));

  return filtered.firstOrNull?.url ?? images.firstOrNull?.url;
}
