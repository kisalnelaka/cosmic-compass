import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user_profile.dart';
import 'calculators/western_calculator.dart';
import 'calculators/bazi_calculator.dart';
import 'calculators/vedic_calculator.dart';
import 'calculators/mayan_calculator.dart';

class TraditionSynastry {
  final String traditionName;
  final String userSign;
  final String partnerSign;
  final int score;
  final String harmonyLevel;
  final String description;
  final Color accentColor;
  final IconData icon;

  const TraditionSynastry({
    required this.traditionName,
    required this.userSign,
    required this.partnerSign,
    required this.score,
    required this.harmonyLevel,
    required this.description,
    required this.accentColor,
    required this.icon,
  });
}

class SynastryDomainAdvice {
  final String domain;
  final String dynamicSummary;
  final String actionRecommendation;
  final IconData icon;
  final Color color;

  const SynastryDomainAdvice({
    required this.domain,
    required this.dynamicSummary,
    required this.actionRecommendation,
    required this.icon,
    required this.color,
  });
}

class PartnerCompatibilityResult {
  final UserProfile user;
  final UserProfile partner;
  final int overallScore;
  final String relationshipArchetype;
  final String executiveSummary;
  final List<TraditionSynastry> traditionBreakdowns;
  final List<SynastryDomainAdvice> domainAdvice;

  const PartnerCompatibilityResult({
    required this.user,
    required this.partner,
    required this.overallScore,
    required this.relationshipArchetype,
    required this.executiveSummary,
    required this.traditionBreakdowns,
    required this.domainAdvice,
  });
}

class PartnerSynastryService {
  static const String _partnerKey = 'partner_cosmic_profile_v1';

  static Future<UserProfile?> loadPartnerProfile() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonStr = prefs.getString(_partnerKey);
    if (jsonStr == null) return null;
    try {
      final map = jsonDecode(jsonStr) as Map<String, dynamic>;
      return UserProfile.fromJson(map);
    } catch (_) {
      return null;
    }
  }

  static Future<void> savePartnerProfile(UserProfile partner) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonStr = jsonEncode(partner.toJson());
    await prefs.setString(_partnerKey, jsonStr);
  }

  static Future<void> clearPartnerProfile() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_partnerKey);
  }

  static PartnerCompatibilityResult calculateSynastry(
    UserProfile user,
    UserProfile partner,
  ) {
    // 1. Calculate individual tradition charts
    final userWestern = WesternCalculator.calculate(user);
    final partnerWestern = WesternCalculator.calculate(partner);

    final userBaZi = BaZiCalculator.calculate(user);
    final partnerBaZi = BaZiCalculator.calculate(partner);


    final userVedic = VedicCalculator.calculate(user);
    final partnerVedic = VedicCalculator.calculate(partner);

    final userMayan = MayanCalculator.calculate(user);
    final partnerMayan = MayanCalculator.calculate(partner);

    // 2. Compute Western Synastry
    final westernSynastry = _calcWesternSynastry(userWestern, partnerWestern);

    // 3. Compute BaZi Synastry
    final baziSynastry = _calcBaZiSynastry(userBaZi, partnerBaZi);

    // 4. Compute Japanese Blood Type Synastry
    final bloodSynastry = _calcBloodTypeSynastry(user.bloodType, partner.bloodType);

    // 5. Compute Vedic Jyotish Synastry
    final vedicSynastry = _calcVedicSynastry(userVedic, partnerVedic);

    // 6. Compute Mayan Tzolk'in Synastry
    final mayanSynastry = _calcMayanSynastry(userMayan, partnerMayan);

    final breakdowns = [
      westernSynastry,
      baziSynastry,
      bloodSynastry,
      vedicSynastry,
      mayanSynastry,
    ];

    // Overall Weighted Score
    final weighted = (westernSynastry.score * 0.25) +
        (baziSynastry.score * 0.25) +
        (bloodSynastry.score * 0.20) +
        (vedicSynastry.score * 0.15) +
        (mayanSynastry.score * 0.15);
    final overallScore = weighted.clamp(68.0, 98.0).round();

    // Determine Archetype
    final archetype = _determineArchetype(
      userWestern.element,
      partnerWestern.element,
      userBaZi.animal,
      partnerBaZi.animal,
      overallScore,
    );

    final executiveSummary =
        '${user.name} and ${partner.name} exhibit an overall synergy index of $overallScore%. Across Western elemental dynamics (${userWestern.element} + ${partnerWestern.element}) and Eastern BaZi branch resonance (${userBaZi.animal} + ${partnerBaZi.animal}), this union operates as "$archetype"—uniting complementary instincts into shared momentum.';

    // Generate Domain Advice
    final domainAdvice = _generateDomainAdvice(
      user,
      partner,
      userWestern,
      partnerWestern,
      userBaZi,
      partnerBaZi,
      user.bloodType,
      partner.bloodType,
    );

    return PartnerCompatibilityResult(
      user: user,
      partner: partner,
      overallScore: overallScore,
      relationshipArchetype: archetype,
      executiveSummary: executiveSummary,
      traditionBreakdowns: breakdowns,
      domainAdvice: domainAdvice,
    );
  }

  // --- PRIVATE TRADITION CALCULATORS ---

  static TraditionSynastry _calcWesternSynastry(
    dynamic u,
    dynamic p,
  ) {
    final uElem = u.element as String;
    final pElem = p.element as String;

    int score = 80;
    String level = 'Complementary';
    String desc = '';

    if (uElem == pElem) {
      score = 92;
      level = 'Harmonious Resonance';
      desc =
          'Shared $uElem element creates an effortless, intuitive understanding. You both process reality and emotional stakes through the same core frequency.';
    } else if ((uElem == 'Fire' && pElem == 'Air') || (uElem == 'Air' && pElem == 'Fire')) {
      score = 94;
      level = 'Dynamic Inspiration';
      desc =
          'Fire and Air form an alchemical catalyst: Air provides visionary perspective and breath that empowers Fire’s courage, while Fire ignites Air’s intellect into passionate action.';
    } else if ((uElem == 'Earth' && pElem == 'Water') || (uElem == 'Water' && pElem == 'Earth')) {
      score = 93;
      level = 'Fertile & Grounded';
      desc =
          'Earth provides the stable riverbanks and structure for Water’s emotional depth, while Water softens Earth and nurtures long-term manifestation.';
    } else if ((uElem == 'Fire' && pElem == 'Water') || (uElem == 'Water' && pElem == 'Fire')) {
      score = 75;
      level = 'Steam & Passion (Dynamic Tension)';
      desc =
          'Steam relationship: Fire brings raw drive, Water brings soul nuance. Requires deliberate communication so passion neither boils over nor quenches initiative.';
    } else {
      score = 76;
      level = 'Growth Polarity';
      desc =
          '$uElem and $pElem challenge each other to expand beyond their comfort zones, turning initial friction into lasting architectural balance.';
    }

    return TraditionSynastry(
      traditionName: 'Western Tropical Zodiac',
      userSign: '${u.signName} (${u.element})',
      partnerSign: '${p.signName} (${p.element})',
      score: score,
      harmonyLevel: level,
      description: desc,
      accentColor: const Color(0xFFFF416C),
      icon: Icons.auto_awesome,
    );
  }

  static TraditionSynastry _calcBaZiSynastry(
    dynamic u,
    dynamic p,
  ) {
    final uAnimal = u.animal as String;
    final pAnimal = p.animal as String;

    // San He Trines
    const trines = [
      {'Rat', 'Dragon', 'Monkey'},
      {'Ox', 'Snake', 'Rooster'},
      {'Tiger', 'Horse', 'Dog'},
      {'Rabbit', 'Goat', 'Pig'},
    ];

    // Liu He Secret Friends
    const secretFriends = [
      {'Rat', 'Ox'},
      {'Tiger', 'Pig'},
      {'Rabbit', 'Dog'},
      {'Dragon', 'Rooster'},
      {'Snake', 'Monkey'},
      {'Horse', 'Goat'},
    ];

    // Liu Chong Clashes
    const clashes = [
      {'Rat', 'Horse'},
      {'Ox', 'Goat'},
      {'Tiger', 'Monkey'},
      {'Rabbit', 'Rooster'},
      {'Dragon', 'Dog'},
      {'Snake', 'Pig'},
    ];

    int score = 84;
    String level = 'Harmonious Alliance';
    String desc = 'Stable cosmic cooperation between $uAnimal and $pAnimal in the earthly branches.';

    final pair = {uAnimal, pAnimal};

    if (secretFriends.any((s) => s.containsAll(pair) && pair.length == 2)) {
      score = 96;
      level = 'Liu He (Six Secret Allies)';
      desc =
          'Legendary BaZi alliance. Ancient texts denote this pairing as mutual soul protectors who instinctively safeguard each other’s reputation and prosperity.';
    } else if (trines.any((t) => t.contains(uAnimal) && t.contains(pAnimal))) {
      score = 94;
      level = 'San He (Three Harmonies Trine)';
      desc =
          'Belong to the same cosmic elemental trine. Your creative timing, lifestyle rhythms, and collaborative goals flow in natural synchronized momentum.';
    } else if (clashes.any((c) => c.containsAll(pair) && pair.length == 2)) {
      score = 72;
      level = 'Liu Chong (Direct Growth Catalyst)';
      desc =
          'Opposing branch axes create magnetic attraction and catalytic personal growth. Great for rapid mutual evolution when mutual boundaries are preserved.';
    }

    return TraditionSynastry(
      traditionName: 'Chinese BaZi & Earthly Branches',
      userSign: '$uAnimal (Year)',
      partnerSign: '$pAnimal (Year)',
      score: score,
      harmonyLevel: level,
      description: desc,
      accentColor: const Color(0xFFE74C3C),
      icon: Icons.brightness_auto,
    );
  }

  static TraditionSynastry _calcBloodTypeSynastry(
    BloodType u,
    BloodType p,
  ) {
    int score = 84;
    String level = 'Balanced';
    String desc = '';

    // Japanese Ketsuekigata Interpersonal Matrix
    if ((u == BloodType.a && p == BloodType.o) || (u == BloodType.o && p == BloodType.a)) {
      score = 96;
      level = 'Golden Ketsuekigata Pair';
      desc =
          'Historically revered in Japanese culture as the ultimate partnership: Type O provides bold leadership, optimism, and warmth, completely dissolving Type A’s conscientious anxiety.';
    } else if ((u == BloodType.b && p == BloodType.o) || (u == BloodType.o && p == BloodType.b)) {
      score = 93;
      level = 'Passionate & Dynamic';
      desc =
          'Type O deeply respects Type B’s spontaneous creative genius and independence, while B feels secure within O’s generous vitality and protection.';
    } else if ((u == BloodType.b && p == BloodType.ab) || (u == BloodType.ab && p == BloodType.b)) {
      score = 91;
      level = 'Intellectual Chemistry';
      desc =
          'AB’s calm rational intellect easily handles B’s unrestrained creative bursts. Mutual non-conformism creates endless fascinating conversations.';
    } else if (u == BloodType.a && p == BloodType.a) {
      score = 88;
      level = 'Mutual Devotion';
      desc =
          'Unrivaled reliability, mutual respect, and attention to detail. Both partners intuitively uphold order and courtesy, though scheduling playful adventures is advised.';
    } else if (u == BloodType.ab && p == BloodType.ab) {
      score = 86;
      level = 'Esoteric Rapport';
      desc =
          'Dual intellects in harmony. You grant each other the mental solitude and respect each needs without ever taking personal space as rejection.';
    } else if (u == BloodType.o && p == BloodType.o) {
      score = 82;
      level = 'Commanding Dynamo';
      desc =
          'High energy and shared ambition. As both partners have strong executive instincts, harmony thrives when dividing realms of leadership collaboratively.';
    } else if ((u == BloodType.a && p == BloodType.b) || (u == BloodType.b && p == BloodType.a)) {
      score = 75;
      level = 'Magnetic Opposites';
      desc =
          'Fascinating contrast: Type A’s structured meticulousness meets Type B’s freeform spontaneity. A keeps B grounded; B shows A how to release perfectionism.';
    } else {
      score = 80;
      level = 'Harmonious Balance';
      desc =
          'Complementary behavioral rhythm. Grounded communication balances different pacing and creates an enduring supportive environment.';
    }

    return TraditionSynastry(
      traditionName: 'Japanese Blood Type (Ketsuekigata)',
      userSign: 'Type ${u.shortName}',
      partnerSign: 'Type ${p.shortName}',
      score: score,
      harmonyLevel: level,
      description: desc,
      accentColor: const Color(0xFF27AE60),
      icon: Icons.water_drop,
    );
  }

  static TraditionSynastry _calcVedicSynastry(
    dynamic u,
    dynamic p,
  ) {
    final uNak = u.nakshatra as String;
    final pNak = p.nakshatra as String;
    final uLord = u.dashaLord as String;
    final pLord = p.dashaLord as String;

    int score = 82;
    String level = 'Dharmic Alignment';
    String desc =
        'Your lunar mansions ($uNak and $pNak) weave complementary karmic lessons. In Vedic tradition, shared devotional goals dissolve petty ego struggles.';

    if (uLord == pLord) {
      score = 92;
      level = 'Mitra (Planetary Kinship)';
      desc =
          'Both ruled by planetary lord $uLord. Your internal instincts regarding spiritual purpose and life direction resonate on the exact same cosmic octave.';
    } else if ((uLord == 'Jupiter' && pLord == 'Sun') || (uLord == 'Sun' && pLord == 'Jupiter') ||
        (uLord == 'Moon' && pLord == 'Jupiter') || (uLord == 'Jupiter' && pLord == 'Moon') ||
        (uLord == 'Venus' && pLord == 'Mercury') || (uLord == 'Mercury' && pLord == 'Venus')) {
      score = 94;
      level = 'Param Mitra (Supreme Planetary Friends)';
      desc =
          'Planetary lords $uLord and $pLord are classical supreme friends in Parashara Jyotish, indicating high moral respect and enduring family blessings.';
    }

    return TraditionSynastry(
      traditionName: 'Vedic Jyotish & Nakshatra',
      userSign: '$uNak (Lord $uLord)',
      partnerSign: '$pNak (Lord $pLord)',
      score: score,
      harmonyLevel: level,
      description: desc,
      accentColor: const Color(0xFFFF9933),
      icon: Icons.wb_sunny,
    );
  }

  static TraditionSynastry _calcMayanSynastry(
    dynamic u,
    dynamic p,
  ) {
    final uNahual = u.nahualName as String;
    final pNahual = p.nahualName as String;
    final uTone = u.tone as int;
    final pTone = p.tone as int;

    int score = 83;
    String level = 'Sacred Kin Balance';
    String desc =
        'Your solar frequencies ($uNahual Tone $uTone & $pNahual Tone $pTone) form an interwoven sacred tapestry within the 260-day Sacred Tzolk\'in.';

    final toneSum = uTone + pTone;
    if (toneSum == 14) {
      score = 95;
      level = 'Galactic Occult Harmonic';
      desc =
          'Your tones sum to 14—the magical occult complement in Mayan cosmology. You naturally reveal the hidden blind spots and dormant powers in one another.';
    } else if ((uTone - pTone).abs() == 7) {
      score = 90;
      level = 'Resonant Tone Bridge';
      desc =
          'Separated by a half-octave of 7 tones. One partner anchors form and rhythm while the other broadcasts inspiration and activation.';
    }

    return TraditionSynastry(
      traditionName: 'Mayan Tzolk\'in Sacred Kin',
      userSign: '$uNahual (Tone $uTone)',
      partnerSign: '$pNahual (Tone $pTone)',
      score: score,
      harmonyLevel: level,
      description: desc,
      accentColor: const Color(0xFF00E5FF),
      icon: Icons.all_inclusive,
    );
  }

  static String _determineArchetype(
    String uElem,
    String pElem,
    String uAnimal,
    String pAnimal,
    int score,
  ) {
    if (score >= 92) {
      return 'The Alchemical Union & Sovereign Anchor';
    } else if ((uElem == 'Fire' || uElem == 'Air') && (pElem == 'Fire' || pElem == 'Air')) {
      return 'The Visionary Catalysts & Radiant Flame';
    } else if ((uElem == 'Earth' || uElem == 'Water') && (pElem == 'Earth' || pElem == 'Water')) {
      return 'The Fertile Haven & Manifestation Engine';
    } else {
      return 'The Complementary Architects & Sacred Mirror';
    }
  }

  static List<SynastryDomainAdvice> _generateDomainAdvice(
    UserProfile user,
    UserProfile partner,
    dynamic uW,
    dynamic pW,
    dynamic uB,
    dynamic pB,
    BloodType uBlood,
    BloodType pBlood,
  ) {
    return [
      SynastryDomainAdvice(
        domain: 'Communication & Intellectual Flow',
        dynamicSummary:
            '${user.name} communicates with ${uW.element}-grounded logic, whereas ${partner.name} emphasizes ${pW.element}-oriented expression.',
        actionRecommendation:
            'When resolving disagreements, articulate emotional intent first before detailing tactical solutions. Give each other 2 minutes of uninterrupted speaking time.',
        icon: Icons.chat_bubble_outline,
        color: const Color(0xFF38BDF8),
      ),
      SynastryDomainAdvice(
        domain: 'Passion, Vitality & Chemistry',
        dynamicSummary:
            'BaZi branches (${uB.animal} & ${pB.animal}) paired with Blood Types (${uBlood.shortName} & ${pBlood.shortName}) create high creative magnetism.',
        actionRecommendation:
            'Keep curiosity active through spontaneous shared novelty—try unfamiliar cuisines, travel to unmapped places, and champion each other\'s eccentric hobbies.',
        icon: Icons.favorite_border,
        color: const Color(0xFFFF5252),
      ),
      SynastryDomainAdvice(
        domain: 'Long-term Synergy & Growth',
        dynamicSummary:
            'Your multi-cultural charts demonstrate mutual reinforcement: one partner provides the visionary horizon, the other provides the architectural steps.',
        actionRecommendation:
            'Establish shared seasonal milestones (financial, personal, spiritual). Revisit this cosmic consensus during solstice and equinox transitions.',
        icon: Icons.trending_up,
        color: const Color(0xFFFFD700),
      ),
    ];
  }
}
