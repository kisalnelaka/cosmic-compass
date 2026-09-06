import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/user_profile.dart';
import '../models/cosmic_synthesis.dart';
import '../models/cultural_profiles.dart';
import '../services/profile_service.dart';
import '../services/daily_prediction_service.dart';
import '../widgets/glass_card.dart';
import '../widgets/elemental_radar_widget.dart';
import '../widgets/cultural_disclaimer_card.dart';

class ComparisonScreen extends StatefulWidget {
  final UserProfile profile;

  const ComparisonScreen({super.key, required this.profile});

  @override
  State<ComparisonScreen> createState() => _ComparisonScreenState();
}

class _ComparisonScreenState extends State<ComparisonScreen> {
  String _selectedRegion = 'All';
  int _currentViewMode = 0; // 0: Overlap & Concordance, 1: Full Comparison Matrix

  final List<String> _regions = [
    'All',
    'East Asian',
    'South Asian',
    'Greco-Roman & Arabian',
    'Indigenous Americas',
    'European Folk',
  ];

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
                    'Where World Cultures Agree on You',
                    style: GoogleFonts.outfit(
                      fontSize: 24,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'Across thousands of years and continents, independent civilizations developed unique cosmic systems. Here is where they arrive at identical conclusions about your personality and strengths.',
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

          // View Switcher (Concordance Overlaps vs Full Matrix)
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
                    Expanded(
                      child: InkWell(
                        onTap: () => setState(() => _currentViewMode = 0),
                        borderRadius: BorderRadius.circular(14),
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 11),
                          decoration: BoxDecoration(
                            gradient: _currentViewMode == 0
                                ? const LinearGradient(
                                    colors: [Color(0xFFFFD700), Color(0xFFFFA000)],
                                  )
                                : null,
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: Center(
                            child: Text(
                              'Shared Traits & Overlaps',
                              style: GoogleFonts.outfit(
                                fontSize: 13,
                                fontWeight: _currentViewMode == 0 ? FontWeight.bold : FontWeight.w500,
                                color: _currentViewMode == 0 ? Colors.black : Colors.white70,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () => setState(() => _currentViewMode = 1),
                        borderRadius: BorderRadius.circular(14),
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 11),
                          decoration: BoxDecoration(
                            gradient: _currentViewMode == 1
                                ? const LinearGradient(
                                    colors: [Color(0xFFFFD700), Color(0xFFFFA000)],
                                  )
                                : null,
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: Center(
                            child: Text(
                              'All 11 Traditions Matrix',
                              style: GoogleFonts.outfit(
                                fontSize: 13,
                                fontWeight: _currentViewMode == 1 ? FontWeight.bold : FontWeight.w500,
                                color: _currentViewMode == 1 ? Colors.black : Colors.white70,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
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
                    Text(
                      'Cross-Cultural Core Overlaps',
                      style: GoogleFonts.outfit(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFD700).withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: const Color(0xFFFFD700).withValues(alpha: 0.4)),
                      ),
                      child: Text(
                        '${synthesis.convergences.length} Overlap Themes',
                        style: GoogleFonts.outfit(fontSize: 11.5, fontWeight: FontWeight.bold, color: const Color(0xFFFFD700)),
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
          ] else ...[
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
          ],
          const SliverToBoxAdapter(child: SizedBox(height: 40)),
        ],
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
                      conv.title,
                      style: GoogleFonts.outfit(
                        fontSize: 16.5,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
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
                          fontSize: 15.5,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(12),
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
