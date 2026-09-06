import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'screens/main_navigation_screen.dart';
import 'services/platform_helper.dart';
import 'services/notification_service.dart';
import 'theme/hand_drawn_tokens.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  initializePlatformOverrides();
  await initializeBackgroundTasks();
  await NotificationService.initialize();

  runApp(const OhaAsaApp());
}

class OhaAsaApp extends StatelessWidget {
  const OhaAsaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cosmic Compass: Oha Asa and World Traditions',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
        scaffoldBackgroundColor: HandDrawnTokens.warmPaper,
        colorScheme: const ColorScheme.light(
          primary: HandDrawnTokens.markerRed,
          secondary: HandDrawnTokens.ballpointBlue,
          surface: HandDrawnTokens.cardWhite,
          onPrimary: Colors.white,
          onSecondary: Colors.white,
          onSurface: HandDrawnTokens.pencilBlack,
        ),
        textTheme: GoogleFonts.patrickHandTextTheme().copyWith(
          displayLarge: GoogleFonts.kalam(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: HandDrawnTokens.pencilBlack,
          ),
          displayMedium: GoogleFonts.kalam(
            fontSize: 26,
            fontWeight: FontWeight.bold,
            color: HandDrawnTokens.pencilBlack,
          ),
          titleLarge: GoogleFonts.kalam(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: HandDrawnTokens.pencilBlack,
          ),
          titleMedium: GoogleFonts.kalam(
            fontSize: 17,
            fontWeight: FontWeight.bold,
            color: HandDrawnTokens.pencilBlack,
          ),
          bodyLarge: GoogleFonts.patrickHand(
            fontSize: 17,
            color: HandDrawnTokens.pencilBlack,
          ),
          bodyMedium: GoogleFonts.patrickHand(
            fontSize: 15,
            color: HandDrawnTokens.pencilBlack,
          ),
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0,
          titleTextStyle: GoogleFonts.kalam(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: HandDrawnTokens.pencilBlack,
          ),
          iconTheme: const IconThemeData(color: HandDrawnTokens.pencilBlack),
        ),
      ),
      home: const MainNavigationScreen(),
    );
  }
}
