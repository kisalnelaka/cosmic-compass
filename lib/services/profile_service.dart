import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user_profile.dart';
import '../models/cosmic_synthesis.dart';
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

    // Synergy resonance calculation (75 - 99%)
    final seed = profile.birthDate.day * 7 + profile.birthDate.month * 11 + profile.birthTime.hour * 3;
    final synergyScore = 78 + (seed % 21);

    final universalMantra = _generateUniversalMantra(dominant, western.signName, vedic.nakshatra);

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
    );
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
