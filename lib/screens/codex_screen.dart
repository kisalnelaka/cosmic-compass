import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widgets/glass_card.dart';

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
          'Oha Asa (おはよう朝日です / Good Morning Morning) ranks the 12 signs daily based on TV Asahi astrologers. It provides concrete, actionable lucky items, colors, and 4 specific luck vectors (Money, Love, Work, Health) designed to proactively shift one’s daily fortune.',
      authorityStandard: 'Live broadcast scraping & deterministic daily ephemeris algorithm.',
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
      authorityStandard: 'Japan Blood Type Humanics Research Center & Nomi Toshitaka behavioral archives.',
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
      authorityStandard: 'Purple Mountain Observatory astronomical solar terms & HKO Lunar conversion.',
      authoritativeResources: [
        'Hong Kong Observatory Gregorian-Lunar Tables (hko.gov.hk)',
        'Purple Mountain Observatory (Chinese Academy of Sciences)',
        'San Ming Tong Hui (《三命通会》) & Di Tian Sui Classical Texts',
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
      authorityStandard: 'Positional Astronomy Centre (Govt. of India) & NASA Swiss Ephemeris.',
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
        'Agastya Samhita & Bhrigu Samhita Traditions',
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
      authorityStandard: 'NASA JPL Horizons Ephemeris & Claudius Ptolemy’s Tetrabiblos.',
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
      authorityStandard: 'Al-Biruni’s Kitab al-Tafhim & Warburg Institute Manuscripts.',
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
      origin: 'Central Mexico (Nahua & Aztec Civilization)',
      primaryCycle: '260-Day Sacred Calendar of 20 Trecenas',
      description:
          'The Tonalpohualli ("count of days") governed divination, ceremonies, and character. Each of the 20 day signs (Cipactli, Ehecatl, Calli, etc.) combines with numbers 1 to 13 to designate divine patron deities and cardinal directions.',
      authorityStandard: 'Codex Borgia, Codex Borbonicus & INAH Archival Records.',
      authoritativeResources: [
        'Instituto Nacional de Antropología e Historia (INAH Mexico)',
        'Codex Borgia & Codex Fejérváry-Mayer Digital Archives',
      ],
      icon: '🐆',
      color: Color(0xFFC0392B),
    ),
    CodexEntry(
      title: 'Medicine Wheel Earth Astrology',
      origin: 'Indigenous North America',
      primaryCycle: '12 Moons & 4 Elemental Clans Earth Wheel',
      description:
          'The Medicine Wheel connects human life cycles to the seasonal rhythms of Mother Earth. Each individual is assigned a Totem Animal, Elemental Clan (Thunderbird, Turtle, Butterfly, Frog), plant totem, and mineral totem reflecting earth-wisdom.',
      authorityStandard: 'Sun Bear & Wabun Wind Earth Astrology records (Bear Tribe).',
      authoritativeResources: [
        'Smithsonian Center for Folklife and Cultural Heritage',
        'The Medicine Wheel: Earth Astrology by Sun Bear & Wabun Wind',
      ],
      icon: '🪶',
      color: Color(0xFF795548),
    ),
    CodexEntry(
      title: 'Celtic Tree Astrology',
      origin: 'Ancient British Isles & Gaul',
      primaryCycle: '13 Lunar Sacred Tree Months & Ogham Alphabet',
      description:
          'Druidic astrology honors 13 sacred trees (Birch, Rowan, Oak, Reed, etc.) linked to lunar months. Each sign carries an Ogham alphabet letter, an animal guide, and ancient poetic attributes.',
      authorityStandard: 'Book of Ballymote (Auraicept na n-Éces) & Royal Irish Academy.',
      authoritativeResources: [
        'Royal Irish Academy (RIA) Celtic Manuscript Collections',
        'Celtic Inscribed Stones Project (University of Glasgow)',
      ],
      icon: '🌳',
      color: Color(0xFF2E7D32),
    ),
    CodexEntry(
      title: 'Norse Runic Divination',
      origin: 'Ancient Scandinavia & Germanic Tribes',
      primaryCycle: '24 Elder Futhark Runes & Three Aettir',
      description:
          'Runes are sacred staves carved into wood and stone representing cosmic forces, gods (Odin, Thor, Freyr), and human lessons. Castings provide direct communion with Wyrd (destiny) and ancestral fortitude.',
      authorityStandard: 'Scandinavian Runic-text Database (Rundata, Uppsala University).',
      authoritativeResources: [
        'Arnamagnæan Manuscript Collection (University of Copenhagen)',
        'Uppsala University Rundata Archaeological Inscriptions Database',
      ],
      icon: 'ᚠ',
      color: Color(0xFF0284C7),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'TRADITIONS CODEX & SOURCES',
                    style: GoogleFonts.outfit(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFFFFD700),
                      letterSpacing: 2.5,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'The 11 Global Astrological Traditions',
                    style: GoogleFonts.outfit(
                      fontSize: 24,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'Historical foundations, astronomical calculation methods, and authoritative references for each tradition.',
                    style: TextStyle(fontSize: 13, color: Colors.white.withValues(alpha: 0.75), height: 1.4),
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
      child: GlassCard(
        borderColor: entry.color.withValues(alpha: 0.4),
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
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: entry.color.withValues(alpha: 0.5)),
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
                        style: GoogleFonts.outfit(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Row(
                        children: [
                          Icon(Icons.public_rounded, size: 13, color: entry.color),
                          const SizedBox(width: 4),
                          Expanded(
                            child: Text(
                              entry.origin,
                              style: TextStyle(
                                fontSize: 13,
                                color: entry.color,
                                fontWeight: FontWeight.w600,
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
                color: Colors.white.withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
              ),
              child: Text(
                'Astronomical Cycle: ${entry.primaryCycle}',
                style: const TextStyle(fontSize: 12, color: Colors.white, fontWeight: FontWeight.w500),
              ),
            ),
            const SizedBox(height: 14),
            Text(
              entry.description,
              style: TextStyle(
                fontSize: 14,
                height: 1.5,
                color: Colors.white.withValues(alpha: 0.9),
              ),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.black.withValues(alpha: 0.25),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.verified_outlined, size: 14, color: Color(0xFFFFD700)),
                      const SizedBox(width: 6),
                      Text(
                        'ASTRONOMICAL CALCULATION STANDARD',
                        style: GoogleFonts.outfit(fontSize: 11, fontWeight: FontWeight.bold, color: const Color(0xFFFFD700), letterSpacing: 0.8),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(
                    entry.authorityStandard,
                    style: const TextStyle(fontSize: 12.5, color: Colors.white, height: 1.35),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      const Icon(Icons.menu_book_rounded, size: 14, color: Color(0xFF00E5FF)),
                      const SizedBox(width: 6),
                      Text(
                        'AUTHORITATIVE SOURCES & ARCHIVES',
                        style: GoogleFonts.outfit(fontSize: 11, fontWeight: FontWeight.bold, color: const Color(0xFF00E5FF), letterSpacing: 0.8),
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
                          const Text('• ', style: TextStyle(fontSize: 12, color: Color(0xFF00E5FF), fontWeight: FontWeight.bold)),
                          Expanded(
                            child: Text(
                              res,
                              style: TextStyle(fontSize: 12, color: Colors.white.withValues(alpha: 0.85)),
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
