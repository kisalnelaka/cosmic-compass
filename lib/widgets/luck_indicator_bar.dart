import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
            width: 58,
            child: Text(
              label,
              style: GoogleFonts.outfit(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: Colors.white70,
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
                    height: 6,
                    margin: const EdgeInsets.symmetric(horizontal: 2),
                    decoration: BoxDecoration(
                      color: isFilled ? color : Colors.white.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(3),
                      boxShadow: isFilled
                          ? [
                              BoxShadow(
                                color: color.withValues(alpha: 0.4),
                                blurRadius: 4,
                                spreadRadius: 1,
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
