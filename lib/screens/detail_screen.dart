import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/horoscope.dart';
import '../services/color_mapper.dart';

class DetailScreen extends StatelessWidget {
  final Horoscope horoscope;

  const DetailScreen({super.key, required this.horoscope});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1E1E1E),
      body: CustomScrollView(
        slivers: [
          _buildSliverAppBar(context),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                children: [
                  _buildLuckSection(),
                  const SizedBox(height: 32),
                  _buildAdviceSection(),
                  const SizedBox(height: 32),
                  _buildBottomInfo(),
                  const SizedBox(height: 48),
                ],
              ),
            ),
          ),
        ],
      ).animate().fadeIn(duration: 400.ms),
    );
  }

  Widget _buildSliverAppBar(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 300,
      pinned: true,
      backgroundColor: const Color(0xFF6A11CB),
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white),
        onPressed: () => Navigator.pop(context),
      ),
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xFF6A11CB), Color(0xFF2575FC)],
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 40),
              Text(
                horoscope.icon,
                style: const TextStyle(fontSize: 80),
              ).animate().scale(delay: 200.ms),
              const SizedBox(height: 12),
              Text(
                horoscope.signName,
                style: GoogleFonts.outfit(
                  fontSize: 36,
                  fontWeight: FontWeight.w900,
                  color: Colors.white,
                ),
              ),
              Text(
                horoscope.period,
                style: const TextStyle(color: Colors.white70, letterSpacing: 1),
              ),
              const SizedBox(height: 16),
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
        ),
      ),
    );
  }

  Widget _buildLuckSection() {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 500),
      child: Column(
        children: [
          _buildLuckMeter('Money', horoscope.moneyLuck, Colors.amber),
          const SizedBox(height: 20),
          _buildLuckMeter('Love', horoscope.loveLuck, Colors.pinkAccent),
          const SizedBox(height: 20),
          _buildLuckMeter('Work', horoscope.workLuck, Colors.blueAccent),
          const SizedBox(height: 20),
          _buildLuckMeter('Health', horoscope.healthLuck, Colors.greenAccent),
        ],
      ),
    );
  }

  Widget _buildLuckMeter(String label, int value, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label, style: const TextStyle(color: Colors.white70, fontWeight: FontWeight.bold, fontSize: 16)),
            Text('${value * 20}%', style: TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 16)),
          ],
        ),
        const SizedBox(height: 12),
        ClipRRect(
          borderRadius: BorderRadius.circular(6),
          child: LinearProgressIndicator(
            value: value / 5.0,
            backgroundColor: Colors.white10,
            color: color,
            minHeight: 12,
          ),
        ),
      ],
    );
  }

  Widget _buildAdviceSection() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.auto_awesome, color: Colors.amber, size: 24),
              SizedBox(width: 8),
              Text('DAILY ADVICE', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            horoscope.description,
            style: const TextStyle(color: Colors.white70, height: 1.8, fontSize: 17),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomInfo() {
    final luckyColor = ColorMapper.fromName(horoscope.luckyColor);
    return Row(
      children: [
        Expanded(child: _buildInfoCard('Lucky Color', horoscope.luckyColor, Icons.palette, luckyColor)),
        const SizedBox(width: 16),
        Expanded(child: _buildInfoCard('Lucky Key', horoscope.luckyItem, Icons.key, Colors.cyanAccent)),
      ],
    );
  }

  Widget _buildInfoCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: color.withValues(alpha: 0.2)),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 28),
          const SizedBox(height: 12),
          Text(title, style: TextStyle(color: color, fontSize: 12, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Text(
            value,
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
