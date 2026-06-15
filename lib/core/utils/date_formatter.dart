abstract final class DateFormatter {
  static String eventDateTime(DateTime? date, String? localTime) {
    if (date == null) return 'Date to be announced';

    final dateLabel = '${_weekday(date.weekday)}, ${_month(date.month)} ${date.day}';
    if (localTime == null || localTime.isEmpty) return dateLabel;

    final timeParts = localTime.split(':');
    final hour = int.tryParse(timeParts.first);
    final minute = timeParts.length > 1 ? int.tryParse(timeParts[1]) : null;
    if (hour == null || minute == null) return dateLabel;

    return '$dateLabel - ${_time(hour, minute)}';
  }

  static String scheduleLabel(DateTime? date, String? localTime) {
    if (date == null) return 'Date to be announced';

    final dateLabel = '${date.day} ${_month(date.month)} - ${_weekday(date.weekday)}';
    if (localTime == null || localTime.isEmpty) return dateLabel;

    final timeParts = localTime.split(':');
    final hour = int.tryParse(timeParts.first);
    final minute = timeParts.length > 1 ? int.tryParse(timeParts[1]) : null;
    if (hour == null || minute == null) return dateLabel;

    return '$dateLabel - ${_time(hour, minute)}';
  }

  static String _time(int hour, int minute) {
    final period = hour >= 12 ? 'PM' : 'AM';
    final displayHour = hour % 12 == 0 ? 12 : hour % 12;
    return '$displayHour:${minute.toString().padLeft(2, '0')} $period';
  }

  static String _weekday(int weekday) {
    const weekdays = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    return weekdays[weekday - 1];
  }

  static String _month(int month) {
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    return months[month - 1];
  }
}
