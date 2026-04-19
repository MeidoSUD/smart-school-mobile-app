import 'package:geniuses_school/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class RoleSelectWidget extends StatelessWidget {
  final int? selectedRole;
  final Function(int?) onChanged;
  final String? Function(int?)? validator;

  const RoleSelectWidget({
    super.key,
    required this.selectedRole,
    required this.onChanged,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;

    final roles = [
      {"id": 2, "title": l10n.teacher},
      {"id": 1, "title": l10n.student},
    ];

    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.9,
      child: DropdownButtonFormField<int>(
        initialValue: selectedRole,
        validator: validator,
        items: roles
            .map(
              (g) => DropdownMenuItem<int>(
                value: g["id"] as int,
                child: Text(
                  g["title"] as String,
                  style: const TextStyle(fontSize: 16),
                ),
              ),
            )
            .toList(),
        onChanged: onChanged,
        decoration: InputDecoration(
          hintText: l10n.selectRole,
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
