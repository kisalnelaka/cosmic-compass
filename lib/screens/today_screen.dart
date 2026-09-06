import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../models/horoscope.dart';
import '../models/user_profile.dart';
import '../services/horoscope_service.dart';
import '../services/daily_prediction_service.dart';
import '../services/sign_calculator.dart';
import '../services/color_mapper.dart';
import '../services/share_service.dart';
import '../services/notification_service.dart';
import '../services/widget_service.dart';
import '../theme/hand_drawn_tokens.dart';
import '../widgets/hand_drawn_card.dart';
import '../widgets/hand_drawn_button.dart';
import '../widgets/hand_drawn_badge.dart';
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
  bool _notificationsEnabled = true;

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
    _loadNotificationState();
  }

  Future<void> _loadNotificationState() async {
    final enabled = await NotificationService.isEnabled();
    if (mounted) {
      setState(() {
        _notificationsEnabled = enabled;
      });
    }
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

  Future<void> _toggleNotifications() async {
    final newState = !_notificationsEnabled;
    await NotificationService.setEnabled(newState);
    setState(() {
      _notificationsEnabled = newState;
    });

    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: HandDrawnTokens.pencilBlack,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: HandDrawnTokens.wobblySm),
        content: Text(
          newState
              ? 'Morning notifications turned on (7:00 AM fortune alert)'
              : 'Morning notifications turned off',
          style: HandDrawnTokens.bodyFont(color: HandDrawnTokens.warmPaper, fontSize: 14),
        ),
      ),
    );
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

  void _shareReading(Horoscope h) {
    ShareService.copyHoroscopeToClipboard(h, profileName: widget.profile.name);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: HandDrawnTokens.pencilBlack,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: HandDrawnTokens.wobblySm),
        content: Text(
          'Daily horoscope copied to clipboard. Ready to share!',
          style: HandDrawnTokens.bodyFont(color: HandDrawnTokens.warmPaper, fontSize: 14),
        ),
      ),
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
          child: HandDrawnCard(
            decoration: HandDrawnCardDecoration.pin,
            backgroundColor: HandDrawnTokens.cardWhite,
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    HandDrawnBadge(
                      label: forecast.traditionName,
                      color: forecast.accentColor,
                    ),
                    Text(forecast.luckySymbol, style: const TextStyle(fontSize: 28)),
                  ],
                ),
                const SizedBox(height: 14),
                Text(
                  forecast.headline,
                  style: HandDrawnTokens.headingFont(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: HandDrawnTokens.pencilBlack,
                  ),
                ),
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: HandDrawnTokens.warmPaper,
                    borderRadius: HandDrawnTokens.wobblySm,
                    border: Border.all(color: HandDrawnTokens.pencilBlack, width: 1.5),
                  ),
                  child: Text(
                    forecast.guidance,
                    style: HandDrawnTokens.bodyFont(
                      fontSize: 15,
                      height: 1.5,
                      color: HandDrawnTokens.pencilBlack,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: HandDrawnButton(
                    text: 'Close Note',
                    variant: HandDrawnButtonVariant.secondary,
                    onPressed: () => Navigator.of(context).pop(),
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
      color: HandDrawnTokens.markerRed,
      backgroundColor: HandDrawnTokens.warmPaper,
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                  width: 9,
                                  height: 9,
                                  decoration: BoxDecoration(
                                    color: HandDrawnTokens.markerRed,
                                    shape: BoxShape.circle,
                                  ),
                                ).animate(onPlay: (c) => c.repeat(reverse: true)).scale(
                                      begin: const Offset(0.8, 0.8),
                                      end: const Offset(1.3, 1.3),
                                    ),
                                const SizedBox(width: 8),
                                Text(
                                  'DAILY FIELD NOTES',
                                  style: HandDrawnTokens.headingFont(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w700,
                                    color: HandDrawnTokens.markerRed,
                                    letterSpacing: 1.5,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 4),
                            Text(
                              dateHuman,
                              style: HandDrawnTokens.headingFont(
                                fontSize: 24,
                                fontWeight: FontWeight.w900,
                                color: HandDrawnTokens.pencilBlack,
                                letterSpacing: -0.3,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          IconButton(
                            tooltip: _notificationsEnabled ? 'Morning alerts active' : 'Enable morning alerts',
                            onPressed: _toggleNotifications,
                            icon: Icon(
                              _notificationsEnabled
                                  ? Icons.notifications_active_rounded
                                  : Icons.notifications_off_outlined,
                              color: _notificationsEnabled
                                  ? HandDrawnTokens.markerRed
                                  : HandDrawnTokens.erasedPencil,
                            ),
                          ),
                          const SizedBox(width: 4),
                          GestureDetector(
                            onTap: widget.onEditProfile,
                            child: HandDrawnBadge(
                              label: widget.profile.name,
                              color: HandDrawnTokens.ballpointBlue,
                              isPostIt: false,
                            ),
                          ),
                        ],
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
                    child: HandDrawnCard(
                      child: const Center(
                        child: Padding(
                          padding: EdgeInsets.all(28.0),
                          child: CircularProgressIndicator(
                            color: Color(0xFF2D2D2D),
                            strokeWidth: 2.5,
                          ),
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

                // Sync with Home Screen Widget for mobile
                WidgetService.updateWidget(userHoroscope);

                return _buildUserOhaAsaHeroCard(userHoroscope);
              },
            ),
          ),

          // Interactive Norse Rune Cast Banner
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 14, 20, 10),
              child: HandDrawnCard(
                onTap: _openRuneCast,
                decoration: HandDrawnCardDecoration.none,
                backgroundColor: HandDrawnTokens.cardWhite,
                padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
                child: Row(
                  children: [
                    Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: HandDrawnTokens.ballpointBlue.withValues(alpha: 0.12),
                        borderRadius: HandDrawnTokens.wobblySm,
                        border: Border.all(color: HandDrawnTokens.ballpointBlue, width: 2),
                      ),
                      child: Center(
                        child: Text(
                          'ᛟ',
                          style: TextStyle(
                            fontSize: 26,
                            color: HandDrawnTokens.ballpointBlue,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Cast Today’s Norse Rune',
                            style: HandDrawnTokens.headingFont(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: HandDrawnTokens.pencilBlack,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            'Draw from the 24 Elder Futhark runes for practical daily clarity',
                            style: HandDrawnTokens.bodyFont(
                              fontSize: 13.5,
                              color: HandDrawnTokens.erasedPencil,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Icon(
                      Icons.arrow_forward_ios_rounded,
                      color: HandDrawnTokens.pencilBlack,
                      size: 16,
                    ),
                  ],
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
                    style: HandDrawnTokens.headingFont(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: HandDrawnTokens.pencilBlack,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    'Swipe horizontally to explore advice from Asian, Mayan, Vedic, and Nordic traditions',
                    style: HandDrawnTokens.bodyFont(
                      fontSize: 14,
                      color: HandDrawnTokens.erasedPencil,
                    ),
                  ),
                ],
              ),
            ),
          ),

          SliverToBoxAdapter(
            child: SizedBox(
              height: 230,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: _dailyForecasts.length,
                itemBuilder: (context, index) {
                  final item = _dailyForecasts[index];
                  return Container(
                    width: 310,
                    margin: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                    child: HandDrawnCard(
                      onTap: () => _showTransitDetail(item),
                      decoration: index % 2 == 0 ? HandDrawnCardDecoration.tape : HandDrawnCardDecoration.none,
                      backgroundColor: HandDrawnTokens.cardWhite,
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: HandDrawnBadge(
                                  label: item.traditionName,
                                  color: item.accentColor,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Text(item.luckySymbol, style: const TextStyle(fontSize: 20)),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Text(
                            item.headline,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: HandDrawnTokens.headingFont(
                              fontSize: 15.5,
                              fontWeight: FontWeight.bold,
                              color: HandDrawnTokens.pencilBlack,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Expanded(
                            child: Text(
                              item.guidance,
                              maxLines: 4,
                              overflow: TextOverflow.ellipsis,
                              style: HandDrawnTokens.bodyFont(
                                fontSize: 14,
                                height: 1.4,
                                color: HandDrawnTokens.pencilBlack,
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.bottomRight,
                            child: Text(
                              'Tap to inspect note →',
                              style: HandDrawnTokens.bodyFont(
                                fontSize: 12.5,
                                color: HandDrawnTokens.ballpointBlue,
                                fontWeight: FontWeight.bold,
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
                      HandDrawnBadge(
                        label: 'SYNCHRONICITY',
                        color: HandDrawnTokens.markerRed,
                        isPostIt: true,
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          'Where World Cultures Agree Today',
                          style: HandDrawnTokens.headingFont(
                            fontSize: 19,
                            fontWeight: FontWeight.bold,
                            color: HandDrawnTokens.pencilBlack,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'When distinct astrological systems arrive at the exact same recommendation',
                    style: HandDrawnTokens.bodyFont(
                      fontSize: 14,
                      color: HandDrawnTokens.erasedPencil,
                    ),
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
                        style: HandDrawnTokens.headingFont(
                          fontSize: 21,
                          fontWeight: FontWeight.bold,
                          color: HandDrawnTokens.pencilBlack,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        'おはよう朝日です • Japan’s Official 12-Sign Daily Fortune',
                        style: HandDrawnTokens.bodyFont(
                          fontSize: 13.5,
                          color: HandDrawnTokens.erasedPencil,
                        ),
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
                return SliverToBoxAdapter(
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(32.0),
                      child: CircularProgressIndicator(
                        color: HandDrawnTokens.markerRed,
                        strokeWidth: 2.5,
                      ),
                    ),
                  ),
                );
              }

              if (snapshot.hasError) {
                return SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: HandDrawnCard(
                      child: Text(
                        'Unable to load daily rankings: ${snapshot.error}',
                        style: HandDrawnTokens.bodyFont(color: HandDrawnTokens.markerRed),
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

          // Cultural Heritage Disclaimer Card
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
      child: HandDrawnCard(
        decoration: HandDrawnCardDecoration.tape,
        backgroundColor: HandDrawnTokens.postItYellow,
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
                      width: 52,
                      height: 52,
                      decoration: BoxDecoration(
                        color: HandDrawnTokens.cardWhite,
                        borderRadius: HandDrawnTokens.wobblySm,
                        border: Border.all(color: HandDrawnTokens.pencilBlack, width: 2.5),
                        boxShadow: HandDrawnTokens.hardShadowSm,
                      ),
                      child: Center(
                        child: Text(
                          '#${h.rank}',
                          style: HandDrawnTokens.headingFont(
                            fontSize: 24,
                            fontWeight: FontWeight.w900,
                            color: HandDrawnTokens.markerRed,
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
                              style: HandDrawnTokens.headingFont(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: HandDrawnTokens.pencilBlack,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              h.signNameJapanese,
                              style: HandDrawnTokens.bodyFont(
                                fontSize: 14,
                                color: HandDrawnTokens.erasedPencil,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          'Your Morning TV Fortune',
                          style: HandDrawnTokens.bodyFont(
                            fontSize: 13.5,
                            color: HandDrawnTokens.markerRed,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Row(
                  children: [
                    IconButton(
                      tooltip: 'Share / Copy Daily Fortune',
                      onPressed: () => _shareReading(h),
                      icon: Icon(Icons.share_outlined, color: HandDrawnTokens.pencilBlack),
                    ),
                    IconButton(
                      tooltip: 'View details',
                      onPressed: () => _openDetail(h),
                      icon: Icon(Icons.info_outline, color: HandDrawnTokens.pencilBlack),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 14),
            Text(
              h.description,
              style: HandDrawnTokens.bodyFont(
                fontSize: 15.5,
                height: 1.5,
                color: HandDrawnTokens.pencilBlack,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                    decoration: BoxDecoration(
                      color: HandDrawnTokens.cardWhite,
                      borderRadius: HandDrawnTokens.wobblySm,
                      border: Border.all(color: HandDrawnTokens.pencilBlack, width: 2),
                      boxShadow: HandDrawnTokens.hardShadowSm,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'LUCKY COLOR',
                          style: HandDrawnTokens.headingFont(
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            color: HandDrawnTokens.pencilBlack,
                            letterSpacing: 0.8,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            Container(
                              width: 14,
                              height: 14,
                              decoration: BoxDecoration(
                                color: color,
                                shape: BoxShape.circle,
                                border: Border.all(color: HandDrawnTokens.pencilBlack, width: 1.5),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                h.luckyColor,
                                style: HandDrawnTokens.bodyFont(
                                  fontSize: 14,
                                  color: HandDrawnTokens.pencilBlack,
                                  fontWeight: FontWeight.bold,
                                ),
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
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                    decoration: BoxDecoration(
                      color: HandDrawnTokens.cardWhite,
                      borderRadius: HandDrawnTokens.wobblySm,
                      border: Border.all(color: HandDrawnTokens.pencilBlack, width: 2),
                      boxShadow: HandDrawnTokens.hardShadowSm,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'LUCKY ITEM',
                          style: HandDrawnTokens.headingFont(
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            color: HandDrawnTokens.pencilBlack,
                            letterSpacing: 0.8,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          h.luckyItem,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: HandDrawnTokens.bodyFont(
                            fontSize: 14,
                            color: HandDrawnTokens.pencilBlack,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            LuckIndicatorBar(label: 'Money', score: h.moneyLuck, icon: Icons.attach_money_rounded, color: const Color(0xFFD97706)),
            LuckIndicatorBar(label: 'Love', score: h.loveLuck, icon: Icons.favorite_rounded, color: HandDrawnTokens.markerRed),
            LuckIndicatorBar(label: 'Work', score: h.workLuck, icon: Icons.work_outline_rounded, color: HandDrawnTokens.ballpointBlue),
            LuckIndicatorBar(label: 'Health', score: h.healthLuck, icon: Icons.spa_outlined, color: const Color(0xFF16A34A)),
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
      child: HandDrawnCard(
        onTap: () => _openDetail(h),
        decoration: HandDrawnCardDecoration.none,
        backgroundColor: isTopThree ? const Color(0xFFFFFBEB) : HandDrawnTokens.cardWhite,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: isTopThree ? HandDrawnTokens.markerRed : HandDrawnTokens.warmPaper,
                borderRadius: HandDrawnTokens.wobblySm,
                border: Border.all(color: HandDrawnTokens.pencilBlack, width: 2),
              ),
              child: Center(
                child: Text(
                  '${h.rank}',
                  style: HandDrawnTokens.headingFont(
                    fontSize: 16,
                    fontWeight: FontWeight.w900,
                    color: isTopThree ? HandDrawnTokens.warmPaper : HandDrawnTokens.pencilBlack,
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
                        style: HandDrawnTokens.headingFont(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: HandDrawnTokens.pencilBlack,
                        ),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        h.signNameJapanese,
                        style: HandDrawnTokens.bodyFont(
                          fontSize: 13,
                          color: HandDrawnTokens.erasedPencil,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 2),
                  Text(
                    '${h.luckyColor} • ${h.luckyItem}',
                    style: HandDrawnTokens.bodyFont(
                      fontSize: 13.5,
                      color: HandDrawnTokens.pencilBlack.withValues(alpha: 0.8),
                    ),
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
                border: Border.all(color: HandDrawnTokens.pencilBlack, width: 1.5),
              ),
            ),
            const SizedBox(width: 8),
            Icon(Icons.chevron_right_rounded, color: HandDrawnTokens.pencilBlack.withValues(alpha: 0.4), size: 18),
          ],
        ),
      ),
    );
  }

  Widget _buildDailyConsensusCard(DailyConsensusPoint point) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
      child: HandDrawnCard(
        decoration: HandDrawnCardDecoration.none,
        backgroundColor: HandDrawnTokens.cardWhite,
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
                        style: HandDrawnTokens.headingFont(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          color: point.color,
                          letterSpacing: 1.1,
                        ),
                      ),
                      Text(
                        point.consensusTitle,
                        style: HandDrawnTokens.headingFont(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: HandDrawnTokens.pencilBlack,
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
                color: HandDrawnTokens.warmPaper,
                borderRadius: HandDrawnTokens.wobblySm,
                border: Border.all(color: HandDrawnTokens.pencilBlack, width: 1.5),
              ),
              child: Text(
                point.synthesis,
                style: HandDrawnTokens.bodyFont(
                  fontSize: 14.5,
                  height: 1.45,
                  color: HandDrawnTokens.pencilBlack,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Converging Traditions:',
              style: HandDrawnTokens.headingFont(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: HandDrawnTokens.erasedPencil,
              ),
            ),
            const SizedBox(height: 6),
            Wrap(
              spacing: 6,
              runSpacing: 6,
              children: point.convergingTraditions.map((t) {
                return HandDrawnBadge(
                  label: t,
                  color: point.color,
                  isPostIt: false,
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
