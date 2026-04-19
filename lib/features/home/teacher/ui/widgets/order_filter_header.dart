import 'package:geniuses_school/core/utils/date_time_helper.dart';
import 'package:geniuses_school/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../controllers/teacher_orders_provider.dart';

class OrderFilterHeader extends ConsumerWidget implements PreferredSizeWidget {
  const OrderFilterHeader({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(60);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    // Watch the provider via its notifier to get access to selectedDate/status logic
    // Actually we need to watch the provider to rebuild, but the values are stored in the notifier...
    // Wait, AsyncNotifier doesn't expose state like ChangeNotifier.
    // The state IS the list of orders.
    // We need to access the selected filters.
    // Since I implemented getters in the controller, we can access them via reading the notifier?
    // Accessing properties on a notifier that aren't state requires the notifier instance.
    // But `watch(provider)` gives the async value (the list).
    // `watch(provider.notifier)` gives the controller instance.
    // Let's watch the notifier to rebuild when filters change?
    // Changing filters calls `invalidateSelf`, which rebuilds the state (list).
    // So `watch(provider)` rebuilds. But we need to see the *current filter values* to update UI.
    // The current filter values are properties on the controller.
    // When `invalidateSelf` is called, the controller instance itself doesn't change, but the build method re-runs.
    // The properties `_selectedDate` are stored in the controller instance.
    // So we can read them from `ref.watch(teacherOrdersProvider.notifier)`.

    // Watch the provider state
    final state = ref.watch(teacherOrdersProvider);
    final controller = ref.read(teacherOrdersProvider.notifier);

    final selectedDate = state.selectedDate;
    final selectedStatus = state.selectedStatus;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      color: Colors.white,
      child: Row(
        children: [
          // Date Filter
          Expanded(
            child: InkWell(
              onTap: () async {
                final picked = await showDatePicker(
                  context: context,
                  initialDate: selectedDate ?? DateTime.now(),
                  firstDate: DateTime(2020),
                  lastDate: DateTime(2030),
                );
                if (picked != null) {
                  controller.setDateFilter(picked);
                }
              },
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: selectedDate != null
                      ? theme.primaryColor.withValues(alpha: 0.05)
                      : Colors.grey[50],
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: selectedDate != null
                        ? theme.primaryColor.withValues(alpha: 0.2)
                        : Colors.grey[200]!,
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.calendar_today_rounded,
                      size: 18,
                      color: selectedDate != null
                          ? theme.primaryColor
                          : Colors.grey[500],
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        selectedDate != null
                            ? DateTimeHelper.formatDate(
                                context,
                                selectedDate.toString(),
                              )
                            : AppLocalizations.of(context)!.date,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 13,
                          color: selectedDate != null
                              ? theme.primaryColor
                              : Colors.grey[600],
                          fontWeight: selectedDate != null
                              ? FontWeight.w600
                              : FontWeight.w500,
                        ),
                      ),
                    ),
                    if (selectedDate != null)
                      GestureDetector(
                        onTap: () {
                          controller.clearDateFilter();
                        },
                        child: Icon(
                          Icons.close,
                          size: 16,
                          color: theme.colorScheme.error,
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),

          const SizedBox(width: 8),

          // Status Filter
          Expanded(
            child: PopupMenuButton<String>(
              initialValue: selectedStatus ?? 'all',
              offset: const Offset(0, 48),
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              onSelected: (status) {
                controller.setStatusFilter(status);
              },
              itemBuilder: (context) {
                return [
                  PopupMenuItem<String>(
                    value: 'all',
                    child: Text(AppLocalizations.of(context)!.all),
                  ),
                  _buildPopupItem(
                    "pending",
                    AppLocalizations.of(context)!.pending,
                    Colors.orange,
                  ),
                  _buildPopupItem(
                    "accepted",
                    AppLocalizations.of(context)!.accepted,
                    Colors.green,
                  ),
                  _buildPopupItem(
                    "rejected",
                    AppLocalizations.of(context)!.rejected,
                    Colors.red,
                  ),
                ];
              },
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: (selectedStatus != null && selectedStatus != 'all')
                      ? theme.primaryColor.withValues(alpha: 0.05)
                      : Colors.grey[50],
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: (selectedStatus != null && selectedStatus != 'all')
                        ? theme.primaryColor.withValues(alpha: 0.2)
                        : Colors.grey[200]!,
                  ),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.filter_list_rounded,
                      size: 20,
                      color: (selectedStatus != null && selectedStatus != 'all')
                          ? theme.primaryColor
                          : Colors.grey[500],
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        (selectedStatus != null && selectedStatus != 'all')
                            ? _getStatusLabel(context, selectedStatus)
                            : AppLocalizations.of(context)!.status,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 13,
                          color:
                              (selectedStatus != null &&
                                  selectedStatus != 'all')
                              ? theme.primaryColor
                              : Colors.grey[600],
                          fontWeight:
                              (selectedStatus != null &&
                                  selectedStatus != 'all')
                              ? FontWeight.w600
                              : FontWeight.w500,
                        ),
                      ),
                    ),
                    Icon(
                      Icons.keyboard_arrow_down_rounded,
                      size: 18,
                      color: (selectedStatus != null && selectedStatus != 'all')
                          ? theme.primaryColor
                          : Colors.grey[400],
                    ),
                  ],
                ),
              ),
            ),
          ),

          const SizedBox(width: 8),

          // Clear Filter Button
          if (selectedDate != null ||
              (selectedStatus != null && selectedStatus != 'all'))
            InkWell(
              onTap: () {
                controller.clearAllFilters();
              },
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: Colors.red.withValues(alpha: 0.05),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.red.withValues(alpha: 0.2)),
                ),
                child: const Icon(
                  Icons.filter_alt_off_rounded,
                  color: Colors.red,
                  size: 20,
                ),
              ),
            ),
        ],
      ),
    );
  }

  PopupMenuItem<String> _buildPopupItem(
    String value,
    String label,
    Color color,
  ) {
    return PopupMenuItem<String>(
      value: value,
      child: Row(
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          ),
          const SizedBox(width: 8),
          Text(label),
        ],
      ),
    );
  }

  String _getStatusLabel(BuildContext context, String status) {
    switch (status) {
      case 'pending':
        return AppLocalizations.of(context)!.pending;
      case 'accepted':
        return AppLocalizations.of(context)!.accepted;
      case 'rejected':
        return AppLocalizations.of(context)!.rejected;
      default:
        return status;
    }
  }
}
