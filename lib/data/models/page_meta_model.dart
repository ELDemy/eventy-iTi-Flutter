class PageMetaModel {
  const PageMetaModel({
    required this.size,
    required this.totalElements,
    required this.totalPages,
    required this.number,
  });

  final int size;
  final int totalElements;
  final int totalPages;
  final int number;

  factory PageMetaModel.fromJson(Map<String, Object?> json) {
    return PageMetaModel(
      size: json['size'] as int? ?? 0,
      totalElements: json['totalElements'] as int? ?? 0,
      totalPages: json['totalPages'] as int? ?? 0,
      number: json['number'] as int? ?? 0,
    );
  }

  Map<String, Object?> toJson() {
    return {
      'size': size,
      'totalElements': totalElements,
      'totalPages': totalPages,
      'number': number,
    };
  }
}
