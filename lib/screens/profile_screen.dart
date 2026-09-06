import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/user_profile.dart';
import '../models/cosmic_synthesis.dart';
import '../models/cultural_profiles.dart';
import '../services/profile_service.dart';
import '../widgets/glass_card.dart';

class ProfileScreen extends StatelessWidget {
  final UserProfile profile;
  final VoidCallback onEditProfile;

  const ProfileScreen({
    super.key,
    required this.profile,
    required this.onEditProfile,
  });

  @override
  Widget build(BuildContext context) {
    final synthesis = ProfileService.synthesize(profile);

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          // Cosmic Hero Header
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'MY COSMIC PROFILE',
                        style: GoogleFonts.outfit(
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFFFFD700),
                          letterSpacing: 3,
                        ),
                      ),
                      IconButton(
                        onPressed: onEditProfile,
                        icon: const Icon(Icons.edit_calendar_rounded, color: Color(0xFFFFD700)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  _buildArchetypeHero(synthesis),
                ],
              ),
            ),
          ),

          // Universal Synthesis Mantra
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              child: GlassCard(
                backgroundColor: const Color(0xFF1E1B4B).withValues(alpha: 0.7),
                borderColor: const Color(0xFF9B51E0).withValues(alpha: 0.4),
                borderRadius: 18,
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    const Text('✨', style: TextStyle(fontSize: 24)),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'UNIVERSAL SYNTHESIS MANTRA',
                            style: GoogleFonts.outfit(fontSize: 10, fontWeight: FontWeight.bold, color: const Color(0xFFFFD700)),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            synthesis.universalMantra,
                            style: GoogleFonts.outfit(
                              fontSize: 13,
                              fontStyle: FontStyle.italic,
                              color: Colors.white.withValues(alpha: 0.95),
                              height: 1.35,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Cultural Charts Title
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 18, 20, 10),
              child: Text(
                '11 Global Astrological Charts',
                style: GoogleFonts.outfit(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),

          // All 11+ Culture Cards
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                _buildCultureCard(synthesis.western, [
                  'Moon Sign: ${synthesis.western.moonSign}',
                  'Rising (Ascendant): ${synthesis.western.ascendantSign}',
                  'Modality: ${synthesis.western.modality}',
                ]),
                _buildCultureCard(synthesis.bazi, [
                  'Year Pillar: ${synthesis.bazi.yearPillar.displayName}',
                  'Month Pillar: ${synthesis.bazi.monthPillar.displayName}',
                  'Day Master: ${synthesis.bazi.dayMaster}',
                  'Hour Pillar: ${synthesis.bazi.hourPillar.displayName}',
                ]),
                _buildCultureCard(synthesis.ziwei, [
                  'Life Palace: ${synthesis.ziwei.lifePalaceBranch}',
                  'Major Star: ${synthesis.ziwei.dominantArchetype}',
                  'Auspicious Palaces: ${synthesis.ziwei.favorablePalaces.join(', ')}',
                ]),
                _buildCultureCard(synthesis.vedic, [
                  'Sidereal Sign: ${synthesis.vedic.signName}',
                  'Nakshatra: ${synthesis.vedic.nakshatra} (${synthesis.vedic.nakshatraDeity})',
                  'Vimshottari Dasha Lord: ${synthesis.vedic.dashaLord}',
                  'Lahiri Ayanamsa: ${synthesis.vedic.ayanamsaDegrees}°',
                ]),
                _buildCultureCard(synthesis.nadi, [
                  'Destiny Kaanda: ${synthesis.nadi.lifeChapterTitle}',
                  'Karmic Archetype: ${synthesis.nadi.karmicArchetype}',
                  'Sacred Remedy: ${synthesis.nadi.remedialMantra}',
                ]),
                _buildCultureCard(synthesis.mayan, [
                  'Kin Number: Kin ${synthesis.mayan.kinNumber} (1-260)',
                  'Galactic Tone: Tone ${synthesis.mayan.tone} of 13',
                  'Solar Seal / Nahual: ${synthesis.mayan.nahualName}',
                  'Sacred Direction: ${synthesis.mayan.sacredDirection}',
                ]),
                _buildCultureCard(synthesis.aztec, [
                  'Tonalpohualli Sign: ${synthesis.aztec.trecenaSign}',
                  'Cardinal Lord: ${synthesis.aztec.cardinalLord}',
                  'Patron Deity: ${synthesis.aztec.rulingForce}',
                ]),
                _buildCultureCard(synthesis.medicineWheel, [
                  'Totem Animal: ${synthesis.medicineWheel.signName}',
                  'Elemental Clan: ${synthesis.medicineWheel.elementalClan}',
                  'Plant Totem: ${synthesis.medicineWheel.plantTotem}',
                  'Mineral Totem: ${synthesis.medicineWheel.mineralTotem}',
                ]),
                _buildCultureCard(synthesis.celticTree, [
                  'Sacred Tree: ${synthesis.celticTree.signName}',
                  'Ogham Stave: ${synthesis.celticTree.oghamLetter}',
                  'Animal Familiar: ${synthesis.celticTree.animalGuide}',
                  'Lunar Period: ${synthesis.celticTree.lunarPeriod}',
                ]),
                _buildCultureCard(synthesis.norseRune, [
                  'Birth Sun Rune: ${synthesis.norseRune.signName}',
                  'Hour Rune: ${synthesis.norseRune.hourRuneName} (${synthesis.norseRune.hourRuneSymbol})',
                  'Aett Clan: ${synthesis.norseRune.aettGroup}',
                ]),
                _buildCultureCard(synthesis.bloodType, [
                  'Blood Type Archetype: ${synthesis.bloodType.signName}',
                  'Workplace Role: ${synthesis.bloodType.idealWorkplaceRole}',
                  'Social Synergy: ${synthesis.bloodType.compatibility}',
                ]),
                _buildCultureCard(synthesis.arabian, [
                  'Part of Fortune: ${synthesis.arabian.lotOfFortuneDegree}',
                  'Planetary Hour: ${synthesis.arabian.birthPlanetaryHour}',
                  'Golden Window: ${synthesis.arabian.auspiciousWindow}',
                ]),
                const SizedBox(height: 40),
              ]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildArchetypeHero(CosmicSynthesis synthesis) {
    return GlassCard(
      backgroundColor: const Color(0xFF161938).withValues(alpha: 0.9),
      borderColor: const Color(0xFFFFD700).withValues(alpha: 0.4),
      borderRadius: 24,
      padding: const EdgeInsets.all(22),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      synthesis.profile.name,
                      style: GoogleFonts.outfit(
                        fontSize: 24,
                        fontWeight: FontWeight.w900,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'Born ${synthesis.profile.birthDate.year}/${synthesis.profile.birthDate.month}/${synthesis.profile.birthDate.day} • ${synthesis.profile.cityName}',
                      style: TextStyle(fontSize: 12, color: Colors.white.withValues(alpha: 0.6)),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF8E2DE2), Color(0xFF4A00E0)],
                  ),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: const Color(0xFFFFD700)),
                ),
                child: Column(
                  children: [
                    Text(
                      '${synthesis.cosmicSynergyScore}%',
                      style: GoogleFonts.outfit(
                        fontSize: 18,
                        fontWeight: FontWeight.w900,
                        color: const Color(0xFFFFD700),
                      ),
                    ),
                    Text(
                      'ALIGNMENT',
                      style: GoogleFonts.outfit(fontSize: 9, fontWeight: FontWeight.bold, color: Colors.white70),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.06),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Row(
              children: [
                const Icon(Icons.shield_outlined, color: Color(0xFFFFD700), size: 20),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    synthesis.cosmicArchetypeTitle,
                    style: GoogleFonts.outfit(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFFFFD700),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCultureCard(CulturalSign chart, List<String> keyPoints) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: GlassCard(
        borderColor: chart.accentColor.withValues(alpha: 0.35),
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: chart.accentColor.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: chart.accentColor.withValues(alpha: 0.5)),
                  ),
                  child: Center(
                    child: Text(
                      chart.symbol,
                      style: const TextStyle(fontSize: 22),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        chart.systemName.toUpperCase(),
                        style: GoogleFonts.outfit(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: chart.accentColor,
                          letterSpacing: 1.5,
                        ),
                      ),
                      Text(
                        chart.signName,
                        style: GoogleFonts.outfit(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              chart.essence,
              style: TextStyle(fontSize: 13, height: 1.4, color: Colors.white.withValues(alpha: 0.85)),
            ),
            const SizedBox(height: 10),
            ...keyPoints.map((point) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 4),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('• ', style: TextStyle(color: chart.accentColor, fontWeight: FontWeight.bold)),
                    Expanded(
                      child: Text(
                        point,
                        style: const TextStyle(fontSize: 12, color: Colors.white70),
                      ),
                    ),
                  ],
                ),
              );
            }),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.04),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(Icons.lightbulb_outline, size: 14, color: Color(0xFFFFD700)),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Text(
                      chart.destinyAdvice,
                      style: TextStyle(fontSize: 11, fontStyle: FontStyle.italic, color: Colors.white.withValues(alpha: 0.9)),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
