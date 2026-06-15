class ServerException implements Exception {
  const ServerException({
    required this.message,
    this.statusCode,
  });

  final String message;
  final int? statusCode;

  @override
  String toString() {
    final code = statusCode == null ? '' : ' ($statusCode)';
    return 'ServerException$code: $message';
  }
}
