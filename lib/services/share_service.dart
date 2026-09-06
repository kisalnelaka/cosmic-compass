import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../models/horoscope.dart';
import '../services/partner_synastry_service.dart';

class ShareService {
  static Future<void> copyHoroscopeToClipboard(
    Horoscope horoscope, {
    BuildContext? context,
    String? profileName,
  }) async {
    final title = profileName != null
        ? 'Oha Asa Daily Reading for $profileName (${horoscope.signName})'
        : 'Oha Asa Daily Reading for ${horoscope.signName} (${horoscope.period})';

    final text = '''
$title
Daily TV Rank: #${horoscope.rank} of 12
Lucky Item: ${horoscope.luckyItem}
Lucky Color: ${horoscope.luckyColor}

Advice:
${horoscope.description}

Luck Scores:
• Money: ${horoscope.moneyLuck * 20}%
• Love: ${horoscope.loveLuck * 20}%
• Work: ${horoscope.workLuck * 20}%
• Health: ${horoscope.healthLuck * 20}%

Read full multi-cultural insights at: https://kisalnelaka.github.io/oha_asa_app/
''';

    await Clipboard.setData(ClipboardData(text: text.trim()));

    if (context != null && context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text(
            'Copied your daily horoscope reading to clipboard!',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          backgroundColor: const Color(0xFF2D2D2D),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }

  static Future<void> copySynastryToClipboard(
    PartnerCompatibilityResult synastry, {
    BuildContext? context,
  }) async {
    final text = '''
Cosmic Compass Partner Synergy: ${synastry.user.name} & ${synastry.partner.name}
Overall Compatibility: ${synastry.overallScore}%
Relationship Archetype: ${synastry.relationshipArchetype}

Summary:
${synastry.executiveSummary}

Tradition Highlights:
${synastry.traditionBreakdowns.map((t) => '• ${t.traditionName}: ${t.score}% (${t.harmonyLevel})').join('\n')}

Explore full cross-cultural charts at: https://kisalnelaka.github.io/oha_asa_app/
''';

    await Clipboard.setData(ClipboardData(text: text.trim()));

    if (context != null && context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text(
            'Copied partner synergy report to clipboard!',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          backgroundColor: const Color(0xFF2D2D2D),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }
}
