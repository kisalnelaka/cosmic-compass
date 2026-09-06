import 'package:flutter/material.dart';
import '../../models/cultural_profiles.dart';
import '../../models/user_profile.dart';

class AztecCalculator {
  static const List<Map<String, String>> aztecSigns = [
    {'name': 'Cipactli (Crocodile)', 'patron': 'Tonacatecuhtli (Lord of Sustenance)', 'direction': 'East', 'symbol': '🐊', 'meaning': 'Primordial beginning, fertile strength, unshakeable foundation.'},
    {'name': 'Ehecatl (Wind)', 'patron': 'Quetzalcoatl (Feathered Serpent)', 'direction': 'North', 'symbol': '🌬️', 'meaning': 'Intellectual movement, sudden breakthroughs, spiritual breath.'},
    {'name': 'Calli (House)', 'patron': 'Tepeyollotl (Heart of the Mountain)', 'direction': 'West', 'symbol': '🏠', 'meaning': 'Sanctuary, deep tranquility, preserving wisdom within the home.'},
    {'name': 'Cuetzpalin (Lizard)', 'patron': 'Huehuecoyotl (Old Coyote of Dance)', 'direction': 'South', 'symbol': '🦎', 'meaning': 'Endurance, survival agility, instinctual regeneration, vitality.'},
    {'name': 'Coatl (Serpent)', 'patron': 'Chalchiuhtlicue (Jade Skirt / Waters)', 'direction': 'East', 'symbol': '🐍', 'meaning': 'Transmutation of desire, earth energy, spiritual shedding of skins.'},
    {'name': 'Miquiztli (Death)', 'patron': 'Metztli & Tecciztecatl (Moon deities)', 'direction': 'North', 'symbol': '💀', 'meaning': 'Transformation through surrender, ancestral protection, quiet rebirth.'},
    {'name': 'Mazatl (Deer)', 'patron': 'Tlaloc (Lord of Rain & Storms)', 'direction': 'West', 'symbol': '🦌', 'meaning': 'Nobility, grace under threat, vigilant pace, sacred hunting instinct.'},
    {'name': 'Tochtli (Rabbit)', 'patron': 'Mayahuel (Goddess of Maguey & Joy)', 'direction': 'South', 'symbol': '🐇', 'meaning': 'Fertility, artistic abandon, prosperity, swift ingenuity.'},
    {'name': 'Atl (Water)', 'patron': 'Xiuhtecuhtli (Lord of Sacred Fire)', 'direction': 'East', 'symbol': '🌊', 'meaning': 'Purification through trials, emotional depth, flowing adaptability.'},
    {'name': 'Itzcuintli (Dog)', 'patron': 'Mictlantecuhtli (Lord of Underworld)', 'direction': 'North', 'symbol': '🐕', 'meaning': 'Absolute fidelity, guiding souls through darkness, brave loyalty.'},
    {'name': 'Ozomahtli (Monkey)', 'patron': 'Xochipilli (Prince of Flowers & Art)', 'direction': 'West', 'symbol': '🐒', 'meaning': 'Celebration, theatrical genius, humor, social charm.'},
    {'name': 'Malinalli (Grass)', 'patron': 'Patecatl (Lord of Medicinal Roots)', 'direction': 'South', 'symbol': '🌾', 'meaning': 'Resilience against fire, healing herbs, enduring humble tenacity.'},
    {'name': 'Acatl (Reed)', 'patron': 'Tezcatlipoca (Smoking Mirror)', 'direction': 'East', 'symbol': '🎋', 'meaning': 'Rigid moral authority, piercing truth, internal justice, archery of spirit.'},
    {'name': 'Ocelotl (Jaguar)', 'patron': 'Tlazolteotl (Eater of Impurities)', 'direction': 'North', 'symbol': '🐆', 'meaning': 'Nocturnal courage, warrior stealth, fierce protection of sacred ground.'},
    {'name': 'Cuauhtli (Eagle)', 'patron': 'Xipe Totec (Our Lord the Flayed One)', 'direction': 'West', 'symbol': '🦅', 'meaning': 'Solar elevation, sovereign clarity, heroic sacrifice, fearless sight.'},
    {'name': 'Cozcacuauhtli (Vulture)', 'patron': 'Itzapaplotl (Obsidian Butterfly)', 'direction': 'South', 'symbol': '🦃', 'meaning': 'Longevity, wisdom through experience, cleansing the collective soul.'},
    {'name': 'Ollin (Movement / Earthquake)', 'patron': 'Xolotl (Evening Star Companion)', 'direction': 'East', 'symbol': '🌀', 'meaning': 'Cosmic shift, decisive evolution, dynamic shaking of complacency.'},
    {'name': 'Tecpatl (Flint Knife)', 'patron': 'Chalchiuhtotolin (Jeweled Turkey)', 'direction': 'North', 'symbol': '🗡️', 'meaning': 'Sharp mental discernment, severing false ties, pristine clarity.'},
    {'name': 'Quiahuitl (Rain)', 'patron': 'Chantico (Goddess of Hearth Fire)', 'direction': 'West', 'symbol': '🌧️', 'meaning': 'Revitalizing emotional downpour, lightning inspiration, passionate warmth.'},
    {'name': 'Xochitl (Flower)', 'patron': 'Tonantzin (Beloved Earth Mother)', 'direction': 'South', 'symbol': '🌺', 'meaning': 'Culmination of beauty, poetic creation, blossoming of the radiant soul.'},
  ];

  static AztecChart calculate(UserProfile profile) {
    final date = profile.birthDate;
    final dayOfYear = date.difference(DateTime(date.year, 1, 1)).inDays;
    final index = (dayOfYear + (date.year * 5)) % aztecSigns.length;
    final sign = aztecSigns[index];
    final trecenaNum = (dayOfYear % 13) + 1;

    return AztecChart(
      signName: '$trecenaNum-${sign['name']!}',
      symbol: sign['symbol']!,
      element: sign['direction'] == 'East' || sign['direction'] == 'South' ? 'Fire / Earth' : 'Air / Water',
      rulingForce: 'Patron: ${sign['patron']!}',
      essence: sign['meaning']!,
      destinyAdvice: 'Draw upon the sacred energy of ${sign['name']}: navigate trials with honor and divine integrity.',
      accentColor: const Color(0xFFC0392B), // Aztec Terracotta Red
      trecenaSign: sign['name']!,
      cardinalLord: sign['direction']!,
    );
  }
}
