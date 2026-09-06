import 'package:flutter/material.dart';
import '../../models/cultural_profiles.dart';
import '../../models/user_profile.dart';

class ArabianPartsCalculator {
  static const List<String> planetaryHours = [
    'Hour of the Sun (Solar Authority & Vitality)',
    'Hour of Venus (Love, Arts & Social Grace)',
    'Hour of Mercury (Commerce, Writing & Speech)',
    'Hour of the Moon (Intuition, Home & Flow)',
    'Hour of Saturn (Structure, Discipline & Study)',
    'Hour of Jupiter (Expansion, Wisdom & Abundance)',
    'Hour of Mars (Courage, Initiative & Action)',
  ];

  static const List<String> zodiacSigns = [
    'Aries', 'Taurus', 'Gemini', 'Cancer', 'Leo', 'Virgo',
    'Libra', 'Scorpio', 'Sagittarius', 'Capricorn', 'Aquarius', 'Pisces'
  ];

  static ArabianChart calculate(UserProfile profile) {
    final date = profile.birthDate;
    final hour = profile.birthTime.hour;

    // Chaldean planetary hours
    // Day rulers: Sun (Sunday), Moon (Monday), Mars (Tuesday), Mercury (Wednesday), Jupiter (Thursday), Venus (Friday), Saturn (Saturday)
    final dayOfWeekRulerOffset = (date.weekday % 7);
    final planetaryHourIndex = (dayOfWeekRulerOffset + hour) % 7;
    final planetaryHour = planetaryHours[planetaryHourIndex];

    // Part of Fortune = Ascendant + Moon - Sun (Day chart) or Ascendant + Sun - Moon (Night chart)
    final isDayChart = hour >= 6 && hour < 18;
    final dayOfYear = date.difference(DateTime(date.year, 1, 1)).inDays;
    final approxSunDeg = (dayOfYear * (360.0 / 365.25)) % 360;
    final approxMoonDeg = (approxSunDeg + (date.day * 13.2)) % 360;
    final approxAscDeg = (approxSunDeg + ((hour - 6 + 24) % 24) * 15.0) % 360;

    double pofDegree;
    if (isDayChart) {
      pofDegree = (approxAscDeg + approxMoonDeg - approxSunDeg + 360) % 360;
    } else {
      pofDegree = (approxAscDeg + approxSunDeg - approxMoonDeg + 360) % 360;
    }

    final signIndex = (pofDegree / 30.0).floor() % 12;
    final degInSign = (pofDegree % 30).toStringAsFixed(1);
    final signName = zodiacSigns[signIndex];

    final auspiciousHours = isDayChart
        ? 'Morning peak: 09:00 - 11:30 (Solar/Jupiter radiance)'
        : 'Evening peak: 19:30 - 21:45 (Lunar/Venusian resonance)';

    return ArabianChart(
      signName: 'Part of Fortune in $signName ($degInSign°)',
      symbol: '⊕',
      element: _getSignElement(signName),
      rulingForce: planetaryHour,
      essence: 'The Lot of Fortune marks the physical vessel of worldly prosperity and serendipitous karma.',
      destinyAdvice: 'Cultivate wealth and self-realization through the natural gifts of $signName. Best timing: $auspiciousHours.',
      accentColor: const Color(0xFFF39C12), // Arabian Gold
      birthPlanetaryHour: planetaryHour,
      lotOfFortuneDegree: '$signName $degInSign°',
      auspiciousWindow: auspiciousHours,
    );
  }

  static String _getSignElement(String sign) {
    if (['Aries', 'Leo', 'Sagittarius'].contains(sign)) return 'Fire';
    if (['Taurus', 'Virgo', 'Capricorn'].contains(sign)) return 'Earth';
    if (['Gemini', 'Libra', 'Aquarius'].contains(sign)) return 'Air';
    return 'Water';
  }
}
