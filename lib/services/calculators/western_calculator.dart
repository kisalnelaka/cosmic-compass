import 'package:flutter/material.dart';
import '../../models/cultural_profiles.dart';
import '../../models/user_profile.dart';

class WesternCalculator {
  static WesternChart calculate(UserProfile profile) {
    final date = profile.birthDate;
    final time = profile.birthTime;

    final sunSignData = _getSunSignData(date.month, date.day);
    final moonSign = _approximateMoonSign(date);
    final ascendantSign = _approximateAscendant(date.month, date.day, time.hour);

    return WesternChart(
      signName: sunSignData['name'] as String,
      symbol: sunSignData['symbol'] as String,
      element: sunSignData['element'] as String,
      rulingForce: sunSignData['ruler'] as String,
      essence: sunSignData['essence'] as String,
      destinyAdvice: sunSignData['advice'] as String,
      accentColor: sunSignData['color'] as Color,
      moonSign: moonSign,
      ascendantSign: ascendantSign,
      modality: sunSignData['modality'] as String,
      houseOfSun: ((time.hour + 6) % 12) + 1,
    );
  }

  static Map<String, dynamic> _getSunSignData(int month, int day) {
    if ((month == 3 && day >= 21) || (month == 4 && day <= 19)) {
      return {
        'name': 'Aries',
        'symbol': '♈',
        'element': 'Fire',
        'modality': 'Cardinal',
        'ruler': 'Mars',
        'essence': 'Pioneering initiator, courageous catalyst, direct assertiveness.',
        'advice': 'Channel passionate impulse into disciplined execution.',
        'color': const Color(0xFFFF416C),
      };
    } else if ((month == 4 && day >= 20) || (month == 5 && day <= 20)) {
      return {
        'name': 'Taurus',
        'symbol': '♉',
        'element': 'Earth',
        'modality': 'Fixed',
        'ruler': 'Venus',
        'essence': 'Unyielding anchor, sensual builder, patient devotion to value.',
        'advice': 'Embrace adaptive change without sacrificing steadfast roots.',
        'color': const Color(0xFF00B09B),
      };
    } else if ((month == 5 && day >= 21) || (month == 6 && day <= 20)) {
      return {
        'name': 'Gemini',
        'symbol': '♊',
        'element': 'Air',
        'modality': 'Mutable',
        'ruler': 'Mercury',
        'essence': 'Inquisitive synthesist, articulate bridge, versatile polymath.',
        'advice': 'Synthesize fragmented curiosities into singular mastery.',
        'color': const Color(0xFFFFD200),
      };
    } else if ((month == 6 && day >= 21) || (month == 7 && day <= 22)) {
      return {
        'name': 'Cancer',
        'symbol': '♋',
        'element': 'Water',
        'modality': 'Cardinal',
        'ruler': 'Moon',
        'essence': 'Intuitive protector, empathetic sanctuary, emotional resonance.',
        'advice': 'Build firm external boundaries so your inner sanctuary flourishes.',
        'color': const Color(0xFF6DD5ED),
      };
    } else if ((month == 7 && day >= 23) || (month == 8 && day <= 22)) {
      return {
        'name': 'Leo',
        'symbol': '♌',
        'element': 'Fire',
        'modality': 'Fixed',
        'ruler': 'Sun',
        'essence': 'Radiant sovereign, magnanimous creator, noble warmth.',
        'advice': 'True leadership illuminates others rather than blinding them.',
        'color': const Color(0xFFF7971E),
      };
    } else if ((month == 8 && day >= 23) || (month == 9 && day <= 22)) {
      return {
        'name': 'Virgo',
        'symbol': '♍',
        'element': 'Earth',
        'modality': 'Mutable',
        'ruler': 'Mercury',
        'essence': 'Architect of perfection, analytical craftsman, humble service.',
        'advice': 'Accept imperfect beauty while continuing to refine your craft.',
        'color': const Color(0xFF96C93D),
      };
    } else if ((month == 9 && day >= 23) || (month == 10 && day <= 22)) {
      return {
        'name': 'Libra',
        'symbol': '♎',
        'element': 'Air',
        'modality': 'Cardinal',
        'ruler': 'Venus',
        'essence': 'Aesthetic arbiter, diplomatic harmonizer, balanced justice.',
        'advice': 'Decisiveness preserves true harmony better than passive peace.',
        'color': const Color(0xFFE0C3FC),
      };
    } else if ((month == 10 && day >= 23) || (month == 11 && day <= 21)) {
      return {
        'name': 'Scorpio',
        'symbol': '♏',
        'element': 'Water',
        'modality': 'Fixed',
        'ruler': 'Pluto & Mars',
        'essence': 'Alchemical transformer, penetrating visionary, sacred depth.',
        'advice': 'Transmute fierce passions into unconditional empowerment.',
        'color': const Color(0xFF8E2DE2),
      };
    } else if ((month == 11 && day >= 22) || (month == 12 && day <= 21)) {
      return {
        'name': 'Sagittarius',
        'symbol': '♐',
        'element': 'Fire',
        'modality': 'Mutable',
        'ruler': 'Jupiter',
        'essence': 'Cosmic philosopher, relentless explorer, infectious optimism.',
        'advice': 'Anchor visionary ideals to meticulous practical steps.',
        'color': const Color(0xFFF857A6),
      };
    } else if ((month == 12 && day >= 22) || (month == 1 && day <= 19)) {
      return {
        'name': 'Capricorn',
        'symbol': '♑',
        'element': 'Earth',
        'modality': 'Cardinal',
        'ruler': 'Saturn',
        'essence': 'Mountain sovereign, disciplined titan, enduring legacy.',
        'advice': 'Build not merely for ambition, but for lasting spiritual virtue.',
        'color': const Color(0xFF4B6CB7),
      };
    } else if ((month == 1 && day >= 20) || (month == 2 && day <= 18)) {
      return {
        'name': 'Aquarius',
        'symbol': '♒',
        'element': 'Air',
        'modality': 'Fixed',
        'ruler': 'Uranus & Saturn',
        'essence': 'Avant-garde reformer, humanitarian visionary, rebellious intellect.',
        'advice': 'Connect intellectual breakthroughs to heartfelt human compassion.',
        'color': const Color(0xFF00C9FF),
      };
    } else {
      return {
        'name': 'Pisces',
        'symbol': '♓',
        'element': 'Water',
        'modality': 'Mutable',
        'ruler': 'Neptune & Jupiter',
        'essence': 'Mystic dreamer, boundless empath, oceanic imagination.',
        'advice': 'Anchor your transcendent vision into concrete physical reality.',
        'color': const Color(0xFF9B51E0),
      };
    }
  }

  static const List<String> _zodiacSigns = [
    'Aries', 'Taurus', 'Gemini', 'Cancer', 'Leo', 'Virgo',
    'Libra', 'Scorpio', 'Sagittarius', 'Capricorn', 'Aquarius', 'Pisces'
  ];

  static String _approximateMoonSign(DateTime date) {
    // Moon moves ~13.2 degrees per day through 12 signs (~2.25 days per sign)
    final dayOfYear = date.difference(DateTime(date.year, 1, 1)).inDays;
    final yearOffset = (date.year * 13) % 12;
    final signIndex = (yearOffset + (dayOfYear / 2.25).floor()) % 12;
    return _zodiacSigns[signIndex];
  }

  static String _approximateAscendant(int month, int day, int hour) {
    // Ascendant shifts ~1 sign every 2 hours, starting from Sun Sign at sunrise (~6 AM)
    final sunSignIndex = _getSunSignIndex(month, day);
    final hoursSinceSunrise = (hour - 6 + 24) % 24;
    final ascendantShift = (hoursSinceSunrise / 2).floor();
    return _zodiacSigns[(sunSignIndex + ascendantShift) % 12];
  }

  static int _getSunSignIndex(int month, int day) {
    final name = _getSunSignData(month, day)['name'] as String;
    return _zodiacSigns.indexOf(name);
  }
}
