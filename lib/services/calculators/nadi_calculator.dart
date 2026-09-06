import 'package:flutter/material.dart';
import '../../models/cultural_profiles.dart';
import '../../models/user_profile.dart';

class NadiCalculator {
  static const List<Map<String, String>> kaandas = [
    {
      'chapter': 'Kaanda 1: The General Destiny (Shanti Kaanda)',
      'archetype': 'The Pilgrim of Transmutation',
      'lesson': 'Dissolving past ancestry burdens into service and wisdom.',
      'mantra': 'Om Namah Shivaya (Five sacred syllables of renewal)',
      'element': 'Ether / Akasha',
      'symbol': '📜',
    },
    {
      'chapter': 'Kaanda 2: The Treasury of Voice & Wealth',
      'archetype': 'The Sovereign Custodian',
      'lesson': 'Mastering honest articulation and sustaining rightful wealth.',
      'mantra': 'Om Shreem Mahalakshmiyei Namaha',
      'element': 'Earth',
      'symbol': '🪙',
    },
    {
      'chapter': 'Kaanda 3: The Courageous Brother-in-Arms',
      'archetype': 'The Fearless Defender of Truth',
      'lesson': 'Standing with brothers and sisters against spiritual apathy.',
      'mantra': 'Om Kartikeyaya Namaha (Mantra of Lord Murugan)',
      'element': 'Fire',
      'symbol': '🗡️',
    },
    {
      'chapter': 'Kaanda 4: The Sacred Mother & Sanctuary',
      'archetype': 'The Builder of Havens',
      'lesson': 'Honoring maternal roots and establishing grounded shelter.',
      'mantra': 'Om Dum Durgayei Namaha',
      'element': 'Water',
      'symbol': '🏡',
    },
    {
      'chapter': 'Kaanda 5: The Progeny & Past Merit (Purva Punya)',
      'archetype': 'The Bearer of Sacred Lineage',
      'lesson': 'Harvesting blessings of past lifetimes to uplift upcoming youth.',
      'mantra': 'Om Gam Ganapataye Namaha',
      'element': 'Fire',
      'symbol': '🔥',
    },
    {
      'chapter': 'Kaanda 6: The Alchemist of Adversity',
      'archetype': 'The Vanquisher of Hidden Afflictions',
      'lesson': 'Transmuting health tests and adversaries into spiritual fortitude.',
      'mantra': 'Om Tryambakam Yajamahe Sugandhim Pushtivardhanam',
      'element': 'Earth',
      'symbol': '🛡️',
    },
    {
      'chapter': 'Kaanda 7: The Sacred Union (Kalyana Kaanda)',
      'archetype': 'The Seeker of Divine Partnership',
      'lesson': 'Transcending ego in intimate union and spiritual matrimony.',
      'mantra': 'Om Kleem Krishnaya Namaha',
      'element': 'Air',
      'symbol': '💍',
    },
    {
      'chapter': 'Kaanda 8: The Mystic of Longevity (Ayur Kaanda)',
      'archetype': 'The Eternal Witness',
      'lesson': 'Unveiling esoteric occult mysteries and conquering fear of the unknown.',
      'mantra': 'Maha Mrityunjaya Mantra',
      'element': 'Water',
      'symbol': '⏳',
    },
    {
      'chapter': 'Kaanda 9: The Dharma Inheritor',
      'archetype': 'The Pilgrim of Guru Grace',
      'lesson': 'Sitting at the feet of wise masters and walking the righteous path.',
      'mantra': 'Om Gurave Namaha',
      'element': 'Fire',
      'symbol': '🪷',
    },
    {
      'chapter': 'Kaanda 10: The Sovereign of Works (Karma Kaanda)',
      'archetype': 'The Architect of Destined Calling',
      'lesson': 'Performing duty without attachment to the fruits of action.',
      'mantra': 'Om Suryaya Namaha',
      'element': 'Air',
      'symbol': '🏛️',
    },
    {
      'chapter': 'Kaanda 11: The Harvest of Aspirations (Labha Kaanda)',
      'archetype': 'The Manifestor of Universal Abundance',
      'lesson': 'Sharing communal prosperity and fulfilling noble lifelong dreams.',
      'mantra': 'Om Vishnave Namaha',
      'element': 'Ether',
      'symbol': '🌾',
    },
    {
      'chapter': 'Kaanda 12: The Seeker of Final Liberation (Moksha Kaanda)',
      'archetype': 'The Liberated Sage',
      'lesson': 'Surrendering material attachments to realize the luminous self.',
      'mantra': 'Om Tat Sat',
      'element': 'Water',
      'symbol': '🕊️',
    },
  ];

  static NadiChart calculate(UserProfile profile) {
    final date = profile.birthDate;
    final index = (date.day + date.month + (date.year % 100)) % kaandas.length;
    final data = kaandas[index];

    return NadiChart(
      signName: data['chapter']!,
      symbol: data['symbol']!,
      element: data['element']!,
      rulingForce: 'Sage Agastya & Sage Bhrigu Palm Leaf Inscriptions',
      essence: 'Archetype: ${data['archetype']}. Focus: ${data['lesson']}',
      destinyAdvice: 'Remedial prescription: Chant "${data['mantra']}" and practice sacred charity.',
      accentColor: const Color(0xFFD4AF37), // Vedic Gold
      karmicArchetype: data['archetype']!,
      lifeChapterTitle: data['chapter']!,
      remedialMantra: data['mantra']!,
    );
  }
}
