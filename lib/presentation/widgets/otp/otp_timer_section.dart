import 'package:flutter/material.dart';

import '../../../l10n/app_localizations.dart';

class OtpTimerSection extends StatelessWidget {
  final int remainingSeconds;
  final bool canResend;
  final VoidCallback onResend;

  const OtpTimerSection({
    super.key,
    required this.remainingSeconds,
    required this.canResend,
    required this.onResend,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;
    if (!canResend) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.access_time, size: 20, color: theme.primaryColor),
          const SizedBox(width: 8),
          Text(
            l10n.resendCodeIn,
            style: TextStyle(color: Colors.grey.shade600, fontSize: 14),
          ),
          Text(
            '$remainingSeconds ${l10n.seconds}',
            style: TextStyle(
              color: theme.primaryColor,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ],
      );
    }

    return TextButton.icon(
      onPressed: onResend,
      icon: Icon(Icons.refresh, color: theme.primaryColor),
      label: Text(
        l10n.resendCode,
        style: TextStyle(
          color: theme.primaryColor,
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
    );
  }
}
