import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Hand-Drawn Sketchbook Design Tokens
/// Inspired by physical artist notebooks, paper textures, 2B pencil lead,
/// red correction markers, blue ballpoint pens, and sticky notes.
class HandDrawnTokens {
  // --- PALETTE ---
  static const Color warmPaper = Color(0xFFFDFBF7);
  static const Color cardWhite = Color(0xFFFFFFFF);
  static const Color pencilBlack = Color(0xFF22201D);
  static const Color erasedPencil = Color(0xFF524E48); // High contrast dark graphite lead (WCAG AAA compliant)
  static const Color faintPencil = Color(0xFF78726A);  // Medium graphite for placeholders/hints
  static const Color emptySlot = Color(0xFFEFEBE4);    // Tint for unfilled gauge segments
  static const Color markerRed = Color(0xFFD32F2F);
  static const Color ballpointBlue = Color(0xFF1E40AF);
  static const Color postItYellow = Color(0xFFFFF9C4);
  static const Color highlighterGreen = Color(0xFFC8E6C9);
  static const Color highlighterPurple = Color(0xFFE1BEE7);
  static const Color highlighterOrange = Color(0xFFFFE0B2);
  static const Color tapeColor = Color(0xD9E5E0D8);

  // --- WOBBLY BORDER RADII ---
  static const BorderRadius wobblySm = BorderRadius.only(
    topLeft: Radius.elliptical(14, 10),
    topRight: Radius.elliptical(10, 14),
    bottomRight: Radius.elliptical(14, 9),
    bottomLeft: Radius.elliptical(9, 14),
  );

  static const BorderRadius wobblyMd = BorderRadius.only(
    topLeft: Radius.elliptical(22, 16),
    topRight: Radius.elliptical(16, 22),
    bottomRight: Radius.elliptical(22, 14),
    bottomLeft: Radius.elliptical(14, 22),
  );

  static const BorderRadius wobblyLg = BorderRadius.only(
    topLeft: Radius.elliptical(32, 20),
    topRight: Radius.elliptical(18, 30),
    bottomRight: Radius.elliptical(30, 18),
    bottomLeft: Radius.elliptical(18, 28),
  );

  static const BorderRadius wobblyButton = BorderRadius.only(
    topLeft: Radius.elliptical(25, 14),
    topRight: Radius.elliptical(14, 24),
    bottomRight: Radius.elliptical(24, 14),
    bottomLeft: Radius.elliptical(14, 25),
  );

  static const BorderRadius wobblyBadge = BorderRadius.only(
    topLeft: Radius.elliptical(12, 8),
    topRight: Radius.elliptical(8, 12),
    bottomRight: Radius.elliptical(12, 7),
    bottomLeft: Radius.elliptical(7, 12),
  );

  // --- HARD OFFSET BOX SHADOWS (NO BLUR) ---
  static const List<BoxShadow> hardShadowSm = [
    BoxShadow(
      color: pencilBlack,
      offset: Offset(2, 2),
      blurRadius: 0,
      spreadRadius: 0,
    ),
  ];

  static const List<BoxShadow> hardShadowMd = [
    BoxShadow(
      color: pencilBlack,
      offset: Offset(4, 4),
      blurRadius: 0,
      spreadRadius: 0,
    ),
  ];

  static const List<BoxShadow> hardShadowLg = [
    BoxShadow(
      color: pencilBlack,
      offset: Offset(6, 6),
      blurRadius: 0,
      spreadRadius: 0,
    ),
  ];

  static const List<BoxShadow> hardShadowPressed = [
    BoxShadow(
      color: pencilBlack,
      offset: Offset(1, 1),
      blurRadius: 0,
      spreadRadius: 0,
    ),
  ];

  // --- TYPOGRAPHY ---
  static TextStyle headingLarge({Color color = pencilBlack}) => GoogleFonts.kalam(
        fontSize: 26,
        fontWeight: FontWeight.bold,
        color: color,
        height: 1.2,
      );

  static TextStyle headingMedium({Color color = pencilBlack}) => GoogleFonts.kalam(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: color,
        height: 1.25,
      );

  static TextStyle headingSmall({Color color = pencilBlack}) => GoogleFonts.kalam(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: color,
        height: 1.25,
      );

  static TextStyle bodyLarge({Color color = pencilBlack}) => GoogleFonts.patrickHand(
        fontSize: 18,
        fontWeight: FontWeight.normal,
        color: color,
        height: 1.4,
      );

  static TextStyle bodyMedium({Color color = pencilBlack}) => GoogleFonts.patrickHand(
        fontSize: 16,
        fontWeight: FontWeight.normal,
        color: color,
        height: 1.4,
      );

  static TextStyle bodySmall({Color color = pencilBlack}) => GoogleFonts.patrickHand(
        fontSize: 14,
        fontWeight: FontWeight.normal,
        color: color,
        height: 1.35,
      );

  // --- DYNAMIC FONT CONSTRUCTORS ---
  static TextStyle headingFont({
    double? fontSize,
    FontWeight? fontWeight,
    Color? color,
    double? letterSpacing,
    double? height,
    FontStyle? fontStyle,
  }) =>
      GoogleFonts.kalam(
        fontSize: fontSize ?? 18,
        fontWeight: fontWeight ?? FontWeight.bold,
        color: color ?? pencilBlack,
        letterSpacing: letterSpacing,
        height: height ?? 1.25,
        fontStyle: fontStyle,
      );

  static TextStyle bodyFont({
    double? fontSize,
    FontWeight? fontWeight,
    Color? color,
    double? letterSpacing,
    double? height,
    FontStyle? fontStyle,
  }) =>
      GoogleFonts.patrickHand(
        fontSize: fontSize ?? 15,
        fontWeight: fontWeight ?? FontWeight.normal,
        color: color ?? pencilBlack,
        letterSpacing: letterSpacing,
        height: height ?? 1.35,
        fontStyle: fontStyle,
      );
}
