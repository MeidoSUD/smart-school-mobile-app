import 'package:geniuses_school/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class PhoneNumberFieldWidget extends StatelessWidget {
  final TextEditingController controller;
  final String? selectedCode;
  final Function(String) onCodeChanged;
  final String? Function(String?)? validator;

  const PhoneNumberFieldWidget({
    super.key,
    required this.controller,
    this.selectedCode,
    required this.onCodeChanged,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final countryCodes = ['+974', '+20', '+966', '+971', '+1']; // sample list

    final normalizedSelectedCode =
        (selectedCode != null && !selectedCode!.startsWith('+'))
        ? '+$selectedCode'
        : selectedCode;

    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.9,
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: Row(
          children: [
            // Country code dropdown
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              decoration: BoxDecoration(
                color: theme.cardColor,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.transparent),
              ),
              child: DropdownButton<String>(
                value: normalizedSelectedCode,
                underline: const SizedBox(),
                items: countryCodes
                    .map(
                      (code) => DropdownMenuItem(
                        value: code,
                        child: Text(code, style: const TextStyle(fontSize: 16)),
                      ),
                    )
                    .toList(),
                onChanged: (value) {
                  if (value != null) onCodeChanged(value);
                },
              ),
            ),
            const SizedBox(width: 8),

            // Phone number field
            Expanded(
              child: TextFormField(
                controller: controller,
                keyboardType: TextInputType.phone,
                validator: validator,
                style: const TextStyle(fontSize: 16),
                decoration: InputDecoration(
                  hintText: AppLocalizations.of(context)!.phoneNumberHint,
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
            ),
          ],
        ),
      ),
    );
  }
}
