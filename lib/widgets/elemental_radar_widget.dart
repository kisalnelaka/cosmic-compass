import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/cosmic_synthesis.dart';

class ElementalRadarWidget extends StatelessWidget {
  final ElementalBalance balance;

  const ElementalRadarWidget({super.key, required this.balance});

  @override
  Widget build(BuildContext context) {
    final elements = [
      {'name': 'Fire', 'symbol': '🔥', 'val': balance.fire, 'color': const Color(0xFFFF5252)},
      {'name': 'Earth', 'symbol': '🌍', 'val': balance.earth, 'color': const Color(0xFF4CAF50)},
      {'name': 'Air', 'symbol': '🌬️', 'val': balance.air, 'color': const Color(0xFF00E5FF)},
      {'name': 'Water', 'symbol': '💧', 'val': balance.water, 'color': const Color(0xFF448AFF)},
      {'name': 'Ether', 'symbol': '✨', 'val': balance.ether, 'color': const Color(0xFFE040FB)},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Elemental Harmony Matrix',
              style: GoogleFonts.outfit(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.white.withValues(alpha: 0.2)),
              ),
              child: Text(
                'Dominant: ${balance.dominantElement}',
                style: GoogleFonts.outfit(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFFFFD700),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 14),
        ...elements.map((item) {
          final val = item['val'] as double;
          final pct = (val * 100).toStringAsFixed(0);
          final color = item['color'] as Color;

          return Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text(item['symbol'] as String, style: const TextStyle(fontSize: 14)),
                        const SizedBox(width: 8),
                        Text(
                          item['name'] as String,
                          style: GoogleFonts.outfit(
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                            color: Colors.white70,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      '$pct%',
                      style: GoogleFonts.outfit(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: color,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                ClipRRect(
                  borderRadius: BorderRadius.circular(6),
                  child: LinearProgressIndicator(
                    value: val.clamp(0.05, 1.0),
                    minHeight: 6,
                    backgroundColor: Colors.white.withValues(alpha: 0.08),
                    valueColor: AlwaysStoppedAnimation<Color>(color),
                  ),
                ),
              ],
            ),
          );
        }),
      ],
    );
  }
}
