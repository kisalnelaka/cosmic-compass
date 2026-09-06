import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/hand_drawn_tokens.dart';

class LuckIndicatorBar extends StatelessWidget {
  final String label;
  final int score; // 1 to 5
  final IconData icon;
  final Color color;

  const LuckIndicatorBar({
    super.key,
    required this.label,
    required this.score,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Icon(icon, size: 16, color: color),
          const SizedBox(width: 8),
          SizedBox(
            width: 65,
            child: Text(
              label,
              style: GoogleFonts.patrickHand(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: HandDrawnTokens.pencilBlack,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Row(
              children: List.generate(5, (index) {
                final isFilled = index < score;
                return Expanded(
                  child: Container(
                    height: 9,
                    margin: const EdgeInsets.symmetric(horizontal: 2),
                    decoration: BoxDecoration(
                      color: isFilled ? color : HandDrawnTokens.emptySlot,
                      borderRadius: BorderRadius.circular(2),
                      border: Border.all(
                        color: HandDrawnTokens.pencilBlack,
                        width: 1.5,
                      ),
                      boxShadow: isFilled
                          ? const [
                              BoxShadow(
                                color: HandDrawnTokens.pencilBlack,
                                offset: Offset(1, 1),
                                blurRadius: 0,
                              ),
                            ]
                          : null,
                    ),
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}
