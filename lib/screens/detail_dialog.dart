import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/horoscope.dart';

class DetailDialog extends StatelessWidget {
  final Horoscope horoscope;

  const DetailDialog({super.key, required this.horoscope});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFF1E1E1E),
          borderRadius: BorderRadius.circular(32),
          border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              _buildHeader(),
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  children: [
                    _buildLuckSection(),
                    const SizedBox(height: 32),
                    _buildAdviceSection(),
                    const SizedBox(height: 32),
                    _buildBottomInfo(),
                    const SizedBox(height: 32),
                    _buildCloseButton(context),
                  ],
                ),
              ),
            ],
          ),
        ).animate().scale(duration: 400.ms, curve: Curves.easeOutBack),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 40),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF6A11CB), Color(0xFF2575FC)],
        ),
        borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
      ),
      child: Column(
        children: [
          Text(
            horoscope.icon,
            style: const TextStyle(fontSize: 64),
          ),
          const SizedBox(height: 12),
          Text(
            horoscope.signName,
            style: GoogleFonts.outfit(
              fontSize: 32,
              fontWeight: FontWeight.w900,
              color: Colors.white,
            ),
          ),
          Text(
            horoscope.period,
            style: TextStyle(color: Colors.white70, letterSpacing: 1),
          ),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              'RANK #${horoscope.rank}',
              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w900),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLuckSection() {
    return Column(
      children: [
        _buildLuckMeter('Money', horoscope.moneyLuck, Colors.amber),
        const SizedBox(height: 16),
        _buildLuckMeter('Love', horoscope.loveLuck, Colors.pinkAccent),
        const SizedBox(height: 16),
        _buildLuckMeter('Work', horoscope.workLuck, Colors.blueAccent),
        const SizedBox(height: 16),
        _buildLuckMeter('Health', horoscope.healthLuck, Colors.greenAccent),
      ],
    );
  }

  Widget _buildLuckMeter(String label, int value, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label, style: const TextStyle(color: Colors.white70, fontWeight: FontWeight.bold)),
            Text('${value * 20}%', style: TextStyle(color: color, fontWeight: FontWeight.bold)),
          ],
        ),
        const SizedBox(height: 8),
        ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: LinearProgressIndicator(
            value: value / 5.0,
            backgroundColor: Colors.white10,
            color: color,
            minHeight: 8,
          ),
        ),
      ],
    );
  }

  Widget _buildAdviceSection() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.auto_awesome, color: Colors.amber, size: 20),
              SizedBox(width: 8),
              Text('DAILY ADVICE', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            horoscope.description,
            style: const TextStyle(color: Colors.white70, height: 1.6, fontSize: 16),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomInfo() {
    return Row(
      children: [
        Expanded(child: _buildInfoCard('Lucky Color', horoscope.luckyColor, Icons.palette, Colors.pinkAccent)),
        const SizedBox(width: 16),
        Expanded(child: _buildInfoCard('Lucky Key', horoscope.luckyItem, Icons.key, Colors.cyanAccent)),
      ],
    );
  }

  Widget _buildInfoCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withValues(alpha: 0.2)),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 24),
          const SizedBox(height: 8),
          Text(title, style: TextStyle(color: color, fontSize: 11, fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          Text(
            value,
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  Widget _buildCloseButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 60,
      child: ElevatedButton(
        onPressed: () => Navigator.pop(context),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white.withValues(alpha: 0.1),
          foregroundColor: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        ),
        child: const Text('GOT IT', style: TextStyle(letterSpacing: 2, fontWeight: FontWeight.bold)),
      ),
    );
  }
}
