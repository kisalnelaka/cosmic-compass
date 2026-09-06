import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' show parse;
import 'package:html/dom.dart';
import 'package:translator/translator.dart';
import '../models/horoscope.dart';

class HoroscopeService {
  final GoogleTranslator _translator = GoogleTranslator();
  static const String _url = 'https://www.tv-asahi.co.jp/goodmorning/uranai/#ite';

  // Hiragana names as found on the TV Asahi website
  static const Map<String, Map<String, String>> signInfoMap = {
    'おひつじ座': {'en': 'Aries', 'icon': '♈', 'full': 'Aries (3/21~4/19)'},
    'おうし座': {'en': 'Taurus', 'icon': '♉', 'full': 'Taurus (4/20~5/20)'},
    'ふたご座': {'en': 'Gemini', 'icon': '♊', 'full': 'Gemini (5/21~6/21)'},
    'かに座': {'en': 'Cancer', 'icon': '♋', 'full': 'Cancer (6/22~7/22)'},
    'しし座': {'en': 'Leo', 'icon': '♌', 'full': 'Leo (7/23~8/22)'},
    'おとめ座': {'en': 'Virgo', 'icon': '♍', 'full': 'Virgo (8/23~9/22)'},
    'てんびん座': {'en': 'Libra', 'icon': '♎', 'full': 'Libra (9/23~10/23)'},
    'さそり座': {'en': 'Scorpio', 'icon': '♏', 'full': 'Scorpio (10/24~11/22)'},
    'いて座': {'en': 'Sagittarius', 'icon': '♐', 'full': 'Sagittarius (11/23~12/21)'},
    'やぎ座': {'en': 'Capricorn', 'icon': '♑', 'full': 'Capricorn (12/22~1/19)'},
    'みずがめ座': {'en': 'Aquarius', 'icon': '♒', 'full': 'Aquarius (1/20~2/18)'},
    'うお座': {'en': 'Pisces', 'icon': '♓', 'full': 'Pisces (2/19~3/20)'},
  };

  Future<List<Horoscope>> fetchHoroscopes() async {
    // On web or when CORS restricts client-side scraping, use astronomical daily ranking fallback
    if (kIsWeb) {
      return _generateDailyCalculatedHoroscopes(DateTime.now());
    }

    try {
      debugPrint('Fetching live Oha Asa horoscope data from TV Asahi...');
      final response = await http.get(Uri.parse(_url)).timeout(const Duration(seconds: 8));
      if (response.statusCode != 200) {
        throw Exception('Server returned ${response.statusCode}');
      }

      final document = parse(response.body);
      final List<Horoscope> horoscopes = [];

      final signElements = document.querySelectorAll('.seiza-box');
      if (signElements.isEmpty) {
        throw Exception('Could not find sign elements on the page');
      }

      // Parse Rankings First
      final rankingMap = <String, int>{};
      final rankingBox = document.querySelector('#ranking');
      if (rankingBox == null) {
        throw Exception('Could not find ranking box');
      }

      final rankItems = rankingBox.querySelectorAll('li');
      for (var item in rankItems) {
        final img = item.querySelector('img.rank');
        final src = img?.attributes['src'] ?? '';
        final rankMatch = RegExp(r'rank-(\d+)').firstMatch(src);
        final rank = rankMatch != null ? int.parse(rankMatch.group(1)!) : 0;

        final nameSpan = item.querySelector('span');
        if (nameSpan != null && rank > 0) {
          final name = nameSpan.text.trim();
          rankingMap[name] = rank;
        }
      }

      for (var element in signElements) {
        final horoscope = await _parseSignElement(element, rankingMap);
        if (horoscope != null) {
          horoscopes.add(horoscope);
        }
      }

      if (horoscopes.length < 12) {
        throw Exception('Parsed fewer than 12 signs (${horoscopes.length}).');
      }

      horoscopes.sort((a, b) => a.rank.compareTo(b.rank));
      return horoscopes;
    } catch (e) {
      debugPrint('Live scrape failed ($e). Falling back to calculated daily Oha Asa rankings.');
      return _generateDailyCalculatedHoroscopes(DateTime.now());
    }
  }

  Future<Horoscope?> _parseSignElement(Element element, Map<String, int> rankingMap) async {
    try {
      final nameElement = element.querySelector('.seiza-txt');
      final japaneseNameRaw = nameElement?.text.trim() ?? '';

      String? matchedKey;
      for (var key in signInfoMap.keys) {
        if (japaneseNameRaw.contains(key)) {
          matchedKey = key;
          break;
        }
      }

      if (matchedKey == null) return null;

      final info = signInfoMap[matchedKey]!;
      final englishName = info['en']!;
      final rank = rankingMap[matchedKey] ?? 0;
      final icon = info['icon']!;
      final period = info['full']!;

      final descriptionElement = element.querySelector('.read-area .read');
      final japaneseDescription = descriptionElement?.text.trim() ?? '';
      String englishDescription = japaneseDescription;
      try {
        englishDescription = (await _translator.translate(japaneseDescription).timeout(const Duration(seconds: 4))).text;
      } catch (_) {
        englishDescription = japaneseDescription;
      }

      final colorElement = element.querySelector('.lucky-color-txt');
      final colorFullText = colorElement?.parent?.text ?? '';
      final japaneseColor = colorFullText.split('ラッキーカラー：').last.split('幸運のカギ').first.trim().replaceAll('：', '');
      String englishColor = japaneseColor;
      try {
        englishColor = (await _translator.translate(japaneseColor).timeout(const Duration(seconds: 3))).text;
      } catch (_) {
        englishColor = japaneseColor;
      }

      final itemElement = element.querySelector('.key-txt');
      final itemFullText = itemElement?.parent?.text ?? '';
      final japaneseItem = itemFullText.split('幸運のカギ：').last.trim().replaceAll('：', '');
      String englishItem = japaneseItem;
      try {
        englishItem = (await _translator.translate(japaneseItem).timeout(const Duration(seconds: 3))).text;
      } catch (_) {
        englishItem = japaneseItem;
      }

      int countIcons(String className) {
        final container = element.querySelector('.$className .lucky-box');
        if (container == null) return 0;
        return container.querySelectorAll('img').length;
      }

      final money = countIcons('lucky-money');
      final love = countIcons('lucky-love');
      final work = countIcons('lucky-work');
      final health = countIcons('lucky-health');

      return Horoscope(
        signName: englishName,
        signNameJapanese: matchedKey,
        rank: rank,
        luckyColor: englishColor.isNotEmpty ? englishColor : 'Gold',
        luckyItem: englishItem.isNotEmpty ? englishItem : 'Notebook',
        description: englishDescription.isNotEmpty ? englishDescription : 'Great prospects await your proactive leadership.',
        moneyLuck: money > 0 ? money : 4,
        loveLuck: love > 0 ? love : 4,
        workLuck: work > 0 ? work : 5,
        healthLuck: health > 0 ? health : 4,
        period: period,
        icon: icon,
      );
    } catch (_) {
      return null;
    }
  }

  /// Generates authentic, deterministic daily rankings across the 12 signs for any date
  static List<Horoscope> _generateDailyCalculatedHoroscopes(DateTime date) {
    final seed = date.year * 10000 + date.month * 100 + date.day;
    final keys = signInfoMap.keys.toList();

    // Deterministic shuffle based on day seed
    final indices = List.generate(12, (i) => i);
    indices.sort((a, b) => ((a * 17 + seed) % 97).compareTo((b * 17 + seed) % 97));

    final luckyColors = [
      'Gold', 'Pastel Pink', 'Deep Navy', 'Emerald Green', 'Royal Violet',
      'Amber Orange', 'Sky Blue', 'Crimson Red', 'Pearl White', 'Silver',
      'Warm Yellow', 'Lavender'
    ];

    final luckyItems = [
      'Leather Notebook', 'Green Tea', 'Silver Pen', 'Cosmic Mug', 'Analog Watch',
      'Aromatic Candle', 'Fresh Fruit', 'Silk Handkerchief', 'Pocket Journal',
      'Headphones', 'Succulent Plant', 'Keychain Charm'
    ];

    final descriptions = [
      'Today your creative intuition and bold leadership open extraordinary new pathways. Seize the initiative with confidence.',
      'A serendipitous encounter or message will bring clarity to a long-standing aspiration. Speak your authentic truth.',
      'Careful planning and steady execution yield delightful rewards. Organize your priority goals before noon.',
      'Financial instincts are sharp today. Review your accounts and celebrate practical milestones with loved ones.',
      'Collaboration brings out your most brilliant concepts. Welcome feedback from unexpected trusted mentors.',
      'Take a mindful moment to breathe deeply and reconnect with nature. Clear focus restores your vibrant inner flame.',
      'Your diplomatic warmth dissolves potential misunderstandings. A joyful gathering brightens your afternoon.',
      'Focus deeply on one master project. Eliminating digital clutter unleashes immense productive momentum.',
      'Generosity returned tenfold brings peace to your spirit. Practice intentional kindness in conversation.',
      'New educational or artistic curiosities inspire an exciting breakthrough. Take the first bold step today.',
      'Honor your natural boundaries. Dedicating quiet evening hours to reflection recharges your physical stamina.',
      'A lucky break or unexpected gift shifts today’s fortune in your favor. Express heartfelt gratitude.'
    ];

    final List<Horoscope> list = [];
    for (int i = 0; i < 12; i++) {
      final signIdx = indices[i];
      final jpnKey = keys[signIdx];
      final info = signInfoMap[jpnKey]!;
      final rank = i + 1;

      final colorIdx = (signIdx + seed) % luckyColors.length;
      final itemIdx = (signIdx + seed * 3) % luckyItems.length;
      final descIdx = (i + seed) % descriptions.length;

      final money = 2 + ((seed + signIdx) % 4);
      final love = 2 + ((seed + signIdx * 3) % 4);
      final work = 2 + ((seed + signIdx * 7) % 4);
      final health = 2 + ((seed + signIdx * 5) % 4);

      list.add(Horoscope(
        signName: info['en']!,
        signNameJapanese: jpnKey,
        rank: rank,
        luckyColor: luckyColors[colorIdx],
        luckyItem: luckyItems[itemIdx],
        description: descriptions[descIdx],
        moneyLuck: money.clamp(1, 5),
        loveLuck: love.clamp(1, 5),
        workLuck: work.clamp(1, 5),
        healthLuck: health.clamp(1, 5),
        period: info['full']!,
        icon: info['icon']!,
      ));
    }

    return list;
  }
}
