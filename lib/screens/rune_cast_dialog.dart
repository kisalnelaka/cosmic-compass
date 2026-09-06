import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../services/calculators/norse_rune_calculator.dart';
import '../theme/hand_drawn_tokens.dart';
import '../widgets/hand_drawn_card.dart';
import '../widgets/hand_drawn_button.dart';

class RuneCastDialog extends StatefulWidget {
  const RuneCastDialog({super.key});

  @override
  State<RuneCastDialog> createState() => _RuneCastDialogState();
}

class _RuneCastDialogState extends State<RuneCastDialog> {
  bool _isCasting = true;
  late NorseRuneData _drawnRune;

  @override
  void initState() {
    super.initState();
    _castRune();
  }

  void _castRune() {
    setState(() {
      _isCasting = true;
    });

    Future.delayed(const Duration(milliseconds: 900), () {
      if (mounted) {
        setState(() {
          _drawnRune = NorseRuneCalculator.castRandomRune();
          _isCasting = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 480),
          child: HandDrawnCard(
            decoration: HandDrawnCardDecoration.tape,
            backgroundColor: HandDrawnTokens.cardWhite,
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text(
                          'ᛟ',
                          style: TextStyle(
                            fontSize: 24,
                            color: HandDrawnTokens.ballpointBlue,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'Elder Futhark Rune Cast',
                          style: HandDrawnTokens.headingFont(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: HandDrawnTokens.pencilBlack,
                          ),
                        ),
                      ],
                    ),
                    IconButton(
                      onPressed: () => Navigator.of(context).pop(),
                      icon: Icon(Icons.close, color: HandDrawnTokens.pencilBlack, size: 22),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                if (_isCasting) ...[
                  const SizedBox(height: 30),
                  Container(
                    width: 100,
                    height: 120,
                    decoration: BoxDecoration(
                      color: HandDrawnTokens.warmPaper,
                      borderRadius: HandDrawnTokens.wobblySm,
                      border: Border.all(color: HandDrawnTokens.pencilBlack, width: 2),
                      boxShadow: HandDrawnTokens.hardShadowSm,
                    ),
                    child: Center(
                      child: Text(
                        'ᛉ',
                        style: TextStyle(
                          fontSize: 48,
                          color: HandDrawnTokens.ballpointBlue,
                        ),
                      ),
                    ),
                  )
                      .animate(onPlay: (controller) => controller.repeat())
                      .scale(begin: const Offset(0.95, 0.95), end: const Offset(1.05, 1.05)),
                  const SizedBox(height: 24),
                  Text(
                    'Casting into the Well of Urðr...',
                    style: HandDrawnTokens.bodyFont(
                      color: HandDrawnTokens.erasedPencil,
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(height: 30),
                ] else ...[
                  Container(
                    width: 110,
                    height: 130,
                    decoration: BoxDecoration(
                      color: HandDrawnTokens.warmPaper,
                      borderRadius: HandDrawnTokens.wobblySm,
                      border: Border.all(color: HandDrawnTokens.pencilBlack, width: 2.5),
                      boxShadow: HandDrawnTokens.hardShadowMd,
                    ),
                    child: Center(
                      child: Text(
                        _drawnRune.symbol,
                        style: TextStyle(
                          fontSize: 64,
                          color: HandDrawnTokens.pencilBlack,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ).animate().scale(begin: const Offset(0.7, 0.7), end: const Offset(1.0, 1.0), duration: 300.ms),
                  const SizedBox(height: 16),
                  Text(
                    _drawnRune.name.toUpperCase(),
                    style: HandDrawnTokens.headingFont(
                      fontSize: 22,
                      fontWeight: FontWeight.w900,
                      color: HandDrawnTokens.markerRed,
                      letterSpacing: 2,
                    ),
                  ),
                  Text(
                    _drawnRune.translation,
                    textAlign: TextAlign.center,
                    style: HandDrawnTokens.bodyFont(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: HandDrawnTokens.pencilBlack,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: HandDrawnTokens.warmPaper,
                      borderRadius: HandDrawnTokens.wobblyBadge,
                      border: Border.all(color: HandDrawnTokens.pencilBlack, width: 1.5),
                    ),
                    child: Text(
                      '${_drawnRune.aett} • Element: ${_drawnRune.element}',
                      style: HandDrawnTokens.bodyFont(fontSize: 12, color: HandDrawnTokens.erasedPencil),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: HandDrawnTokens.warmPaper,
                      borderRadius: HandDrawnTokens.wobblySm,
                      border: Border.all(color: HandDrawnTokens.pencilBlack, width: 1.5),
                    ),
                    child: Text(
                      _drawnRune.divineAdvice,
                      textAlign: TextAlign.center,
                      style: HandDrawnTokens.bodyFont(
                        fontSize: 14.5,
                        height: 1.45,
                        color: HandDrawnTokens.pencilBlack,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: HandDrawnButton(
                          text: 'Draw Another',
                          variant: HandDrawnButtonVariant.secondary,
                          onPressed: _castRune,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: HandDrawnButton(
                          text: 'Accept Stave',
                          variant: HandDrawnButtonVariant.primary,
                          onPressed: () => Navigator.of(context).pop(),
                        ),
                      ),
                    ],
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
