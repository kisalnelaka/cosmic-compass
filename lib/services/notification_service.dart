import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/horoscope.dart';

class NotificationService {
  static final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static const String _prefKeyEnabled = 'daily_notifications_enabled';
  static const String _prefKeyHour = 'daily_notification_hour';
  static const String _prefKeyMinute = 'daily_notification_minute';

  static Future<void> initialize() async {
    const androidSettings = AndroidInitializationSettings('@mipmap/ic_launcher');
    const darwinSettings = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );
    const linuxSettings = LinuxInitializationSettings(defaultActionName: 'open');

    const initSettings = InitializationSettings(
      android: androidSettings,
      iOS: darwinSettings,
      macOS: darwinSettings,
      linux: linuxSettings,
    );

    try {
      await _notificationsPlugin.initialize(
        settings: initSettings,
        onDidReceiveNotificationResponse: (details) {
          debugPrint('Notification clicked: ${details.payload}');
        },
      );

      // Request permission on Android 13+
      if (!kIsWeb) {
        final androidImpl = _notificationsPlugin.resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>();
        await androidImpl?.requestNotificationsPermission();
      }
    } catch (e) {
      debugPrint('Notification initialization notice: $e');
    }
  }

  static Future<bool> isEnabled() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_prefKeyEnabled) ?? true;
  }

  static Future<void> setEnabled(bool enabled) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_prefKeyEnabled, enabled);
    if (!enabled) {
      await cancelAll();
    }
  }

  static Future<int> getScheduledHour() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_prefKeyHour) ?? 7; // Default 7:00 AM
  }

  static Future<int> getScheduledMinute() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_prefKeyMinute) ?? 0;
  }

  static Future<void> setScheduledTime(int hour, int minute) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_prefKeyHour, hour);
    await prefs.setInt(_prefKeyMinute, minute);
  }

  static Future<void> showDailyHoroscopeAlert(Horoscope horoscope) async {
    final enabled = await isEnabled();
    if (!enabled) return;

    const androidDetails = AndroidNotificationDetails(
      'daily_horoscope_channel',
      'Daily Horoscope Guidance',
      channelDescription: 'Morning fortune rankings and lucky items',
      importance: Importance.high,
      priority: Priority.high,
    );

    const darwinDetails = DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    const details = NotificationDetails(
      android: androidDetails,
      iOS: darwinDetails,
      macOS: darwinDetails,
    );

    try {
      await _notificationsPlugin.show(
        id: 101,
        title: 'Good Morning: ${horoscope.signName} is #${horoscope.rank} Today',
        body: 'Lucky Item: ${horoscope.luckyItem}, Lucky Color: ${horoscope.luckyColor}. Tap to view your full daily reading.',
        notificationDetails: details,
      );
    } catch (e) {
      debugPrint('Failed to send notification: $e');
    }
  }

  static Future<void> cancelAll() async {
    try {
      await _notificationsPlugin.cancelAll();
    } catch (_) {}
  }
}
