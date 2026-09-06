import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/user_profile.dart';
import '../models/cosmic_synthesis.dart';
import '../models/cultural_profiles.dart';
import '../services/profile_service.dart';
import '../services/daily_prediction_service.dart';
import '../services/partner_synastry_service.dart';
import '../widgets/glass_card.dart';
import '../widgets/elemental_radar_widget.dart';
import '../widgets/cultural_disclaimer_card.dart';
import 'partner_setup_dialog.dart';

class ComparisonScreen extends StatefulWidget {
  final UserProfile profile;

  const ComparisonScreen({super.key, required this.profile});

  @override
  State<ComparisonScreen> createState() => _ComparisonScreenState();
}

class _ComparisonScreenState extends State<ComparisonScreen> {
  String _selectedRegion = 'All';
  int _currentViewMode = 0; // 0: Overlap & Concordance, 1: Full Comparison Matrix, 2: Partner Synergy
  UserProfile? _partnerProfile;
  bool _isLoadingPartner = true;

  final List<String> _regions = [
    'All',
    'East Asian',
    'South Asian',
    'Greco-Roman & Arabian',
    'Indigenous Americas',
    'European Folk',
  ];

  @override
  void initState() {
    super.initState();
    _loadPartner();
  }

  Future<void> _loadPartner() async {
    final p = await PartnerSynastryService.loadPartnerProfile();
    if (mounted) {
      setState(() {
        _partnerProfile = p;
        _isLoadingPartner = false;
      });
    }
  }

  void _openPartnerDialog() {
    showDialog(
      context: context,
      builder: (context) => PartnerSetupDialog(
        initialPartner: _partnerProfile,
        onSave: (partner) async {
          setState(() => _partnerProfile = partner);
          await PartnerSynastryService.savePartnerProfile(partner);
        },
        onClear: () async {
          setState(() => _partnerProfile = null);
          await PartnerSynastryService.clearPartnerProfile();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final synthesis = ProfileService.synthesize(widget.profile);
    final dailyConsensus = DailyPredictionService.generateDailyConsensus(
      widget.profile,
      DateTime.now(),
    );

    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [
        // Header
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'CROSS-CULTURAL HARMONY',
                  style: GoogleFonts.outfit(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF00E5FF),
                    letterSpacing: 2.5,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  _currentViewMode == 2
                      ? 'Partner Synergy & Synastry'
                      : 'Where World Cultures Agree on You',
                  style: GoogleFonts.outfit(
                    fontSize: 24,
                    fontWeight: FontWeight.w900,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  _currentViewMode == 2
                      ? 'Synthesizing your birth profile with your partner across Western elements, Chinese BaZi trines, Japanese Ketsuekigata, Vedic Nakshatras, and Mayan Kin.'
                      : 'Across thousands of years and continents, independent civilizations developed unique cosmic systems. Here is where they arrive at identical conclusions about your personality and strengths.',
                  style: TextStyle(fontSize: 13, color: Colors.white.withValues(alpha: 0.75), height: 1.4),
                ),
              ],
            ),
          ),
        ),

        // Cultural Heritage & Pinch of Salt Disclaimer
        const SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 6),
            child: CulturalDisclaimerCard(compact: true),
          ),
        ),

        // View Switcher (Shared Traits vs 11 Traditions vs Partner Synergy)
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 14, 20, 10),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.white.withValues(alpha: 0.12)),
              ),
              child: Row(
                children: [
                  _buildTabButton(index: 0, label: 'Shared Traits'),
                  _buildTabButton(index: 1, label: '11 Traditions'),
                  _buildTabButton(index: 2, label: 'Partner Synergy', isSpecial: true),
                ],
              ),
            ),
          ),
        ),

        if (_currentViewMode == 0) ...[
          // OVERLAPS & CONCORDANCE VIEW

          // Elemental Balance
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              child: GlassCard(
                padding: const EdgeInsets.all(20),
                backgroundColor: const Color(0xFF13172E).withValues(alpha: 0.9),
                child: ElementalRadarWidget(balance: synthesis.elementalBalance),
              ),
            ),
          ),

          // Overlap Points Header
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Core Trait Convergences',
                          style: GoogleFonts.outfit(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          'Where at least 3 distinct world systems pinpoint the same trait',
                          style: TextStyle(fontSize: 12.5, color: Colors.white.withValues(alpha: 0.7)),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: const Color(0xFF00E5FF).withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: const Color(0xFF00E5FF).withValues(alpha: 0.4)),
                    ),
                    child: Text(
                      '${synthesis.convergences.length} Overlaps',
                      style: GoogleFonts.outfit(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF00E5FF),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Convergence Cards List
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final conv = synthesis.convergences[index];
                  return _buildConvergenceCard(conv);
                },
                childCount: synthesis.convergences.length,
              ),
            ),
          ),

          // Today's Prediction Overlaps Header
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Today’s Prediction Overlaps',
                    style: GoogleFonts.outfit(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    'Points where independent daily astrological cycles harmonize for your specific chart',
                    style: TextStyle(fontSize: 12.5, color: Colors.white.withValues(alpha: 0.7)),
                  ),
                ],
              ),
            ),
          ),

          // Daily Consensus Points
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final pt = dailyConsensus[index];
                  return _buildDailyConsensusCard(pt);
                },
                childCount: dailyConsensus.length,
              ),
            ),
          ),
        ] else if (_currentViewMode == 1) ...[
          // FULL 11 TRADITIONS COMPARATIVE MATRIX VIEW

          // Region Filter Chips
          SliverToBoxAdapter(
            child: SizedBox(
              height: 50,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                itemCount: _regions.length,
                itemBuilder: (context, index) {
                  final reg = _regions[index];
                  final isSelected = _selectedRegion == reg;
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: FilterChip(
                      selected: isSelected,
                      label: Text(
                        reg,
                        style: GoogleFonts.outfit(
                          fontSize: 12.5,
                          fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                          color: isSelected ? Colors.black : Colors.white70,
                        ),
                      ),
                      backgroundColor: Colors.white.withValues(alpha: 0.06),
                      selectedColor: const Color(0xFFFFD700),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      side: BorderSide(
                        color: isSelected ? const Color(0xFFFFD700) : Colors.white.withValues(alpha: 0.15),
                      ),
                      onSelected: (val) {
                        setState(() => _selectedRegion = reg);
                      },
                    ),
                  );
                },
              ),
            ),
          ),

          // Matrix List
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final filtered = _getFilteredSigns(synthesis);
                  final item = filtered[index];
                  return _buildComparisonItem(item);
                },
                childCount: _getFilteredSigns(synthesis).length,
              ),
            ),
          ),
        ] else ...[
          // PARTNER SYNERGY VIEW
          if (_isLoadingPartner) ...[
            const SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.all(40),
                child: Center(
                  child: CircularProgressIndicator(color: Color(0xFFEC4899)),
                ),
              ),
            ),
          ] else if (_partnerProfile == null) ...[
            SliverToBoxAdapter(
              child: _buildEmptyPartnerView(),
            ),
          ] else ...[
            _buildPartnerSynastryView(),
          ],
        ],
        const SliverToBoxAdapter(child: SizedBox(height: 40)),
      ],
    );
  }

  Widget _buildTabButton({
    required int index,
    required String label,
    bool isSpecial = false,
  }) {
    final isSelected = _currentViewMode == index;
    return Expanded(
      child: InkWell(
        onTap: () => setState(() => _currentViewMode = index),
        borderRadius: BorderRadius.circular(14),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 11),
          decoration: BoxDecoration(
            gradient: isSelected
                ? (isSpecial
                    ? const LinearGradient(colors: [Color(0xFFEC4899), Color(0xFF8B5CF6)])
                    : const LinearGradient(colors: [Color(0xFFFFD700), Color(0xFFFFA000)]))
                : null,
            borderRadius: BorderRadius.circular(14),
          ),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (isSpecial) ...[
                  Icon(
                    Icons.favorite,
                    size: 13,
                    color: isSelected ? Colors.white : const Color(0xFFEC4899),
                  ),
                  const SizedBox(width: 4),
                ],
                Text(
                  label,
                  style: GoogleFonts.outfit(
                    fontSize: 12,
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                    color: isSelected
                        ? (isSpecial ? Colors.white : Colors.black)
                        : Colors.white70,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyPartnerView() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: GlassCard(
        backgroundColor: const Color(0xFF13172E).withValues(alpha: 0.9),
        borderColor: const Color(0xFFEC4899).withValues(alpha: 0.4),
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: const LinearGradient(
                  colors: [Color(0xFFEC4899), Color(0xFF8B5CF6)],
                ),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFFEC4899).withValues(alpha: 0.35),
                    blurRadius: 20,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: const Icon(Icons.favorite, color: Colors.white, size: 36),
            ),
            const SizedBox(height: 16),
            Text(
              'Cross-Cultural Partner Synergy',
              textAlign: TextAlign.center,
              style: GoogleFonts.outfit(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Compare your chart with a partner, friend, or collaborator across 5 major world traditions: Western elemental harmony, Chinese BaZi trines & secret allies, Japanese blood type interpersonal matrix, Vedic nakshatra alignment, and Mayan galactic kin harmonics.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 13,
                height: 1.5,
                color: Colors.white.withValues(alpha: 0.8),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: _openPartnerDialog,
              icon: const Icon(Icons.favorite_rounded, size: 18),
              label: Text(
                'Add Partner Details',
                style: GoogleFonts.outfit(fontWeight: FontWeight.bold, fontSize: 14),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFEC4899),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                elevation: 4,
              ),
            ),
            const SizedBox(height: 24),
            // Preview list of traditions evaluated
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.04),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'TRADITIONS EVALUATED IN SYNASTRY',
                    style: GoogleFonts.outfit(
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFFEC4899),
                      letterSpacing: 1.5,
                    ),
                  ),
                  const SizedBox(height: 12),
                  _buildFeatureBullet('Western Tropical Zodiac', 'Elemental balance (Fire, Earth, Air, Water) and modal polarity.'),
                  _buildFeatureBullet('Chinese BaZi & Earthly Branches', '3-Harmony Trines (San He), 6 Secret Friends (Liu He) & growth clashes.'),
                  _buildFeatureBullet('Japanese Blood Type (Ketsuekigata)', 'Empirical interpersonal compatibility matrix (A, B, AB, O).'),
                  _buildFeatureBullet('Vedic Jyotish & Nakshatras', 'Planetary lord friendships and lunar mansion dharmic alignment.'),
                  _buildFeatureBullet('Mayan Tzolk\'in Sacred Kin', 'Galactic tone resonance and sacred occult counterpart pairings.'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureBullet(String title, String subtitle) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 4),
            child: Icon(Icons.check_circle_outline, color: Color(0xFFEC4899), size: 14),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w600)),
                Text(subtitle, style: TextStyle(color: Colors.white.withValues(alpha: 0.65), fontSize: 11.5)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPartnerSynastryView() {
    final synastry = PartnerSynastryService.calculateSynastry(widget.profile, _partnerProfile!);

    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Partner Header
            GlassCard(
              backgroundColor: const Color(0xFF13172E).withValues(alpha: 0.9),
              borderColor: const Color(0xFFEC4899).withValues(alpha: 0.35),
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Flexible(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.08),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.person, size: 14, color: Color(0xFFFFD700)),
                          const SizedBox(width: 6),
                          Flexible(
                            child: Text(
                              widget.profile.name,
                              style: GoogleFonts.outfit(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 13),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 6),
                    child: Text('❤️', style: TextStyle(fontSize: 16)),
                  ),
                  Flexible(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.08),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.person_outline, size: 14, color: Color(0xFFEC4899)),
                          const SizedBox(width: 6),
                          Flexible(
                            child: Text(
                              _partnerProfile!.name,
                              style: GoogleFonts.outfit(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 13),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  OutlinedButton.icon(
                    onPressed: _openPartnerDialog,
                    icon: const Icon(Icons.edit_outlined, size: 13, color: Color(0xFFEC4899)),
                    label: Text('Edit', style: GoogleFonts.outfit(fontSize: 12, color: const Color(0xFFEC4899))),
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Color(0xFFEC4899)),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),

            // Overall Synergy Gauge & Archetype Card
            GlassCard(
              backgroundColor: const Color(0xFF0F172A).withValues(alpha: 0.95),
              borderColor: const Color(0xFFEC4899).withValues(alpha: 0.4),
              padding: const EdgeInsets.all(20),
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
                              'OVERALL COSMIC SYNERGY',
                              style: GoogleFonts.outfit(
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                                color: const Color(0xFFEC4899),
                                letterSpacing: 1.5,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              '${synastry.overallScore}% Synergy',
                              style: GoogleFonts.outfit(
                                fontSize: 28,
                                fontWeight: FontWeight.w900,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 12),
                      Flexible(
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [Color(0xFFEC4899), Color(0xFF8B5CF6)],
                            ),
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0xFFEC4899).withValues(alpha: 0.3),
                                blurRadius: 10,
                              ),
                            ],
                          ),
                          child: Text(
                            synastry.relationshipArchetype,
                            style: GoogleFonts.outfit(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),

                  // Progress Bar
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: LinearProgressIndicator(
                      value: synastry.overallScore / 100.0,
                      minHeight: 8,
                      backgroundColor: Colors.white.withValues(alpha: 0.1),
                      valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFFEC4899)),
                    ),
                  ),
                  const SizedBox(height: 14),

                  Text(
                    synastry.executiveSummary,
                    style: TextStyle(
                      fontSize: 13,
                      height: 1.45,
                      color: Colors.white.withValues(alpha: 0.9),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Tradition Synastry Breakdown Header
            Text(
              'Multi-Cultural Synastry Analysis',
              style: GoogleFonts.outfit(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Detailed compatibility computed across 5 world cosmic frameworks',
              style: TextStyle(fontSize: 12.5, color: Colors.white.withValues(alpha: 0.7)),
            ),
            const SizedBox(height: 12),

            // Tradition Synastry Cards
            ...synastry.traditionBreakdowns.map((ts) => _buildTraditionSynastryCard(ts)),

            const SizedBox(height: 12),

            // Deep Dynamic Guidance Domains Header
            Text(
              'Relationship Dynamics & Action Guidance',
              style: GoogleFonts.outfit(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Practical recommendations derived from your astrological alignments',
              style: TextStyle(fontSize: 12.5, color: Colors.white.withValues(alpha: 0.7)),
            ),
            const SizedBox(height: 12),

            // Domain Guidance Cards
            ...synastry.domainAdvice.map((adv) => _buildDomainAdviceCard(adv)),
          ],
        ),
      ),
    );
  }

  Widget _buildTraditionSynastryCard(TraditionSynastry ts) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: GlassCard(
        borderColor: ts.accentColor.withValues(alpha: 0.35),
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(ts.icon, color: ts.accentColor, size: 18),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    ts.traditionName,
                    style: GoogleFonts.outfit(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                    color: ts.accentColor.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: ts.accentColor.withValues(alpha: 0.4)),
                  ),
                  child: Text(
                    '${ts.score}% • ${ts.harmonyLevel}',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      color: ts.accentColor,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.05),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      'You: ${ts.userSign}',
                      style: const TextStyle(fontSize: 12, color: Colors.white70),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 6),
                  child: Icon(Icons.sync_alt, size: 14, color: Colors.white38),
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.05),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      'Partner: ${ts.partnerSign}',
                      style: const TextStyle(fontSize: 12, color: Colors.white70),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              ts.description,
              style: TextStyle(
                fontSize: 13,
                height: 1.45,
                color: Colors.white.withValues(alpha: 0.85),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDomainAdviceCard(SynastryDomainAdvice adv) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: GlassCard(
        borderColor: adv.color.withValues(alpha: 0.3),
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(adv.icon, color: adv.color, size: 18),
                const SizedBox(width: 8),
                Text(
                  adv.domain.toUpperCase(),
                  style: GoogleFonts.outfit(
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    color: adv.color,
                    letterSpacing: 1.2,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              adv.dynamicSummary,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: Colors.white,
                height: 1.35,
              ),
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.04),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 2),
                    child: Icon(Icons.lightbulb_outline, size: 14, color: Color(0xFFFFD700)),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      adv.actionRecommendation,
                      style: TextStyle(
                        fontSize: 12,
                        height: 1.4,
                        color: Colors.white.withValues(alpha: 0.85),
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

  Widget _buildConvergenceCard(TraditionConvergence conv) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: GlassCard(
        borderColor: const Color(0xFF9B51E0).withValues(alpha: 0.4),
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text(conv.icon, style: const TextStyle(fontSize: 22)),
                    const SizedBox(width: 10),
                    Text(
                      conv.title.toUpperCase(),
                      style: GoogleFonts.outfit(
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF00E5FF),
                        letterSpacing: 1.5,
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: const Color(0xFF00E5FF).withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: const Color(0xFF00E5FF).withValues(alpha: 0.4)),
                  ),
                  child: Text(
                    '${conv.agreementPercentage}% Concordance',
                    style: GoogleFonts.outfit(
                      fontSize: 11.5,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF00E5FF),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
              decoration: BoxDecoration(
                color: const Color(0xFFFFD700).withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: const Color(0xFFFFD700).withValues(alpha: 0.3)),
              ),
              child: Text(
                'Consensus Insight: ${conv.consensusTrait}',
                style: GoogleFonts.outfit(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFFFFD700),
                ),
              ),
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.05),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'CONVERGING TRADITIONS',
                    style: GoogleFonts.outfit(fontSize: 10.5, fontWeight: FontWeight.bold, color: Colors.white70, letterSpacing: 0.8),
                  ),
                  const SizedBox(height: 6),
                  ...conv.agreeingTraditions.map((t) => Padding(
                        padding: const EdgeInsets.only(bottom: 3.5),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('• ', style: TextStyle(color: Color(0xFF00E5FF), fontWeight: FontWeight.bold)),
                            Expanded(child: Text(t, style: const TextStyle(fontSize: 13, color: Colors.white, height: 1.35))),
                          ],
                        ),
                      )),
                ],
              ),
            ),
            const SizedBox(height: 12),
            Text(
              conv.analyticalSynthesis,
              style: TextStyle(
                fontSize: 13.5,
                height: 1.5,
                color: Colors.white.withValues(alpha: 0.95),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDailyConsensusCard(DailyConsensusPoint pt) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: GlassCard(
        borderColor: pt.color.withValues(alpha: 0.35),
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(pt.icon, style: const TextStyle(fontSize: 20)),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        pt.domain.toUpperCase(),
                        style: GoogleFonts.outfit(
                          fontSize: 10.5,
                          fontWeight: FontWeight.bold,
                          color: pt.color,
                          letterSpacing: 1.2,
                        ),
                      ),
                      Text(
                        pt.consensusTitle,
                        style: GoogleFonts.outfit(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: pt.color.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: pt.color.withValues(alpha: 0.3)),
                  ),
                  child: Text(
                    '${pt.convergingTraditions.length} Traditions Agree',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      color: pt.color,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.04),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
              ),
              child: Text(
                pt.synthesis,
                style: const TextStyle(fontSize: 13.5, height: 1.45, color: Colors.white),
              ),
            ),
            const SizedBox(height: 10),
            Wrap(
              spacing: 6,
              runSpacing: 6,
              children: pt.convergingTraditions
                  .map((t) => Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: pt.color.withValues(alpha: 0.12),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: pt.color.withValues(alpha: 0.25)),
                        ),
                        child: Text(t, style: TextStyle(fontSize: 11.5, color: Colors.white.withValues(alpha: 0.95))),
                      ))
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildComparisonItem(CulturalSign sign) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: GlassCard(
        borderColor: sign.accentColor.withValues(alpha: 0.3),
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: sign.accentColor.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: sign.accentColor.withValues(alpha: 0.5)),
              ),
              child: Center(
                child: Text(sign.symbol, style: const TextStyle(fontSize: 22)),
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        sign.systemName,
                        style: GoogleFonts.outfit(
                          fontSize: 11.5,
                          fontWeight: FontWeight.bold,
                          color: sign.accentColor,
                          letterSpacing: 1,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2.5),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.08),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          sign.element,
                          style: const TextStyle(fontSize: 11, color: Colors.white, fontWeight: FontWeight.w600),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    sign.signName,
                    style: GoogleFonts.outfit(
                      fontSize: 16.5,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    sign.essence,
                    style: TextStyle(
                      fontSize: 13,
                      height: 1.45,
                      color: Colors.white.withValues(alpha: 0.85),
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

  List<CulturalSign> _getFilteredSigns(CosmicSynthesis s) {
    switch (_selectedRegion) {
      case 'East Asian':
        return [s.bazi, s.ziwei, s.bloodType];
      case 'South Asian':
        return [s.vedic, s.nadi];
      case 'Greco-Roman & Arabian':
        return [s.western, s.arabian];
      case 'Indigenous Americas':
        return [s.mayan, s.aztec, s.medicineWheel];
      case 'European Folk':
        return [s.celticTree, s.norseRune];
      case 'All':
      default:
        return s.allSigns;
    }
  }
}
