import 'package:flutter_test/flutter_test.dart';
import 'package:events_hub/main.dart';

void main() {
  testWidgets('App launches successfully', (WidgetTester tester) async {
    await tester.pumpWidget(const EventsHubApp());
    expect(find.byType(EventsHubApp), findsOneWidget);
  });
}
