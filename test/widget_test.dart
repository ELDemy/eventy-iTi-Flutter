import 'package:flutter_test/flutter_test.dart';
import 'package:events_hub/main.dart';

void main() {
  testWidgets('App launches sign in screen', (WidgetTester tester) async {
    await tester.pumpWidget(const EventsHubApp());
    expect(find.text('Sign in'), findsOneWidget);
    expect(find.text('EventHub'), findsOneWidget);
  });
}
