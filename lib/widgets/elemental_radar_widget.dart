import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/cosmic_synthesis.dart';
import '../theme/hand_drawn_tokens.dart';
import 'hand_drawn_badge.dart';

class ElementalRadarWidget extends StatelessWidget {
  final ElementalBalance balance;

  const ElementalRadarWidget({super.key, required this.balance});

  @override
  Widget build(BuildContext context) {
    final elements = [
      {'name': 'Fire', 'symbol': '🔥', 'val': balance.fire, 'color': HandDrawnTokens.markerRed},
      {'name': 'Earth', 'symbol': '🌍', 'val': balance.earth, 'color': const Color(0xFF4CAF50)},
      {'name': 'Air', 'symbol': '🌬️', 'val': balance.air, 'color': HandDrawnTokens.ballpointBlue},
      {'name': 'Water', 'symbol': '💧', 'val': balance.water, 'color': const Color(0xFF00ACC1)},
      {'name': 'Ether / Wood', 'symbol': '✨', 'val': balance.ether, 'color': const Color(0xFF8E24AA)},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Elemental Harmony Matrix',
              style: GoogleFonts.kalam(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: HandDrawnTokens.pencilBlack,
              ),
            ),
            HandDrawnBadge(
              label: 'Dominant: ${balance.dominantElement}',
              style: HandDrawnBadgeStyle.stickyTag,
              backgroundColor: HandDrawnTokens.postItYellow,
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
                        Text(item['symbol'] as String, style: const TextStyle(fontSize: 15)),
                        const SizedBox(width: 8),
                        Text(
                          item['name'] as String,
                          style: GoogleFonts.patrickHand(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: HandDrawnTokens.pencilBlack,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      '$pct%',
                      style: GoogleFonts.patrickHand(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: color,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                Container(
                  height: 10,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: HandDrawnTokens.erasedPencil,
                    borderRadius: BorderRadius.circular(3),
                    border: Border.all(color: HandDrawnTokens.pencilBlack, width: 1.5),
                  ),
                  alignment: Alignment.centerLeft,
                  child: FractionallySizedBox(
                    widthFactor: val.clamp(0.04, 1.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: color,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
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
