import 'package:home_widget/home_widget.dart';
import '../models/horoscope.dart';

class WidgetService {
  static const String _androidWidgetName = 'HoroscopeWidgetProvider';

  static Future<void> updateWidget(Horoscope horoscope) async {
    try {
      await HomeWidget.saveWidgetData('widget_sign', horoscope.signName);
      await HomeWidget.saveWidgetData('widget_rank', horoscope.rank.toString());
      await HomeWidget.saveWidgetData('widget_item', horoscope.luckyItem);
      await HomeWidget.saveWidgetData('widget_color', horoscope.luckyColor);
      
      await HomeWidget.updateWidget(
        name: _androidWidgetName,
        androidName: _androidWidgetName,
      );
      print('Widget updated successfully for ${horoscope.signName}');
    } catch (e) {
      print('Failed to update widget: $e');
    }
  }
}
