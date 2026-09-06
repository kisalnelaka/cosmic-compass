import 'package:flutter_test/flutter_test.dart';
import 'package:oha_asa_app/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  testWidgets('App launches with bottom navigation bar smoke test', (WidgetTester tester) async {
    SharedPreferences.setMockInitialValues({});

    await tester.pumpWidget(const OhaAsaApp());
    await tester.pump(const Duration(milliseconds: 300));
    await tester.pump(const Duration(milliseconds: 300));

    // Verify bottom navigation items are present
    expect(find.text('Daily Forecast'), findsOneWidget);
    expect(find.text('My Charts'), findsOneWidget);
    expect(find.text('Comparison'), findsOneWidget);
    expect(find.text('Codex'), findsOneWidget);
  });
}
