import 'package:http/http.dart' as http;
import 'package:html/parser.dart' show parse;
import 'package:html/dom.dart';
import 'package:translator/translator.dart';
import '../models/horoscope.dart';

class HoroscopeService {
  final GoogleTranslator _translator = GoogleTranslator();
  static const String _url = 'https://www.tv-asahi.co.jp/goodmorning/uranai/#ite';

  // Hiragana names as found on the website
  final Map<String, Map<String, String>> _signInfoMap = {
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
    try {
      print('Fetching horoscope data...');
      final response = await http.get(Uri.parse(_url)).timeout(const Duration(seconds: 15));
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
      
      if (horoscopes.isEmpty) {
        throw Exception('Parsed 0 signs. Parsing failed.');
      }

      horoscopes.sort((a, b) => a.rank.compareTo(b.rank));
      return horoscopes;
    } catch (e) {
      rethrow;
    }
  }

  Future<Horoscope?> _parseSignElement(Element element, Map<String, int> rankingMap) async {
    try {
      final nameElement = element.querySelector('.seiza-txt');
      final japaneseNameRaw = nameElement?.text.trim() ?? '';
      
      // Find matching sign info by checking if the raw text contains the key
      String? matchedKey;
      for (var key in _signInfoMap.keys) {
        if (japaneseNameRaw.contains(key)) {
          matchedKey = key;
          break;
        }
      }

      if (matchedKey == null) {
        return null;
      }

      final info = _signInfoMap[matchedKey]!;
      final englishName = info['en']!;
      final rank = rankingMap[matchedKey] ?? 0;
      final icon = info['icon']!;
      final period = info['full']!;

      // Description - only the text inside .read
      final descriptionElement = element.querySelector('.read-area .read');
      final japaneseDescription = descriptionElement?.text.trim() ?? '';
      final englishDescription = (await _translator.translate(japaneseDescription).timeout(const Duration(seconds: 5))).text;

      // Lucky Color - handle "ラッキーカラー：ピンク"
      final colorElement = element.querySelector('.lucky-color-txt');
      final colorFullText = colorElement?.parent?.text ?? '';
      // Better isolation: Split by the key label as well to avoid duplication
      final japaneseColor = colorFullText.split('ラッキーカラー：').last.split('幸運のカギ').first.trim().replaceAll('：', '');
      final englishColor = (await _translator.translate(japaneseColor).timeout(const Duration(seconds: 5))).text;

      // Lucky Key (Lucky Item) - handle "幸運のカギ：家族の写真"
      final itemElement = element.querySelector('.key-txt');
      final itemFullText = itemElement?.parent?.text ?? '';
      final japaneseItem = itemFullText.split('幸運のカギ：').last.trim().replaceAll('：', '');
      final englishItem = (await _translator.translate(japaneseItem).timeout(const Duration(seconds: 5))).text;

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
        luckyColor: englishColor,
        luckyItem: englishItem,
        description: englishDescription,
        moneyLuck: money,
        loveLuck: love,
        workLuck: work,
        healthLuck: health,
        period: period,
        icon: icon,
      );
    } catch (e) {
      return null;
    }
  }
}
