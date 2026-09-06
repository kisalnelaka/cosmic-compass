import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/hand_drawn_tokens.dart';

enum HandDrawnBadgeStyle {
  pill,
  stickyTag,
  outline,
}

class HandDrawnBadge extends StatelessWidget {
  final String label;
  final IconData? icon;
  final Color? backgroundColor;
  final Color? textColor;
  final HandDrawnBadgeStyle style;
  final double rotation;

  const HandDrawnBadge({
    super.key,
    required this.label,
    this.icon,
    Color? color,
    this.backgroundColor,
    this.textColor,
    this.style = HandDrawnBadgeStyle.pill,
    bool isPostIt = false,
    this.rotation = 0.0,
  })  : _color = color,
        _isPostIt = isPostIt;

  final Color? _color;
  final bool _isPostIt;

  @override
  Widget build(BuildContext context) {
    Color bg;
    Color fg;

    final effectiveStyle = _isPostIt ? HandDrawnBadgeStyle.stickyTag : style;
    final baseColor = _color ?? backgroundColor;

    switch (effectiveStyle) {
      case HandDrawnBadgeStyle.stickyTag:
        bg = baseColor ?? HandDrawnTokens.postItYellow;
        break;
      case HandDrawnBadgeStyle.outline:
        bg = baseColor ?? Colors.white;
        break;
      case HandDrawnBadgeStyle.pill:
        bg = baseColor ?? HandDrawnTokens.warmPaper;
        break;
    }

    final lum = bg.computeLuminance();
    fg = textColor ?? (lum > 0.45 ? HandDrawnTokens.pencilBlack : Colors.white);

    Widget badge = Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: HandDrawnTokens.wobblyBadge,
        border: Border.all(color: HandDrawnTokens.pencilBlack, width: 2.0),
        boxShadow: const [
          BoxShadow(
            color: HandDrawnTokens.pencilBlack,
            offset: Offset(2, 2),
            blurRadius: 0,
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, size: 14, color: fg),
            const SizedBox(width: 4),
          ],
          Flexible(
            child: Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.patrickHand(
                fontSize: 13,
                fontWeight: FontWeight.bold,
                color: fg,
                height: 1.2,
              ),
            ),
          ),
        ],
      ),
    );

    if (rotation != 0.0) {
      badge = Transform.rotate(angle: rotation, child: badge);
    }

    return badge;
  }
}
