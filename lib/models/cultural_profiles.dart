import 'package:flutter/material.dart';

/// Represents a single cultural system's astrological or divination outcome.
abstract class CulturalSign {
  String get systemName;
  String get signName;
  String get symbol;
  String get element;
  String get rulingForce;
  String get essence;
  String get destinyAdvice;
  Color get accentColor;
}

/// 1. Western & Hellenistic
class WesternChart implements CulturalSign {
  @override
  final String systemName = 'Western Astrology';
  @override
  final String signName;
  @override
  final String symbol;
  @override
  final String element;
  @override
  final String rulingForce;
  @override
  final String essence;
  @override
  final String destinyAdvice;
  @override
  final Color accentColor;

  final String moonSign;
  final String ascendantSign;
  final String modality;
  final int houseOfSun;

  const WesternChart({
    required this.signName,
    required this.symbol,
    required this.element,
    required this.rulingForce,
    required this.essence,
    required this.destinyAdvice,
    required this.accentColor,
    required this.moonSign,
    required this.ascendantSign,
    required this.modality,
    this.houseOfSun = 1,
  });
}

/// 2. Chinese BaZi & Shengxiao (Four Pillars)
class BaZiPillar {
  final String heavenlyStem;
  final String earthlyBranch;
  final String element;
  final String animal;

  const BaZiPillar({
    required this.heavenlyStem,
    required this.earthlyBranch,
    required this.element,
    required this.animal,
  });

  String get displayName => '$heavenlyStem $earthlyBranch ($element $animal)';
}

class BaZiChart implements CulturalSign {
  @override
  final String systemName = 'BaZi & Chinese Zodiac';
  @override
  final String signName; // E.g. Yang Wood Dragon
  @override
  final String symbol;
  @override
  final String element;
  @override
  final String rulingForce; // E.g. Jupiter (Sui Xing)
  @override
  final String essence;
  @override
  final String destinyAdvice;
  @override
  final Color accentColor;

  final String animal;
  final String polarity; // Yin or Yang
  final BaZiPillar yearPillar;
  final BaZiPillar monthPillar;
  final BaZiPillar dayPillar;
  final BaZiPillar hourPillar;
  final String dayMaster;

  const BaZiChart({
    required this.signName,
    required this.symbol,
    required this.element,
    required this.rulingForce,
    required this.essence,
    required this.destinyAdvice,
    required this.accentColor,
    required this.animal,
    required this.polarity,
    required this.yearPillar,
    required this.monthPillar,
    required this.dayPillar,
    required this.hourPillar,
    required this.dayMaster,
  });
}

/// 3. Zi Wei Dou Shu (Purple Star Astrology)
class ZiWeiChart implements CulturalSign {
  @override
  final String systemName = 'Zi Wei Dou Shu';
  @override
  final String signName; // Major Star (e.g., Zi Wei - The Emperor Star)
  @override
  final String symbol;
  @override
  final String element;
  @override
  final String rulingForce;
  @override
  final String essence;
  @override
  final String destinyAdvice;
  @override
  final Color accentColor;

  final String lifePalaceBranch;
  final String dominantArchetype;
  final List<String> favorablePalaces;

  const ZiWeiChart({
    required this.signName,
    required this.symbol,
    required this.element,
    required this.rulingForce,
    required this.essence,
    required this.destinyAdvice,
    required this.accentColor,
    required this.lifePalaceBranch,
    required this.dominantArchetype,
    required this.favorablePalaces,
  });
}

/// 4. Vedic (Jyotish)
class VedicChart implements CulturalSign {
  @override
  final String systemName = 'Vedic (Jyotish)';
  @override
  final String signName; // Sidereal Rashi (e.g., Mesha / Sidereal Aries)
  @override
  final String symbol;
  @override
  final String element;
  @override
  final String rulingForce; // Planetary Lord (e.g., Mangala / Mars)
  @override
  final String essence;
  @override
  final String destinyAdvice;
  @override
  final Color accentColor;

  final String nakshatra; // Lunar Mansion (e.g., Ashwini, Rohini)
  final String nakshatraDeity;
  final String dashaLord; // Vimshottari current period lord
  final double ayanamsaDegrees;

  const VedicChart({
    required this.signName,
    required this.symbol,
    required this.element,
    required this.rulingForce,
    required this.essence,
    required this.destinyAdvice,
    required this.accentColor,
    required this.nakshatra,
    required this.nakshatraDeity,
    required this.dashaLord,
    this.ayanamsaDegrees = 24.1,
  });
}

/// 5. Nadi Palm Leaf Astrology
class NadiChart implements CulturalSign {
  @override
  final String systemName = 'Nadi Astrology';
  @override
  final String signName; // E.g., Leaf Chapter 1 (General Destiny / Kaanda)
  @override
  final String symbol;
  @override
  final String element;
  @override
  final String rulingForce;
  @override
  final String essence;
  @override
  final String destinyAdvice;
  @override
  final Color accentColor;

  final String karmicArchetype;
  final String lifeChapterTitle;
  final String remedialMantra;

  const NadiChart({
    required this.signName,
    required this.symbol,
    required this.element,
    required this.rulingForce,
    required this.essence,
    required this.destinyAdvice,
    required this.accentColor,
    required this.karmicArchetype,
    required this.lifeChapterTitle,
    required this.remedialMantra,
  });
}

/// 6. Arabian & Persian Astrology
class ArabianChart implements CulturalSign {
  @override
  final String systemName = 'Arabian & Persian Astrology';
  @override
  final String signName; // Part of Fortune placement
  @override
  final String symbol;
  @override
  final String element;
  @override
  final String rulingForce;
  @override
  final String essence;
  @override
  final String destinyAdvice;
  @override
  final Color accentColor;

  final String birthPlanetaryHour;
  final String lotOfFortuneDegree;
  final String auspiciousWindow;

  const ArabianChart({
    required this.signName,
    required this.symbol,
    required this.element,
    required this.rulingForce,
    required this.essence,
    required this.destinyAdvice,
    required this.accentColor,
    required this.birthPlanetaryHour,
    required this.lotOfFortuneDegree,
    required this.auspiciousWindow,
  });
}

/// 7. Mayan Tzolk'in Calendar
class MayanChart implements CulturalSign {
  @override
  final String systemName = "Mayan Tzolk'in";
  @override
  final String signName; // E.g., 8 Chuen (Monkey)
  @override
  final String symbol;
  @override
  final String element;
  @override
  final String rulingForce;
  @override
  final String essence;
  @override
  final String destinyAdvice;
  @override
  final Color accentColor;

  final int kinNumber; // 1 to 260
  final int tone; // 1 to 13 Galactic Tone
  final String nahualName; // 20 Day Signs (Imix, Ik, Akbal, etc.)
  final String sacredDirection;

  const MayanChart({
    required this.signName,
    required this.symbol,
    required this.element,
    required this.rulingForce,
    required this.essence,
    required this.destinyAdvice,
    required this.accentColor,
    required this.kinNumber,
    required this.tone,
    required this.nahualName,
    required this.sacredDirection,
  });
}

/// 8. Aztec Tonalpohualli
class AztecChart implements CulturalSign {
  @override
  final String systemName = 'Aztec Tonalpohualli';
  @override
  final String signName; // E.g., 1-Cipactli (Crocodile)
  @override
  final String symbol;
  @override
  final String element;
  @override
  final String rulingForce; // Patron deity (e.g., Tonacatecuhtli)
  @override
  final String essence;
  @override
  final String destinyAdvice;
  @override
  final Color accentColor;

  final String trecenaSign;
  final String cardinalLord;

  const AztecChart({
    required this.signName,
    required this.symbol,
    required this.element,
    required this.rulingForce,
    required this.essence,
    required this.destinyAdvice,
    required this.accentColor,
    required this.trecenaSign,
    required this.cardinalLord,
  });
}

/// 9. Native American Medicine Wheel
class MedicineWheelChart implements CulturalSign {
  @override
  final String systemName = 'Medicine Wheel';
  @override
  final String signName; // Totem Animal (e.g. Red Hawk)
  @override
  final String symbol;
  @override
  final String element;
  @override
  final String rulingForce; // Moon cycle & Clan
  @override
  final String essence;
  @override
  final String destinyAdvice;
  @override
  final Color accentColor;

  final String elementalClan; // Thunderbird, Turtle, Butterfly, Frog
  final String plantTotem;
  final String mineralTotem;
  final String direction;

  const MedicineWheelChart({
    required this.signName,
    required this.symbol,
    required this.element,
    required this.rulingForce,
    required this.essence,
    required this.destinyAdvice,
    required this.accentColor,
    required this.elementalClan,
    required this.plantTotem,
    required this.mineralTotem,
    required this.direction,
  });
}

/// 10. Celtic Tree Astrology
class CelticTreeChart implements CulturalSign {
  @override
  final String systemName = 'Celtic Tree Astrology';
  @override
  final String signName; // Sacred Tree (e.g., Birch / Beth)
  @override
  final String symbol;
  @override
  final String element;
  @override
  final String rulingForce;
  @override
  final String essence;
  @override
  final String destinyAdvice;
  @override
  final Color accentColor;

  final String oghamLetter;
  final String animalGuide;
  final String lunarPeriod;

  const CelticTreeChart({
    required this.signName,
    required this.symbol,
    required this.element,
    required this.rulingForce,
    required this.essence,
    required this.destinyAdvice,
    required this.accentColor,
    required this.oghamLetter,
    required this.animalGuide,
    required this.lunarPeriod,
  });
}

/// 11. Norse Runic Divination
class NorseRuneChart implements CulturalSign {
  @override
  final String systemName = 'Norse Runic Divination';
  @override
  final String signName; // Birth Sun Rune (e.g., Fehu)
  @override
  final String symbol; // E.g. ᚠ
  @override
  final String element;
  @override
  final String rulingForce; // Aett (Freyr, Heimdall, Tyr)
  @override
  final String essence;
  @override
  final String destinyAdvice;
  @override
  final Color accentColor;

  final String hourRuneName;
  final String hourRuneSymbol;
  final String aettGroup;

  const NorseRuneChart({
    required this.signName,
    required this.symbol,
    required this.element,
    required this.rulingForce,
    required this.essence,
    required this.destinyAdvice,
    required this.accentColor,
    required this.hourRuneName,
    required this.hourRuneSymbol,
    required this.aettGroup,
  });
}

/// 12. Japanese Blood Type (Ketsuekigata)
class BloodTypeChart implements CulturalSign {
  @override
  final String systemName = 'Japanese Blood Type (Ketsuekigata)';
  @override
  final String signName; // Type A, B, AB, O
  @override
  final String symbol;
  @override
  final String element;
  @override
  final String rulingForce;
  @override
  final String essence;
  @override
  final String destinyAdvice;
  @override
  final Color accentColor;

  final String idealWorkplaceRole;
  final String compatibility;
  final String dailySocialAdvice;

  const BloodTypeChart({
    required this.signName,
    required this.symbol,
    required this.element,
    required this.rulingForce,
    required this.essence,
    required this.destinyAdvice,
    required this.accentColor,
    required this.idealWorkplaceRole,
    required this.compatibility,
    required this.dailySocialAdvice,
  });
}
