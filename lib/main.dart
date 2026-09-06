import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'screens/main_navigation_screen.dart';
import 'services/platform_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  initializePlatformOverrides();
  await initializeBackgroundTasks();

  runApp(const OhaAsaApp());
}

class OhaAsaApp extends StatelessWidget {
  const OhaAsaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cosmic Compass • Oha Asa & Global Horoscope',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF090B16),
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFFFFD700), // Celestial Gold
          secondary: Color(0xFF9B51E0), // Cosmic Violet
          surface: Color(0xFF13172E),
          onPrimary: Colors.black,
          onSecondary: Colors.white,
          onSurface: Colors.white,
        ),
        textTheme: GoogleFonts.outfitTextTheme(ThemeData.dark().textTheme),
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0,
          titleTextStyle: GoogleFonts.outfit(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      home: const MainNavigationScreen(),
    );
  }
}
