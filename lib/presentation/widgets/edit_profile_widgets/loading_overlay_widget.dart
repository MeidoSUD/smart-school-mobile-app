import 'package:geniuses_school/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class LoadingOverlayWidget extends StatelessWidget {
  final bool isUpdating;

  const LoadingOverlayWidget({super.key, required this.isUpdating});

  @override
  Widget build(BuildContext context) {
    if (!isUpdating) return const SizedBox.shrink();

    final theme = Theme.of(context);

    return Container(
      color: Colors.black54,
      child: Center(
        child: Card(
          margin: const EdgeInsets.all(32),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircularProgressIndicator(color: theme.primaryColor),
                const SizedBox(height: 16),
                Text(
                  AppLocalizations.of(context)!.savingData,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  AppLocalizations.of(context)!.loadingMessage,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: Colors.grey.shade600,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
