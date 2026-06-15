abstract final class ApiConstants {
  static const String baseUrl = 'https://app.ticketmaster.com/discovery/v2/';
  static const String events = 'events.json';
  static const String classifications = 'classifications.json';

  static String eventDetails(String eventId) => 'events/$eventId.json';
}
