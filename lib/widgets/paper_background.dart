import 'package:flutter/material.dart';
import '../theme/hand_drawn_tokens.dart';

class PaperBackground extends StatelessWidget {
  final Widget child;
  final bool showDots;

  const PaperBackground({
    super.key,
    required this.child,
    this.showDots = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: HandDrawnTokens.warmPaper,
      child: CustomPaint(
        painter: showDots ? _NotebookDotGridPainter() : null,
        child: child,
      ),
    );
  }
}

class _NotebookDotGridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = HandDrawnTokens.erasedPencil.withValues(alpha: 0.85)
      ..style = PaintingStyle.fill;

    const spacing = 24.0;
    const dotRadius = 1.1;

    for (double y = spacing; y < size.height; y += spacing) {
      for (double x = spacing; x < size.width; x += spacing) {
        canvas.drawCircle(Offset(x, y), dotRadius, paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
