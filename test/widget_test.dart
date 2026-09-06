import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:oha_asa_app/main.dart';
import 'package:oha_asa_app/models/user_profile.dart';
import 'package:oha_asa_app/services/partner_synastry_service.dart';
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
    expect(find.text('DAILY FIELD NOTES'), findsOneWidget);

    // Tap Comparison tab and verify render
    await tester.tap(find.text('Comparison'));
    await tester.pump(const Duration(milliseconds: 300));
    expect(find.text('CROSS-CULTURAL HARMONY'), findsOneWidget);

    // Tap My Charts tab and verify render
    await tester.tap(find.text('My Charts'));
    await tester.pump(const Duration(milliseconds: 300));
    expect(find.text('MY COSMIC FIELD DOSSIER'), findsOneWidget);

    // Tap Codex tab and verify render
    await tester.tap(find.text('Codex'));
    await tester.pump(const Duration(milliseconds: 300));
    expect(find.text('The World Traditions Codex'), findsOneWidget);
  });

  testWidgets('First-time user receives birth profile setup prompt', (WidgetTester tester) async {
    SharedPreferences.setMockInitialValues({});

    await tester.pumpWidget(const OhaAsaApp());
    await tester.pump(const Duration(milliseconds: 300));
    await tester.pump(const Duration(milliseconds: 300));

    // Verify First-time prompt is displayed
    expect(find.text('Welcome to Your Cosmic Field Guide'), findsOneWidget);
    expect(find.text('Calculate My Charts & Daily Horoscope'), findsOneWidget);
    expect(find.text('Explore Default Charts First'), findsOneWidget);

    // Tap Explore Default Charts First
    await tester.tap(find.text('Explore Default Charts First'));
    await tester.pump(const Duration(milliseconds: 300));
    expect(find.text('Welcome to Your Cosmic Field Guide'), findsNothing);
  });

  test('PartnerSynastryService calculates accurate multi-cultural synastry', () {
    final user = UserProfile(
      name: 'User A',
      birthDate: DateTime(1996, 7, 10), // Cancer / Rat / Water
      birthTime: const TimeOfDay(hour: 8, minute: 30),
      bloodType: BloodType.a,
      cityName: 'Tokyo, Japan',
    );

    final partner = UserProfile(
      name: 'User B',
      birthDate: DateTime(1998, 11, 22), // Sagittarius/Scorpio / Tiger
      birthTime: const TimeOfDay(hour: 14, minute: 15),
      bloodType: BloodType.o,
      cityName: 'Kyoto, Japan',
    );

    final result = PartnerSynastryService.calculateSynastry(user, partner);

    expect(result.overallScore, greaterThanOrEqualTo(68));
    expect(result.overallScore, lessThanOrEqualTo(98));
    expect(result.relationshipArchetype.isNotEmpty, true);
    expect(result.executiveSummary.contains('User A'), true);
    expect(result.executiveSummary.contains('User B'), true);

    // 5 Cultural Traditions Evaluated
    expect(result.traditionBreakdowns.length, 5);
    final traditionNames = result.traditionBreakdowns.map((t) => t.traditionName).toList();
    expect(traditionNames.contains('Western Tropical Zodiac'), true);
    expect(traditionNames.contains('Chinese BaZi & Earthly Branches'), true);
    expect(traditionNames.contains('Japanese Blood Type (Ketsuekigata)'), true);
    expect(traditionNames.contains('Vedic Jyotish & Nakshatra'), true);
    expect(traditionNames.contains('Mayan Tzolk\'in Sacred Kin'), true);

    // 3 Guidance Domains
    expect(result.domainAdvice.length, 3);
  });

  testWidgets('Partner Synergy tab shows invitation and allows adding partner', (WidgetTester tester) async {
    final mockUser = UserProfile(
      name: 'Elena',
      birthDate: DateTime(1995, 3, 21),
      birthTime: const TimeOfDay(hour: 9, minute: 0),
      bloodType: BloodType.o,
      cityName: 'Tokyo, Japan',
    );

    SharedPreferences.setMockInitialValues({
      'user_cosmic_profile_v1': jsonEncode(mockUser.toJson()),
    });

    tester.view.physicalSize = const Size(1920, 1080);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(() => tester.view.resetPhysicalSize());

    await tester.pumpWidget(const OhaAsaApp());
    await tester.pump(const Duration(milliseconds: 300));
    await tester.pump(const Duration(milliseconds: 300));

    // Navigate to Comparison
    await tester.tap(find.text('Comparison'));
    await tester.pump(const Duration(milliseconds: 300));

    // Switch to Partner Synergy Tab
    expect(find.text('Partner Synergy'), findsOneWidget);
    await tester.tap(find.text('Partner Synergy'));
    await tester.pump(const Duration(milliseconds: 300));

    // Verify empty state invitation card is rendered
    expect(find.text('Cross-Cultural Partner Synergy'), findsOneWidget);
    expect(find.text('Add Partner Details'), findsOneWidget);

    // Tap Add Partner Details
    await tester.tap(find.text('Add Partner Details'));
    await tester.pump(const Duration(milliseconds: 300));

    // Verify Partner Setup Dialog opened
    expect(find.text('PARTNER\'S NAME'), findsOneWidget);
    expect(find.text('Calculate Synergy'), findsOneWidget);

    // Submit dialog
    await tester.tap(find.text('Calculate Synergy'));
    await tester.pump(const Duration(milliseconds: 300));
    await tester.pump(const Duration(milliseconds: 300));

    // Verify synastry calculation is rendered on screen
    expect(find.text('OVERALL COSMIC SYNERGY'), findsOneWidget);
    expect(find.text('Multi-Cultural Synastry Analysis'), findsOneWidget);
    expect(find.text('Western Tropical Zodiac'), findsOneWidget);
  });
}
