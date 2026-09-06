import 'dart:math';
import 'package:flutter/material.dart';
import '../../models/cultural_profiles.dart';
import '../../models/user_profile.dart';

class NorseRuneData {
  final String name;
  final String symbol;
  final String aett;
  final String element;
  final String translation;
  final String divineAdvice;

  const NorseRuneData({
    required this.name,
    required this.symbol,
    required this.aett,
    required this.element,
    required this.translation,
    required this.divineAdvice,
  });
}

class NorseRuneCalculator {
  static const List<NorseRuneData> runes = [
    NorseRuneData(name: 'Fehu', symbol: 'ᚠ', aett: "Freyr's Aett", element: 'Fire / Earth', translation: 'Cattle, Mobile Wealth, Primal Energy', divineAdvice: 'Circulate abundance with generosity; stagnated wealth breeds spiritual decay.'),
    NorseRuneData(name: 'Uruz', symbol: 'ᚢ', aett: "Freyr's Aett", element: 'Earth', translation: 'Aurochs, Untamed Vitality, Raw Power', divineAdvice: 'Harness primal raw vitality; endure trials without breaking your inner spirit.'),
    NorseRuneData(name: 'Thurisaz', symbol: 'ᚦ', aett: "Freyr's Aett", element: 'Fire', translation: 'Giant, Thor’s Hammer, Active Defense', divineAdvice: 'Strike only when necessary to protect sacred boundaries; avoid reckless anger.'),
    NorseRuneData(name: 'Ansuz', symbol: 'ᚨ', aett: "Freyr's Aett", element: 'Air', translation: 'Odin, Divine Breath, Inspired Word', divineAdvice: 'Listen for sacred counsel in quiet winds; speak only what aligns with higher truth.'),
    NorseRuneData(name: 'Raidho', symbol: 'ᚱ', aett: "Freyr's Aett", element: 'Air / Fire', translation: 'Wagon, Journey, Cosmic Order', divineAdvice: 'Stay centered through cyclical journeys; alignment with natural law guarantees progress.'),
    NorseRuneData(name: 'Kenaz', symbol: 'ᚲ', aett: "Freyr's Aett", element: 'Fire', translation: 'Torch, Craftsmanship, Revelation', divineAdvice: 'Ignite the torch of creative brilliance to banish shadows of doubt and ignorance.'),
    NorseRuneData(name: 'Gebo', symbol: 'ᚷ', aett: "Freyr's Aett", element: 'Air', translation: 'Gift, Mutual Exchange, Sacred Alliance', divineAdvice: 'Reciprocity sustains all holy bonds; give freely without strings of obligation.'),
    NorseRuneData(name: 'Wunjo', symbol: 'ᚹ', aett: "Freyr's Aett", element: 'Earth / Air', translation: 'Joy, Fellowship, Harmonious Fruition', divineAdvice: 'Celebrate authentic victory with kindred kin; joy is a spiritual defense.'),
    NorseRuneData(name: 'Hagalaz', symbol: 'ᚺ', aett: "Hagal's Aett", element: 'Ice / Water', translation: 'Hailstone, Cosmic Egg, Disruptive Crisis', divineAdvice: 'Allow obsolete structures to shatter; crisis clears the soil for divine renewal.'),
    NorseRuneData(name: 'Nauthiz', symbol: 'ᚾ', aett: "Hagal's Aett", element: 'Fire / Ice', translation: 'Need, Constraint, Turning Distress to Strength', divineAdvice: 'Master friction and necessity; self-discipline converts hardship into mastery.'),
    NorseRuneData(name: 'Isa', symbol: 'ᛁ', aett: "Hagal's Aett", element: 'Ice', translation: 'Ice, Stillness, Contemplative Pause', divineAdvice: 'Freeze rash impulses; winter invites deep subterranean introspection.'),
    NorseRuneData(name: 'Jera', symbol: 'ᛃ', aett: "Hagal's Aett", element: 'Earth', translation: 'Year, Bountiful Harvest, Patience', divineAdvice: 'Tend your crops in due season; righteous work ripens in its destined hour.'),
    NorseRuneData(name: 'Eihwaz', symbol: 'ᛇ', aett: "Hagal's Aett", element: 'All Elements / Yggdrasil', translation: 'Yew Tree, Axis Mundi, Death & Rebirth', divineAdvice: 'Anchor into the cosmic tree; flexibility and endurance bridge life and eternity.'),
    NorseRuneData(name: 'Perthro', symbol: 'ᛈ', aett: "Hagal's Aett", element: 'Water', translation: 'Dice Cup, Mystery, The Well of Wyrd', divineAdvice: 'Trust the unfolding destiny cast by the Norns; welcome sacred chance.'),
    NorseRuneData(name: 'Algiz', symbol: 'ᛉ', aett: "Hagal's Aett", element: 'Air', translation: 'Elk, Shield of Protection, Higher Self', divineAdvice: 'Reach your antlers to heaven; divine guardian wards envelope you in danger.'),
    NorseRuneData(name: 'Sowilo', symbol: 'ᛋ', aett: "Hagal's Aett", element: 'Fire', translation: 'Sun, Supreme Victory, Solar Radiance', divineAdvice: 'Blaze with undivided integrity; solar power dissolves all deceit and darkness.'),
    NorseRuneData(name: 'Tiwaz', symbol: 'ᛏ', aett: "Tyr's Aett", element: 'Air / Fire', translation: 'Tyr, Just Sacrifice, Cosmic Law', divineAdvice: 'Uphold sworn oaths and honorable justice, even when sacrifice is demanded.'),
    NorseRuneData(name: 'Berkano', symbol: 'ᛒ', aett: "Tyr's Aett", element: 'Earth', translation: 'Birch Goddess, Sanctuary, Nurturing Birth', divineAdvice: 'Shelter tender new ideas with maternal patience; protect fragile beginnings.'),
    NorseRuneData(name: 'Ehwaz', symbol: 'ᛖ', aett: "Tyr's Aett", element: 'Earth / Water', translation: 'Two Horses, Partnership, Steady Momentum', divineAdvice: 'Walk in trust with loyal companions; synergy doubles distance covered.'),
    NorseRuneData(name: 'Mannaz', symbol: 'ᛗ', aett: "Tyr's Aett", element: 'Air', translation: 'Humanity, Collective Intellect, Self-Knowledge', divineAdvice: 'Know thyself within the great woven tapestry of the human clan.'),
    NorseRuneData(name: 'Laguz', symbol: 'ᛚ', aett: "Tyr's Aett", element: 'Water', translation: 'Ocean Water, Flow, Intuitive Undercurrent', divineAdvice: 'Surrender to oceanic intuition; ride currents rather than wrestling storms.'),
    NorseRuneData(name: 'Ingwaz', symbol: 'ᛜ', aett: "Tyr's Aett", element: 'Earth / Water', translation: 'Earth God Ing, Gestation, Latent Potential', divineAdvice: 'Rest in cocooned gestation; silent inner integration precedes great emergence.'),
    NorseRuneData(name: 'Dagaz', symbol: 'ᛞ', aett: "Tyr's Aett", element: 'Fire / Air', translation: 'Daylight, Dawn, Sudden Enlightenment', divineAdvice: 'Step boldly across the twilight threshold into the dawn of full realization.'),
    NorseRuneData(name: 'Othala', symbol: 'ᛟ', aett: "Tyr's Aett", element: 'Earth', translation: 'Ancestral Homeland, Spiritual Inheritance', divineAdvice: 'Honor your ancestral roots and build enduring sovereign sanctuaries.'),
  ];

  static NorseRuneChart calculate(UserProfile profile) {
    final date = profile.birthDate;
    final hour = profile.birthTime.hour;

    // Day of year mapped across 24 half-month solar rune periods
    final dayOfYear = date.difference(DateTime(date.year, 1, 1)).inDays;
    final solarIndex = ((dayOfYear / 365.25) * 24).floor() % 24;
    final hourIndex = hour % 24;

    final sunRune = runes[solarIndex];
    final hourRune = runes[hourIndex];

    return NorseRuneChart(
      signName: '${sunRune.name} (${sunRune.translation})',
      symbol: sunRune.symbol,
      element: sunRune.element,
      rulingForce: '${sunRune.aett} | Hour Rune: ${hourRune.name} (${hourRune.symbol})',
      essence: sunRune.translation,
      destinyAdvice: sunRune.divineAdvice,
      accentColor: const Color(0xFF3498DB),
      hourRuneName: hourRune.name,
      hourRuneSymbol: hourRune.symbol,
      aettGroup: sunRune.aett,
    );
  }

  static NorseRuneData castRandomRune() {
    final rand = Random();
    return runes[rand.nextInt(runes.length)];
  }
}
