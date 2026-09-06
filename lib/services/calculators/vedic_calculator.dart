import 'package:flutter/material.dart';
import '../../models/cultural_profiles.dart';
import '../../models/user_profile.dart';

class VedicCalculator {
  static const double lahiriAyanamsa = 24.1; // Chitra Paksha Ayanamsa offset

  static const List<Map<String, String>> siderealRashis = [
    {'sanskrit': 'Mesha', 'english': 'Sidereal Aries', 'symbol': '♈', 'element': 'Fire', 'ruler': 'Mangala (Mars)'},
    {'sanskrit': 'Vrishabha', 'english': 'Sidereal Taurus', 'symbol': '♉', 'element': 'Earth', 'ruler': 'Shukra (Venus)'},
    {'sanskrit': 'Mithuna', 'english': 'Sidereal Gemini', 'symbol': '♊', 'element': 'Air', 'ruler': 'Budha (Mercury)'},
    {'sanskrit': 'Karka', 'english': 'Sidereal Cancer', 'symbol': '♋', 'element': 'Water', 'ruler': 'Chandra (Moon)'},
    {'sanskrit': 'Simha', 'english': 'Sidereal Leo', 'symbol': '♌', 'element': 'Fire', 'ruler': 'Surya (Sun)'},
    {'sanskrit': 'Kanya', 'english': 'Sidereal Virgo', 'symbol': '♍', 'element': 'Earth', 'ruler': 'Budha (Mercury)'},
    {'sanskrit': 'Tula', 'english': 'Sidereal Libra', 'symbol': '♎', 'element': 'Air', 'ruler': 'Shukra (Venus)'},
    {'sanskrit': 'Vrishchika', 'english': 'Sidereal Scorpio', 'symbol': '♏', 'element': 'Water', 'ruler': 'Mangala & Ketu'},
    {'sanskrit': 'Dhanu', 'english': 'Sidereal Sagittarius', 'symbol': '♐', 'element': 'Fire', 'ruler': 'Guru (Jupiter)'},
    {'sanskrit': 'Makara', 'english': 'Sidereal Capricorn', 'symbol': '♑', 'element': 'Earth', 'ruler': 'Shani (Saturn)'},
    {'sanskrit': 'Kumbha', 'english': 'Sidereal Aquarius', 'symbol': '♒', 'element': 'Air', 'ruler': 'Shani & Rahu'},
    {'sanskrit': 'Meena', 'english': 'Sidereal Pisces', 'symbol': '♓', 'element': 'Water', 'ruler': 'Guru (Jupiter)'},
  ];

  static const List<Map<String, String>> nakshatras = [
    {'name': 'Ashwini', 'deity': 'Ashvins (Divine Physicians)', 'lord': 'Ketu', 'animal': 'Horse'},
    {'name': 'Bharani', 'deity': 'Yama (God of Dharma & Justice)', 'lord': 'Venus', 'animal': 'Elephant'},
    {'name': 'Krittika', 'deity': 'Agni (God of Sacred Fire)', 'lord': 'Sun', 'animal': 'Sheep'},
    {'name': 'Rohini', 'deity': 'Brahma (Creator)', 'lord': 'Moon', 'animal': 'Serpent'},
    {'name': 'Mrigashira', 'deity': 'Soma (Moon God)', 'lord': 'Mars', 'animal': 'Serpent'},
    {'name': 'Ardra', 'deity': 'Rudra (Storm & Transformation)', 'lord': 'Rahu', 'animal': 'Dog'},
    {'name': 'Punarvasu', 'deity': 'Aditi (Mother of the Gods)', 'lord': 'Jupiter', 'animal': 'Cat'},
    {'name': 'Pushya', 'deity': 'Brihaspati (Divine Priest)', 'lord': 'Saturn', 'animal': 'Goat'},
    {'name': 'Ashlesha', 'deity': 'Nagas (Serpent Kings)', 'lord': 'Mercury', 'animal': 'Cat'},
    {'name': 'Magha', 'deity': 'Pitris (Ancestral Spirits)', 'lord': 'Ketu', 'animal': 'Rat'},
    {'name': 'Purva Phalguni', 'deity': 'Bhaga (God of Delight)', 'lord': 'Venus', 'animal': 'Rat'},
    {'name': 'Uttara Phalguni', 'deity': 'Aryaman (God of Friendship)', 'lord': 'Sun', 'animal': 'Cow'},
    {'name': 'Hasta', 'deity': 'Savitr (The Sun God)', 'lord': 'Moon', 'animal': 'Buffalo'},
    {'name': 'Chitra', 'deity': 'Vishwakarma (Divine Architect)', 'lord': 'Mars', 'animal': 'Tiger'},
    {'name': 'Swati', 'deity': 'Vayu (Wind God)', 'lord': 'Rahu', 'animal': 'Buffalo'},
    {'name': 'Vishakha', 'deity': 'Indra & Agni', 'lord': 'Jupiter', 'animal': 'Tiger'},
    {'name': 'Anuradha', 'deity': 'Mitra (Divine Harmony)', 'lord': 'Saturn', 'animal': 'Deer'},
    {'name': 'Jyeshtha', 'deity': 'Indra (King of Gods)', 'lord': 'Mercury', 'animal': 'Deer'},
    {'name': 'Mula', 'deity': 'Nirriti (Goddess of Dissolution)', 'lord': 'Ketu', 'animal': 'Dog'},
    {'name': 'Purva Ashadha', 'deity': 'Apas (Cosmic Waters)', 'lord': 'Venus', 'animal': 'Monkey'},
    {'name': 'Uttara Ashadha', 'deity': 'Vishwadevas (Universal Gods)', 'lord': 'Sun', 'animal': 'Mongoose'},
    {'name': 'Shravana', 'deity': 'Vishnu (The Preserver)', 'lord': 'Moon', 'animal': 'Monkey'},
    {'name': 'Dhanishta', 'deity': 'Ashta Vasus (Elements)', 'lord': 'Mars', 'animal': 'Lion'},
    {'name': 'Shatabhisha', 'deity': 'Varuna (Cosmic Ocean)', 'lord': 'Rahu', 'animal': 'Horse'},
    {'name': 'Purva Bhadrapada', 'deity': 'Aja Ekapada (One-Footed Goat)', 'lord': 'Jupiter', 'animal': 'Lion'},
    {'name': 'Uttara Bhadrapada', 'deity': 'Ahirbudhnya (Serpent of Deep)', 'lord': 'Saturn', 'animal': 'Cow'},
    {'name': 'Revati', 'deity': 'Pushan (Nourisher of Souls)', 'lord': 'Mercury', 'animal': 'Elephant'},
  ];

  static VedicChart calculate(UserProfile profile) {
    final date = profile.birthDate;

    // Approximate tropical sun degree (0 to 360)
    final dayOfYear = date.difference(DateTime(date.year, 1, 1)).inDays;
    final tropicalSunDegree = (dayOfYear + 284) % 365 * (360.0 / 365.25);

    // Sidereal Sun Degree = Tropical Sun Degree - Lahiri Ayanamsa
    final siderealDegree = (tropicalSunDegree - lahiriAyanamsa + 360) % 360;
    final rashiIndex = (siderealDegree / 30.0).floor() % 12;
    final rashi = siderealRashis[rashiIndex];

    // Nakshatra = 360 / 27 = 13° 20' (13.3333°) per mansion
    // Using approximated sidereal moon longitude
    final approxMoonDegree = (siderealDegree + (date.day * 13.18) + (profile.birthTime.hour * 0.55)) % 360;
    final nakshatraIndex = (approxMoonDegree / (360.0 / 27.0)).floor() % 27;
    final nak = nakshatras[nakshatraIndex];

    return VedicChart(
      signName: '${rashi['sanskrit']!} (${rashi['english']!})',
      symbol: rashi['symbol']!,
      element: rashi['element']!,
      rulingForce: rashi['ruler']!,
      essence: 'Nakshatra: ${nak['name']} (${nak['deity']}), guided by planetary lord ${nak['lord']}.',
      destinyAdvice: 'Align action with cosmic Dharma; cultivate devotion to overcome karmic debts (prarabdha karma).',
      accentColor: const Color(0xFFFF9933), // Saffron Gold
      nakshatra: nak['name']!,
      nakshatraDeity: nak['deity']!,
      dashaLord: nak['lord']!,
      ayanamsaDegrees: lahiriAyanamsa,
    );
  }
}
