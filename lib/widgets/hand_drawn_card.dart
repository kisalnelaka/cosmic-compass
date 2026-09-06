import 'package:flutter/material.dart';
import '../theme/hand_drawn_tokens.dart';

enum HandDrawnCardDecoration {
  none,
  tape,
  thumbtack,
  pin,
  postIt,
}

class HandDrawnCard extends StatefulWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final Color? backgroundColor;
  final Color? borderColor;
  final double borderWidth;
  final BorderRadius? borderRadius;
  final List<BoxShadow>? boxShadow;
  final HandDrawnCardDecoration decoration;
  final double rotation; // Radians, e.g. -0.015 (-0.8deg)
  final VoidCallback? onTap;

  const HandDrawnCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(16),
    this.margin,
    this.backgroundColor,
    this.borderColor,
    this.borderWidth = 2.5,
    this.borderRadius,
    this.boxShadow,
    this.decoration = HandDrawnCardDecoration.none,
    this.rotation = 0.0,
    this.onTap,
  });

  @override
  State<HandDrawnCard> createState() => _HandDrawnCardState();
}

class _HandDrawnCardState extends State<HandDrawnCard> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    final bg = widget.decoration == HandDrawnCardDecoration.postIt
        ? HandDrawnTokens.postItYellow
        : (widget.backgroundColor ?? HandDrawnTokens.cardWhite);

    final borderC = widget.borderColor ?? HandDrawnTokens.pencilBlack;
    final r = widget.borderRadius ?? HandDrawnTokens.wobblyMd;
    final effectiveShadow = widget.boxShadow ??
        (_isPressed
            ? HandDrawnTokens.hardShadowPressed
            : HandDrawnTokens.hardShadowMd);

    final double effectiveRotation = widget.decoration == HandDrawnCardDecoration.postIt && widget.rotation == 0.0
        ? -0.015
        : widget.rotation;

    Widget cardBody = AnimatedContainer(
      duration: const Duration(milliseconds: 90),
      curve: Curves.easeInOut,
      transform: _isPressed
          ? Matrix4.translationValues(2, 2, 0)
          : Matrix4.identity(),
      padding: widget.padding,
      decoration: BoxDecoration(
        color: bg,
        borderRadius: r,
        border: Border.all(
          color: borderC,
          width: widget.borderWidth,
        ),
        boxShadow: effectiveShadow,
      ),
      child: widget.child,
    );

    if (widget.onTap != null) {
      cardBody = GestureDetector(
        onTapDown: (_) => setState(() => _isPressed = true),
        onTapUp: (_) => setState(() => _isPressed = false),
        onTapCancel: () => setState(() => _isPressed = false),
        onTap: widget.onTap,
        child: cardBody,
      );
    }

    Widget decorated = Stack(
      clipBehavior: Clip.none,
      children: [
        cardBody,
        if (widget.decoration == HandDrawnCardDecoration.tape)
          const Positioned(
            top: -10,
            left: 0,
            right: 0,
            child: Center(
              child: TapeStrip(),
            ),
          ),
        if (widget.decoration == HandDrawnCardDecoration.thumbtack ||
            widget.decoration == HandDrawnCardDecoration.pin)
          const Positioned(
            top: -9,
            left: 0,
            right: 0,
            child: Center(
              child: ThumbtackPin(),
            ),
          ),
      ],
    );

    if (effectiveRotation != 0.0) {
      decorated = Transform.rotate(
        angle: effectiveRotation,
        child: decorated,
      );
    }

    if (widget.margin != null) {
      decorated = Padding(
        padding: widget.margin!,
        child: decorated,
      );
    }

    return decorated;
  }
}

/// A sketched masking tape strip with subtle rotation
class TapeStrip extends StatelessWidget {
  final double width;
  final double height;
  final double angle;

  const TapeStrip({
    super.key,
    this.width = 72,
    this.height = 18,
    this.angle = -0.03, // approx -1.7 degrees
  });

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: angle,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: const Color(0xCCEAE4D8),
          border: Border.all(
            color: HandDrawnTokens.pencilBlack.withValues(alpha: 0.25),
            width: 1.0,
          ),
          borderRadius: BorderRadius.circular(2),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.08),
              offset: const Offset(1, 1),
              blurRadius: 0,
            ),
          ],
        ),
      ),
    );
  }
}

/// A hand-drawn red thumbtack pin
class ThumbtackPin extends StatelessWidget {
  const ThumbtackPin({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 18,
      height: 18,
      decoration: BoxDecoration(
        color: HandDrawnTokens.markerRed,
        shape: BoxShape.circle,
        border: Border.all(color: HandDrawnTokens.pencilBlack, width: 2),
        boxShadow: const [
          BoxShadow(
            color: HandDrawnTokens.pencilBlack,
            offset: Offset(2, 2),
            blurRadius: 0,
          ),
        ],
      ),
      child: Center(
        child: Container(
          width: 5,
          height: 5,
          decoration: const BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
          ),
        ),
      ),
    );
  }
}
