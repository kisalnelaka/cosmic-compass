import 'package:flutter/material.dart';
import '../../models/cultural_profiles.dart';
import '../../models/user_profile.dart';

class CelticTreeCalculator {
  static const List<Map<String, dynamic>> trees = [
    {
      'name': 'Birch (Beth)',
      'start': [12, 24], 'end': [1, 20],
      'ogham': 'ᚁ (Beith)',
      'animal': 'White Stag',
      'element': 'Water / Air',
      'symbol': '🌳',
      'essence': 'Pioneer, resilient renewal, ambition, purifying new dawns.',
      'advice': 'Clear out stagnant past habits to unleash fresh creative growth.',
      'color': Color(0xFFE8F5E9),
    },
    {
      'name': 'Rowan (Luis)',
      'start': [1, 21], 'end': [2, 17],
      'ogham': 'ᚂ (Luis)',
      'animal': 'Green Dragon / Crane',
      'element': 'Fire / Spirit',
      'symbol': '🌿',
      'essence': 'Visionary philosopher, protection against darkness, quiet genius.',
      'advice': 'Do not shy away from sharing your unorthodox prophetic visions.',
      'color': Color(0xFFC8E6C9),
    },
    {
      'name': 'Ash (Nion)',
      'start': [2, 18], 'end': [3, 17],
      'ogham': 'ᚅ (Nion)',
      'animal': 'Adder / Seagull',
      'element': 'Water',
      'symbol': '🌱',
      'essence': 'Enchanter, poetic imagination, deep compassion, cosmic roots.',
      'advice': 'Anchor your boundless psychic wonder into creative masterpieces.',
      'color': Color(0xFFA5D6A7),
    },
    {
      'name': 'Alder (Fearn)',
      'start': [3, 18], 'end': [4, 14],
      'ogham': 'ᚃ (Fearn)',
      'animal': 'Hawk / Fox',
      'element': 'Fire',
      'symbol': '🔥',
      'essence': 'Trailblazer, charismatic courage, fierce protector of friends.',
      'advice': 'Channel fiery ambition with deliberate patience for allies.',
      'color': Color(0xFF81C784),
    },
    {
      'name': 'Willow (Saille)',
      'start': [4, 15], 'end': [5, 12],
      'ogham': 'ᚄ (Saille)',
      'animal': 'Hare / Sea Serpent',
      'element': 'Water',
      'symbol': '💧',
      'essence': 'Lunar observer, deep intuition, psychic sensitivity, flexibility.',
      'advice': 'Trust your subtle instinctual whispers above loud outside noise.',
      'color': Color(0xFF66BB6A),
    },
    {
      'name': 'Hawthorn (Huath)',
      'start': [5, 13], 'end': [6, 9],
      'ogham': 'ᚆ (Uath)',
      'animal': 'Chalice / Owl',
      'element': 'Air',
      'symbol': '🌸',
      'essence': 'Illusionist, charismatic dualism, secret depth, creative humor.',
      'advice': 'Allow trusted confidants to see beyond your clever comedic shield.',
      'color': Color(0xFF4CAF50),
    },
    {
      'name': 'Oak (Duir)',
      'start': [6, 10], 'end': [7, 7],
      'ogham': 'ᚇ (Dair)',
      'animal': 'Wren / White Bull',
      'element': 'Earth / Water',
      'symbol': '🌰',
      'essence': 'Mighty protector, generous endurance, moral titan, noble fortitude.',
      'advice': 'Pair unshakeable fortitude with gentleness for fragile souls.',
      'color': Color(0xFF43A047),
    },
    {
      'name': 'Holly (Tinne)',
      'start': [7, 8], 'end': [8, 4],
      'ogham': 'ᚈ (Tinne)',
      'animal': 'Unicorn / Cat',
      'element': 'Fire',
      'symbol': '👑',
      'essence': 'Regal warrior, victorious perseverance, aristocratic generosity.',
      'advice': 'Let humility safeguard your accomplishments against envy.',
      'color': Color(0xFF388E3C),
    },
    {
      'name': 'Hazel (Coll)',
      'start': [8, 5], 'end': [9, 1],
      'ogham': 'ᚉ (Coll)',
      'animal': 'Salmon of Wisdom',
      'element': 'Air / Earth',
      'symbol': '🌰',
      'essence': 'Knower, razor-sharp intellect, encyclopedic recall, analytical genius.',
      'advice': 'Remember that emotional empathy carries wisdom as profound as intellect.',
      'color': Color(0xFF2E7D32),
    },
    {
      'name': 'Vine (Muin)',
      'start': [9, 2], 'end': [9, 29],
      'ogham': 'ᚋ (Muin)',
      'animal': 'White Swan / Lizard',
      'element': 'Water / Air',
      'symbol': '🍇',
      'essence': 'Equalizer, aesthetic refinement, discriminating taste, diplomatic charm.',
      'advice': 'Embrace bold decisions; clarity brings peace faster than indecision.',
      'color': Color(0xFF1B5E20),
    },
    {
      'name': 'Ivy (Gort)',
      'start': [9, 30], 'end': [10, 27],
      'ogham': 'ᚌ (Gort)',
      'animal': 'Boar / Butterfly',
      'element': 'Water',
      'symbol': '🍃',
      'essence': 'Survivor, loyalty, overcoming insurmountable odds with spirit.',
      'advice': 'Your perseverance can surmount any wall; never surrender your hope.',
      'color': Color(0xFF00796B),
    },
    {
      'name': 'Reed (Ngetal)',
      'start': [10, 28], 'end': [11, 24],
      'ogham': 'ᚍ (Ngetal)',
      'animal': 'Hound / Water Dragon',
      'element': 'Water',
      'symbol': '🌾',
      'essence': 'Inquisitive investigator, uncovering secrets, intense loyalty, depth.',
      'advice': 'Use your uncovering of hidden truths to heal and reconcile.',
      'color': Color(0xFF004D40),
    },
    {
      'name': 'Elder (Ruis)',
      'start': [11, 25], 'end': [12, 23],
      'ogham': 'ᚏ (Ruis)',
      'animal': 'Raven / Black Horse',
      'element': 'Fire / Spirit',
      'symbol': '🍂',
      'essence': 'Philosopher of transformation, frank honesty, wild freedom.',
      'advice': 'Temper raw candor with mindful tact to build lasting alliances.',
      'color': Color(0xFF3E2723),
    },
  ];

  static CelticTreeChart calculate(UserProfile profile) {
    final date = profile.birthDate;
    final m = date.month;
    final d = date.day;

    Map<String, dynamic>? matchedTree;
    for (var item in trees) {
      final s = item['start'] as List<int>;
      final e = item['end'] as List<int>;

      if (s[0] == 12 && e[0] == 1) {
        if ((m == 12 && d >= s[1]) || (m == 1 && d <= e[1])) {
          matchedTree = item;
          break;
        }
      } else {
        if ((m == s[0] && d >= s[1]) || (m == e[0] && d <= e[1])) {
          matchedTree = item;
          break;
        }
      }
    }

    matchedTree ??= trees.first;

    final s = matchedTree['start'] as List<int>;
    final e = matchedTree['end'] as List<int>;
    final periodStr = '${s[0]}/${s[1]} - ${e[0]}/${e[1]}';

    return CelticTreeChart(
      signName: matchedTree['name'] as String,
      symbol: matchedTree['symbol'] as String,
      element: matchedTree['element'] as String,
      rulingForce: 'Ogham: ${matchedTree['ogham']} | Guide: ${matchedTree['animal']}',
      essence: matchedTree['essence'] as String,
      destinyAdvice: matchedTree['advice'] as String,
      accentColor: matchedTree['color'] as Color,
      oghamLetter: matchedTree['ogham'] as String,
      animalGuide: matchedTree['animal'] as String,
      lunarPeriod: periodStr,
    );
  }
}
