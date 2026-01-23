import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/horoscope.dart';
import '../services/horoscope_service.dart';
import '../services/sign_calculator.dart';
import '../services/color_mapper.dart';
import '../services/widget_service.dart';
import 'detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final HoroscopeService _service = HoroscopeService();
  late Future<List<Horoscope>> _horoscopeFuture;
  String? _userSign;

  @override
  void initState() {
    super.initState();
    _horoscopeFuture = _service.fetchHoroscopes();
    _loadUserSign();
  }

  Future<void> _loadUserSign() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _userSign = prefs.getString('user_sign');
    });
  }

  Future<void> _saveUserSign(String sign) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('user_sign', sign);
  }

  Future<void> _refresh() async {
    setState(() {
      _horoscopeFuture = _service.fetchHoroscopes();
    });
    await _horoscopeFuture;
  }

  void _showBirthdayPicker() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime(2000, 1, 1),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Color(0xFF6A11CB),
              onPrimary: Colors.white,
              surface: Colors.white,
              onSurface: Colors.black,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      final sign = SignCalculator.getSign(picked.month, picked.day);
      setState(() {
        _userSign = sign;
      });
      _saveUserSign(sign);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF2575FC), // Blue
              Color(0xFF6A11CB), // Purple
              Color(0xFFFF0080), // Pink
            ],
            stops: [0.0, 0.5, 1.0],
          ),
        ),
        child: SafeArea(
          child: CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              _buildAppBar(),
              _buildBirthdaySection(),
              _buildListHeader(),
              _buildHoroscopeList(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAppBar() {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Ohayo Asahi',
              style: GoogleFonts.outfit(
                fontSize: 42,
                fontWeight: FontWeight.w900,
                color: Colors.white,
                letterSpacing: -1,
              ),
            ).animate().fadeIn(duration: 600.ms).slideY(begin: 0.3, end: 0),
            Text(
              'DAILY HOROSCOPE',
              style: GoogleFonts.outfit(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.white.withValues(alpha: 0.7),
                letterSpacing: 4,
              ),
            ).animate(delay: 200.ms).fadeIn().slideY(begin: 0.5, end: 0),
          ],
        ),
      ),
    );
  }

  Widget _buildBirthdaySection() {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        child: GestureDetector(
          onTap: _showBirthdayPicker,
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: Colors.white.withValues(alpha: 0.2)),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: const BoxDecoration(
                    color: Colors.white24,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.cake_rounded, color: Colors.white, size: 28),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _userSign == null ? 'Find My Sign' : 'Your Sign: $_userSign',
                        style: GoogleFonts.outfit(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        _userSign == null 
                          ? 'Enter your birthday for custom insights' 
                          : 'Tap to change birthday',
                        style: TextStyle(color: Colors.white70, fontSize: 13),
                      ),
                    ],
                  ),
                ),
                const Icon(Icons.chevron_right_rounded, color: Colors.white70),
              ],
            ),
          ),
        ),
      ).animate(delay: 400.ms).fadeIn().scale(begin: const Offset(0.9, 0.9)),
    );
  }

  Widget _buildListHeader() {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(28, 32, 28, 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Daily Rankings',
              style: GoogleFonts.outfit(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            IconButton(
              onPressed: _refresh,
              icon: const Icon(Icons.refresh_rounded, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHoroscopeList() {
    return FutureBuilder<List<Horoscope>>(
      future: _horoscopeFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const SliverFillRemaining(
            child: Center(child: CircularProgressIndicator(color: Colors.white)),
          );
        } else if (snapshot.hasError || !snapshot.hasData || snapshot.data!.isEmpty) {
          final error = snapshot.error?.toString() ?? 'No data found';
          return SliverFillRemaining(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(32.0),
                child: Text(
                  'Error: $error\n\nTap refresh icon to try again.',
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.white70),
                ),
              ),
            ),
          );
        }

        final list = snapshot.data!;
        final horoscopes = snapshot.data!;
        
        // Update Widget if user sign is set
        if (_userSign != null) {
          try {
            final userHoroscope = horoscopes.firstWhere((h) => h.signName == _userSign);
            WidgetService.updateWidget(userHoroscope);
          } catch (_) {
            // Handle case where user's sign is not found in the fetched horoscopes
            // This might happen if the data is incomplete or _userSign is invalid.
          }
        }

        return SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          sliver: SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final item = horoscopes[index];
                return _buildRankCard(item, index);
              },
              childCount: horoscopes.length,
            ),
          ),
        );
      },
    );
  }

  Widget _buildRankCard(Horoscope item, int index) {
    final isUserSign = item.signName == _userSign;
    final isFirst = item.rank == 1;

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailScreen(horoscope: item),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(2), // For gradient border
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(28),
          gradient: isUserSign
              ? const LinearGradient(colors: [Colors.amber, Colors.orange])
              : null,
        ),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xFF1E1E1E).withValues(alpha: 0.8),
            borderRadius: BorderRadius.circular(26),
          ),
          child: Row(
            children: [
              // Icon/Rank Container
              Stack(
                alignment: Alignment.center,
                children: [
                   Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: isFirst ? Colors.amber.withValues(alpha: 0.2) : Colors.white.withValues(alpha: 0.05),
                      shape: BoxShape.circle,
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      item.icon,
                      style: const TextStyle(fontSize: 32),
                    ),
                  ),
                  Positioned(
                    right: 0,
                    top: 0,
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: isFirst ? Colors.amber : const Color(0xFF333333),
                        shape: BoxShape.circle,
                        border: Border.all(color: const Color(0xFF1E1E1E), width: 2),
                      ),
                      child: Text(
                        '#${item.rank}',
                        style: GoogleFonts.outfit(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: isFirst ? Colors.black : Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.signName,
                      style: GoogleFonts.outfit(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      item.signNameJapanese,
                      style: GoogleFonts.outfit(
                        fontSize: 12,
                        color: Colors.white54,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        _buildMiniPill(Icons.palette_rounded, item.luckyColor, ColorMapper.fromName(item.luckyColor)),
                        const SizedBox(width: 8),
                        _buildMiniPill(Icons.key_rounded, item.luckyItem, Colors.cyanAccent),
                      ],
                    ),
                  ],
                ),
              ),
              const Icon(Icons.arrow_forward_ios_rounded, color: Colors.white24, size: 16),
            ],
          ),
        ),
      ),
    )
    .animate(delay: Duration(milliseconds: 50 * index))
    .fadeIn(duration: 400.ms)
    .slideX(begin: 0.2, end: 0);
  }

  Widget _buildMiniPill(IconData icon, String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 12, color: color),
          const SizedBox(width: 4),
          Flexible(
            child: Text(
              text,
              style: TextStyle(color: color, fontSize: 11, fontWeight: FontWeight.w600),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
