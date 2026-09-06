import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'glass_card.dart';

class CulturalDisclaimerCard extends StatefulWidget {
  final bool compact;

  const CulturalDisclaimerCard({super.key, this.compact = false});

  @override
  State<CulturalDisclaimerCard> createState() => _CulturalDisclaimerCardState();
}

class _CulturalDisclaimerCardState extends State<CulturalDisclaimerCard> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      backgroundColor: const Color(0xFF161224).withValues(alpha: 0.85),
      borderColor: const Color(0xFFFFD700).withValues(alpha: 0.3),
      borderRadius: 18,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: () {
              setState(() {
                _isExpanded = !_isExpanded;
              });
            },
            borderRadius: BorderRadius.circular(12),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFD700).withValues(alpha: 0.12),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.menu_book_rounded, color: Color(0xFFFFD700), size: 18),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'CULTURAL HERITAGE & PERSPECTIVE NOTICE',
                        style: GoogleFonts.outfit(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFFFFD700),
                          letterSpacing: 1.2,
                        ),
                      ),
                      Text(
                        'Take these cosmic predictions with a thoughtful pinch of salt',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.white.withValues(alpha: 0.7),
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(
                  _isExpanded ? Icons.keyboard_arrow_up_rounded : Icons.keyboard_arrow_down_rounded,
                  color: Colors.white60,
                  size: 20,
                ),
              ],
            ),
          ),
          if (_isExpanded || !widget.compact) ...[
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.04),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
              ),
              child: Text(
                'While modern empirical science classifies astrological and divination systems as cultural and philosophical traditions rather than deterministic physical laws, ancient civilizations across millennia—from Mayan daykeepers and Celtic druids to Vedic rishis and TV Asahi astrologers—persisted in observing these celestial cycles.\n\nThey revered these traditions as symbolic mirrors for self-reflection, emotional calibration, and aligning human action with the seasons of nature. Use these predictions not as unalterable fate, but as inspirational tools for intentional living.',
                style: GoogleFonts.outfit(
                  fontSize: 12,
                  height: 1.45,
                  color: Colors.white.withValues(alpha: 0.85),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
