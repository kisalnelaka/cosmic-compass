import 'package:flutter/material.dart';
import '../models/user_profile.dart';
import '../models/cosmic_synthesis.dart';
import '../models/cultural_profiles.dart';
import '../services/profile_service.dart';
import '../services/daily_prediction_service.dart';
import '../services/partner_synastry_service.dart';
import '../services/share_service.dart';
import '../theme/hand_drawn_tokens.dart';
import '../widgets/hand_drawn_card.dart';
import '../widgets/hand_drawn_button.dart';
import '../widgets/hand_drawn_badge.dart';
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

  void _shareSynergyReport(PartnerCompatibilityResult synastry) {
    ShareService.copySynastryToClipboard(synastry);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: HandDrawnTokens.pencilBlack,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: HandDrawnTokens.wobblySm),
        content: Text(
          'Partner synergy report copied to clipboard. Ready to share!',
          style: HandDrawnTokens.bodyFont(color: HandDrawnTokens.warmPaper, fontSize: 14),
        ),
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
                  style: HandDrawnTokens.headingFont(
                    fontSize: 12.5,
                    fontWeight: FontWeight.w700,
                    color: HandDrawnTokens.markerRed,
                    letterSpacing: 2.0,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  _currentViewMode == 2
                      ? 'Partner Synergy & Synastry'
                      : 'Where World Cultures Agree on You',
                  style: HandDrawnTokens.headingFont(
                    fontSize: 24,
                    fontWeight: FontWeight.w900,
                    color: HandDrawnTokens.pencilBlack,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  _currentViewMode == 2
                      ? 'Synthesizing your birth profile with your partner across Western elements, Chinese BaZi trines, Japanese Blood Types, Vedic Nakshatras, and Mayan Kin.'
                      : 'Across thousands of years and continents, independent civilizations developed unique cosmic systems. Here is where they arrive at identical conclusions about your personality and strengths.',
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

        // Cultural Heritage Disclaimer
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
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: HandDrawnTokens.warmPaper,
                borderRadius: HandDrawnTokens.wobblySm,
                border: Border.all(color: HandDrawnTokens.pencilBlack, width: 2),
                boxShadow: HandDrawnTokens.hardShadowSm,
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
              child: HandDrawnCard(
                padding: const EdgeInsets.all(20),
                backgroundColor: HandDrawnTokens.cardWhite,
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
                          style: HandDrawnTokens.headingFont(
                            fontSize: 19,
                            fontWeight: FontWeight.bold,
                            color: HandDrawnTokens.pencilBlack,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          'Where at least 3 distinct world systems pinpoint the exact same trait',
                          style: HandDrawnTokens.bodyFont(
                            fontSize: 13.5,
                            color: HandDrawnTokens.erasedPencil,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  HandDrawnBadge(
                    label: '${synthesis.convergences.length} Overlaps',
                    color: HandDrawnTokens.ballpointBlue,
                    isPostIt: false,
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
                    style: HandDrawnTokens.headingFont(
                      fontSize: 19,
                      fontWeight: FontWeight.bold,
                      color: HandDrawnTokens.pencilBlack,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    'Points where independent daily astrological cycles harmonize for your specific chart',
                    style: HandDrawnTokens.bodyFont(
                      fontSize: 13.5,
                      color: HandDrawnTokens.erasedPencil,
                    ),
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
              height: 52,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                itemCount: _regions.length,
                itemBuilder: (context, index) {
                  final reg = _regions[index];
                  final isSelected = _selectedRegion == reg;
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: InkWell(
                      onTap: () => setState(() => _selectedRegion = reg),
                      borderRadius: HandDrawnTokens.wobblySm,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: isSelected ? HandDrawnTokens.postItYellow : HandDrawnTokens.cardWhite,
                          borderRadius: HandDrawnTokens.wobblySm,
                          border: Border.all(
                            color: HandDrawnTokens.pencilBlack,
                            width: isSelected ? 2.0 : 1.5,
                          ),
                          boxShadow: isSelected ? HandDrawnTokens.hardShadowSm : [],
                        ),
                        child: Center(
                          child: Text(
                            reg,
                            style: HandDrawnTokens.bodyFont(
                              fontSize: 13,
                              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                              color: HandDrawnTokens.pencilBlack,
                            ),
                          ),
                        ),
                      ),
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
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(40),
                child: Center(
                  child: CircularProgressIndicator(
                    color: HandDrawnTokens.markerRed,
                    strokeWidth: 2.5,
                  ),
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
        borderRadius: HandDrawnTokens.wobblySm,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 9),
          decoration: BoxDecoration(
            color: isSelected
                ? (isSpecial ? HandDrawnTokens.postItYellow : HandDrawnTokens.cardWhite)
                : Colors.transparent,
            borderRadius: HandDrawnTokens.wobblySm,
            border: isSelected ? Border.all(color: HandDrawnTokens.pencilBlack, width: 2) : null,
          ),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (isSpecial) ...[
                  Icon(
                    Icons.favorite,
                    size: 13,
                    color: HandDrawnTokens.markerRed,
                  ),
                  const SizedBox(width: 4),
                ],
                Text(
                  label,
                  style: HandDrawnTokens.headingFont(
                    fontSize: 13,
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                    color: isSelected ? HandDrawnTokens.pencilBlack : HandDrawnTokens.erasedPencil,
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
      child: HandDrawnCard(
        decoration: HandDrawnCardDecoration.pin,
        backgroundColor: HandDrawnTokens.cardWhite,
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: HandDrawnTokens.postItYellow,
                border: Border.all(color: HandDrawnTokens.pencilBlack, width: 2),
                boxShadow: HandDrawnTokens.hardShadowSm,
              ),
              child: Icon(Icons.favorite, color: HandDrawnTokens.markerRed, size: 36),
            ),
            const SizedBox(height: 16),
            Text(
              'Cross-Cultural Partner Synergy',
              textAlign: TextAlign.center,
              style: HandDrawnTokens.headingFont(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: HandDrawnTokens.pencilBlack,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Compare your chart with a partner, friend, or collaborator across 5 major world traditions: Western elemental harmony, Chinese BaZi trines and secret allies, Japanese blood type interpersonal matrix, Vedic nakshatra alignment, and Mayan galactic kin harmonics.',
              textAlign: TextAlign.center,
              style: HandDrawnTokens.bodyFont(
                fontSize: 14.5,
                height: 1.5,
                color: HandDrawnTokens.pencilBlack,
              ),
            ),
            const SizedBox(height: 20),
            HandDrawnButton(
              text: 'Add Partner Details',
              variant: HandDrawnButtonVariant.primary,
              icon: Icons.favorite_rounded,
              onPressed: _openPartnerDialog,
            ),
            const SizedBox(height: 24),
            // Preview list of traditions evaluated
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: HandDrawnTokens.warmPaper,
                borderRadius: HandDrawnTokens.wobblySm,
                border: Border.all(color: HandDrawnTokens.pencilBlack, width: 1.5),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'TRADITIONS EVALUATED IN SYNASTRY',
                    style: HandDrawnTokens.headingFont(
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      color: HandDrawnTokens.markerRed,
                      letterSpacing: 1.5,
                    ),
                  ),
                  const SizedBox(height: 12),
                  _buildFeatureBullet('Western Tropical Zodiac', 'Elemental balance (Fire, Earth, Air, Water) and modal polarity.'),
                  _buildFeatureBullet('Chinese BaZi & Earthly Branches', '3-Harmony Trines (San He), 6 Secret Friends (Liu He), and growth tensions.'),
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
          Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Icon(Icons.check_circle_outline, color: HandDrawnTokens.markerRed, size: 16),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: HandDrawnTokens.headingFont(
                    color: HandDrawnTokens.pencilBlack,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  subtitle,
                  style: HandDrawnTokens.bodyFont(
                    color: HandDrawnTokens.erasedPencil,
                    fontSize: 13,
                  ),
                ),
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
            HandDrawnCard(
              backgroundColor: HandDrawnTokens.cardWhite,
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Flexible(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                      decoration: BoxDecoration(
                        color: HandDrawnTokens.warmPaper,
                        borderRadius: HandDrawnTokens.wobblySm,
                        border: Border.all(color: HandDrawnTokens.pencilBlack, width: 1.5),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.person, size: 14, color: HandDrawnTokens.pencilBlack),
                          const SizedBox(width: 6),
                          Flexible(
                            child: Text(
                              widget.profile.name,
                              style: HandDrawnTokens.headingFont(
                                fontWeight: FontWeight.bold,
                                color: HandDrawnTokens.pencilBlack,
                                fontSize: 13,
                              ),
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
                        color: HandDrawnTokens.postItYellow,
                        borderRadius: HandDrawnTokens.wobblySm,
                        border: Border.all(color: HandDrawnTokens.pencilBlack, width: 1.5),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.favorite, size: 14, color: HandDrawnTokens.markerRed),
                          const SizedBox(width: 6),
                          Flexible(
                            child: Text(
                              _partnerProfile!.name,
                              style: HandDrawnTokens.headingFont(
                                fontWeight: FontWeight.bold,
                                color: HandDrawnTokens.pencilBlack,
                                fontSize: 13,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  HandDrawnButton(
                    text: 'Edit',
                    variant: HandDrawnButtonVariant.secondary,
                    onPressed: _openPartnerDialog,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),

            // Overall Synergy Gauge & Archetype Card
            HandDrawnCard(
              decoration: HandDrawnCardDecoration.tape,
              backgroundColor: HandDrawnTokens.postItYellow,
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
                              style: HandDrawnTokens.headingFont(
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                                color: HandDrawnTokens.markerRed,
                                letterSpacing: 1.5,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              '${synastry.overallScore}% Synergy',
                              style: HandDrawnTokens.headingFont(
                                fontSize: 28,
                                fontWeight: FontWeight.w900,
                                color: HandDrawnTokens.pencilBlack,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 12),
                      Flexible(
                        child: HandDrawnBadge(
                          label: synastry.relationshipArchetype,
                          color: HandDrawnTokens.markerRed,
                          isPostIt: false,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),

                  // Progress Bar
                  Container(
                    height: 10,
                    decoration: BoxDecoration(
                      color: HandDrawnTokens.cardWhite,
                      borderRadius: HandDrawnTokens.wobblySm,
                      border: Border.all(color: HandDrawnTokens.pencilBlack, width: 2),
                    ),
                    alignment: Alignment.centerLeft,
                    child: FractionallySizedBox(
                      widthFactor: synastry.overallScore / 100.0,
                      child: Container(
                        decoration: BoxDecoration(
                          color: HandDrawnTokens.markerRed,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 14),

                  Text(
                    synastry.executiveSummary,
                    style: HandDrawnTokens.bodyFont(
                      fontSize: 14.5,
                      height: 1.5,
                      color: HandDrawnTokens.pencilBlack,
                    ),
                  ),
                  const SizedBox(height: 12),

                  Align(
                    alignment: Alignment.centerRight,
                    child: HandDrawnButton(
                      text: 'Share Synergy Report',
                      icon: Icons.share_outlined,
                      variant: HandDrawnButtonVariant.secondary,
                      onPressed: () => _shareSynergyReport(synastry),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Tradition Synastry Breakdown Header
            Text(
              'Multi-Cultural Synastry Analysis',
              style: HandDrawnTokens.headingFont(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: HandDrawnTokens.pencilBlack,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Detailed compatibility computed across 5 world cosmic frameworks',
              style: HandDrawnTokens.bodyFont(
                fontSize: 14,
                color: HandDrawnTokens.erasedPencil,
              ),
            ),
            const SizedBox(height: 12),

            // Tradition Synastry Cards
            ...synastry.traditionBreakdowns.map((ts) => _buildTraditionSynastryCard(ts)),

            const SizedBox(height: 12),

            // Deep Dynamic Guidance Domains Header
            Text(
              'Relationship Dynamics & Action Guidance',
              style: HandDrawnTokens.headingFont(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: HandDrawnTokens.pencilBlack,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Practical recommendations derived from your astrological alignments',
              style: HandDrawnTokens.bodyFont(
                fontSize: 14,
                color: HandDrawnTokens.erasedPencil,
              ),
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
      child: HandDrawnCard(
        backgroundColor: HandDrawnTokens.cardWhite,
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(ts.icon, color: HandDrawnTokens.pencilBlack, size: 20),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    ts.traditionName,
                    style: HandDrawnTokens.headingFont(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: HandDrawnTokens.pencilBlack,
                    ),
                  ),
                ),
                HandDrawnBadge(
                  label: '${ts.score}% • ${ts.harmonyLevel}',
                  color: ts.accentColor,
                  isPostIt: false,
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
                      color: HandDrawnTokens.warmPaper,
                      borderRadius: HandDrawnTokens.wobblySm,
                      border: Border.all(color: HandDrawnTokens.pencilBlack, width: 1.5),
                    ),
                    child: Text(
                      'You: ${ts.userSign}',
                      style: HandDrawnTokens.bodyFont(fontSize: 13, color: HandDrawnTokens.pencilBlack),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 6),
                  child: Icon(Icons.sync_alt, size: 16, color: HandDrawnTokens.pencilBlack),
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(
                      color: HandDrawnTokens.warmPaper,
                      borderRadius: HandDrawnTokens.wobblySm,
                      border: Border.all(color: HandDrawnTokens.pencilBlack, width: 1.5),
                    ),
                    child: Text(
                      'Partner: ${ts.partnerSign}',
                      style: HandDrawnTokens.bodyFont(fontSize: 13, color: HandDrawnTokens.pencilBlack),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              ts.description,
              style: HandDrawnTokens.bodyFont(
                fontSize: 14,
                height: 1.45,
                color: HandDrawnTokens.pencilBlack,
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
      child: HandDrawnCard(
        backgroundColor: HandDrawnTokens.cardWhite,
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(adv.icon, color: HandDrawnTokens.pencilBlack, size: 20),
                const SizedBox(width: 8),
                Text(
                  adv.domain.toUpperCase(),
                  style: HandDrawnTokens.headingFont(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: HandDrawnTokens.markerRed,
                    letterSpacing: 1.2,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              adv.dynamicSummary,
              style: HandDrawnTokens.headingFont(
                fontSize: 14.5,
                fontWeight: FontWeight.bold,
                color: HandDrawnTokens.pencilBlack,
                height: 1.35,
              ),
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: HandDrawnTokens.warmPaper,
                borderRadius: HandDrawnTokens.wobblySm,
                border: Border.all(color: HandDrawnTokens.pencilBlack, width: 1.5),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 2),
                    child: Icon(Icons.lightbulb_outline, size: 16, color: HandDrawnTokens.pencilBlack),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      adv.actionRecommendation,
                      style: HandDrawnTokens.bodyFont(
                        fontSize: 13.5,
                        height: 1.4,
                        color: HandDrawnTokens.pencilBlack,
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
      child: HandDrawnCard(
        backgroundColor: HandDrawnTokens.cardWhite,
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
                      style: HandDrawnTokens.headingFont(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: HandDrawnTokens.markerRed,
                        letterSpacing: 1.5,
                      ),
                    ),
                  ],
                ),
                HandDrawnBadge(
                  label: '${conv.agreementPercentage}% Concordance',
                  color: HandDrawnTokens.ballpointBlue,
                  isPostIt: false,
                ),
              ],
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
              decoration: BoxDecoration(
                color: HandDrawnTokens.postItYellow,
                borderRadius: HandDrawnTokens.wobblySm,
                border: Border.all(color: HandDrawnTokens.pencilBlack, width: 1.5),
              ),
              child: Text(
                'Consensus Insight: ${conv.consensusTrait}',
                style: HandDrawnTokens.headingFont(
                  fontSize: 14.5,
                  fontWeight: FontWeight.bold,
                  color: HandDrawnTokens.pencilBlack,
                ),
              ),
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: HandDrawnTokens.warmPaper,
                borderRadius: HandDrawnTokens.wobblySm,
                border: Border.all(color: HandDrawnTokens.pencilBlack, width: 1.5),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'CONVERGING TRADITIONS',
                    style: HandDrawnTokens.headingFont(
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      color: HandDrawnTokens.erasedPencil,
                      letterSpacing: 0.8,
                    ),
                  ),
                  const SizedBox(height: 6),
                  ...conv.agreeingTraditions.map((t) => Padding(
                        padding: const EdgeInsets.only(bottom: 3.5),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '• ',
                              style: TextStyle(
                                color: HandDrawnTokens.markerRed,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Expanded(
                              child: Text(
                                t,
                                style: HandDrawnTokens.bodyFont(
                                  fontSize: 13.5,
                                  color: HandDrawnTokens.pencilBlack,
                                  height: 1.35,
                                ),
                              ),
                            ),
                          ],
                        ),
                      )),
                ],
              ),
            ),
            const SizedBox(height: 12),
            Text(
              conv.analyticalSynthesis,
              style: HandDrawnTokens.bodyFont(
                fontSize: 14,
                height: 1.5,
                color: HandDrawnTokens.pencilBlack,
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
      child: HandDrawnCard(
        backgroundColor: HandDrawnTokens.cardWhite,
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
                        style: HandDrawnTokens.headingFont(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          color: HandDrawnTokens.markerRed,
                          letterSpacing: 1.2,
                        ),
                      ),
                      Text(
                        pt.consensusTitle,
                        style: HandDrawnTokens.headingFont(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: HandDrawnTokens.pencilBlack,
                        ),
                      ),
                    ],
                  ),
                ),
                HandDrawnBadge(
                  label: '${pt.convergingTraditions.length} Traditions Agree',
                  color: pt.color,
                  isPostIt: false,
                ),
              ],
            ),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: HandDrawnTokens.warmPaper,
                borderRadius: HandDrawnTokens.wobblySm,
                border: Border.all(color: HandDrawnTokens.pencilBlack, width: 1.5),
              ),
              child: Text(
                pt.synthesis,
                style: HandDrawnTokens.bodyFont(
                  fontSize: 14,
                  height: 1.45,
                  color: HandDrawnTokens.pencilBlack,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Wrap(
              spacing: 6,
              runSpacing: 6,
              children: pt.convergingTraditions
                  .map((t) => HandDrawnBadge(
                        label: t,
                        color: pt.color,
                        isPostIt: false,
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
      child: HandDrawnCard(
        backgroundColor: HandDrawnTokens.cardWhite,
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: sign.accentColor.withValues(alpha: 0.15),
                borderRadius: HandDrawnTokens.wobblySm,
                border: Border.all(color: HandDrawnTokens.pencilBlack, width: 2),
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
                        style: HandDrawnTokens.headingFont(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: HandDrawnTokens.markerRed,
                          letterSpacing: 1,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2.5),
                        decoration: BoxDecoration(
                          color: HandDrawnTokens.warmPaper,
                          borderRadius: HandDrawnTokens.wobblyBadge,
                          border: Border.all(color: HandDrawnTokens.pencilBlack, width: 1.5),
                        ),
                        child: Text(
                          sign.element,
                          style: HandDrawnTokens.bodyFont(
                            fontSize: 12,
                            color: HandDrawnTokens.pencilBlack,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    sign.signName,
                    style: HandDrawnTokens.headingFont(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: HandDrawnTokens.pencilBlack,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    sign.essence,
                    style: HandDrawnTokens.bodyFont(
                      fontSize: 13.5,
                      height: 1.45,
                      color: HandDrawnTokens.pencilBlack,
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
