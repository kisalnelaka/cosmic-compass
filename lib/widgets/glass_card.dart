import 'package:flutter/material.dart';
import '../theme/hand_drawn_tokens.dart';

class GlassCard extends StatefulWidget {
  final Widget child;
  final double borderRadius;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final Color? borderColor;
  final Color? backgroundColor;
  final Gradient? gradient;
  final VoidCallback? onTap;

  const GlassCard({
    super.key,
    required this.child,
    this.borderRadius = 20,
    this.padding = const EdgeInsets.all(16),
    this.margin,
    this.borderColor,
    this.backgroundColor,
    this.gradient,
    this.onTap,
  });

  @override
  State<GlassCard> createState() => _GlassCardState();
}

class _GlassCardState extends State<GlassCard> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    final bg = widget.backgroundColor != null &&
            widget.backgroundColor!.computeLuminance() < 0.3
        ? HandDrawnTokens.cardWhite // Convert old dark colors to clean card white
        : (widget.backgroundColor ?? HandDrawnTokens.cardWhite);

    final borderC = widget.borderColor != null &&
            widget.borderColor!.computeLuminance() > 0.8
        ? HandDrawnTokens.pencilBlack
        : (widget.borderColor ?? HandDrawnTokens.pencilBlack);

    Widget content = AnimatedContainer(
      duration: const Duration(milliseconds: 90),
      curve: Curves.easeInOut,
      transform: _isPressed ? Matrix4.translationValues(2, 2, 0) : Matrix4.identity(),
      padding: widget.padding,
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(widget.borderRadius),
        border: Border.all(
          color: borderC,
          width: 2.5,
        ),
        boxShadow: _isPressed
            ? HandDrawnTokens.hardShadowPressed
            : HandDrawnTokens.hardShadowMd,
      ),
      child: widget.child,
    );

    if (widget.margin != null) {
      content = Padding(padding: widget.margin!, child: content);
    }

    if (widget.onTap != null) {
      return GestureDetector(
        onTapDown: (_) => setState(() => _isPressed = true),
        onTapUp: (_) => setState(() => _isPressed = false),
        onTapCancel: () => setState(() => _isPressed = false),
        onTap: widget.onTap,
        child: content,
      );
    }

    return content;
  }
}
