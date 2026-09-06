import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:oha_asa_app/main.dart';
import 'package:oha_asa_app/models/user_profile.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  testWidgets('App launches and switches tabs cleanly on desktop', (WidgetTester tester) async {
    final mockProfile = UserProfile(
      name: 'Cosmic Seeker',
      birthDate: DateTime(2000, 1, 1),
      birthTime: const TimeOfDay(hour: 12, minute: 0),
      bloodType: BloodType.o,
      cityName: 'Tokyo, Japan',
    );

    SharedPreferences.setMockInitialValues({
      'user_cosmic_profile_v1': jsonEncode(mockProfile.toJson()),
    });

    tester.view.physicalSize = const Size(1920, 1080);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(() => tester.view.resetPhysicalSize());

    await tester.pumpWidget(const OhaAsaApp());
    await tester.pump(const Duration(milliseconds: 300));
    await tester.pump(const Duration(milliseconds: 300));

    // Verify bottom navigation items are present
    expect(find.text('Daily Forecast'), findsOneWidget);
    expect(find.text('My Charts'), findsOneWidget);
    expect(find.text('Comparison'), findsOneWidget);
    expect(find.text('Codex'), findsOneWidget);

    // Verify Today screen content renders
    expect(find.text('DAILY COSMIC GUIDANCE'), findsOneWidget);

    // Tap Comparison tab and verify render
    await tester.tap(find.text('Comparison'));
    await tester.pump(const Duration(milliseconds: 300));
    expect(find.text('CROSS-CULTURAL HARMONY'), findsOneWidget);

    // Tap My Charts tab and verify render
    await tester.tap(find.text('My Charts'));
    await tester.pump(const Duration(milliseconds: 300));
    expect(find.text('MY COSMIC BLUEPRINT'), findsOneWidget);

    // Tap Codex tab and verify render
    await tester.tap(find.text('Codex'));
    await tester.pump(const Duration(milliseconds: 300));
    expect(find.text('TRADITIONS CODEX & SOURCES'), findsOneWidget);
  });

  testWidgets('First-time user receives birth profile setup prompt', (WidgetTester tester) async {
    SharedPreferences.setMockInitialValues({});

    await tester.pumpWidget(const OhaAsaApp());
    await tester.pump(const Duration(milliseconds: 300));
    await tester.pump(const Duration(milliseconds: 300));

    // Verify First-time prompt is displayed
    expect(find.text('Welcome to Cosmic Compass'), findsOneWidget);
    expect(find.text('Calculate My Charts & Daily Horoscope'), findsOneWidget);
    expect(find.text('Explore Default Charts First'), findsOneWidget);

    // Tap Explore Default Charts First
    await tester.tap(find.text('Explore Default Charts First'));
    await tester.pump(const Duration(milliseconds: 300));
    expect(find.text('Welcome to Cosmic Compass'), findsNothing);
  });
}
