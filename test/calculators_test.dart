import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:cosmic_compass/models/user_profile.dart';
import 'package:cosmic_compass/services/profile_service.dart';
import 'package:cosmic_compass/services/calculators/western_calculator.dart';
import 'package:cosmic_compass/services/calculators/bazi_calculator.dart';
import 'package:cosmic_compass/services/calculators/ziwei_calculator.dart';
import 'package:cosmic_compass/services/calculators/vedic_calculator.dart';
import 'package:cosmic_compass/services/calculators/nadi_calculator.dart';
import 'package:cosmic_compass/services/calculators/mayan_calculator.dart';
import 'package:cosmic_compass/services/calculators/aztec_calculator.dart';
import 'package:cosmic_compass/services/calculators/medicine_wheel_calculator.dart';
import 'package:cosmic_compass/services/calculators/celtic_tree_calculator.dart';
import 'package:cosmic_compass/services/calculators/norse_rune_calculator.dart';
import 'package:cosmic_compass/services/calculators/blood_type_calculator.dart';
import 'package:cosmic_compass/services/calculators/arabian_parts_calculator.dart';

void main() {
  group('Cross-Cultural Astrological Calculators Test Suite', () {
    final testProfile = UserProfile(
      name: 'Test Seeker',
      birthDate: DateTime(1996, 7, 18),
      birthTime: const TimeOfDay(hour: 14, minute: 30),
      bloodType: BloodType.ab,
      cityName: 'Tokyo, Japan',
    );

    test('Western Calculator identifies Cancer Sun', () {
      final chart = WesternCalculator.calculate(testProfile);
      expect(chart.signName, 'Cancer');
      expect(chart.element, 'Water');
      expect(chart.modality, 'Cardinal');
      expect(chart.rulingForce, 'Moon');
    });

    test('BaZi Calculator computes Four Pillars and Day Master', () {
      final chart = BaZiCalculator.calculate(testProfile);
      expect(chart.yearPillar.animal, isNotEmpty);
      expect(chart.yearPillar.element, isNotEmpty);
      expect(chart.dayMaster, isNotEmpty);
      expect(chart.polarity, anyOf('Yang', 'Yin'));
    });

    test('Zi Wei Calculator maps Life Palace and Major Star', () {
      final chart = ZiWeiCalculator.calculate(testProfile);
      expect(chart.signName, isNotEmpty);
      expect(chart.dominantArchetype, isNotEmpty);
      expect(chart.lifePalaceBranch, isNotEmpty);
    });

    test('Vedic Calculator calculates sidereal rashi and nakshatra', () {
      final chart = VedicCalculator.calculate(testProfile);
      expect(chart.signName, contains('Sidereal'));
      expect(chart.nakshatra, isNotEmpty);
      expect(chart.dashaLord, isNotEmpty);
      expect(chart.ayanamsaDegrees, closeTo(24.1, 0.5));
    });

    test('Nadi Calculator assigns Kaanda chapter and mantra', () {
      final chart = NadiCalculator.calculate(testProfile);
      expect(chart.signName, contains('Kaanda'));
      expect(chart.remedialMantra, isNotEmpty);
    });

    test('Mayan Calculator computes Kin and Galactic Tone accurately', () {
      final chart = MayanCalculator.calculate(testProfile);
      expect(chart.kinNumber, inInclusiveRange(1, 260));
      expect(chart.tone, inInclusiveRange(1, 13));
      expect(chart.nahualName, isNotEmpty);
    });

    test('Aztec Calculator assigns Tonalpohualli day sign', () {
      final chart = AztecCalculator.calculate(testProfile);
      expect(chart.signName, isNotEmpty);
      expect(chart.cardinalLord, isNotEmpty);
    });

    test('Medicine Wheel Calculator identifies 12 Moons Totem', () {
      final chart = MedicineWheelCalculator.calculate(testProfile);
      // July 18 is Strong Sun Moon / Woodpecker
      expect(chart.signName, contains('Woodpecker'));
      expect(chart.elementalClan, contains('Frog Clan'));
    });

    test('Celtic Tree Calculator maps sacred tree sign', () {
      final chart = CelticTreeCalculator.calculate(testProfile);
      // July 18 falls in Holly (Tinne: Jul 8 - Aug 4)
      expect(chart.signName, contains('Holly'));
      expect(chart.oghamLetter, isNotEmpty);
    });

    test('Norse Rune Calculator assigns birth rune and casts random rune', () {
      final chart = NorseRuneCalculator.calculate(testProfile);
      expect(chart.symbol, isNotEmpty);
      expect(chart.hourRuneName, isNotEmpty);

      final cast = NorseRuneCalculator.castRandomRune();
      expect(cast.name, isNotEmpty);
      expect(cast.symbol, isNotEmpty);
    });

    test('Blood Type Calculator assigns Ketsuekigata Type AB traits', () {
      final chart = BloodTypeCalculator.calculate(testProfile);
      expect(chart.signName, contains('Blood Type AB'));
      expect(chart.idealWorkplaceRole, isNotEmpty);
    });

    test('Arabian Parts Calculator determines Part of Fortune', () {
      final chart = ArabianPartsCalculator.calculate(testProfile);
      expect(chart.signName, contains('Part of Fortune'));
      expect(chart.birthPlanetaryHour, isNotEmpty);
    });

    test('ProfileService synthesizes all 12 cultural signs and harmony score', () {
      final synthesis = ProfileService.synthesize(testProfile);
      expect(synthesis.allSigns.length, 12);
      expect(synthesis.cosmicSynergyScore, inInclusiveRange(70, 100));
      expect(synthesis.cosmicArchetypeTitle, isNotEmpty);
      expect(synthesis.universalMantra, isNotEmpty);
      expect(synthesis.elementalBalance.dominantElement, isNotEmpty);
    });
  });
}
