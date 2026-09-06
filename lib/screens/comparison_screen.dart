import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/user_profile.dart';
import '../models/cosmic_synthesis.dart';
import '../models/cultural_profiles.dart';
import '../services/profile_service.dart';
import '../widgets/glass_card.dart';
import '../widgets/elemental_radar_widget.dart';

class ComparisonScreen extends StatefulWidget {
  final UserProfile profile;

  const ComparisonScreen({super.key, required this.profile});

  @override
  State<ComparisonScreen> createState() => _ComparisonScreenState();
}

class _ComparisonScreenState extends State<ComparisonScreen> {
  String _selectedRegion = 'All';

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

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          // Header
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'CROSS-CULTURAL SYNTHESIS',
                    style: GoogleFonts.outfit(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF00E5FF),
                      letterSpacing: 2.5,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Comparative Matrix',
                    style: GoogleFonts.outfit(
                      fontSize: 26,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'How different civilizational cycles interpret your single cosmic imprint',
                    style: TextStyle(fontSize: 13, color: Colors.white.withValues(alpha: 0.7)),
                  ),
                ],
              ),
            ),
          ),

          // Elemental Balance Card
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

          // Cross-System Harmony Insights Card
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              child: GlassCard(
                backgroundColor: const Color(0xFF1E1436).withValues(alpha: 0.85),
                borderColor: const Color(0xFFFF4081).withValues(alpha: 0.4),
                padding: const EdgeInsets.all(18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.sync_alt_rounded, color: Color(0xFFFF4081)),
                        const SizedBox(width: 8),
                        Text(
                          'Cross-Cultural Harmony Synergy',
                          style: GoogleFonts.outfit(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    _buildSynergyRow(
                      'Solar & Lunar Alignment',
                      'Western ${synthesis.western.signName} matches with Sidereal ${synthesis.vedic.signName} through the ${synthesis.vedic.ayanamsaDegrees}° Lahiri Ayanamsa precession.',
                    ),
                    _buildSynergyRow(
                      'Elemental Clan & Five Elements',
                      'Medicine Wheel ${synthesis.medicineWheel.elementalClan} clan resonates with Chinese BaZi ${synthesis.bazi.dayMaster} Day Master.',
                    ),
                    _buildSynergyRow(
                      'Spiritual Archetype Bridge',
                      'Mayan ${synthesis.mayan.nahualName} and Celtic Tree ${synthesis.celticTree.signName} share a common emphasis on visionary guidance and organic timing.',
                    ),
                  ],
                ),
              ),
            ),
          ),

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
                          fontSize: 12,
                          fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                          color: isSelected ? Colors.white : Colors.white70,
                        ),
                      ),
                      backgroundColor: Colors.white.withValues(alpha: 0.06),
                      selectedColor: const Color(0xFF6A11CB),
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

          // Comparative Items List
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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
          const SliverToBoxAdapter(child: SizedBox(height: 40)),
        ],
      ),
    );
  }

  Widget _buildSynergyRow(String title, String desc) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: GoogleFonts.outfit(fontSize: 13, fontWeight: FontWeight.bold, color: const Color(0xFFFFD700)),
          ),
          const SizedBox(height: 2),
          Text(
            desc,
            style: TextStyle(fontSize: 12, height: 1.35, color: Colors.white.withValues(alpha: 0.8)),
          ),
        ],
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
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          color: sign.accentColor,
                          letterSpacing: 1,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.08),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          sign.element,
                          style: const TextStyle(fontSize: 10, color: Colors.white70),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    sign.signName,
                    style: GoogleFonts.outfit(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    sign.essence,
                    style: TextStyle(
                      fontSize: 12,
                      height: 1.35,
                      color: Colors.white.withValues(alpha: 0.8),
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
