import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import '../services/calculators/norse_rune_calculator.dart';
import '../widgets/glass_card.dart';

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
          child: GlassCard(
            backgroundColor: const Color(0xFF0F172A).withValues(alpha: 0.95),
            borderColor: const Color(0xFF38BDF8).withValues(alpha: 0.4),
            borderRadius: 24,
            padding: const EdgeInsets.all(24),
            child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Text('ᛟ', style: TextStyle(fontSize: 22, color: Color(0xFF38BDF8))),
                    const SizedBox(width: 8),
                    Text(
                      'Elder Futhark Rune Cast',
                      style: GoogleFonts.outfit(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                IconButton(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: const Icon(Icons.close, color: Colors.white54, size: 20),
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
                  color: Colors.white.withValues(alpha: 0.05),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: const Color(0xFF38BDF8), width: 2),
                ),
                child: const Center(
                  child: Text('ᛉ', style: TextStyle(fontSize: 48, color: Color(0xFF38BDF8))),
                ),
              ).animate(onPlay: (controller) => controller.repeat())
                  .shimmer(duration: 800.ms, color: const Color(0xFF38BDF8))
                  .scale(begin: const Offset(0.95, 0.95), end: const Offset(1.05, 1.05)),
              const SizedBox(height: 24),
              Text(
                'Casting into the Well of Urðr...',
                style: GoogleFonts.outfit(color: Colors.white70, fontSize: 14),
              ),
              const SizedBox(height: 30),
            ] else ...[
              Container(
                width: 110,
                height: 130,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Color(0xFF1E293B), Color(0xFF0F172A)],
                  ),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: const Color(0xFF38BDF8), width: 2.5),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF38BDF8).withValues(alpha: 0.4),
                      blurRadius: 20,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: Center(
                  child: Text(
                    _drawnRune.symbol,
                    style: const TextStyle(fontSize: 64, color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ).animate().scale(begin: const Offset(0.7, 0.7), end: const Offset(1.0, 1.0), duration: 400.ms).fadeIn(),
              const SizedBox(height: 16),
              Text(
                _drawnRune.name.toUpperCase(),
                style: GoogleFonts.outfit(
                  fontSize: 22,
                  fontWeight: FontWeight.w900,
                  color: const Color(0xFF38BDF8),
                  letterSpacing: 2,
                ),
              ),
              Text(
                _drawnRune.translation,
                textAlign: TextAlign.center,
                style: GoogleFonts.outfit(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFFFFD700),
                ),
              ),
              const SizedBox(height: 6),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  '${_drawnRune.aett} • Element: ${_drawnRune.element}',
                  style: const TextStyle(fontSize: 11, color: Colors.white60),
                ),
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.05),
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
                ),
                child: Text(
                  _drawnRune.divineAdvice,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.outfit(
                    fontSize: 13,
                    height: 1.4,
                    color: Colors.white.withValues(alpha: 0.9),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: _castRune,
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: const Color(0xFF38BDF8).withValues(alpha: 0.5)),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                      child: Text(
                        'Draw Another Rune',
                        style: GoogleFonts.outfit(color: const Color(0xFF38BDF8), fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => Navigator.of(context).pop(),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF38BDF8),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                      child: Text(
                        'Accept Stave',
                        style: GoogleFonts.outfit(color: Colors.black, fontWeight: FontWeight.bold),
                      ),
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
