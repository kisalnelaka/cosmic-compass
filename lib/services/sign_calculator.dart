class SignCalculator {
  static const Map<String, Map<String, dynamic>> _signs = {
    'Aries': {'start': [3, 21], 'end': [4, 19]},
    'Taurus': {'start': [4, 20], 'end': [5, 20]},
    'Gemini': {'start': [5, 21], 'end': [6, 21]},
    'Cancer': {'start': [6, 22], 'end': [7, 22]},
    'Leo': {'start': [7, 23], 'end': [8, 22]},
    'Virgo': {'start': [8, 23], 'end': [9, 22]},
    'Libra': {'start': [9, 23], 'end': [10, 23]},
    'Scorpio': {'start': [10, 24], 'end': [11, 22]},
    'Sagittarius': {'start': [11, 23], 'end': [12, 21]},
    'Capricorn': {'start': [12, 22], 'end': [1, 19]},
    'Aquarius': {'start': [1, 20], 'end': [2, 18]},
    'Pisces': {'start': [2, 19], 'end': [3, 20]},
  };

  static String getSign(int month, int day) {
    for (var entry in _signs.entries) {
      final start = entry.value['start'] as List<int>;
      final end = entry.value['end'] as List<int>;

      if (month == start[0] && day >= start[1]) return entry.key;
      if (month == end[0] && day <= end[1]) return entry.key;
    }
    return '';
  }
}
