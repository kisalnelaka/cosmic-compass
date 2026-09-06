import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../models/horoscope.dart';
import '../services/color_mapper.dart';
import '../theme/hand_drawn_tokens.dart';
import '../widgets/hand_drawn_card.dart';
import '../widgets/hand_drawn_button.dart';
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
          child: HandDrawnCard(
            decoration: HandDrawnCardDecoration.tape,
            backgroundColor: isTopThree ? HandDrawnTokens.postItYellow : HandDrawnTokens.cardWhite,
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
                              color: isTopThree ? HandDrawnTokens.markerRed : HandDrawnTokens.warmPaper,
                              borderRadius: HandDrawnTokens.wobblySm,
                              border: Border.all(color: HandDrawnTokens.pencilBlack, width: 2),
                              boxShadow: HandDrawnTokens.hardShadowSm,
                            ),
                            child: Center(
                              child: Text(
                                '#${horoscope.rank}',
                                style: HandDrawnTokens.headingFont(
                                  fontSize: 22,
                                  fontWeight: FontWeight.w900,
                                  color: isTopThree ? HandDrawnTokens.warmPaper : HandDrawnTokens.pencilBlack,
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
                                    style: HandDrawnTokens.headingFont(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: HandDrawnTokens.pencilBlack,
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    horoscope.signNameJapanese,
                                    style: HandDrawnTokens.bodyFont(
                                      fontSize: 14,
                                      color: HandDrawnTokens.erasedPencil,
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                horoscope.period,
                                style: HandDrawnTokens.bodyFont(
                                  fontSize: 13,
                                  color: HandDrawnTokens.erasedPencil,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: Icon(Icons.close_rounded, color: HandDrawnTokens.pencilBlack, size: 22),
                      ),
                    ],
                  ),
                  const SizedBox(height: 18),

                  // Daily Advice Box
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
                        Row(
                          children: [
                            Icon(Icons.auto_awesome, color: HandDrawnTokens.markerRed, size: 18),
                            const SizedBox(width: 8),
                            Text(
                              'DAILY ADVICE',
                              style: HandDrawnTokens.headingFont(
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                                color: HandDrawnTokens.markerRed,
                                letterSpacing: 1.2,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          horoscope.description,
                          style: HandDrawnTokens.bodyFont(
                            color: HandDrawnTokens.pencilBlack,
                            height: 1.5,
                            fontSize: 14.5,
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
                            color: HandDrawnTokens.warmPaper,
                            borderRadius: HandDrawnTokens.wobblySm,
                            border: Border.all(color: HandDrawnTokens.pencilBlack, width: 1.5),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'LUCKY COLOR',
                                style: HandDrawnTokens.headingFont(
                                  fontSize: 10.5,
                                  fontWeight: FontWeight.bold,
                                  color: HandDrawnTokens.erasedPencil,
                                  letterSpacing: 0.8,
                                ),
                              ),
                              const SizedBox(height: 6),
                              Row(
                                children: [
                                  Container(
                                    width: 14,
                                    height: 14,
                                    decoration: BoxDecoration(
                                      color: color,
                                      shape: BoxShape.circle,
                                      border: Border.all(color: HandDrawnTokens.pencilBlack, width: 1.5),
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: Text(
                                      horoscope.luckyColor,
                                      style: HandDrawnTokens.bodyFont(
                                        fontSize: 14,
                                        color: HandDrawnTokens.pencilBlack,
                                        fontWeight: FontWeight.bold,
                                      ),
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
                            color: HandDrawnTokens.warmPaper,
                            borderRadius: HandDrawnTokens.wobblySm,
                            border: Border.all(color: HandDrawnTokens.pencilBlack, width: 1.5),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'LUCKY ITEM',
                                style: HandDrawnTokens.headingFont(
                                  fontSize: 10.5,
                                  fontWeight: FontWeight.bold,
                                  color: HandDrawnTokens.erasedPencil,
                                  letterSpacing: 0.8,
                                ),
                              ),
                              const SizedBox(height: 6),
                              Text(
                                horoscope.luckyItem,
                                style: HandDrawnTokens.bodyFont(
                                  fontSize: 14,
                                  color: HandDrawnTokens.pencilBlack,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // 4 Segmented Luck Indicator Bars
                  LuckIndicatorBar(label: 'Money', score: horoscope.moneyLuck, icon: Icons.attach_money_rounded, color: const Color(0xFFD97706)),
                  LuckIndicatorBar(label: 'Love', score: horoscope.loveLuck, icon: Icons.favorite_rounded, color: HandDrawnTokens.markerRed),
                  LuckIndicatorBar(label: 'Work', score: horoscope.workLuck, icon: Icons.work_outline_rounded, color: HandDrawnTokens.ballpointBlue),
                  LuckIndicatorBar(label: 'Health', score: horoscope.healthLuck, icon: Icons.spa_outlined, color: const Color(0xFF16A34A)),
                  const SizedBox(height: 20),

                  // Dismiss Button
                  SizedBox(
                    width: double.infinity,
                    child: HandDrawnButton(
                      text: 'Close Window',
                      variant: HandDrawnButtonVariant.secondary,
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                ],
              ),
            ),
          ).animate().scale(duration: 250.ms, curve: Curves.easeOutBack),
        ),
      ),
    );
  }
}
