import 'package:flutter/material.dart';
import '../../models/cultural_profiles.dart';
import '../../models/user_profile.dart';

class BaZiCalculator {
  static const List<String> heavenlyStems = [
    'Jia (甲)', 'Yi (乙)', 'Bing (丙)', 'Ding (丁)', 'Wu (戊)',
    'Ji (己)', 'Geng (庚)', 'Xin (辛)', 'Ren (壬)', 'Gui (癸)'
  ];

  static const List<String> earthlyBranches = [
    'Zi (子)', 'Chou (丑)', 'Yin (寅)', 'Mao (卯)', 'Chen (辰)', 'Si (巳)',
    'Wu (午)', 'Wei (未)', 'Shen (申)', 'You (酉)', 'Xu (戌)', 'Hai (亥)'
  ];

  static const List<String> branchAnimals = [
    'Rat', 'Ox', 'Tiger', 'Rabbit', 'Dragon', 'Snake',
    'Horse', 'Goat', 'Monkey', 'Rooster', 'Dog', 'Pig'
  ];

  static const List<String> animalSymbols = [
    '🐀', '🐂', '🐅', '🐇', '🐉', '🐍',
    '🐎', '🐐', '🐒', '🐓', '🐕', '🐖'
  ];

  static const List<String> stemElements = [
    'Wood', 'Wood', 'Fire', 'Fire', 'Earth',
    'Earth', 'Metal', 'Metal', 'Water', 'Water'
  ];

  static BaZiChart calculate(UserProfile profile) {
    final date = profile.birthDate;
    final hour = profile.birthTime.hour;

    // 1. Year Pillar: Sexagenary cycle offset from 1924 (Jia Zi Year)
    final yearOffset = date.year - 1924;
    final yearStemIdx = (yearOffset % 10 + 10) % 10;
    final yearBranchIdx = (yearOffset % 12 + 12) % 12;

    final yearPillar = BaZiPillar(
      heavenlyStem: heavenlyStems[yearStemIdx],
      earthlyBranch: earthlyBranches[yearBranchIdx],
      element: stemElements[yearStemIdx],
      animal: branchAnimals[yearBranchIdx],
    );

    // 2. Month Pillar: Tied to solar term / month
    final monthStemIdx = ((yearStemIdx % 5) * 2 + date.month) % 10;
    final monthBranchIdx = (date.month + 1) % 12; // Yin month is roughly Feb
    final monthPillar = BaZiPillar(
      heavenlyStem: heavenlyStems[monthStemIdx],
      earthlyBranch: earthlyBranches[monthBranchIdx],
      element: stemElements[monthStemIdx],
      animal: branchAnimals[monthBranchIdx],
    );

    // 3. Day Pillar: Julian day offset mod 60
    final jdn = _julianDayNumber(date.year, date.month, date.day);
    final dayStemIdx = (jdn % 10);
    final dayBranchIdx = (jdn % 12);
    final dayPillar = BaZiPillar(
      heavenlyStem: heavenlyStems[dayStemIdx],
      earthlyBranch: earthlyBranches[dayBranchIdx],
      element: stemElements[dayStemIdx],
      animal: branchAnimals[dayBranchIdx],
    );

    // 4. Hour Pillar: Based on Chinese two-hour shifts (Shi Chen)
    final hourBranchIdx = ((hour + 1) ~/ 2) % 12;
    final hourStemIdx = ((dayStemIdx % 5) * 2 + hourBranchIdx) % 10;
    final hourPillar = BaZiPillar(
      heavenlyStem: heavenlyStems[hourStemIdx],
      earthlyBranch: earthlyBranches[hourBranchIdx],
      element: stemElements[hourStemIdx],
      animal: branchAnimals[hourBranchIdx],
    );

    final polarity = (yearStemIdx % 2 == 0) ? 'Yang' : 'Yin';
    final mainElement = stemElements[yearStemIdx];
    final animalName = branchAnimals[yearBranchIdx];
    final signName = '$polarity $mainElement $animalName';

    return BaZiChart(
      signName: signName,
      symbol: animalSymbols[yearBranchIdx],
      element: mainElement,
      rulingForce: 'Tai Sui (Jupiter & Wood Star)',
      essence: 'Pillar essence: $polarity $mainElement $animalName with ${stemElements[dayStemIdx]} Day Master.',
      destinyAdvice: 'Balance your ${stemElements[dayStemIdx]} Day Master with harmonious nourishment and avoid abrupt clashes.',
      accentColor: _getElementColor(mainElement),
      animal: animalName,
      polarity: polarity,
      yearPillar: yearPillar,
      monthPillar: monthPillar,
      dayPillar: dayPillar,
      hourPillar: hourPillar,
      dayMaster: '${stemElements[dayStemIdx]} (${heavenlyStems[dayStemIdx].split(' ').first})',
    );
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

  static Color _getElementColor(String element) {
    switch (element) {
      case 'Wood':
        return const Color(0xFF2ECC71);
      case 'Fire':
        return const Color(0xFFE74C3C);
      case 'Earth':
        return const Color(0xFFF39C12);
      case 'Metal':
        return const Color(0xFFBDC3C7);
      case 'Water':
      default:
        return const Color(0xFF3498DB);
    }
  }
}
