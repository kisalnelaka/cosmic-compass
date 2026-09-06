import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/hand_drawn_tokens.dart';
import 'hand_drawn_card.dart';

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
    return HandDrawnCard(
      decoration: HandDrawnCardDecoration.tape,
      backgroundColor: HandDrawnTokens.postItYellow,
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
            borderRadius: BorderRadius.circular(10),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: HandDrawnTokens.markerRed.withValues(alpha: 0.15),
                    shape: BoxShape.circle,
                    border: Border.all(color: HandDrawnTokens.pencilBlack, width: 1.5),
                  ),
                  child: const Icon(Icons.menu_book_rounded, color: HandDrawnTokens.markerRed, size: 18),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'A QUICK NOTE ON CULTURAL HERITAGE',
                        style: GoogleFonts.kalam(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: HandDrawnTokens.pencilBlack,
                          letterSpacing: 0.8,
                        ),
                      ),
                      Text(
                        'Take these daily predictions with a thoughtful pinch of salt',
                        style: GoogleFonts.patrickHand(
                          fontSize: 14,
                          color: HandDrawnTokens.pencilBlack.withValues(alpha: 0.8),
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(
                  _isExpanded ? Icons.keyboard_arrow_up_rounded : Icons.keyboard_arrow_down_rounded,
                  color: HandDrawnTokens.pencilBlack,
                  size: 22,
                ),
              ],
            ),
          ),
          if (_isExpanded || !widget.compact) ...[
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.7),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: HandDrawnTokens.pencilBlack.withValues(alpha: 0.25), width: 1.5),
              ),
              child: Text(
                'Modern empirical science views astrological and divination systems as cultural philosophies rather than rigid physical laws. Yet across thousands of years, civilizations like Mayan daykeepers, Celtic druids, Vedic scholars, and modern Japanese TV astrologers found real value in watching these cycles.\n\nThey treated these systems as symbolic mirrors to reflect on their feelings, build good habits, and stay grounded with nature. Please enjoy these readings as creative, uplifting tools for mindful living rather than unchangeable fate.',
                style: GoogleFonts.patrickHand(
                  fontSize: 15,
                  height: 1.4,
                  color: HandDrawnTokens.pencilBlack,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
