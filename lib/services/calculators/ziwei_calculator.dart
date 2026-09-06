import 'package:flutter/material.dart';
import '../../models/cultural_profiles.dart';
import '../../models/user_profile.dart';

class ZiWeiCalculator {
  static const List<String> palaces = [
    'Life Palace (命宫 - Ming Gong)',
    'Siblings Palace (兄弟宫)',
    'Spouse Palace (夫妻宫)',
    'Children Palace (子女宫)',
    'Wealth Palace (财帛宫)',
    'Health Palace (疾厄宫)',
    'Travel Palace (迁移宫)',
    'Friends Palace (交友宫)',
    'Career Palace (官禄宫)',
    'Property Palace (田宅宫)',
    'Mental Well-being Palace (福德宫)',
    'Parents Palace (父母宫)',
  ];

  static const List<Map<String, dynamic>> majorStars = [
    {
      'name': 'Zi Wei (紫微 - The Emperor Star)',
      'element': 'Earth',
      'archetype': 'Supreme Monarch & Sovereign Leader',
      'ruler': 'Polaris (North Star)',
      'symbol': '👑',
      'essence': 'Commanding majesty, supreme nobility, dignified responsibility.',
      'advice': 'True sovereignty is defined by benevolence and sheltering those beneath you.',
      'color': Color(0xFF9B51E0),
    },
    {
      'name': 'Tian Ji (天机 - The Heavenly Strategist)',
      'element': 'Wood',
      'archetype': 'Master Strategist & Chief Counselor',
      'ruler': 'Mercury / Wisdom Star',
      'symbol': '📜',
      'essence': 'Supreme intellect, agility, mathematical precision, counsel.',
      'advice': 'Avoid over-analyzing; translate cerebral plans into courageous deeds.',
      'color': Color(0xFF27AE60),
    },
    {
      'name': 'Tai Yang (太阳 - The Radiant Sun)',
      'element': 'Fire',
      'archetype': 'The Magnanimous Illuminator',
      'ruler': 'Solar Luminary',
      'symbol': '☀️',
      'essence': 'Boundless altruism, public prominence, radiant honor.',
      'advice': 'Preserve your internal flame; do not deplete yourself for applause.',
      'color': Color(0xFFF39C12),
    },
    {
      'name': 'Wu Qu (武曲 - The Wealth Martial Star)',
      'element': 'Metal',
      'archetype': 'The Decisive Financier & Commander',
      'ruler': 'Martial Metal Star',
      'symbol': '⚔️',
      'essence': 'Tireless work ethic, fiscal acuity, pragmatic tenacity.',
      'advice': 'Tempering unyielding grit with emotional warmth elevates your empire.',
      'color': Color(0xFFE67E22),
    },
    {
      'name': 'Tian Tong (天同 - The Child of Fortune)',
      'element': 'Water',
      'archetype': 'The Harmonious Optimist',
      'ruler': 'Fortunate Water Star',
      'symbol': '🕊️',
      'essence': 'Contentment, artistic sensibility, peace, fortunate ease.',
      'advice': 'Cultivate rigorous ambition to match your natural blessings.',
      'color': Color(0xFF2980B9),
    },
    {
      'name': 'Lian Zhen (廉贞 - The Diplomatic Fire)',
      'element': 'Fire',
      'archetype': 'The Charismatic Diplomat',
      'ruler': 'Secondary Peach Blossom Star',
      'symbol': '🔥',
      'essence': 'Passionate conviction, political finesse, loyalty.',
      'advice': 'Channel intense inner emotions into principled public triumphs.',
      'color': Color(0xFFC0392B),
    },
    {
      'name': 'Tian Fu (天府 - The Heavenly Treasury)',
      'element': 'Earth',
      'archetype': 'The Chancellor & Keeper of Abundance',
      'ruler': 'Southern Dipper Prime Star',
      'symbol': '🏛️',
      'essence': 'Financial stability, administrative excellence, graceful hospitality.',
      'advice': 'Guard your treasury with vision rather than conservative fear.',
      'color': Color(0xFF8E44AD),
    },
    {
      'name': 'Tai Yin (太阴 - The Serene Moon)',
      'element': 'Water',
      'archetype': 'The Intuitive Guardian & Nurturer',
      'ruler': 'Lunar Luminary',
      'symbol': '🌙',
      'essence': 'Profound intuition, refined elegance, quiet wealth accumulation.',
      'advice': 'Step boldly out of the shadows; let the world see your creative genius.',
      'color': Color(0xFF16A085),
    },
    {
      'name': 'Tan Lang (贪狼 - The Hungry Wolf / Catalyst)',
      'element': 'Wood / Water',
      'archetype': 'The Magnetic Explorer of Desires',
      'ruler': 'Primary Desire Star',
      'symbol': '🐺',
      'essence': 'Irresistible charisma, multidisciplinary talents, relentless ambition.',
      'advice': 'Align earthly worldly pursuits with esoteric spiritual wisdom.',
      'color': Color(0xFFD35400),
    },
    {
      'name': 'Qi Sha (七杀 - The Seven Killings / Vanguard)',
      'element': 'Metal / Fire',
      'archetype': 'The Fearless Lone General',
      'ruler': 'Vanguard Star',
      'symbol': '🛡️',
      'essence': 'Heroic audacity, independent self-reliance, breakthrough momentum.',
      'advice': 'True courage masters restraint; choose battles of enduring consequence.',
      'color': Color(0xFF7F8C8D),
    },
  ];

  static ZiWeiChart calculate(UserProfile profile) {
    final date = profile.birthDate;
    final hour = profile.birthTime.hour;

    // Life Palace branch calculation: month and hour combination in Chinese astrology
    final lifeBranchIndex = (date.month - (hour ~/ 2) + 12) % 12;
    final starIndex = (date.year + date.month + date.day + hour) % majorStars.length;
    final star = majorStars[starIndex];

    final branchNames = [
      'Zi (North)', 'Chou (NNE)', 'Yin (ENE)', 'Mao (East)',
      'Chen (ESE)', 'Si (SSE)', 'Wu (South)', 'Wei (SSW)',
      'Shen (WSW)', 'You (West)', 'Xu (WNW)', 'Hai (NNW)'
    ];

    return ZiWeiChart(
      signName: star['name'] as String,
      symbol: star['symbol'] as String,
      element: star['element'] as String,
      rulingForce: star['ruler'] as String,
      essence: star['essence'] as String,
      destinyAdvice: star['advice'] as String,
      accentColor: star['color'] as Color,
      lifePalaceBranch: branchNames[lifeBranchIndex],
      dominantArchetype: star['archetype'] as String,
      favorablePalaces: [
        palaces[0],
        palaces[4], // Wealth
        palaces[8], // Career
      ],
    );
  }
}
