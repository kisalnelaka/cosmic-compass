import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/user_profile.dart';
import '../services/profile_service.dart';
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
    }
  }

  void _openProfileEditor() {
    showDialog(
      context: context,
      builder: (context) => ProfileSetupDialog(
        initialProfile: _userProfile,
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
      return const Scaffold(
        backgroundColor: Color(0xFF0A0D1A),
        body: Center(
          child: CircularProgressIndicator(color: Color(0xFFFFD700)),
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
      backgroundColor: Colors.transparent,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF090B16), // Deep Cosmic Void
              Color(0xFF131127), // Nebula Indigo
              Color(0xFF1C1335), // Mystic Plum
            ],
            stops: [0.0, 0.5, 1.0],
          ),
        ),
        child: SafeArea(
          bottom: false,
          child: screens[_currentIndex],
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: const Color(0xFF0F1226).withValues(alpha: 0.96),
          border: Border(
            top: BorderSide(
              color: Colors.white.withValues(alpha: 0.12),
              width: 1.0,
            ),
          ),
        ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) => setState(() => _currentIndex = index),
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.transparent,
          selectedItemColor: const Color(0xFFFFD700),
          unselectedItemColor: Colors.white.withValues(alpha: 0.45),
          selectedLabelStyle: GoogleFonts.outfit(fontSize: 11, fontWeight: FontWeight.bold),
          unselectedLabelStyle: GoogleFonts.outfit(fontSize: 11),
          elevation: 0,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.today_rounded),
              activeIcon: Icon(Icons.today_rounded, color: Color(0xFFFFD700)),
              label: 'Daily Forecast',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.auto_awesome_rounded),
              activeIcon: Icon(Icons.auto_awesome_rounded, color: Color(0xFFFFD700)),
              label: 'My Charts',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.compare_arrows_rounded),
              activeIcon: Icon(Icons.compare_arrows_rounded, color: Color(0xFFFFD700)),
              label: 'Comparison',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.menu_book_rounded),
              activeIcon: Icon(Icons.menu_book_rounded, color: Color(0xFFFFD700)),
              label: 'Codex',
            ),
          ],
        ),
      ),
    );
  }
}
