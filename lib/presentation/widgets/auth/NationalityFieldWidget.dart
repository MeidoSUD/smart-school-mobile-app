import 'package:geniuses_school/l10n/app_localizations.dart';
import 'package:geniuses_school/presentation/widgets/common/flagWidget.dart';
import 'package:flutter/material.dart';
// import your normalize + flagWidget functions

class NationalityFieldWidget extends StatelessWidget {
  final String? selectedNationality;
  final Function(String?) onChanged;
  final String? Function(String?)? validator;

  const NationalityFieldWidget({
    super.key,
    required this.selectedNationality,
    required this.onChanged,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // Replace this with a complete country list (ISO names or common names)
    final l10n = AppLocalizations.of(context)!;

    // Map of display name (localized) to value (can be country code or standard name)
    // Here using standard English names as values for backend compatibility if needed,
    // or you could use ISO codes. Assuming backend expects the English names currently.
    final nationalities = [
      {'value': 'Qatar', 'label': l10n.countryQatar},
      {'value': 'Egypt', 'label': l10n.countryEgypt},
      {'value': 'Saudi', 'label': l10n.countrySaudi},
      {'value': 'Sudan', 'label': l10n.countrySudan},
      {'value': 'United Arab Emirates', 'label': l10n.countryUAE},
      {'value': 'Kuwait', 'label': l10n.countryKuwait},
      {'value': 'Bahrain', 'label': l10n.countryBahrain},
      {'value': 'Oman', 'label': l10n.countryOman},
      {'value': 'Yemen', 'label': l10n.countryYemen},
      {'value': 'Jordan', 'label': l10n.countryJordan},
      {'value': 'Syria', 'label': l10n.countrySyria},
      {'value': 'Lebanon', 'label': l10n.countryLebanon},
      {'value': 'Palestine', 'label': l10n.countryPalestine},
      {'value': 'Iraq', 'label': l10n.countryIraq},
      {'value': 'Libya', 'label': l10n.countryLibya},
      {'value': 'Tunisia', 'label': l10n.countryTunisia},
      {'value': 'Algeria', 'label': l10n.countryAlgeria},
      {'value': 'Morocco', 'label': l10n.countryMorocco},
      {'value': 'Mauritania', 'label': l10n.countryMauritania},
      {'value': 'Somalia', 'label': l10n.countrySomalia},
      {'value': 'Djibouti', 'label': l10n.countryDjibouti},
      {'value': 'Comoros', 'label': l10n.countryComoros},
      {'value': 'Turkey', 'label': l10n.countryTurkey},
      {'value': 'Indonesia', 'label': l10n.countryIndonesia},
      {'value': 'Malaysia', 'label': l10n.countryMalaysia},
      {'value': 'India', 'label': l10n.countryIndia},
      {'value': 'Pakistan', 'label': l10n.countryPakistan},
      {'value': 'United States', 'label': l10n.countryUS},
      {'value': 'United Kingdom', 'label': l10n.countryUK},
      {'value': 'France', 'label': l10n.countryFrance},
      {'value': 'Germany', 'label': l10n.countryGermany},
      {'value': 'Spain', 'label': l10n.countrySpain},
      {'value': 'Italy', 'label': l10n.countryItaly},
      {'value': 'Russia', 'label': l10n.countryRussia},
      {'value': 'China', 'label': l10n.countryChina},
      {'value': 'Japan', 'label': l10n.countryJapan},
      {'value': 'South Korea', 'label': l10n.countrySouthKorea},
      {'value': 'Canada', 'label': l10n.countryCanada},
      {'value': 'Brazil', 'label': l10n.countryBrazil},
      {'value': 'Australia', 'label': l10n.countryAustralia},
      {'value': 'Nigeria', 'label': l10n.countryNigeria},
      {'value': 'South Africa', 'label': l10n.countrySouthAfrica},
      {'value': 'Mexico', 'label': l10n.countryMexico},
      {'value': 'Argentina', 'label': l10n.countryArgentina},
    ];

    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.9,
      child: DropdownButtonFormField<String>(
        initialValue: selectedNationality,
        validator: validator,
        dropdownColor: theme.cardColor,
        padding: const EdgeInsets.symmetric(horizontal: 8),
        items: nationalities
            .map(
              (n) => DropdownMenuItem(
                value: n['value'],
                child: Row(
                  children: [
                    flagWidget(
                      n['value']!,
                      width: 28,
                      height: 18,
                      borderRadius: 3,
                    ),
                    const SizedBox(width: 8),
                    Text(n['label']!, style: const TextStyle(fontSize: 16)),
                  ],
                ),
              ),
            )
            .toList(),
        onChanged: onChanged,
        decoration: InputDecoration(
          hintText: AppLocalizations.of(context)!.selectNationality,
          filled: true,
          fillColor: theme.cardColor,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 14,
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(12),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: theme.primaryColor, width: 1),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Colors.red),
          ),
        ),
      ),
    );
  }
}
