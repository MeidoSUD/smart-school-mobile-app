import 'package:flutter/material.dart';

/// Try to normalize your input (e.g. 'su' -> 'sd') if you have non-standard codes.
/// Update this map to fit your dataset.
String normalizeCountryCode(String input) {
  final s = input.trim().toLowerCase();
  // common aliases -> ISO alpha-2
const aliases = {
  // Africa
  'su': 'sd', 'sudan': 'sd',
  'eg': 'eg', 'egypt': 'eg',
  'dz': 'dz', 'algeria': 'dz',
  'ma': 'ma', 'morocco': 'ma',
  'tn': 'tn', 'tunisia': 'tn',
  'ly': 'ly', 'libya': 'ly',
  'ng': 'ng', 'nigeria': 'ng',
  'ke': 'ke', 'kenya': 'ke',
  'tz': 'tz', 'tanzania': 'tz',
  'za': 'za', 'south africa': 'za',
  'gh': 'gh', 'ghana': 'gh',
  'et': 'et', 'ethiopia': 'et',
  'ci': 'ci', "cote d'ivoire": 'ci', 'ivory coast': 'ci',
  
  // Middle East
  'sa': 'sa', 'ksa': 'sa', 'saudi arabia': 'sa',
  'ae': 'ae', 'uae': 'ae', 'emirates': 'ae',
  'qa': 'qa', 'qatar': 'qa',
  'bh': 'bh', 'bahrain': 'bh',
  'om': 'om', 'oman': 'om',
  'kw': 'kw', 'kuwait': 'kw',
  'jo': 'jo', 'jordan': 'jo',
  'lb': 'lb', 'lebanon': 'lb',
  'iq': 'iq', 'iraq': 'iq',
  'sy': 'sy', 'syria': 'sy',
  'ye': 'ye', 'yemen': 'ye',
  
  // Asia
  'in': 'in', 'india': 'in',
  'pk': 'pk', 'pakistan': 'pk',
  'bd': 'bd', 'bangladesh': 'bd',
  'lk': 'lk', 'sri lanka': 'lk',
  'np': 'np', 'nepal': 'np',
  'cn': 'cn', 'china': 'cn',
  'jp': 'jp', 'japan': 'jp',
  'kr': 'kr', 'south korea': 'kr', 'korea': 'kr',
  'vn': 'vn', 'vietnam': 'vn',
  'th': 'th', 'thailand': 'th',
  'my': 'my', 'malaysia': 'my',
  'sg': 'sg', 'singapore': 'sg',
  'id': 'id', 'indonesia': 'id',
  'ph': 'ph', 'philippines': 'ph',
  
  // Europe
  'fr': 'fr', 'france': 'fr',
  'de': 'de', 'germany': 'de',
  'uk': 'gb', 'gb': 'gb', 'united kingdom': 'gb', 'britain': 'gb', 'england': 'gb',
  'es': 'es', 'spain': 'es',
  'it': 'it', 'italy': 'it',
  'nl': 'nl', 'netherlands': 'nl',
  'be': 'be', 'belgium': 'be',
  'ch': 'ch', 'switzerland': 'ch',
  'se': 'se', 'sweden': 'se',
  'no': 'no', 'norway': 'no',
  'fi': 'fi', 'finland': 'fi',
  'dk': 'dk', 'denmark': 'dk',
  'pl': 'pl', 'poland': 'pl',
  'ru': 'ru', 'russia': 'ru',
  
  // Americas
  'us': 'us', 'usa': 'us', 'america': 'us', 'united states': 'us',
  'ca': 'ca', 'canada': 'ca',
  'mx': 'mx', 'mexico': 'mx',
  'br': 'br', 'brazil': 'br',
  'ar': 'ar', 'argentina': 'ar',
  'cl': 'cl', 'chile': 'cl',
  'co': 'co', 'colombia': 'co',
  
  // Oceania
  'au': 'au', 'australia': 'au',
  'nz': 'nz', 'new zealand': 'nz',
  'fj': 'fj', 'fiji': 'fj',
  
  // Common short codes that may appear
  'ua': 'ua', 'ukraine': 'ua',

  'gr': 'gr', 'greece': 'gr',
  'tr': 'tr', 'turkey': 'tr',
};

  if (aliases.containsKey(s)) return aliases[s]!;
  if (s.length == 2) return s; // already alpha-2
  // fallback: try first two letters (not ideal — better to normalize upstream)
  return s.length >= 2 ? s.substring(0, 2) : s;
}

/// Convert ISO two-letter code to emoji flag (fallback if image missing)
String countryCodeToEmoji(String countryCode) {
  final code = countryCode.toUpperCase();
  if (code.length != 2) return '';
  final int base = 0x1F1E6;
  final first = base + code.codeUnitAt(0) - 65;
  final second = base + code.codeUnitAt(1) - 65;
  return String.fromCharCodes([first, second]);
}

/// Widget that displays a flag image from country_icons package,
/// with emoji fallback and placeholder.
Widget flagWidget(String nationality, {double width = 32, double height = 20, double borderRadius = 4}) {
  final iso = normalizeCountryCode(nationality);
  final assetPath = 'packages/country_icons/icons/flags/png/2.5x/${iso.toLowerCase()}.png';

  return ClipRRect(
    borderRadius: BorderRadius.circular(borderRadius),
    child: Image.asset(
      assetPath,
      width: width,
      height: height,
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) {
        final emoji = countryCodeToEmoji(iso);
        if (emoji.isNotEmpty) {
          return Center(child: Text(emoji, style: TextStyle(fontSize: height * 0.9)));
        }
        // final fallback box
        return Container(
          width: width,
          height: height,
          color: Colors.grey.shade200,
          child: Icon(Icons.flag, size: width * 0.6, color: Colors.grey),
        );
      },
    ),
  );
}
