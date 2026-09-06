import 'package:flutter/material.dart';
import '../../models/cultural_profiles.dart';
import '../../models/user_profile.dart';

class MayanCalculator {
  static const int gmtCorrelation = 584283;

  static const List<Map<String, String>> nahuals = [
    {'name': 'Imix (Red Dragon)', 'direction': 'East', 'element': 'Water / Primordial Earth', 'symbol': '🐊', 'meaning': 'Source of life, ancient memory, nurturance, new beginnings.'},
    {'name': 'Ik (White Wind)', 'direction': 'North', 'element': 'Air / Spirit', 'symbol': '🌬️', 'meaning': 'Breath of life, spiritual communication, inspired voice, agility.'},
    {'name': 'Akbal (Blue Night)', 'direction': 'West', 'element': 'Ether / Abundance', 'symbol': '🌌', 'meaning': 'Dreamtime temple, introspection, subconscious intuition, mystery.'},
    {'name': 'Kan (Yellow Seed)', 'direction': 'South', 'element': 'Fire / Germination', 'symbol': '🌱', 'meaning': 'Targeted intention, dynamic blossoming, potential, fertile focus.'},
    {'name': 'Chicchan (Red Serpent)', 'direction': 'East', 'element': 'Earth / Kundalini', 'symbol': '🐍', 'meaning': 'Vital life-force, instinctual wisdom, passion, cellular vitality.'},
    {'name': 'Cimi (White World-Bridger)', 'direction': 'North', 'element': 'Air / Surrender', 'symbol': '💀', 'meaning': 'Transmutation, releasing the old, bridging realms, peace.'},
    {'name': 'Manik (Blue Hand)', 'direction': 'West', 'element': 'Water / Completion', 'symbol': '✋', 'meaning': 'Spiritual healing, accomplishment, sacred craftsmanship, integrity.'},
    {'name': 'Lamat (Yellow Star)', 'direction': 'South', 'element': 'Fire / Harmony', 'symbol': '⭐', 'meaning': 'Artistic beauty, elegance, cosmic alignment, radiant grace.'},
    {'name': 'Muluc (Red Moon)', 'direction': 'East', 'element': 'Water / Purification', 'symbol': '🌕', 'meaning': 'Universal water, flow of gratitude, awakening divine consciousness.'},
    {'name': 'Oc (White Dog)', 'direction': 'North', 'element': 'Air / Loyalty', 'symbol': '🐕', 'meaning': 'Heart devotion, companion guidance, emotional honesty, soul-love.'},
    {'name': 'Chuen (Blue Monkey)', 'direction': 'West', 'element': 'Water / Play', 'symbol': '🐒', 'meaning': 'Divine weaver of illusions, artistic humor, cosmic playfulness.'},
    {'name': 'Eb (Yellow Human)', 'direction': 'South', 'element': 'Fire / Free Will', 'symbol': '🏺', 'meaning': 'Vessel of higher consciousness, responsible stewardship, free choice.'},
    {'name': 'Ben (Red Skywalker)', 'direction': 'East', 'element': 'Earth / Courage', 'symbol': '🎋', 'meaning': 'Pillars of heaven, exploration, bold boundaries, spiritual quest.'},
    {'name': 'Ix (White Wizard)', 'direction': 'North', 'element': 'Air / Timelessness', 'symbol': '🧙', 'meaning': 'Shamanic wisdom, heart knowing, enchantment, integrity in present.'},
    {'name': 'Men (Blue Eagle)', 'direction': 'West', 'element': 'Water / Vision', 'symbol': '🦅', 'meaning': 'Planetary broad perspective, visionary creation, soaring hope.'},
    {'name': 'Cib (Yellow Warrior)', 'direction': 'South', 'element': 'Fire / Intelligence', 'symbol': '🦉', 'meaning': 'Graceful fearlessness, cosmic questioning, ancestral guidance.'},
    {'name': 'Caban (Red Earth)', 'direction': 'East', 'element': 'Earth / Navigation', 'symbol': '🌍', 'meaning': 'Synchronicity, tracking earth energy, mental evolution, alignment.'},
    {'name': 'Etznab (White Mirror)', 'direction': 'North', 'element': 'Air / Truth', 'symbol': '🪞', 'meaning': 'Reflecting absolute reality, clarity, cutting through illusion.'},
    {'name': 'Cauac (Blue Storm)', 'direction': 'West', 'element': 'Water / Catalyzation', 'symbol': '⚡', 'meaning': 'Self-generation, thunderous transformation, cleansing purification.'},
    {'name': 'Ahau (Yellow Sun)', 'direction': 'South', 'element': 'Fire / Enlightenment', 'symbol': '☀️', 'meaning': 'Universal solar Christ consciousness, total wholeness, mastery.'},
  ];

  static const List<String> galacticTones = [
    'Tone 1: Magnetic (Purpose & Attraction)',
    'Tone 2: Lunar (Polarity & Challenge)',
    'Tone 3: Electric (Activation & Service)',
    'Tone 4: Self-Existing (Form & Definition)',
    'Tone 5: Overtone (Radiance & Empowerment)',
    'Tone 6: Rhythmic (Equality & Balance)',
    'Tone 7: Resonant (Attunement & Channeling)',
    'Tone 8: Galactic (Integrity & Harmonization)',
    'Tone 9: Solar (Intention & Pulsing)',
    'Tone 10: Planetary (Manifestation & Perfection)',
    'Tone 11: Spectral (Liberation & Dissolution)',
    'Tone 12: Crystal (Cooperation & Synthesis)',
    'Tone 13: Cosmic (Transcendence & Presence)',
  ];

  static MayanChart calculate(UserProfile profile) {
    final date = profile.birthDate;
    final jdn = _julianDayNumber(date.year, date.month, date.day);

    // Standard Mayan Kin calculation
    final kinZeroIndex = (jdn - gmtCorrelation) % 260;
    final kinNumber = kinZeroIndex <= 0 ? kinZeroIndex + 260 : kinZeroIndex;

    final toneIndex = (kinNumber - 1) % 13;
    final nahualIndex = (kinNumber - 1) % 20;

    final tone = toneIndex + 1;
    final nahual = nahuals[nahualIndex];
    final toneName = galacticTones[toneIndex];
    final fullName = 'Kin $kinNumber: Tone $tone ${nahual['name']}';

    return MayanChart(
      signName: fullName,
      symbol: nahual['symbol']!,
      element: nahual['element']!,
      rulingForce: '$toneName | Sacred Direction: ${nahual['direction']}',
      essence: nahual['meaning']!,
      destinyAdvice: 'Honor your sacred Kin $kinNumber signature: live as an embodied conduit of ${nahual['name']}.',
      accentColor: _getDirectionColor(nahual['direction']!),
      kinNumber: kinNumber,
      tone: tone,
      nahualName: nahual['name']!,
      sacredDirection: nahual['direction']!,
    );
  }

  static int _julianDayNumber(int y, int m, int d) {
    if (m <= 2) {
      y -= 1;
      m += 12;
    }
    final a = (y / 100).floor();
    final b = 2 - a + (a / 4).floor();
    return (365.25 * (y + 4716)).floor() + (30.6001 * (m + 1)).floor() + d + b - 1524;
  }

  static Color _getDirectionColor(String direction) {
    switch (direction) {
      case 'East':
        return const Color(0xFFE74C3C); // Red
      case 'North':
        return const Color(0xFFECF0F1); // White
      case 'West':
        return const Color(0xFF2980B9); // Blue
      case 'South':
      default:
        return const Color(0xFFF1C40F); // Yellow
    }
  }
}
