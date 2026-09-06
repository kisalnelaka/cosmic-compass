import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:workmanager/workmanager.dart';
import 'horoscope_service.dart';
import 'widget_service.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port) => true;
  }
}

void setupHttpOverrides() {
  if (!kIsWeb) {
    HttpOverrides.global = MyHttpOverrides();
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

Future<void> setupWorkmanager() async {
  if (!kIsWeb) {
    try {
      await Workmanager().initialize(
        callbackDispatcher,
      );

      await Workmanager().registerPeriodicTask(
        "daily_horoscope_update",
        "fetch_horoscope_task",
        frequency: const Duration(hours: 24),
        constraints: Constraints(
          networkType: NetworkType.connected,
        ),
      );
    } catch (_) {
      // Ignore background registration errors on non-supported platforms
    }
  }
}
