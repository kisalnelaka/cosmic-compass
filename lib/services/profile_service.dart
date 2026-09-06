import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user_profile.dart';
import '../models/cosmic_synthesis.dart';
import '../models/cultural_profiles.dart';
import 'calculators/western_calculator.dart';
import 'calculators/bazi_calculator.dart';
import 'calculators/ziwei_calculator.dart';
import 'calculators/vedic_calculator.dart';
import 'calculators/nadi_calculator.dart';
import 'calculators/arabian_parts_calculator.dart';
import 'calculators/mayan_calculator.dart';
import 'calculators/aztec_calculator.dart';
import 'calculators/medicine_wheel_calculator.dart';
import 'calculators/celtic_tree_calculator.dart';
import 'calculators/norse_rune_calculator.dart';
import 'calculators/blood_type_calculator.dart';

class ProfileService {
  static const String _profileKey = 'user_cosmic_profile_v1';

  static Future<UserProfile?> loadProfile() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonStr = prefs.getString(_profileKey);
    if (jsonStr == null) return null;
    try {
      final map = jsonDecode(jsonStr) as Map<String, dynamic>;
      return UserProfile.fromJson(map);
    } catch (_) {
      return null;
    }
  }

  static Future<void> saveProfile(UserProfile profile) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonStr = jsonEncode(profile.toJson());
    await prefs.setString(_profileKey, jsonStr);
  }

  static CosmicSynthesis synthesize(UserProfile profile) {
    final western = WesternCalculator.calculate(profile);
    final bazi = BaZiCalculator.calculate(profile);
    final ziwei = ZiWeiCalculator.calculate(profile);
    final vedic = VedicCalculator.calculate(profile);
    final nadi = NadiCalculator.calculate(profile);
    final arabian = ArabianPartsCalculator.calculate(profile);
    final mayan = MayanCalculator.calculate(profile);
    final aztec = AztecCalculator.calculate(profile);
    final medicineWheel = MedicineWheelCalculator.calculate(profile);
    final celticTree = CelticTreeCalculator.calculate(profile);
    final norseRune = NorseRuneCalculator.calculate(profile);
    final bloodType = BloodTypeCalculator.calculate(profile);

    // Calculate Elemental Balance across the 12 charts
    double fireScore = 0;
    double earthScore = 0;
    double airScore = 0;
    double waterScore = 0;
    double etherScore = 0;

    final allSigns = [
      western, bazi, ziwei, vedic, nadi, arabian,
      mayan, aztec, medicineWheel, celticTree, norseRune, bloodType
    ];

    for (var sign in allSigns) {
      final elem = sign.element.toLowerCase();
      if (elem.contains('fire')) fireScore += 1.0;
      if (elem.contains('earth')) earthScore += 1.0;
      if (elem.contains('air')) airScore += 1.0;
      if (elem.contains('water')) waterScore += 1.0;
      if (elem.contains('ether') || elem.contains('wood') || elem.contains('metal') || elem.contains('spirit')) {
        etherScore += 1.0;
      }
    }

    final total = (fireScore + earthScore + airScore + waterScore + etherScore);
    final elementalBalance = ElementalBalance(
      fire: total > 0 ? (fireScore / total) : 0.2,
      earth: total > 0 ? (earthScore / total) : 0.2,
      air: total > 0 ? (airScore / total) : 0.2,
      water: total > 0 ? (waterScore / total) : 0.2,
      ether: total > 0 ? (etherScore / total) : 0.2,
    );

    // Generate Cosmic Archetype Title based on synthesis
    final dominant = elementalBalance.dominantElement;
    final archetypeTitle = _generateArchetypeTitle(dominant, bazi.animal, mayan.nahualName);

    // Synergy resonance calculation (78 - 98%)
    final seed = profile.birthDate.day * 7 + profile.birthDate.month * 11 + profile.birthTime.hour * 3;
    final synergyScore = 78 + (seed % 21);

    final universalMantra = _generateUniversalMantra(dominant, western.signName, vedic.nakshatra);

    final convergences = _generateConvergences(
      western: western,
      bazi: bazi,
      ziwei: ziwei,
      vedic: vedic,
      nadi: nadi,
      arabian: arabian,
      mayan: mayan,
      aztec: aztec,
      medicineWheel: medicineWheel,
      celticTree: celticTree,
      norseRune: norseRune,
      bloodType: bloodType,
      dominantElement: dominant,
    );

    return CosmicSynthesis(
      profile: profile,
      western: western,
      bazi: bazi,
      ziwei: ziwei,
      vedic: vedic,
      nadi: nadi,
      arabian: arabian,
      mayan: mayan,
      aztec: aztec,
      medicineWheel: medicineWheel,
      celticTree: celticTree,
      norseRune: norseRune,
      bloodType: bloodType,
      cosmicArchetypeTitle: archetypeTitle,
      cosmicSynergyScore: synergyScore,
      universalMantra: universalMantra,
      elementalBalance: elementalBalance,
      convergences: convergences,
    );
  }

  static List<TraditionConvergence> _generateConvergences({
    required WesternChart western,
    required BaZiChart bazi,
    required ZiWeiChart ziwei,
    required VedicChart vedic,
    required NadiChart nadi,
    required ArabianChart arabian,
    required MayanChart mayan,
    required AztecChart aztec,
    required MedicineWheelChart medicineWheel,
    required CelticTreeChart celticTree,
    required NorseRuneChart norseRune,
    required BloodTypeChart bloodType,
    required String dominantElement,
  }) {
    return [
      TraditionConvergence(
        title: 'Elemental Foundation Concordance',
        consensusTrait: 'Dominant $dominantElement Resonance',
        agreeingTraditions: [
          'Western ${western.element} (${western.signName})',
          'BaZi ${bazi.dayMaster} Day Master',
          'Medicine Wheel ${medicineWheel.elementalClan}',
          'Vedic ${vedic.element} Sidereal Rashi',
        ],
        analyticalSynthesis:
            'Across both East Asian Five Elements and Greco-Vedic Classical Elements, your birth coordinates consistently concentrate in $dominantElement. This produces a temperament that instinctively responds through $dominantElement values: clarity, purpose, and deliberate momentum.',
        agreementPercentage: 94,
        icon: '⚖️',
      ),
      TraditionConvergence(
        title: 'Leadership & Destiny Driving Force',
        consensusTrait: '${ziwei.dominantArchetype} & ${mayan.nahualName}',
        agreeingTraditions: [
          'Zi Wei Dou Shu: ${ziwei.signName}',
          'Mayan Tzolk\'in: ${mayan.signName}',
          'Aztec Tonalpohualli: ${aztec.signName}',
          'Celtic Sacred Tree: ${celticTree.signName}',
        ],
        analyticalSynthesis:
            'Both Chinese Purple Star astrology and Mesoamerican Daykeeping identify your soul imprint as a catalyst for sovereign initiatives. Whether described as the ${ziwei.dominantArchetype} in China or ${mayan.nahualName} in Mayan lore, these distant civilizations independently describe your innate aptitude for steering projects toward completion.',
        agreementPercentage: 91,
        icon: '👑',
      ),
      TraditionConvergence(
        title: 'Interpersonal & Communication Dynamics',
        consensusTrait: '${bloodType.signName.split('(').first.trim()} & ${norseRune.signName.split('(').first.trim()}',
        agreeingTraditions: [
          'Japanese Ketsuekigata: ${bloodType.idealWorkplaceRole}',
          'Norse Runic Divination: ${norseRune.signName}',
          'Vedic Nakshatra: ${vedic.nakshatra} (Deity: ${vedic.nakshatraDeity})',
        ],
        analyticalSynthesis:
            'Japanese Blood Type research and ancient Norse runic lore converge on your social methodology. Both suggest that your greatest leverage occurs when your natural analytical discernment is backed by direct, transparent communication rather than unexpressed expectations.',
        agreementPercentage: 88,
        icon: '🤝',
      ),
      TraditionConvergence(
        title: 'Karmic Growth & Life Opportunity Windows',
        consensusTrait: '${nadi.karmicArchetype} & ${arabian.signName}',
        agreeingTraditions: [
          'South Indian Nadi Kaanda: ${nadi.lifeChapterTitle}',
          'Arabian Astrology: ${arabian.signName}',
          'Western Natal House: House ${western.houseOfSun} of the Sun',
        ],
        analyticalSynthesis:
            'Persian mathematical lots (Part of Fortune) and South Indian Palm-Leaf records indicate that financial and personal breakthroughs materialize through disciplined stewardship of your unique talents. Both point toward auspicious turning points when serving larger community initiatives.',
        agreementPercentage: 89,
        icon: '🌟',
      ),
    ];
  }

  static String _generateArchetypeTitle(String dominant, String animal, String nahual) {
    if (dominant.contains('Fire')) {
      return 'The Luminous Sun-Bearer ($animal & $nahual)';
    } else if (dominant.contains('Earth')) {
      return 'The Architect of Sacred Foundations ($animal & $nahual)';
    } else if (dominant.contains('Air')) {
      return 'The Wind-Weaver of Divine Truth ($animal & $nahual)';
    } else if (dominant.contains('Water')) {
      return 'The Mystic Navigator of Deep Tides ($animal & $nahual)';
    } else {
      return 'The Alchemical Sovereign of the Ether ($animal & $nahual)';
    }
  }

  static String _generateUniversalMantra(String dominant, String sunSign, String nakshatra) {
    return 'I stand anchored between Earth and Stars as a $sunSign soul governed by $nakshatra: embodying $dominant in thought, speech, and action.';
  }
}
