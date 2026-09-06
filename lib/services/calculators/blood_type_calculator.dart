import 'package:flutter/material.dart';
import '../../models/cultural_profiles.dart';
import '../../models/user_profile.dart';

class BloodTypeCalculator {
  static BloodTypeChart calculate(UserProfile profile) {
    switch (profile.bloodType) {
      case BloodType.a:
        return const BloodTypeChart(
          signName: 'Blood Type A (農耕民族 - Methodical Farmer Archetype)',
          symbol: '🅰️',
          element: 'Earth & Water',
          rulingForce: 'Ketsuekigata Principle of Harmony & Perfectionism',
          essence: 'Deeply sensible, punctual, polite, cooperative, meticulous attention to detail.',
          destinyAdvice: 'Your conscientiousness builds unbreakable trust, but beware of internalizing excessive stress.',
          accentColor: Color(0xFF27AE60),
          idealWorkplaceRole: 'Chief Quality Architect, Strategic Coordinator, Trusted Manager',
          compatibility: 'Best paired with Type O (grounding support) & Type A (mutual respect)',
          dailySocialAdvice: 'Take short mindful pauses today; do not shoulder collective burdens alone.',
        );
      case BloodType.b:
        return const BloodTypeChart(
          signName: 'Blood Type B (遊牧民族 - Passionate Nomad Archetype)',
          symbol: '🅱️',
          element: 'Fire & Air',
          rulingForce: 'Ketsuekigata Principle of Freedom & Originality',
          essence: 'Creative dynamo, intensely passionate, independent, non-conformist, honest.',
          destinyAdvice: 'Follow your uninhibited creative sparks, but remember to finish what you boldly inaugurate.',
          accentColor: Color(0xFFE74C3C),
          idealWorkplaceRole: 'Solo Innovator, Creative Director, Maverick Pioneer',
          compatibility: 'Best paired with Type AB (shared curiosity) & Type O (mutual admiration)',
          dailySocialAdvice: 'Channel spontaneous bursts into a single high-leverage project today.',
        );
      case BloodType.ab:
        return const BloodTypeChart(
          signName: 'Blood Type AB (二重性 - Enigmatic Synthesist Archetype)',
          symbol: '🆎',
          element: 'Air & Ether',
          rulingForce: 'Ketsuekigata Principle of Dual Intellect & Logic',
          essence: 'Rational, multi-faceted, calm under crisis, highly observant, esoteric charm.',
          destinyAdvice: 'Embrace your dual perspectives as a cosmic bridge connecting contradictory viewpoints.',
          accentColor: Color(0xFF8E44AD),
          idealWorkplaceRole: 'Diplomatic Negotiator, High-Level Systems Architect, Critic',
          compatibility: 'Best paired with Type AB (deep soul rapport) & Type B (creative spark)',
          dailySocialAdvice: 'Carve out solitary contemplation time to recharge your mental battery.',
        );
      case BloodType.o:
        return const BloodTypeChart(
          signName: 'Blood Type O (狩猟民族 - Resilient Warrior/Leader Archetype)',
          symbol: '🅾️',
          element: 'Fire & Earth',
          rulingForce: 'Ketsuekigata Principle of Ambition & Resilience',
          essence: 'Magnetic charisma, bold optimism, natural leader, generous, robust constitution.',
          destinyAdvice: 'Your generous vitality inspires the room; lead with servant-heart humility.',
          accentColor: Color(0xFFF39C12),
          idealWorkplaceRole: 'Executive Founder, Dynamic Commander, Community Pillar',
          compatibility: 'Best paired with Type A (structured execution) & Type B (dynamic thrill)',
          dailySocialAdvice: 'Inspire a colleague today; your natural optimism clears anxiety.',
        );
    }
  }
}
