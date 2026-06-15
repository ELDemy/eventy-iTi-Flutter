class VenueModel {
  const VenueModel({
    this.name,
    this.city,
    this.country,
    this.address,
    this.latitude,
    this.longitude,
  });

  final String? name;
  final String? city;
  final String? country;
  final String? address;
  final String? latitude;
  final String? longitude;

  factory VenueModel.fromJson(Map<String, Object?> json) {
    final city = json['city'];
    final country = json['country'];
    final address = json['address'];
    final location = json['location'];

    return VenueModel(
      name: json['name'] as String?,
      city: city is Map<String, Object?> ? city['name'] as String? : null,
      country: country is Map<String, Object?> ? country['name'] as String? : null,
      address: address is Map<String, Object?> ? address['line1'] as String? : null,
      latitude: location is Map<String, Object?> ? location['latitude'] as String? : null,
      longitude: location is Map<String, Object?> ? location['longitude'] as String? : null,
    );
  }

  Map<String, Object?> toJson() {
    return {
      'name': name,
      'city': {'name': city},
      'country': {'name': country},
      'address': {'line1': address},
      'location': {
        'latitude': latitude,
        'longitude': longitude,
      },
    };
  }

  String get displayLocation {
    final parts = [name, city, country].whereType<String>().where((value) => value.isNotEmpty);
    return parts.isEmpty ? 'Location to be announced' : parts.join(' • ');
  }
}
