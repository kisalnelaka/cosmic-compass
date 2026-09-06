import 'package:flutter/material.dart';
import '../models/user_profile.dart';
import 'calculators/norse_rune_calculator.dart';

class DailyCulturalForecast {
  final String traditionName;
  final String headline;
  final String guidance;
  final String luckySymbol;
  final Color accentColor;

  const DailyCulturalForecast({
    required this.traditionName,
    required this.headline,
    required this.guidance,
    required this.luckySymbol,
    required this.accentColor,
  });
}

class DailyPredictionService {
  static List<DailyCulturalForecast> generateDailyForecasts(UserProfile profile, DateTime today) {
    final daySeed = today.year * 10000 + today.month * 100 + today.day;
    final userSeed = profile.birthDate.day * 13 + profile.birthDate.month * 7;
    final combo = (daySeed + userSeed);

    // 1. BaZi Day Transit
    final baziElements = ['Wood', 'Fire', 'Earth', 'Metal', 'Water'];
    final todayElement = baziElements[(today.day + today.month) % baziElements.length];
    final baziForecast = DailyCulturalForecast(
      traditionName: 'Chinese BaZi Daily Transit',
      headline: 'Today’s Qi: Flourishing $todayElement Energy',
      guidance: 'The cosmic atmosphere resonates with $todayElement. Direct your conscious intention into productive creation and keep harmony in team interactions.',
      luckySymbol: '🐉',
      accentColor: const Color(0xFFE67E22),
    );

    // 2. Mayan Sacred Kin of Today
    final jdnToday = _julianDayNumber(today.year, today.month, today.day);
    final todayKin = ((jdnToday - 584283) % 260) + 1;
    final todayTone = ((todayKin - 1) % 13) + 1;
    final mayanForecast = DailyCulturalForecast(
      traditionName: "Mayan Tzolk'in Day Energy",
      headline: 'Kin $todayKin | Galactic Tone $todayTone Activation',
      guidance: 'The sacred 260-day calendar invites you to align with Tone $todayTone: focus on conscious presence, clear discernment, and honoring synchronicities.',
      luckySymbol: '⚡',
      accentColor: const Color(0xFF9B59B6),
    );

    // 3. Vedic Lunar Transit
    final vedicNakshatras = [
      'Ashwini', 'Rohini', 'Pushya', 'Hasta', 'Swati', 'Anuradha', 'Shravana', 'Revati'
    ];
    final activeNakshatra = vedicNakshatras[combo % vedicNakshatras.length];
    final vedicForecast = DailyCulturalForecast(
      traditionName: 'Vedic Chandra Transit',
      headline: 'Chandra Transit in $activeNakshatra Nakshatra',
      guidance: 'The Moon activates $activeNakshatra today. This auspicious transit supports spiritual meditation, clear communication, and honoring elders.',
      luckySymbol: '🌕',
      accentColor: const Color(0xFFFF9933),
    );

    // 4. Blood Type Social Focus
    final bloodTypeAdvice = _getDailyBloodTypeTip(profile.bloodType, combo);
    final bloodForecast = DailyCulturalForecast(
      traditionName: 'Japanese Ketsuekigata Tip',
      headline: 'Social & Vitality Tip for Type ${profile.bloodType.shortName}',
      guidance: bloodTypeAdvice,
      luckySymbol: '🩸',
      accentColor: const Color(0xFF2ECC71),
    );

    // 5. Norse Daily Stave Guidance
    final dailyRune = NorseRuneCalculator.runes[combo % NorseRuneCalculator.runes.length];
    final runeForecast = DailyCulturalForecast(
      traditionName: 'Norse Rune of the Day',
      headline: '${dailyRune.name} (${dailyRune.symbol}) - ${dailyRune.translation}',
      guidance: dailyRune.divineAdvice,
      luckySymbol: dailyRune.symbol,
      accentColor: const Color(0xFF3498DB),
    );

    // 6. Arabian Auspicious Timing Window
    final hours = [
      '09:30 - 11:15 (Solar Hour of Triumph)',
      '14:00 - 15:45 (Jupiterian Hour of Prosperity)',
      '18:15 - 19:45 (Venusian Hour of Harmony)',
      '20:30 - 22:00 (Mercurial Hour of Intellect)'
    ];
    final chosenHour = hours[combo % hours.length];
    final arabianForecast = DailyCulturalForecast(
      traditionName: 'Arabian Planetary Election',
      headline: 'Golden Activity Window: $chosenHour',
      guidance: 'Schedule high-stakes conversations, financial investments, or creative artistic milestones within this planetary window for peak cosmic fortune.',
      luckySymbol: '⭐',
      accentColor: const Color(0xFFF1C40F),
    );

    return [
      baziForecast,
      mayanForecast,
      vedicForecast,
      bloodForecast,
      runeForecast,
      arabianForecast,
    ];
  }

  static String _getDailyBloodTypeTip(BloodType type, int combo) {
    switch (type) {
      case BloodType.a:
        return 'Methodical focus will keep you three steps ahead today. Avoid overthinking other people’s words—trust your proven preparation.';
      case BloodType.b:
        return 'Spontaneous creativity is your superpower today. Share your unique insight in meetings; people are ready to embrace fresh angles.';
      case BloodType.ab:
        return 'Your analytical neutrality will mediate a complex dispute today. Keep calm and take a scenic walk to clear intellectual fatigue.';
      case BloodType.o:
        return 'Your natural warmth and decisive leadership will galvanize those around you. Be generous with encouragement and lead by example.';
    }
  }

  static int _julianDayNumber(int y, int m, int d) {
    if (m <= 2) {
      y -= 1;
      m += 12;
    }
    final a = (y / 100).floor();
    final b = 2 - a + (a / 4).floor();
    return (365.25 * (y + 4716)).floor() + (30.6001 * (m + 1)).floor() + d + b - 1524;
  }
}
