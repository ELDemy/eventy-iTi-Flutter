class PriceRangeModel {
  const PriceRangeModel({
    this.min,
    this.max,
    this.currency,
  });

  final double? min;
  final double? max;
  final String? currency;

  factory PriceRangeModel.fromJson(Map<String, Object?> json) {
    return PriceRangeModel(
      min: _number(json['min']),
      max: _number(json['max']),
      currency: json['currency'] as String?,
    );
  }

  Map<String, Object?> toJson() {
    return {
      'min': min,
      'max': max,
      'currency': currency,
    };
  }

  int? get displayPrice {
    final value = min ?? max;
    return value?.round();
  }

  static double? _number(Object? value) {
    if (value is num) return value.toDouble();
    return null;
  }
}
