import 'package:geniuses_school/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class SearchBarWidget extends StatelessWidget {
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final TextEditingController? controller;
  final String? hintText;

  const SearchBarWidget({
    super.key,
    this.onChanged,
    this.onSubmitted,
    this.controller,
    this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: theme.primaryColor.withOpacity(0.2),
            blurRadius: 2,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: TextField(
        controller: controller,
        onChanged: onChanged,
        onSubmitted: onSubmitted,
        style: theme.textTheme.bodyMedium?.copyWith(color: Colors.black87),
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(
            vertical: 14,
            horizontal: 16,
          ),
          hintText: hintText ?? AppLocalizations.of(context)!.search,
          hintStyle: theme.textTheme.labelMedium?.copyWith(color: Colors.grey),
          prefixIcon: Icon(Icons.search, color: theme.primaryColor),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
