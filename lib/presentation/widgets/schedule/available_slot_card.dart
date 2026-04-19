import 'package:geniuses_school/data/models/time_slot.dart';
import 'package:flutter/material.dart';

import '../../../l10n/app_localizations.dart';

class AvailableSlotCard extends StatelessWidget {
  final TimeSlot slot;
  final Function(TimeSlot) onRemove;

  const AvailableSlotCard({
    super.key,
    required this.slot,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.withOpacity(0.2), width: 1),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: slot.isAvailable
                  ? Colors.green.withOpacity(0.1)
                  : Colors.grey.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              Icons.event_available,
              color: slot.isAvailable ? Colors.green : Colors.grey,
              size: 24,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  slot.time.format(context),
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  slot.isAvailable
                      ? AppLocalizations.of(context)!.availableTime
                      : AppLocalizations.of(context)!.bookedTime,
                  style: TextStyle(
                    color: slot.isAvailable ? Colors.green : Colors.grey,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                onPressed: () => slot.isAvailable ? onRemove(slot) : null,
                icon: const Icon(Icons.remove_circle_outline),
                color: slot.isAvailable ? Colors.red : Colors.grey,
                tooltip: AppLocalizations.of(context)!.removeTime,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
