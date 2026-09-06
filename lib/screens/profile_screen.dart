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

    return CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          // Cosmic Hero Header
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'MY COSMIC BLUEPRINT',
                        style: GoogleFonts.outfit(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFFFFD700),
                          letterSpacing: 2.5,
                        ),
                      ),
                      TextButton.icon(
                        onPressed: onEditProfile,
                        icon: const Icon(Icons.edit_calendar_rounded, color: Color(0xFFFFD700), size: 16),
                        label: Text(
                          'Edit Birth Data',
                          style: GoogleFonts.outfit(
                            fontSize: 12.5,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFFFFD700),
                          ),
                        ),
                        style: TextButton.styleFrom(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          backgroundColor: Colors.white.withValues(alpha: 0.08),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  _buildArchetypeHero(synthesis),
                ],
              ),
            ),
          ),

          // Universal Synthesis Mantra
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
              child: GlassCard(
                backgroundColor: const Color(0xFF161E36).withValues(alpha: 0.85),
                borderColor: const Color(0xFF9B51E0).withValues(alpha: 0.4),
                borderRadius: 18,
                padding: const EdgeInsets.all(18),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('✨', style: TextStyle(fontSize: 24)),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'CORE PERSONAL AFFIRMATION',
                            style: GoogleFonts.outfit(
                              fontSize: 10.5,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFFFFD700),
                              letterSpacing: 1.2,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '"${synthesis.universalMantra}"',
                            style: GoogleFonts.outfit(
                              fontSize: 14,
                              fontStyle: FontStyle.italic,
                              color: Colors.white,
                              height: 1.45,
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
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Your Signs Across 11 World Traditions',
                    style: GoogleFonts.outfit(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    'Calculated accurately from your exact birth date, time, and location',
                    style: TextStyle(fontSize: 12.5, color: Colors.white.withValues(alpha: 0.7)),
                  ),
                ],
              ),
            ),
          ),

          // All 11+ Culture Cards
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                _buildCultureCard(synthesis.western, [
                  'Sun Sign: ${synthesis.western.signName}',
                  'Moon Sign (Inner Emotional Core): ${synthesis.western.moonSign}',
                  'Rising / Ascendant (Outer Persona): ${synthesis.western.ascendantSign}',
                  'Modality: ${synthesis.western.modality} Energy',
                ]),
                _buildCultureCard(synthesis.bazi, [
                  'Year Pillar: ${synthesis.bazi.yearPillar.displayName}',
                  'Month Pillar: ${synthesis.bazi.monthPillar.displayName}',
                  'Core Day Element (Day Master): ${synthesis.bazi.dayMaster}',
                  'Hour Pillar: ${synthesis.bazi.hourPillar.displayName}',
                ]),
                _buildCultureCard(synthesis.ziwei, [
                  'Life Palace (Ming Gong): ${synthesis.ziwei.lifePalaceBranch}',
                  'Dominant Star Archetype: ${synthesis.ziwei.dominantArchetype}',
                  'Key Auspicious Palaces: ${synthesis.ziwei.favorablePalaces.join(', ')}',
                ]),
                _buildCultureCard(synthesis.vedic, [
                  'Sidereal Sign: ${synthesis.vedic.signName}',
                  'Birth Lunar Mansion (Nakshatra): ${synthesis.vedic.nakshatra} (${synthesis.vedic.nakshatraDeity})',
                  'Planetary Period Ruler (Dasha Lord): ${synthesis.vedic.dashaLord}',
                  'Sidereal Equinox Correction (Lahiri): ${synthesis.vedic.ayanamsaDegrees}°',
                ]),
                _buildCultureCard(synthesis.nadi, [
                  'Destiny Chapter (Kaanda): ${synthesis.nadi.lifeChapterTitle}',
                  'Soul Purpose Archetype: ${synthesis.nadi.karmicArchetype}',
                  'Sacred Remedy / Practice: ${synthesis.nadi.remedialMantra}',
                ]),
                _buildCultureCard(synthesis.mayan, [
                  'Sacred Kin Number: Kin ${synthesis.mayan.kinNumber} of 260',
                  'Galactic Creative Tone: Tone ${synthesis.mayan.tone} of 13',
                  'Day Sign / Solar Seal (Nahual): ${synthesis.mayan.nahualName}',
                  'Sacred Compass Direction: ${synthesis.mayan.sacredDirection}',
                ]),
                _buildCultureCard(synthesis.aztec, [
                  'Tonalpohualli Sacred Sign: ${synthesis.aztec.trecenaSign}',
                  'Cardinal Direction Guardian: ${synthesis.aztec.cardinalLord}',
                  'Patron Natural Force: ${synthesis.aztec.rulingForce}',
                ]),
                _buildCultureCard(synthesis.medicineWheel, [
                  'Earth Totem Animal: ${synthesis.medicineWheel.signName}',
                  'Elemental Clan: ${synthesis.medicineWheel.elementalClan}',
                  'Botanical Ally (Plant Totem): ${synthesis.medicineWheel.plantTotem}',
                  'Earth Mineral Totem: ${synthesis.medicineWheel.mineralTotem}',
                ]),
                _buildCultureCard(synthesis.celticTree, [
                  'Sacred Tree Sign: ${synthesis.celticTree.signName}',
                  'Ancient Ogham Inscription: ${synthesis.celticTree.oghamLetter}',
                  'Celtic Animal Guide: ${synthesis.celticTree.animalGuide}',
                  'Lunar Season: ${synthesis.celticTree.lunarPeriod}',
                ]),
                _buildCultureCard(synthesis.norseRune, [
                  'Birth Sun Rune: ${synthesis.norseRune.signName}',
                  'Birth Hour Rune: ${synthesis.norseRune.hourRuneName} (${synthesis.norseRune.hourRuneSymbol})',
                  'Elder Futhark Clan: ${synthesis.norseRune.aettGroup}',
                ]),
                _buildCultureCard(synthesis.bloodType, [
                  'Blood Type Archetype: ${synthesis.bloodType.signName}',
                  'Natural Workplace Strengths: ${synthesis.bloodType.idealWorkplaceRole}',
                  'Interpersonal Compatibility: ${synthesis.bloodType.compatibility}',
                ]),
                _buildCultureCard(synthesis.arabian, [
                  'Lot of Fortune: ${synthesis.arabian.lotOfFortuneDegree}',
                  'Planetary Hour at Birth: ${synthesis.arabian.birthPlanetaryHour}',
                  'Auspicious Daily Window: ${synthesis.arabian.auspiciousWindow}',
                ]),
                const SizedBox(height: 40),
              ]),
            ),
          ),
        ],
      );
  }

  Widget _buildArchetypeHero(CosmicSynthesis synthesis) {
    return GlassCard(
      backgroundColor: const Color(0xFF131B32).withValues(alpha: 0.92),
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
                      'Born ${synthesis.profile.birthDate.year}/${synthesis.profile.birthDate.month.toString().padLeft(2, '0')}/${synthesis.profile.birthDate.day.toString().padLeft(2, '0')} • ${synthesis.profile.cityName}',
                      style: TextStyle(fontSize: 12.5, color: Colors.white.withValues(alpha: 0.65)),
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
                  border: Border.all(color: const Color(0xFFFFD700).withValues(alpha: 0.6)),
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
                      'HARMONY',
                      style: GoogleFonts.outfit(fontSize: 9.5, fontWeight: FontWeight.bold, color: Colors.white),
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
              border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
            ),
            child: Row(
              children: [
                const Icon(Icons.stars_rounded, color: Color(0xFFFFD700), size: 20),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    synthesis.cosmicArchetypeTitle,
                    style: GoogleFonts.outfit(
                      fontSize: 14.5,
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
                          fontSize: 10.5,
                          fontWeight: FontWeight.bold,
                          color: chart.accentColor,
                          letterSpacing: 1.5,
                        ),
                      ),
                      Text(
                        chart.signName,
                        style: GoogleFonts.outfit(
                          fontSize: 16.5,
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
              style: TextStyle(fontSize: 14, height: 1.5, color: Colors.white.withValues(alpha: 0.9)),
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.04),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
              ),
              child: Column(
                children: keyPoints.map((point) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 3.5),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('• ', style: TextStyle(color: chart.accentColor, fontWeight: FontWeight.bold, fontSize: 14)),
                        Expanded(
                          child: Text(
                            point,
                            style: const TextStyle(fontSize: 13, color: Colors.white, height: 1.35),
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFFFFD700).withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: const Color(0xFFFFD700).withValues(alpha: 0.25)),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(Icons.lightbulb_outline_rounded, size: 16, color: Color(0xFFFFD700)),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      chart.destinyAdvice,
                      style: const TextStyle(fontSize: 13, fontStyle: FontStyle.italic, color: Colors.white, height: 1.4),
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
