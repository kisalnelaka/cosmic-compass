class Horoscope {
  final String signName;
  final String signNameJapanese;
  final int rank;
  final String luckyColor;
  final String luckyItem;
  final String description;
  final int moneyLuck;
  final int loveLuck;
  final int workLuck;
  final int healthLuck;
  final String period;
  final String icon;

  Horoscope({
    required this.signName,
    required this.signNameJapanese,
    required this.rank,
    required this.luckyColor,
    required this.luckyItem,
    required this.description,
    required this.moneyLuck,
    required this.loveLuck,
    required this.workLuck,
    required this.healthLuck,
    required this.period,
    required this.icon,
  });

  @override
  String toString() {
    return 'Horoscope(sign: $signName, rank: $rank, item: $luckyItem, color: $luckyColor)';
  }
}

class Ranking {
  final List<Horoscope> horoscopes;
  final DateTime date;

  Ranking({required this.horoscopes, required this.date});
}
