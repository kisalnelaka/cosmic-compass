import 'cultural_profiles.dart';
import 'user_profile.dart';

class ElementalBalance {
  final double fire;
  final double earth;
  final double air;
  final double water;
  final double ether; // Or Wood/Metal in Chinese 5 elements

  const ElementalBalance({
    required this.fire,
    required this.earth,
    required this.air,
    required this.water,
    required this.ether,
  });

  String get dominantElement {
    double maxVal = fire;
    String dominant = 'Fire';
    if (earth > maxVal) {
      maxVal = earth;
      dominant = 'Earth';
    }
    if (air > maxVal) {
      maxVal = air;
      dominant = 'Air';
    }
    if (water > maxVal) {
      maxVal = water;
      dominant = 'Water';
    }
    if (ether > maxVal) {
      dominant = 'Ether / Wood';
    }
    return dominant;
  }
}

class TraditionConvergence {
  final String title;
  final String consensusTrait;
  final List<String> agreeingTraditions;
  final String analyticalSynthesis;
  final int agreementPercentage; // 80 to 98%
  final String icon;

  const TraditionConvergence({
    required this.title,
    required this.consensusTrait,
    required this.agreeingTraditions,
    required this.analyticalSynthesis,
    required this.agreementPercentage,
    required this.icon,
  });
}

class CosmicSynthesis {
  final UserProfile profile;
  final WesternChart western;
  final BaZiChart bazi;
  final ZiWeiChart ziwei;
  final VedicChart vedic;
  final NadiChart nadi;
  final ArabianChart arabian;
  final MayanChart mayan;
  final AztecChart aztec;
  final MedicineWheelChart medicineWheel;
  final CelticTreeChart celticTree;
  final NorseRuneChart norseRune;
  final BloodTypeChart bloodType;

  final String cosmicArchetypeTitle;
  final int cosmicSynergyScore; // 0 to 100
  final String universalMantra;
  final ElementalBalance elementalBalance;
  final List<TraditionConvergence> convergences;

  const CosmicSynthesis({
    required this.profile,
    required this.western,
    required this.bazi,
    required this.ziwei,
    required this.vedic,
    required this.nadi,
    required this.arabian,
    required this.mayan,
    required this.aztec,
    required this.medicineWheel,
    required this.celticTree,
    required this.norseRune,
    required this.bloodType,
    required this.cosmicArchetypeTitle,
    required this.cosmicSynergyScore,
    required this.universalMantra,
    required this.elementalBalance,
    this.convergences = const [],
  });

  List<CulturalSign> get allSigns => [
        western,
        bazi,
        ziwei,
        vedic,
        nadi,
        arabian,
        mayan,
        aztec,
        medicineWheel,
        celticTree,
        norseRune,
        bloodType,
      ];
}
