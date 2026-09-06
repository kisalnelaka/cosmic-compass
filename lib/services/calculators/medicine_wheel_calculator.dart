import 'package:flutter/material.dart';
import '../../models/cultural_profiles.dart';
import '../../models/user_profile.dart';

class MedicineWheelCalculator {
  static const List<Map<String, dynamic>> moons = [
    {
      'startMonth': 12, 'startDay': 22, 'endMonth': 1, 'endDay': 19,
      'moon': 'Earth Renewal Moon',
      'animal': 'Snow Goose',
      'clan': 'Turtle Clan (Earth)',
      'plant': 'Birch',
      'mineral': 'Quartz Crystal',
      'direction': 'North (Wisdom & Purity)',
      'symbol': '🪿',
      'essence': 'Patience, traditional wisdom, conservation, far-reaching vision.',
      'advice': 'Trust slow, intentional growth; preserve core foundations.',
      'color': Color(0xFFBDC3C7),
    },
    {
      'startMonth': 1, 'startDay': 20, 'endMonth': 2, 'endDay': 18,
      'moon': 'Rest and Cleansing Moon',
      'animal': 'Otter',
      'clan': 'Butterfly Clan (Air)',
      'plant': 'Silver Birch',
      'mineral': 'Silver',
      'direction': 'North (Clarity & Innovation)',
      'symbol': '🦦',
      'essence': 'Playful humanitarian, visionary inventiveness, affectionate community.',
      'advice': 'Balance unconventional eccentricity with tangible communal service.',
      'color': Color(0xFF00C9FF),
    },
    {
      'startMonth': 2, 'startDay': 19, 'endMonth': 3, 'endDay': 20,
      'moon': 'Big Winds Moon',
      'animal': 'Cougar / Wolf',
      'clan': 'Frog Clan (Water)',
      'plant': 'Plantain',
      'mineral': 'Turquoise',
      'direction': 'North by East',
      'symbol': '🐺',
      'essence': 'Deep empathy, guardian intuition, mystical spirit journeys.',
      'advice': 'Ground intense psychic sensitivity with practical physical routines.',
      'color': Color(0xFF1ABC9C),
    },
    {
      'startMonth': 3, 'startDay': 21, 'endMonth': 4, 'endDay': 19,
      'moon': 'Budding Trees Moon',
      'animal': 'Red Hawk',
      'clan': 'Thunderbird Clan (Fire)',
      'plant': 'Dandelion',
      'mineral': 'Fire Opal',
      'direction': 'East (Illumination & Dawn)',
      'symbol': '🦅',
      'essence': 'Swift catalyst, courageous pioneer, sharp acute perception.',
      'advice': 'Pair fierce momentum with gentle compassion for fellow travelers.',
      'color': Color(0xFFE74C3C),
    },
    {
      'startMonth': 4, 'startDay': 20, 'endMonth': 5, 'endDay': 20,
      'moon': 'Frogs Return Moon',
      'animal': 'Beaver',
      'clan': 'Turtle Clan (Earth)',
      'plant': 'Blue Camas',
      'mineral': 'Chrysocolla',
      'direction': 'East by South',
      'symbol': '🦫',
      'essence': 'Master architect, persistent builder, practical stewardship.',
      'advice': 'Allow flexibility into your rigid plans; invite spontaneous wonder.',
      'color': Color(0xFF27AE60),
    },
    {
      'startMonth': 5, 'startDay': 21, 'endMonth': 6, 'endDay': 20,
      'moon': 'Cornplanting Moon',
      'animal': 'Deer',
      'clan': 'Butterfly Clan (Air)',
      'plant': 'Yarrow',
      'mineral': 'Moss Agate',
      'direction': 'South (Growth & Passion)',
      'symbol': '🦌',
      'essence': 'Alert sensitivity, melodic communication, gentle agility.',
      'advice': 'Center scattered nervous energy through quiet woodland retreats.',
      'color': Color(0xFFF1C40F),
    },
    {
      'startMonth': 6, 'startDay': 21, 'endMonth': 7, 'endDay': 22,
      'moon': 'Strong Sun Moon',
      'animal': 'Flicker / Woodpecker',
      'clan': 'Frog Clan (Water)',
      'plant': 'Wild Rose',
      'mineral': 'Carnelian',
      'direction': 'South (Emotional Depth)',
      'symbol': '🪵',
      'essence': 'Nurturing heart, sacred home keeper, rhythmic emotional rhythm.',
      'advice': 'Express feelings openly rather than retreating behind emotional walls.',
      'color': Color(0xFFE67E22),
    },
    {
      'startMonth': 7, 'startDay': 23, 'endMonth': 8, 'endDay': 22,
      'moon': 'Ripe Berries Moon',
      'animal': 'Sturgeon',
      'clan': 'Thunderbird Clan (Fire)',
      'plant': 'Raspberry',
      'mineral': 'Garnet',
      'direction': 'South by West',
      'symbol': '🐟',
      'essence': 'Ancient depth, magnetic sovereignty, authoritative strength.',
      'advice': 'True greatness lifts others; share the bounty of your lake.',
      'color': Color(0xFF9B59B6),
    },
    {
      'startMonth': 8, 'startDay': 23, 'endMonth': 9, 'endDay': 22,
      'moon': 'Harvest Moon',
      'animal': 'Brown Bear',
      'clan': 'Turtle Clan (Earth)',
      'plant': 'Violet',
      'mineral': 'Amethyst',
      'direction': 'West (Introspection & Strength)',
      'symbol': '🐻',
      'essence': 'Discernment, practical medicine, meticulous self-sufficiency.',
      'advice': 'Practice self-forgiveness alongside analytical self-improvement.',
      'color': Color(0xFF795548),
    },
    {
      'startMonth': 9, 'startDay': 23, 'endMonth': 10, 'endDay': 23,
      'moon': 'Ducks Flying Moon',
      'animal': 'Raven',
      'clan': 'Butterfly Clan (Air)',
      'plant': 'Mullein',
      'mineral': 'Bloodstone',
      'direction': 'West (Balance & Justice)',
      'symbol': '🪶',
      'essence': 'Diplomatic mediator, cosmic messenger, aesthetic elegance.',
      'advice': 'Make peaceful decisions that honor inner truth over outside pressure.',
      'color': Color(0xFF34495E),
    },
    {
      'startMonth': 10, 'startDay': 24, 'endMonth': 11, 'endDay': 21,
      'moon': 'Freeze Up Moon',
      'animal': 'Snake',
      'clan': 'Frog Clan (Water)',
      'plant': 'Thistle',
      'mineral': 'Malachite',
      'direction': 'West by North',
      'symbol': '🐍',
      'essence': 'Shamanic healer, regenerative power, shedding old wounds.',
      'advice': 'Forgive deeply to fully step into your healing potential.',
      'color': Color(0xFF16A085),
    },
    {
      'startMonth': 11, 'startDay': 22, 'endMonth': 12, 'endDay': 21,
      'moon': 'Long Snows Moon',
      'animal': 'Elk',
      'clan': 'Thunderbird Clan (Fire)',
      'plant': 'Black Spruce',
      'mineral': 'Obsidian',
      'direction': 'North (Stamina & Truth)',
      'symbol': '🦌',
      'essence': 'Stamina, nobility of speech, community warmth, spiritual hunting.',
      'advice': 'Pace your passionate quests to sustain enduring vitality.',
      'color': Color(0xFF2C3E50),
    },
  ];

  static MedicineWheelChart calculate(UserProfile profile) {
    final date = profile.birthDate;
    final m = date.month;
    final d = date.day;

    Map<String, dynamic>? matchedMoon;
    for (var item in moons) {
      final sm = item['startMonth'] as int;
      final sd = item['startDay'] as int;
      final em = item['endMonth'] as int;
      final ed = item['endDay'] as int;

      if (sm == 12 && em == 1) {
        if ((m == 12 && d >= sd) || (m == 1 && d <= ed)) {
          matchedMoon = item;
          break;
        }
      } else {
        if ((m == sm && d >= sd) || (m == em && d <= ed)) {
          matchedMoon = item;
          break;
        }
      }
    }

    matchedMoon ??= moons.first;

    return MedicineWheelChart(
      signName: '${matchedMoon['animal']} (${matchedMoon['moon']})',
      symbol: matchedMoon['symbol'] as String,
      element: (matchedMoon['clan'] as String).split('(').last.replaceAll(')', ''),
      rulingForce: '${matchedMoon['clan']} | Direction: ${matchedMoon['direction']}',
      essence: matchedMoon['essence'] as String,
      destinyAdvice: matchedMoon['advice'] as String,
      accentColor: matchedMoon['color'] as Color,
      elementalClan: matchedMoon['clan'] as String,
      plantTotem: matchedMoon['plant'] as String,
      mineralTotem: matchedMoon['mineral'] as String,
      direction: matchedMoon['direction'] as String,
    );
  }
}
