import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/hand_drawn_tokens.dart';

enum HandDrawnButtonVariant {
  primary, // Marker Red
  secondary, // Ballpoint Blue
  paper, // White Paper
  sticky, // Post-it Yellow
  muted, // Erased Pencil
}

class HandDrawnButton extends StatefulWidget {
  final String label;
  final IconData? icon;
  final VoidCallback? onPressed;
  final HandDrawnButtonVariant variant;
  final bool fullWidth;
  final EdgeInsetsGeometry padding;

  const HandDrawnButton({
    super.key,
    String? label,
    String? text,
    this.icon,
    required this.onPressed,
    this.variant = HandDrawnButtonVariant.primary,
    this.fullWidth = false,
    this.padding = const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
  }) : label = label ?? text ?? '';

  @override
  State<HandDrawnButton> createState() => _HandDrawnButtonState();
}

class _HandDrawnButtonState extends State<HandDrawnButton> {
  bool _isPressed = false;

  Color get _backgroundColor {
    switch (widget.variant) {
      case HandDrawnButtonVariant.primary:
        return HandDrawnTokens.markerRed;
      case HandDrawnButtonVariant.secondary:
        return HandDrawnTokens.ballpointBlue;
      case HandDrawnButtonVariant.paper:
        return HandDrawnTokens.cardWhite;
      case HandDrawnButtonVariant.sticky:
        return HandDrawnTokens.postItYellow;
      case HandDrawnButtonVariant.muted:
        return HandDrawnTokens.erasedPencil;
    }
  }

  Color get _textColor {
    switch (widget.variant) {
      case HandDrawnButtonVariant.primary:
      case HandDrawnButtonVariant.secondary:
        return Colors.white;
      case HandDrawnButtonVariant.paper:
      case HandDrawnButtonVariant.sticky:
      case HandDrawnButtonVariant.muted:
        return HandDrawnTokens.pencilBlack;
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget buttonContent = Row(
      mainAxisSize: widget.fullWidth ? MainAxisSize.max : MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (widget.icon != null) ...[
          Icon(widget.icon, size: 18, color: _textColor),
          const SizedBox(width: 8),
        ],
        Text(
          widget.label,
          style: GoogleFonts.kalam(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: _textColor,
          ),
        ),
      ],
    );

    return GestureDetector(
      onTapDown: widget.onPressed == null ? null : (_) => setState(() => _isPressed = true),
      onTapUp: widget.onPressed == null ? null : (_) => setState(() => _isPressed = false),
      onTapCancel: widget.onPressed == null ? null : () => setState(() => _isPressed = false),
      onTap: widget.onPressed,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 90),
        curve: Curves.easeInOut,
        transform: _isPressed ? Matrix4.translationValues(3, 3, 0) : Matrix4.identity(),
        padding: widget.padding,
        decoration: BoxDecoration(
          color: widget.onPressed == null ? HandDrawnTokens.erasedPencil : _backgroundColor,
          borderRadius: HandDrawnTokens.wobblyButton,
          border: Border.all(color: HandDrawnTokens.pencilBlack, width: 2.5),
          boxShadow: _isPressed || widget.onPressed == null
              ? HandDrawnTokens.hardShadowPressed
              : HandDrawnTokens.hardShadowMd,
        ),
        child: buttonContent,
      ),
    );
  }
}
