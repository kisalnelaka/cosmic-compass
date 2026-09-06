import 'package:flutter/material.dart';
import '../models/user_profile.dart';
import '../services/profile_service.dart';
import '../theme/hand_drawn_tokens.dart';
import '../widgets/paper_background.dart';
import 'today_screen.dart';
import 'profile_screen.dart';
import 'comparison_screen.dart';
import 'codex_screen.dart';
import 'profile_setup_dialog.dart';

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _currentIndex = 0;
  UserProfile _userProfile = UserProfile(
    name: 'Cosmic Seeker',
    birthDate: DateTime(2000, 1, 1),
    birthTime: const TimeOfDay(hour: 12, minute: 0),
    bloodType: BloodType.o,
    cityName: 'Tokyo, Japan',
  );
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadProfile();
  }

  Future<void> _loadProfile() async {
    final saved = await ProfileService.loadProfile();
    if (saved != null) {
      setState(() {
        _userProfile = saved;
        _isLoading = false;
      });
    } else {
      setState(() {
        _isLoading = false;
      });
      // First-time user detected: automatically prompt for birth details with smooth entry
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _promptFirstTimeSetup();
      });
    }
  }

  void _promptFirstTimeSetup() {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) => ProfileSetupDialog(
        initialProfile: _userProfile,
        isFirstTime: true,
        onSave: (newProfile) async {
          setState(() {
            _userProfile = newProfile;
          });
          await ProfileService.saveProfile(newProfile);
        },
      ),
    );
  }

  void _openProfileEditor() {
    showDialog(
      context: context,
      builder: (context) => ProfileSetupDialog(
        initialProfile: _userProfile,
        isFirstTime: false,
        onSave: (newProfile) async {
          setState(() {
            _userProfile = newProfile;
          });
          await ProfileService.saveProfile(newProfile);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Scaffold(
        backgroundColor: HandDrawnTokens.warmPaper,
        body: Center(
          child: CircularProgressIndicator(
            color: HandDrawnTokens.markerRed,
            strokeWidth: 3.0,
          ),
        ),
      );
    }

    final screens = [
      TodayScreen(
        profile: _userProfile,
        onEditProfile: _openProfileEditor,
      ),
      ProfileScreen(
        profile: _userProfile,
        onEditProfile: _openProfileEditor,
      ),
      ComparisonScreen(
        profile: _userProfile,
      ),
      const CodexScreen(),
    ];

    return Scaffold(
      backgroundColor: HandDrawnTokens.warmPaper,
      body: PaperBackground(
        child: SafeArea(
          bottom: false,
          child: Align(
            alignment: Alignment.topCenter,
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 880),
              child: screens[_currentIndex],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: HandDrawnTokens.warmPaper,
          border: Border(
            top: BorderSide(
              color: HandDrawnTokens.pencilBlack,
              width: 2.5,
            ),
          ),
          boxShadow: [
            BoxShadow(
              color: HandDrawnTokens.pencilBlack.withValues(alpha: 0.08),
              offset: const Offset(0, -3),
              blurRadius: 0,
            ),
          ],
        ),
        child: SafeArea(
          top: false,
          child: Align(
            alignment: Alignment.bottomCenter,
            heightFactor: 1.0,
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 880),
              child: BottomNavigationBar(
                currentIndex: _currentIndex,
                onTap: (index) => setState(() => _currentIndex = index),
                type: BottomNavigationBarType.fixed,
                backgroundColor: Colors.transparent,
                selectedItemColor: HandDrawnTokens.markerRed,
                unselectedItemColor: HandDrawnTokens.pencilBlack.withValues(alpha: 0.5),
                selectedLabelStyle: HandDrawnTokens.headingFont(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: HandDrawnTokens.markerRed,
                ),
                unselectedLabelStyle: HandDrawnTokens.bodyFont(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: HandDrawnTokens.pencilBlack.withValues(alpha: 0.6),
                ),
                elevation: 0,
                items: [
                  BottomNavigationBarItem(
                    icon: const Icon(Icons.edit_calendar_outlined),
                    activeIcon: Icon(Icons.today_rounded, color: HandDrawnTokens.markerRed),
                    label: 'Daily Forecast',
                  ),
                  BottomNavigationBarItem(
                    icon: const Icon(Icons.menu_book_outlined),
                    activeIcon: Icon(Icons.auto_stories_rounded, color: HandDrawnTokens.markerRed),
                    label: 'My Charts',
                  ),
                  BottomNavigationBarItem(
                    icon: const Icon(Icons.people_outline_rounded),
                    activeIcon: Icon(Icons.people_rounded, color: HandDrawnTokens.markerRed),
                    label: 'Comparison',
                  ),
                  BottomNavigationBarItem(
                    icon: const Icon(Icons.travel_explore_outlined),
                    activeIcon: Icon(Icons.travel_explore_rounded, color: HandDrawnTokens.markerRed),
                    label: 'Codex',
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
