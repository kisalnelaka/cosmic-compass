import 'package:flutter/foundation.dart';
import 'package:home_widget/home_widget.dart';
import '../models/horoscope.dart';

class WidgetService {
  static const String _androidWidgetName = 'HoroscopeWidgetProvider';

  static Future<void> updateWidget(Horoscope horoscope) async {
    if (kIsWeb) return;
    try {
      await HomeWidget.saveWidgetData('widget_sign', horoscope.signName);
      await HomeWidget.saveWidgetData('widget_rank', horoscope.rank.toString());
      await HomeWidget.saveWidgetData('widget_item', horoscope.luckyItem);
      await HomeWidget.saveWidgetData('widget_color', horoscope.luckyColor);

      await HomeWidget.updateWidget(
        name: _androidWidgetName,
        androidName: _androidWidgetName,
      );
      debugPrint('Widget updated successfully for ${horoscope.signName}');
    } catch (e) {
      debugPrint('Failed to update widget: $e');
    }
  }
}
