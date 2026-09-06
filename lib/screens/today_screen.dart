import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/horoscope.dart';
import '../models/user_profile.dart';
import '../services/horoscope_service.dart';
import '../services/daily_prediction_service.dart';
import '../services/sign_calculator.dart';
import '../services/color_mapper.dart';
import '../widgets/glass_card.dart';
import '../widgets/luck_indicator_bar.dart';
import '../widgets/cultural_disclaimer_card.dart';
import 'rune_cast_dialog.dart';
import 'detail_dialog.dart';

class TodayScreen extends StatefulWidget {
  final UserProfile profile;
  final VoidCallback onEditProfile;

  const TodayScreen({
    super.key,
    required this.profile,
    required this.onEditProfile,
  });

  @override
  State<TodayScreen> createState() => _TodayScreenState();
}

class _TodayScreenState extends State<TodayScreen> {
  final HoroscopeService _horoscopeService = HoroscopeService();
  late Future<List<Horoscope>> _horoscopesFuture;
  late List<DailyCulturalForecast> _dailyForecasts;
  late List<DailyConsensusPoint> _dailyConsensus;

  static const List<String> _months = [
    'January', 'February', 'March', 'April', 'May', 'June',
    'July', 'August', 'September', 'October', 'November', 'December'
  ];

  static const List<String> _weekdays = [
    'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'
  ];

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  @override
  void didUpdateWidget(covariant TodayScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.profile != widget.profile) {
      _loadData();
    }
  }

  void _loadData() {
    _horoscopesFuture = _horoscopeService.fetchHoroscopes();
    _dailyForecasts = DailyPredictionService.generateDailyForecasts(widget.profile, DateTime.now());
    _dailyConsensus = DailyPredictionService.generateDailyConsensus(
      widget.profile,
      DateTime.now(),
      userRank: 3,
    );
  }

  Future<void> _refresh() async {
    setState(() {
      _loadData();
    });
    await _horoscopesFuture;
  }

  void _openRuneCast() {
    showDialog(
      context: context,
      builder: (context) => const RuneCastDialog(),
    );
  }

  void _openDetail(Horoscope h) {
    showDialog(
      context: context,
      builder: (context) => DetailDialog(horoscope: h),
    );
  }

  void _showTransitDetail(DailyCulturalForecast forecast) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) {
        return Container(
          constraints: const BoxConstraints(maxWidth: 600),
          margin: const EdgeInsets.all(16),
          child: GlassCard(
            backgroundColor: const Color(0xFF0F172A).withValues(alpha: 0.96),
            borderColor: forecast.accentColor.withValues(alpha: 0.5),
            borderRadius: 24,
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: forecast.accentColor.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: forecast.accentColor.withValues(alpha: 0.4)),
                      ),
                      child: Text(
                        forecast.traditionName,
                        style: GoogleFonts.outfit(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: forecast.accentColor,
                        ),
                      ),
                    ),
                    Text(forecast.luckySymbol, style: const TextStyle(fontSize: 24)),
                  ],
                ),
                const SizedBox(height: 14),
                Text(
                  forecast.headline,
                  style: GoogleFonts.outfit(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.05),
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
                  ),
                  child: Text(
                    forecast.guidance,
                    style: const TextStyle(
                      fontSize: 14,
                      height: 1.5,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      backgroundColor: Colors.white.withValues(alpha: 0.08),
                    ),
                    child: Text('Close', style: GoogleFonts.outfit(color: Colors.white, fontWeight: FontWeight.bold)),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final weekday = _weekdays[now.weekday - 1];
    final month = _months[now.month - 1];
    final dateHuman = '$weekday, $month ${now.day}, ${now.year}';
    final userSignName = SignCalculator.getSign(widget.profile.birthDate.month, widget.profile.birthDate.day);

    return RefreshIndicator(
      onRefresh: _refresh,
      color: const Color(0xFFFFD700),
      backgroundColor: const Color(0xFF1E1B4B),
      child: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          // Header Area
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 8,
                                height: 8,
                                decoration: const BoxDecoration(
                                  color: Color(0xFFFFD700),
                                  shape: BoxShape.circle,
                                ),
                              ).animate(onPlay: (c) => c.repeat(reverse: true)).scale(begin: const Offset(0.8, 0.8), end: const Offset(1.3, 1.3)),
                              const SizedBox(width: 8),
                              Text(
                                'DAILY COSMIC GUIDANCE',
                                style: GoogleFonts.outfit(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700,
                                  color: const Color(0xFFFFD700),
                                  letterSpacing: 2,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Text(
                            dateHuman,
                            style: GoogleFonts.outfit(
                              fontSize: 22,
                              fontWeight: FontWeight.w900,
                              color: Colors.white,
                              letterSpacing: -0.3,
                            ),
                          ),
                        ],
                      ),
                      InkWell(
                        onTap: widget.onEditProfile,
                        borderRadius: BorderRadius.circular(16),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: Colors.white.withValues(alpha: 0.2)),
                          ),
                          child: Row(
                            children: [
                              const Icon(Icons.person_rounded, size: 16, color: Color(0xFFFFD700)),
                              const SizedBox(width: 6),
                              Text(
                                widget.profile.name,
                                style: GoogleFonts.outfit(
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          // User's Personal Daily Oha Asa Card
          SliverToBoxAdapter(
            child: FutureBuilder<List<Horoscope>>(
              future: _horoscopesFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    child: GlassCard(
                      child: const Center(
                        child: Padding(
                          padding: EdgeInsets.all(24.0),
                          child: CircularProgressIndicator(color: Color(0xFFFFD700)),
                        ),
                      ),
                    ),
                  );
                }

                if (snapshot.hasError || !snapshot.hasData || snapshot.data!.isEmpty) {
                  return const SizedBox.shrink();
                }

                final list = snapshot.data!;
                Horoscope? userHoroscope;
                for (var h in list) {
                  if (h.signName.toLowerCase() == userSignName.toLowerCase()) {
                    userHoroscope = h;
                    break;
                  }
                }
                userHoroscope ??= list.first;

                return _buildUserOhaAsaHeroCard(userHoroscope);
              },
            ),
          ),

          // Interactive Norse Rune Cast Banner
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 14, 20, 10),
              child: InkWell(
                onTap: _openRuneCast,
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFF0F1E36), Color(0xFF1E293B)],
                    ),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: const Color(0xFF38BDF8).withValues(alpha: 0.45), width: 1.2),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF38BDF8).withValues(alpha: 0.12),
                        blurRadius: 14,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                          color: const Color(0xFF38BDF8).withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(color: const Color(0xFF38BDF8)),
                        ),
                        child: const Center(
                          child: Text('ᛟ', style: TextStyle(fontSize: 26, color: Color(0xFF38BDF8))),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Cast Today’s Norse Rune',
                              style: GoogleFonts.outfit(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              'Draw from the 24 Elder Futhark runes for daily clarity',
                              style: TextStyle(fontSize: 12.5, color: Colors.white.withValues(alpha: 0.75)),
                            ),
                          ],
                        ),
                      ),
                      const Icon(Icons.arrow_forward_ios_rounded, color: Color(0xFF38BDF8), size: 16),
                    ],
                  ),
                ),
              ),
            ),
          ),

          // Daily Multi-Cultural Transits Section
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Today’s Insights from Around the World',
                    style: GoogleFonts.outfit(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    'Swipe horizontally to explore daily advice from Asian, Mayan, Vedic, and Nordic traditions',
                    style: TextStyle(fontSize: 12.5, color: Colors.white.withValues(alpha: 0.7)),
                  ),
                ],
              ),
            ),
          ),

          SliverToBoxAdapter(
            child: SizedBox(
              height: 220,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: _dailyForecasts.length,
                itemBuilder: (context, index) {
                  final item = _dailyForecasts[index];
                  return Container(
                    width: 320,
                    margin: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                    child: GlassCard(
                      onTap: () => _showTransitDetail(item),
                      padding: const EdgeInsets.all(16),
                      borderColor: item.accentColor.withValues(alpha: 0.35),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: item.accentColor.withValues(alpha: 0.18),
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(color: item.accentColor.withValues(alpha: 0.4)),
                                  ),
                                  child: Text(
                                    item.traditionName,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: GoogleFonts.outfit(
                                      fontSize: 11.5,
                                      fontWeight: FontWeight.w600,
                                      color: item.accentColor,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8),
                              Text(item.luckySymbol, style: const TextStyle(fontSize: 18)),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Text(
                            item.headline,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.outfit(
                              fontSize: 14.5,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Expanded(
                            child: Text(
                              item.guidance,
                              maxLines: 4,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 12.5,
                                height: 1.45,
                                color: Colors.white.withValues(alpha: 0.88),
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.bottomRight,
                            child: Text(
                              'Tap to read full advice →',
                              style: TextStyle(fontSize: 11, color: item.accentColor.withValues(alpha: 0.9), fontWeight: FontWeight.w600),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),

          // Daily Cross-Cultural Consensus & Overlaps Section
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 24, 20, 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: const Color(0xFF00E5FF).withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: const Color(0xFF00E5FF).withValues(alpha: 0.4)),
                        ),
                        child: Text(
                          'SYNCHRONICITY',
                          style: GoogleFonts.outfit(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFF00E5FF),
                            letterSpacing: 1.2,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Where World Cultures Agree Today',
                        style: GoogleFonts.outfit(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'When cultures from different parts of the world offer the same advice for your day',
                    style: TextStyle(fontSize: 12.5, color: Colors.white.withValues(alpha: 0.7)),
                  ),
                ],
              ),
            ),
          ),

          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final point = _dailyConsensus[index];
                return _buildDailyConsensusCard(point);
              },
              childCount: _dailyConsensus.length,
            ),
          ),

          // Oha Asa TV Ranking Section Title
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 24, 20, 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Oha Asa TV Ranking',
                        style: GoogleFonts.outfit(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        'おはよう朝日です • Japan’s Official 12-Sign Daily Fortune',
                        style: TextStyle(fontSize: 12.5, color: Colors.white.withValues(alpha: 0.65)),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          // Oha Asa 12 Signs List
          FutureBuilder<List<Horoscope>>(
            future: _horoscopesFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const SliverToBoxAdapter(
                  child: Center(
                    child: Padding(
                      padding: EdgeInsets.all(32.0),
                      child: CircularProgressIndicator(color: Color(0xFFFFD700)),
                    ),
                  ),
                );
              }

              if (snapshot.hasError) {
                return SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: GlassCard(
                      child: Text(
                        'Error loading horoscopes: ${snapshot.error}',
                        style: const TextStyle(color: Colors.white70),
                      ),
                    ),
                  ),
                );
              }

              final list = snapshot.data ?? [];
              return SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final item = list[index];
                      return _buildOhaAsaItemCard(item);
                    },
                    childCount: list.length,
                  ),
                ),
              );
            },
          ),

          // Prominent Cultural Heritage Disclaimer
          const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.fromLTRB(20, 16, 20, 12),
              child: CulturalDisclaimerCard(compact: false),
            ),
          ),

          const SliverToBoxAdapter(child: SizedBox(height: 40)),
        ],
      ),
    );
  }

  Widget _buildUserOhaAsaHeroCard(Horoscope h) {
    final color = ColorMapper.getColor(h.luckyColor);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: GlassCard(
        backgroundColor: const Color(0xFF131B2F).withValues(alpha: 0.9),
        borderColor: const Color(0xFFFFD700).withValues(alpha: 0.4),
        borderRadius: 24,
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xFFFFD700), Color(0xFFFFA000)],
                        ),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Center(
                        child: Text(
                          '#${h.rank}',
                          style: GoogleFonts.outfit(
                            fontSize: 22,
                            fontWeight: FontWeight.w900,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 14),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              '${h.icon} ${h.signName}',
                              style: GoogleFonts.outfit(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              h.signNameJapanese,
                              style: TextStyle(fontSize: 13, color: Colors.white.withValues(alpha: 0.6)),
                            ),
                          ],
                        ),
                        Text(
                          'Your Morning TV Fortune',
                          style: TextStyle(fontSize: 12.5, color: const Color(0xFFFFD700).withValues(alpha: 0.95), fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ],
                ),
                IconButton(
                  onPressed: () => _openDetail(h),
                  icon: const Icon(Icons.info_outline, color: Colors.white70),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              h.description,
              style: GoogleFonts.outfit(
                fontSize: 14.5,
                height: 1.5,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.08),
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: Colors.white.withValues(alpha: 0.12)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('LUCKY COLOR', style: GoogleFonts.outfit(fontSize: 10.5, fontWeight: FontWeight.bold, color: Colors.white70, letterSpacing: 0.8)),
                        const SizedBox(height: 6),
                        Row(
                          children: [
                            Container(width: 14, height: 14, decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                h.luckyColor,
                                style: const TextStyle(fontSize: 13, color: Colors.white, fontWeight: FontWeight.w600),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.08),
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: Colors.white.withValues(alpha: 0.12)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('LUCKY ITEM', style: GoogleFonts.outfit(fontSize: 10.5, fontWeight: FontWeight.bold, color: Colors.white70, letterSpacing: 0.8)),
                        const SizedBox(height: 6),
                        Text(
                          h.luckyItem,
                          style: const TextStyle(fontSize: 13, color: Colors.white, fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            LuckIndicatorBar(label: 'Money', score: h.moneyLuck, icon: Icons.attach_money_rounded, color: const Color(0xFFFFD700)),
            LuckIndicatorBar(label: 'Love', score: h.loveLuck, icon: Icons.favorite_rounded, color: const Color(0xFFFF4081)),
            LuckIndicatorBar(label: 'Work', score: h.workLuck, icon: Icons.work_outline_rounded, color: const Color(0xFF00E5FF)),
            LuckIndicatorBar(label: 'Health', score: h.healthLuck, icon: Icons.spa_outlined, color: const Color(0xFF69F0AE)),
          ],
        ),
      ),
    );
  }

  Widget _buildOhaAsaItemCard(Horoscope h) {
    final color = ColorMapper.getColor(h.luckyColor);
    final isTopThree = h.rank <= 3;

    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: GlassCard(
        onTap: () => _openDetail(h),
        borderColor: isTopThree ? const Color(0xFFFFD700).withValues(alpha: 0.4) : null,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Row(
          children: [
            Container(
              width: 38,
              height: 38,
              decoration: BoxDecoration(
                color: isTopThree
                    ? const Color(0xFFFFD700)
                    : Colors.white.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: Text(
                  '${h.rank}',
                  style: GoogleFonts.outfit(
                    fontSize: 16,
                    fontWeight: FontWeight.w900,
                    color: isTopThree ? Colors.black : Colors.white,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 14),
            Text(h.icon, style: const TextStyle(fontSize: 22)),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        h.signName,
                        style: GoogleFonts.outfit(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        h.signNameJapanese,
                        style: TextStyle(fontSize: 12, color: Colors.white.withValues(alpha: 0.55)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 2),
                  Text(
                    '${h.luckyColor} • ${h.luckyItem}',
                    style: TextStyle(fontSize: 12.5, color: Colors.white.withValues(alpha: 0.75)),
                  ),
                ],
              ),
            ),
            Container(
              width: 16,
              height: 16,
              decoration: BoxDecoration(
                color: color,
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white24),
              ),
            ),
            const SizedBox(width: 8),
            const Icon(Icons.chevron_right_rounded, color: Colors.white38, size: 18),
          ],
        ),
      ),
    );
  }

  Widget _buildDailyConsensusCard(DailyConsensusPoint point) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
      child: GlassCard(
        backgroundColor: const Color(0xFF131B2E).withValues(alpha: 0.8),
        borderColor: point.color.withValues(alpha: 0.4),
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(point.icon, style: const TextStyle(fontSize: 22)),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        point.domain.toUpperCase(),
                        style: GoogleFonts.outfit(
                          fontSize: 10.5,
                          fontWeight: FontWeight.bold,
                          color: point.color,
                          letterSpacing: 1.1,
                        ),
                      ),
                      Text(
                        point.consensusTitle,
                        style: GoogleFonts.outfit(
                          fontSize: 15.5,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.04),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
              ),
              child: Text(
                point.synthesis,
                style: const TextStyle(
                  fontSize: 13.5,
                  height: 1.5,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Converging Traditions:',
              style: TextStyle(
                fontSize: 11.5,
                fontWeight: FontWeight.w600,
                color: Colors.white.withValues(alpha: 0.65),
              ),
            ),
            const SizedBox(height: 6),
            Wrap(
              spacing: 6,
              runSpacing: 6,
              children: point.convergingTraditions.map((t) {
                return Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: point.color.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: point.color.withValues(alpha: 0.3)),
                  ),
                  child: Text(
                    t,
                    style: TextStyle(
                      fontSize: 11.5,
                      color: Colors.white.withValues(alpha: 0.95),
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
