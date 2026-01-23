import 'package:flutter/material.dart';

class ColorMapper {
  static Color fromName(String name) {
    final lowerName = name.toLowerCase();
    
    final map = {
      'pink': Colors.pinkAccent,
      'red': Colors.redAccent,
      'blue': Colors.blueAccent,
      'light blue': Colors.lightBlueAccent,
      'navy': const Color(0xFF000080),
      'green': Colors.greenAccent,
      'yellow': Colors.yellowAccent,
      'orange': Colors.orangeAccent,
      'purple': Colors.purpleAccent,
      'lavender': const Color(0xFFE6E6FA),
      'white': Colors.white,
      'black': Colors.black,
      'gold': const Color(0xFFFFD700),
      'silver': const Color(0xFFC0C0C0),
      'brown': Colors.brown,
      'gray': Colors.grey,
      'grey': Colors.grey,
    };

    for (var entry in map.entries) {
      if (lowerName.contains(entry.key)) {
        return entry.value;
      }
    }
    
    return Colors.white54; // Default
  }
}
