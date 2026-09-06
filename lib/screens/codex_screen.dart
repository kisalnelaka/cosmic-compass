import 'package:flutter/material.dart';
import '../theme/hand_drawn_tokens.dart';
import '../widgets/hand_drawn_card.dart';

class CodexEntry {
  final String title;
  final String origin;
  final String primaryCycle;
  final String description;
  final String authorityStandard;
  final List<String> authoritativeResources;
  final String icon;
  final Color color;

  const CodexEntry({
    required this.title,
    required this.origin,
    required this.primaryCycle,
    required this.description,
    required this.authorityStandard,
    required this.authoritativeResources,
    required this.icon,
    required this.color,
  });
}

class CodexScreen extends StatelessWidget {
  const CodexScreen({super.key});

  static const List<CodexEntry> entries = [
    CodexEntry(
      title: 'Oha Asa Morning TV Horoscope',
      origin: 'Japan (Asahi Broadcasting Corporation)',
      primaryCycle: 'Daily 12-Western Signs Morning Ranking',
      description:
          'Oha Asa (おはよう朝日です / Good Morning Morning) ranks the 12 signs daily based on TV Asahi astrologers. It provides concrete, actionable lucky items, colors, and 4 specific luck vectors (Money, Love, Work, Health) designed to proactively shift your daily fortune.',
      authorityStandard: 'Live broadcast scraping and deterministic daily ephemeris algorithm.',
      authoritativeResources: [
        'TV Asahi Official Horoscope (tv-asahi.co.jp/goodmorning/uranai)',
        'ABC TV Japan (asahi.co.jp/ohaasa)',
        'Oha Asa Daily Archives & Broadcast Feeds',
      ],
      icon: '🌅',
      color: Color(0xFFFF416C),
    ),
    CodexEntry(
      title: 'Japanese Blood Type (Ketsuekigata)',
      origin: 'Japan & East Asia',
      primaryCycle: 'Biological Antigen Typology (A, B, AB, O)',
      description:
          'In Japanese culture, blood type (Ketsuekigata) is deeply integrated into interpersonal psychology, daily compatibility, workplace dynamics, and matchmaking. Type A represents meticulous harmony, Type B dynamic passion, Type AB rational dualism, and Type O ambitious leadership.',
      authorityStandard: 'Japan Blood Type Humanics Research Center and Nomi Toshitaka behavioral archives.',
      authoritativeResources: [
        'Japan Blood Type Humanics Research Center (humanics.jp)',
        'Furukawa Takeji & Masahiko Nomi Research Papers',
      ],
      icon: '🩸',
      color: Color(0xFF27AE60),
    ),
    CodexEntry(
      title: 'BaZi (Four Pillars) & Chinese Zodiac',
      origin: 'Ancient China (Han & Song Dynasties)',
      primaryCycle: 'Sexagenary (60-Year) Cycle & 24 Solar Terms (Jie Qi)',
      description:
          'BaZi translates your exact birth Year, Month, Day, and Hour into four pairs of Heavenly Stems and Earthly Branches, encompassing the 12 Zodiac animals, Yin/Yang polarities, and the Five Elements (Wood, Fire, Earth, Metal, Water).',
      authorityStandard: 'Purple Mountain Observatory astronomical solar terms and HKO Lunar conversion.',
      authoritativeResources: [
        'Hong Kong Observatory Gregorian-Lunar Tables (hko.gov.hk)',
        'Purple Mountain Observatory (Chinese Academy of Sciences)',
        'San Ming Tong Hui (《三命通会》) and Di Tian Sui Classical Texts',
      ],
      icon: '🐉',
      color: Color(0xFFE67E22),
    ),
    CodexEntry(
      title: 'Zi Wei Dou Shu (Purple Star Astrology)',
      origin: 'China (Five Dynasties & Song Dynasty)',
      primaryCycle: 'Lunar Calendar & 12 Life Palaces',
      description:
          'Known as the "Emperor’s Astrology", Zi Wei Dou Shu maps major stars across 12 specific life palaces (Ming/Self, Wealth, Career, Spouse, Health, Property, etc.), deriving personality archetypes and karmic flow from Polaris (The Emperor Star) and the Big Dipper constellations.',
      authorityStandard: 'Zi Wei Dou Shu Quan Shu (《紫微斗数全书》) classical canons.',
      authoritativeResources: [
        'Chinese Text Project (ctext.org) Classical Astrological Repositories',
        'National Central Library Lunar Ephemeris Manuscripts',
      ],
      icon: '👑',
      color: Color(0xFF9B51E0),
    ),
    CodexEntry(
      title: 'Vedic Astrology (Jyotish)',
      origin: 'Ancient India (Vedic Tradition)',
      primaryCycle: 'Sidereal Zodiac & 27 Nakshatras (Lunar Mansions)',
      description:
          'Jyotish ("Science of Light") uses the fixed-star sidereal zodiac, adjusting for axial precession via the Lahiri Ayanamsa (~24° offset). It evaluates individual destiny, karma, and timing through the 27 Nakshatras and Vimshottari Dasha planetary periods.',
      authorityStandard: 'Positional Astronomy Centre (Govt. of India) and NASA Swiss Ephemeris.',
      authoritativeResources: [
        'Positional Astronomy Centre, India Meteorological Dept (posac.amssdelhi.gov.in)',
        'NASA Swiss Ephemeris / Astrodienst (astro.com/swisseph)',
        'Brihat Parasara Hora Shastra (BPHS) Classical Compendium',
      ],
      icon: '🪷',
      color: Color(0xFFFF9933),
    ),
    CodexEntry(
      title: 'Nadi Astrology',
      origin: 'Tamil Nadu, South India',
      primaryCycle: 'Ancient Palm Leaf Destiny Inscriptions',
      description:
          'Nadi astrology is an ancient South Indian tradition where enlightened Rishis (Sage Agastya, Sage Bhrigu) recorded destiny readings on palm leaves. Charts correspond to 12 primary Kaandas (life chapters), illuminating karmic lessons and spiritual remediation.',
      authorityStandard: 'Saraswathi Mahal Library Palm-Leaf Manuscripts (Thanjavur, Tamil Nadu).',
      authoritativeResources: [
        'Saraswathi Mahal Library Ancient Manuscript Archives',
        'Agastya Samhita and Bhrigu Samhita Traditions',
      ],
      icon: '📜',
      color: Color(0xFFD4AF37),
    ),
    CodexEntry(
      title: 'Hellenistic & Western Astrology',
      origin: 'Babylon, Hellenistic Greece & Alexandria',
      primaryCycle: 'Tropical Solar Ecliptic & 12 Sun Signs',
      description:
          'Based on the seasonal equinoxes and solstices, Western astrology tracks the Sun, Moon, and planetary archetypes across the 12 signs and 12 houses. It excels at psychological mapping, personality evolution, and transit timing.',
      authorityStandard: 'NASA JPL Horizons Ephemeris and Claudius Ptolemy’s Tetrabiblos.',
      authoritativeResources: [
        'NASA JPL Horizons Ephemeris System (ssd.jpl.nasa.gov/horizons)',
        'Astrodienst Ephemeris Archive (astro.com)',
        'Project Hindsight Hellenistic Translations',
      ],
      icon: '☀️',
      color: Color(0xFF00E5FF),
    ),
    CodexEntry(
      title: 'Arabian & Persian Astrology',
      origin: 'Medieval Islamic Golden Age (Baghdad & Cairo)',
      primaryCycle: 'Planetary Hours & Mathematical Lots (Parts)',
      description:
          'Persian and Arab scholars refined mathematical horoscopy, calculating Arabic Parts (such as the Part of Fortune: Ascendant + Moon - Sun) and Chaldean planetary hours to determine auspicious electional timing windows for high-stakes decisions.',
      authorityStandard: 'Al-Biruni’s Kitab al-Tafhim and Warburg Institute Manuscripts.',
      authoritativeResources: [
        'Al-Biruni Institute of Oriental Studies Manuscripts',
        'Warburg Institute Classical Arabic Astrological Archives',
      ],
      icon: '⭐',
      color: Color(0xFFF1C40F),
    ),
    CodexEntry(
      title: "Mayan Tzolk'in Calendar",
      origin: 'Mesoamerica (Ancient Maya Civilization)',
      primaryCycle: 'Sacred 260-Day Count (13 Tones × 20 Nahuals)',
      description:
          'The Tzolk’in is a sacred ritual calendar aligning 20 solar glyphs (Nahuals / Day Signs) with 13 Galactic Tones. Your birth Kin number (1-260) reveals your cosmic energy signature, spiritual purpose, and sacred elemental direction.',
      authorityStandard: 'Goodman-Martínez-Thompson (GMT 584283) Astronomical Correlation.',
      authoritativeResources: [
        'Smithsonian National Museum of the American Indian (maya.nmai.si.edu)',
        'FAMSI / LACMA Mesoamerican Database (famsi.org)',
      ],
      icon: '🏛️',
      color: Color(0xFF3498DB),
    ),
    CodexEntry(
      title: 'Aztec Tonalpohualli',
      origin: 'Central Mexico (Mexica Empire)',
      primaryCycle: '260-Day Sacred Count (20 Trecenas of 13 Days)',
      description:
          'The sacred Aztec calendar assigns each day a trecena sign governed by cardinal directions, primordial deities (such as Quetzalcoatl and Tezcatlipoca), and natural elemental forces, providing an energetic signature for fate, warfare, and spiritual leadership.',
      authorityStandard: 'Codex Borgia, Codex Borbonicus, and Bernardino de Sahagún’s Florentine Codex.',
      authoritativeResources: [
        'Vatican Library (Codex Borgia Digitized MSS)',
        'National Institute of Anthropology and History (INAH Mexico)',
      ],
      icon: '🦅',
      color: Color(0xFFE74C3C),
    ),
    CodexEntry(
      title: 'Native American Medicine Wheel',
      origin: 'North America (Plains & Woodland Indigenous Peoples)',
      primaryCycle: 'Four Directions & Lunar Moons',
      description:
          'The Sacred Hoop / Medicine Wheel aligns the four directions (East, South, West, North) with seasonal life stages, animal totems, plant allies, and mineral spirits. Sun Bear’s contemporary synthesis maps the 12 moons to earth astrology.',
      authorityStandard: 'Sun Bear (Chippewa) Bear Tribe Earth Astrology records.',
      authoritativeResources: [
        'National Museum of the American Indian Historical Archives',
        'Traditional Cultural Educators Council Repositories',
      ],
      icon: '🪶',
      color: Color(0xFF1ABC9C),
    ),
    CodexEntry(
      title: 'Celtic Tree Astrology (Ogham)',
      origin: 'Ancient Ireland, Scotland & Gaul (Druidic)',
      primaryCycle: '13 Lunar Tree Months & Ogham Alphabet',
      description:
          'Ancient Druids assigned sacred native trees (Birch, Rowan, Ash, Oak, Hazel, Elder, etc.) to 13 lunar cycles throughout the year. Each sacred tree embodies distinct magical virtues, animal guides, and primal earth energies.',
      authorityStandard: 'Book of Ballymote (Ogham Tract) and Robert Graves’ White Goddess references.',
      authoritativeResources: [
        'Royal Irish Academy (RIA) Celtic Manuscripts',
        'Trinity College Dublin Library Special Collections',
      ],
      icon: '🌿',
      color: Color(0xFF2ECC71),
    ),
    CodexEntry(
      title: 'Norse Rune Astrology',
      origin: 'Scandinavia & Germanic Tribes (Viking Era)',
      primaryCycle: '24 Elder Futhark Half-Months & Three Aetts',
      description:
          'The 24 runes of the Elder Futhark are grouped into three Aetts (Freyr, Heimdall, Tyr) and mapped to 24 half-month solar periods. Each rune represents a cosmic law, primal godforce, and energetic archetype for divination and daily guidance.',
      authorityStandard: 'Kylver Stone & Vadstena Bracteate inscriptions, Icelandic Rune Poems.',
      authoritativeResources: [
        'National Historical Museum of Sweden (historiska.se)',
        'Arnamagnæan Manuscript Collection (Copenhagen)',
      ],
      icon: 'ᛟ',
      color: Color(0xFF34495E),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'RESEARCH & HERITAGE COMPENDIUM',
                  style: HandDrawnTokens.headingFont(
                    fontSize: 12.5,
                    fontWeight: FontWeight.w700,
                    color: HandDrawnTokens.markerRed,
                    letterSpacing: 2.0,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'The World Traditions Codex',
                  style: HandDrawnTokens.headingFont(
                    fontSize: 24,
                    fontWeight: FontWeight.w900,
                    color: HandDrawnTokens.pencilBlack,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  'Historical foundations, astronomical calculation methods, and authoritative references for each tradition represented in this application.',
                  style: HandDrawnTokens.bodyFont(
                    fontSize: 14,
                    color: HandDrawnTokens.erasedPencil,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          sliver: SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final entry = entries[index];
                return _buildCodexCard(entry);
              },
              childCount: entries.length,
            ),
          ),
        ),
        const SliverToBoxAdapter(child: SizedBox(height: 40)),
      ],
    );
  }

  Widget _buildCodexCard(CodexEntry entry) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: HandDrawnCard(
        decoration: HandDrawnCardDecoration.none,
        backgroundColor: HandDrawnTokens.cardWhite,
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: entry.color.withValues(alpha: 0.15),
                    borderRadius: HandDrawnTokens.wobblySm,
                    border: Border.all(color: HandDrawnTokens.pencilBlack, width: 2),
                  ),
                  child: Center(
                    child: Text(entry.icon, style: const TextStyle(fontSize: 24)),
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        entry.title,
                        style: HandDrawnTokens.headingFont(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: HandDrawnTokens.pencilBlack,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Row(
                        children: [
                          Icon(Icons.public_rounded, size: 14, color: HandDrawnTokens.pencilBlack),
                          const SizedBox(width: 4),
                          Expanded(
                            child: Text(
                              entry.origin,
                              style: HandDrawnTokens.bodyFont(
                                fontSize: 13.5,
                                color: HandDrawnTokens.erasedPencil,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: HandDrawnTokens.warmPaper,
                borderRadius: HandDrawnTokens.wobblySm,
                border: Border.all(color: HandDrawnTokens.pencilBlack, width: 1.5),
              ),
              child: Text(
                'Astronomical Cycle: ${entry.primaryCycle}',
                style: HandDrawnTokens.bodyFont(
                  fontSize: 13,
                  color: HandDrawnTokens.pencilBlack,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 14),
            Text(
              entry.description,
              style: HandDrawnTokens.bodyFont(
                fontSize: 14.5,
                height: 1.5,
                color: HandDrawnTokens.pencilBlack,
              ),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: HandDrawnTokens.warmPaper,
                borderRadius: HandDrawnTokens.wobblySm,
                border: Border.all(color: HandDrawnTokens.pencilBlack, width: 1.5),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.verified_outlined, size: 16, color: HandDrawnTokens.markerRed),
                      const SizedBox(width: 6),
                      Text(
                        'ASTRONOMICAL CALCULATION STANDARD',
                        style: HandDrawnTokens.headingFont(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          color: HandDrawnTokens.markerRed,
                          letterSpacing: 0.8,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(
                    entry.authorityStandard,
                    style: HandDrawnTokens.bodyFont(
                      fontSize: 13.5,
                      color: HandDrawnTokens.pencilBlack,
                      height: 1.35,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Icon(Icons.menu_book_rounded, size: 16, color: HandDrawnTokens.ballpointBlue),
                      const SizedBox(width: 6),
                      Text(
                        'AUTHORITATIVE SOURCES & ARCHIVES',
                        style: HandDrawnTokens.headingFont(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          color: HandDrawnTokens.ballpointBlue,
                          letterSpacing: 0.8,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  ...entry.authoritativeResources.map((res) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 5),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '• ',
                            style: TextStyle(
                              fontSize: 14,
                              color: HandDrawnTokens.ballpointBlue,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Expanded(
                            child: Text(
                              res,
                              style: HandDrawnTokens.bodyFont(
                                fontSize: 13,
                                color: HandDrawnTokens.pencilBlack,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
