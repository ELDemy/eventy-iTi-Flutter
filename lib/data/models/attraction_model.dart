class AttractionModel {
  const AttractionModel({
    this.name,
    this.url,
  });

  final String? name;
  final String? url;

  factory AttractionModel.fromJson(Map<String, Object?> json) {
    return AttractionModel(
      name: json['name'] as String?,
      url: json['url'] as String?,
    );
  }

  Map<String, Object?> toJson() {
    return {
      'name': name,
      'url': url,
    };
  }
}
