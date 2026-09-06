import 'package:flutter/material.dart';
import '../models/user_profile.dart';
import '../models/cosmic_synthesis.dart';
import '../models/cultural_profiles.dart';
import '../services/profile_service.dart';
import '../theme/hand_drawn_tokens.dart';
import '../widgets/hand_drawn_card.dart';
import '../widgets/hand_drawn_button.dart';

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
                      'MY COSMIC FIELD DOSSIER',
                      style: HandDrawnTokens.headingFont(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        color: HandDrawnTokens.markerRed,
                        letterSpacing: 2.0,
                      ),
                    ),
                    HandDrawnButton(
                      text: 'Edit Birth Details',
                      variant: HandDrawnButtonVariant.secondary,
                      onPressed: onEditProfile,
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                _buildArchetypeHero(context, synthesis),
              ],
            ),
          ),
        ),

        // Universal Synthesis Mantra / Note
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
            child: HandDrawnCard(
              decoration: HandDrawnCardDecoration.pin,
              backgroundColor: HandDrawnTokens.postItYellow,
              padding: const EdgeInsets.all(18),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('📌', style: TextStyle(fontSize: 22)),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'CORE PERSONAL AFFIRMATION',
                          style: HandDrawnTokens.headingFont(
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            color: HandDrawnTokens.pencilBlack,
                            letterSpacing: 1.2,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '"${synthesis.universalMantra}"',
                          style: HandDrawnTokens.bodyFont(
                            fontSize: 15.5,
                            fontStyle: FontStyle.italic,
                            color: HandDrawnTokens.pencilBlack,
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
                  style: HandDrawnTokens.headingFont(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: HandDrawnTokens.pencilBlack,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  'Calculated accurately from your exact birth date, time, and birthplace location',
                  style: HandDrawnTokens.bodyFont(
                    fontSize: 14,
                    color: HandDrawnTokens.erasedPencil,
                  ),
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
                'Sacred Remedy and Practice: ${synthesis.nadi.remedialMantra}',
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

  Widget _buildArchetypeHero(BuildContext context, CosmicSynthesis synthesis) {
    return HandDrawnCard(
      decoration: HandDrawnCardDecoration.tape,
      backgroundColor: HandDrawnTokens.cardWhite,
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
                      style: HandDrawnTokens.headingFont(
                        fontSize: 26,
                        fontWeight: FontWeight.w900,
                        color: HandDrawnTokens.pencilBlack,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'Born ${synthesis.profile.birthDate.year}/${synthesis.profile.birthDate.month.toString().padLeft(2, '0')}/${synthesis.profile.birthDate.day.toString().padLeft(2, '0')} • ${synthesis.profile.cityName}',
                      style: HandDrawnTokens.bodyFont(
                        fontSize: 14,
                        color: HandDrawnTokens.erasedPencil,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                decoration: BoxDecoration(
                  color: HandDrawnTokens.postItYellow,
                  borderRadius: HandDrawnTokens.wobblySm,
                  border: Border.all(color: HandDrawnTokens.pencilBlack, width: 2),
                  boxShadow: HandDrawnTokens.hardShadowSm,
                ),
                child: Column(
                  children: [
                    Text(
                      '${synthesis.cosmicSynergyScore}%',
                      style: HandDrawnTokens.headingFont(
                        fontSize: 20,
                        fontWeight: FontWeight.w900,
                        color: HandDrawnTokens.markerRed,
                      ),
                    ),
                    Text(
                      'HARMONY',
                      style: HandDrawnTokens.headingFont(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: HandDrawnTokens.pencilBlack,
                      ),
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
              color: HandDrawnTokens.warmPaper,
              borderRadius: HandDrawnTokens.wobblySm,
              border: Border.all(color: HandDrawnTokens.pencilBlack, width: 1.5),
            ),
            child: Row(
              children: [
                Icon(Icons.stars_rounded, color: HandDrawnTokens.markerRed, size: 22),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    synthesis.cosmicArchetypeTitle,
                    style: HandDrawnTokens.headingFont(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: HandDrawnTokens.pencilBlack,
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
      child: HandDrawnCard(
        decoration: HandDrawnCardDecoration.none,
        backgroundColor: HandDrawnTokens.cardWhite,
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
                    borderRadius: HandDrawnTokens.wobblySm,
                    border: Border.all(color: HandDrawnTokens.pencilBlack, width: 2),
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
                        style: HandDrawnTokens.headingFont(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          color: HandDrawnTokens.markerRed,
                          letterSpacing: 1.5,
                        ),
                      ),
                      Text(
                        chart.signName,
                        style: HandDrawnTokens.headingFont(
                          fontSize: 17.5,
                          fontWeight: FontWeight.bold,
                          color: HandDrawnTokens.pencilBlack,
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
              style: HandDrawnTokens.bodyFont(
                fontSize: 14.5,
                height: 1.5,
                color: HandDrawnTokens.pencilBlack,
              ),
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              decoration: BoxDecoration(
                color: HandDrawnTokens.warmPaper,
                borderRadius: HandDrawnTokens.wobblySm,
                border: Border.all(color: HandDrawnTokens.pencilBlack, width: 1.5),
              ),
              child: Column(
                children: keyPoints.map((point) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 3.5),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '• ',
                          style: TextStyle(
                            color: HandDrawnTokens.markerRed,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            point,
                            style: HandDrawnTokens.bodyFont(
                              fontSize: 13.5,
                              color: HandDrawnTokens.pencilBlack,
                              height: 1.35,
                            ),
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
                color: HandDrawnTokens.postItYellow.withValues(alpha: 0.6),
                borderRadius: HandDrawnTokens.wobblySm,
                border: Border.all(color: HandDrawnTokens.pencilBlack, width: 1.5),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.lightbulb_outline_rounded, size: 18, color: HandDrawnTokens.pencilBlack),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      chart.destinyAdvice,
                      style: HandDrawnTokens.bodyFont(
                        fontSize: 13.5,
                        fontStyle: FontStyle.italic,
                        color: HandDrawnTokens.pencilBlack,
                        height: 1.4,
                      ),
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
