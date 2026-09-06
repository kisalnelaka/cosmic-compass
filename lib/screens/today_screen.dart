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

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final dateStr = '${now.year}.${now.month.toString().padLeft(2, '0')}.${now.day.toString().padLeft(2, '0')}';
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
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 12),
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
                                  color: Color(0xFF00E5FF),
                                  shape: BoxShape.circle,
                                ),
                              ).animate(onPlay: (c) => c.repeat(reverse: true)).scale(begin: const Offset(0.8, 0.8), end: const Offset(1.4, 1.4)),
                              const SizedBox(width: 8),
                              Text(
                                'DAILY COSMIC ALIGNMENT',
                                style: GoogleFonts.outfit(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700,
                                  color: const Color(0xFF00E5FF),
                                  letterSpacing: 2,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Text(
                            dateStr,
                            style: GoogleFonts.outfit(
                              fontSize: 28,
                              fontWeight: FontWeight.w900,
                              color: Colors.white,
                              letterSpacing: -0.5,
                            ),
                          ),
                        ],
                      ),
                      InkWell(
                        onTap: widget.onEditProfile,
                        borderRadius: BorderRadius.circular(16),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: Colors.white.withValues(alpha: 0.2)),
                          ),
                          child: Row(
                            children: [
                              const Icon(Icons.person_outline, size: 16, color: Colors.white70),
                              const SizedBox(width: 6),
                              Text(
                                widget.profile.name,
                                style: GoogleFonts.outfit(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
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
                      colors: [Color(0xFF0F172A), Color(0xFF1E293B)],
                    ),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: const Color(0xFF38BDF8).withValues(alpha: 0.5), width: 1.2),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF38BDF8).withValues(alpha: 0.15),
                        blurRadius: 14,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 46,
                        height: 46,
                        decoration: BoxDecoration(
                          color: const Color(0xFF38BDF8).withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(color: const Color(0xFF38BDF8)),
                        ),
                        child: const Center(
                          child: Text('ᛟ', style: TextStyle(fontSize: 24, color: Color(0xFF38BDF8))),
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
                            Text(
                              'Draw from the 24 Elder Futhark staves for divine guidance',
                              style: TextStyle(fontSize: 12, color: Colors.white.withValues(alpha: 0.7)),
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
              child: Text(
                'Cross-Cultural Daily Transits',
                style: GoogleFonts.outfit(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),

          SliverToBoxAdapter(
            child: SizedBox(
              height: 185,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: _dailyForecasts.length,
                itemBuilder: (context, index) {
                  final item = _dailyForecasts[index];
                  return Container(
                    width: 280,
                    margin: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                    child: GlassCard(
                      padding: const EdgeInsets.all(16),
                      borderColor: item.accentColor.withValues(alpha: 0.4),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                                  decoration: BoxDecoration(
                                    color: item.accentColor.withValues(alpha: 0.2),
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(color: item.accentColor.withValues(alpha: 0.4)),
                                  ),
                                  child: Text(
                                    item.traditionName,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: GoogleFonts.outfit(
                                      fontSize: 11,
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
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Expanded(
                            child: Text(
                              item.guidance,
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 12,
                                height: 1.35,
                                color: Colors.white.withValues(alpha: 0.8),
                              ),
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
                        'Tradition Overlaps Today',
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
                    'Where independent ancient astrological cycles converge on today’s guidance',
                    style: TextStyle(fontSize: 12, color: Colors.white.withValues(alpha: 0.6)),
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
                      Text(
                        'おはよう朝日です • Official 12-Sign Daily Fortune',
                        style: TextStyle(fontSize: 12, color: Colors.white.withValues(alpha: 0.6)),
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
        backgroundColor: const Color(0xFF1E1B4B).withValues(alpha: 0.8),
        borderColor: const Color(0xFFFFD700).withValues(alpha: 0.5),
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
                          style: TextStyle(fontSize: 12, color: const Color(0xFFFFD700).withValues(alpha: 0.9)),
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
                fontSize: 14,
                height: 1.4,
                color: Colors.white.withValues(alpha: 0.95),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.08),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('LUCKY COLOR', style: GoogleFonts.outfit(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.white60)),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            Container(width: 12, height: 12, decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
                            const SizedBox(width: 6),
                            Flexible(child: Text(h.luckyColor, overflow: TextOverflow.ellipsis, style: const TextStyle(fontSize: 12, color: Colors.white, fontWeight: FontWeight.w600))),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.08),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('LUCKY ITEM', style: GoogleFonts.outfit(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.white60)),
                        const SizedBox(height: 4),
                        Text(h.luckyItem, overflow: TextOverflow.ellipsis, style: const TextStyle(fontSize: 12, color: Colors.white, fontWeight: FontWeight.w600)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),
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
      padding: const EdgeInsets.only(bottom: 12),
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
                        style: TextStyle(fontSize: 12, color: Colors.white.withValues(alpha: 0.5)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 2),
                  Text(
                    '${h.luckyColor} • ${h.luckyItem}',
                    style: TextStyle(fontSize: 12, color: Colors.white.withValues(alpha: 0.7)),
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
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: point.color,
                          letterSpacing: 1.1,
                        ),
                      ),
                      Text(
                        point.consensusTitle,
                        style: GoogleFonts.outfit(
                          fontSize: 15,
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
                  fontSize: 13,
                  height: 1.45,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Converging Traditions:',
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: Colors.white.withValues(alpha: 0.6),
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
                      fontSize: 11,
                      color: Colors.white.withValues(alpha: 0.9),
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
