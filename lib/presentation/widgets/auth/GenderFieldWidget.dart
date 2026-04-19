import 'package:geniuses_school/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class GenderFieldWidget extends StatelessWidget {
  final String? selectedGender;
  final Function(String?) onChanged;
  final String? Function(String?)? validator;

  const GenderFieldWidget({
    super.key,
    required this.selectedGender,
    required this.onChanged,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final l10n = AppLocalizations.of(context)!;
    final genderOptions = [
      {'value': 'male', 'label': l10n.male},
      {'value': 'female', 'label': l10n.female},
      {'value': 'other', 'label': l10n.other},
    ];

    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.9,
      child: DropdownButtonFormField<String>(
        initialValue: selectedGender?.toLowerCase(),
        validator: validator,
        items: genderOptions
            .map(
              (g) => DropdownMenuItem(
                value: g['value'],
                child: Text(g['label']!, style: const TextStyle(fontSize: 16)),
              ),
            )
            .toList(),
        onChanged: onChanged,
        decoration: InputDecoration(
          hintText: AppLocalizations.of(context)!.selectGender,
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
