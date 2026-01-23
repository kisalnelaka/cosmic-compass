import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:workmanager/workmanager.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'screens/home_screen.dart';
import 'services/horoscope_service.dart';
import 'services/widget_service.dart';

class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext? context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}

@pragma('vm:entry-point')
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final userSign = prefs.getString('user_sign');
      if (userSign == null) return true;

      final service = HoroscopeService();
      final horoscopes = await service.fetchHoroscopes();
      final userHoroscope = horoscopes.firstWhere((h) => h.signName == userSign);
      
      await WidgetService.updateWidget(userHoroscope);
      return true;
    } catch (e) {
      return false;
    }
  });
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = MyHttpOverrides();

  await Workmanager().initialize(
    callbackDispatcher,
    isInDebugMode: false,
  );

  await Workmanager().registerPeriodicTask(
    "daily_horoscope_update",
    "fetch_horoscope_task",
    frequency: const Duration(hours: 24),
    constraints: Constraints(
      networkType: NetworkType.connected,
    ),
  );

  runApp(const OhaAsaApp());
}

class OhaAsaApp extends StatelessWidget {
  const OhaAsaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ohayo Asahi',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFFFB7B2), // Pastel Pink
          brightness: Brightness.light,
          surface: const Color(0xFFFFF0F5), // Lavender Blush
        ),
        textTheme: GoogleFonts.quicksandTextTheme(),
        scaffoldBackgroundColor: const Color(0xFFFFF0F5),
      ),
      home: const HomeScreen(),
    );
  }
}
