class Event {
  const Event({
    required this.id,
    required this.title,
    required this.dateTime,
    required this.location,
    required this.imageAsset,
    this.isBookmarked = false,
  });

  final String id;
  final String title;
  final String dateTime;
  final String location;
  final String imageAsset;
  final bool isBookmarked;

  Event copyWith({
    String? id,
    String? title,
    String? dateTime,
    String? location,
    String? imageAsset,
    bool? isBookmarked,
  }) {
    return Event(
      id: id ?? this.id,
      title: title ?? this.title,
      dateTime: dateTime ?? this.dateTime,
      location: location ?? this.location,
      imageAsset: imageAsset ?? this.imageAsset,
      isBookmarked: isBookmarked ?? this.isBookmarked,
    );
  }
}
