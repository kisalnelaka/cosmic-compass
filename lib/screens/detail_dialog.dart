import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/horoscope.dart';
import '../services/color_mapper.dart';
import '../widgets/glass_card.dart';
import '../widgets/luck_indicator_bar.dart';

class DetailDialog extends StatelessWidget {
  final Horoscope horoscope;

  const DetailDialog({super.key, required this.horoscope});

  @override
  Widget build(BuildContext context) {
    final color = ColorMapper.getColor(horoscope.luckyColor);
    final isTopThree = horoscope.rank <= 3;

    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 480),
          child: GlassCard(
            backgroundColor: const Color(0xFF0F172A).withValues(alpha: 0.96),
            borderColor: isTopThree ? const Color(0xFFFFD700).withValues(alpha: 0.5) : Colors.white.withValues(alpha: 0.15),
            borderRadius: 24,
            padding: const EdgeInsets.all(22),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Top Row: Rank Badge, Sign Name & Icon, Close Button
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 48,
                            height: 48,
                            decoration: BoxDecoration(
                              gradient: isTopThree
                                  ? const LinearGradient(colors: [Color(0xFFFFD700), Color(0xFFFFA000)])
                                  : const LinearGradient(colors: [Color(0xFF334155), Color(0xFF1E293B)]),
                              borderRadius: BorderRadius.circular(14),
                            ),
                            child: Center(
                              child: Text(
                                '#${horoscope.rank}',
                                style: GoogleFonts.outfit(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w900,
                                  color: isTopThree ? Colors.black : Colors.white,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 14),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    '${horoscope.icon} ${horoscope.signName}',
                                    style: GoogleFonts.outfit(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    horoscope.signNameJapanese,
                                    style: TextStyle(fontSize: 13, color: Colors.white.withValues(alpha: 0.6)),
                                  ),
                                ],
                              ),
                              Text(
                                horoscope.period,
                                style: TextStyle(fontSize: 12, color: Colors.white.withValues(alpha: 0.6)),
                              ),
                            ],
                          ),
                        ],
                      ),
                      IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: const Icon(Icons.close_rounded, color: Colors.white54, size: 20),
                      ),
                    ],
                  ),
                  const SizedBox(height: 18),

                  // Daily Advice Box
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.05),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.auto_awesome, color: Color(0xFFFFD700), size: 16),
                            const SizedBox(width: 8),
                            Text(
                              'DAILY ADVICE',
                              style: GoogleFonts.outfit(
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                                color: const Color(0xFFFFD700),
                                letterSpacing: 1.2,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          horoscope.description,
                          style: const TextStyle(
                            color: Colors.white,
                            height: 1.5,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Lucky Color & Lucky Item
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.06),
                            borderRadius: BorderRadius.circular(14),
                            border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'LUCKY COLOR',
                                style: GoogleFonts.outfit(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.white60, letterSpacing: 0.8),
                              ),
                              const SizedBox(height: 6),
                              Row(
                                children: [
                                  Container(width: 14, height: 14, decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: Text(
                                      horoscope.luckyColor,
                                      style: const TextStyle(fontSize: 13, color: Colors.white, fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.06),
                            borderRadius: BorderRadius.circular(14),
                            border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'LUCKY ITEM',
                                style: GoogleFonts.outfit(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.white60, letterSpacing: 0.8),
                              ),
                              const SizedBox(height: 6),
                              Text(
                                horoscope.luckyItem,
                                style: const TextStyle(fontSize: 13, color: Colors.white, fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // 4 Segmented Luck Indicator Bars
                  LuckIndicatorBar(label: 'Money', score: horoscope.moneyLuck, icon: Icons.attach_money_rounded, color: const Color(0xFFFFD700)),
                  LuckIndicatorBar(label: 'Love', score: horoscope.loveLuck, icon: Icons.favorite_rounded, color: const Color(0xFFFF4081)),
                  LuckIndicatorBar(label: 'Work', score: horoscope.workLuck, icon: Icons.work_outline_rounded, color: const Color(0xFF00E5FF)),
                  LuckIndicatorBar(label: 'Health', score: horoscope.healthLuck, icon: Icons.spa_outlined, color: const Color(0xFF69F0AE)),
                  const SizedBox(height: 20),

                  // Dismiss Button
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton(
                      onPressed: () => Navigator.pop(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white.withValues(alpha: 0.08),
                        foregroundColor: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                      ),
                      child: Text('Close', style: GoogleFonts.outfit(fontSize: 14, fontWeight: FontWeight.bold)),
                    ),
                  ),
                ],
              ),
            ),
          ).animate().scale(duration: 300.ms, curve: Curves.easeOutBack),
        ),
      ),
    );
  }
}
