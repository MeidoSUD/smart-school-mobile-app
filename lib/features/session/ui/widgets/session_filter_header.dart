import 'package:geniuses_school/core/utils/date_time_helper.dart';
import 'package:geniuses_school/features/session/controllers/session_provider.dart';
import 'package:geniuses_school/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SessionFilterHeader extends ConsumerWidget
    implements PreferredSizeWidget {
  const SessionFilterHeader({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(60);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final sessionState = ref.watch(sessionProvider);
    final l10n = AppLocalizations.of(context)!;

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
                  initialDate: sessionState.selectedDate ?? DateTime.now(),
                  firstDate: DateTime(2020),
                  lastDate: DateTime(2030),
                );
                if (picked != null) {
                  ref.read(sessionProvider.notifier).setDateFilter(picked);
                }
              },
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: sessionState.selectedDate != null
                      ? theme.primaryColor.withOpacity(0.05)
                      : Colors.grey[50],
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: sessionState.selectedDate != null
                        ? theme.primaryColor.withOpacity(0.2)
                        : Colors.grey[200]!,
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.calendar_today_rounded,
                      size: 18,
                      color: sessionState.selectedDate != null
                          ? theme.primaryColor
                          : Colors.grey[500],
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        sessionState.selectedDate != null
                            ? DateTimeHelper.formatDate(
                                context,
                                sessionState.selectedDate!.toString(),
                              )
                            : l10n.filterDatePlaceholder,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 13,
                          color: sessionState.selectedDate != null
                              ? theme.primaryColor
                              : Colors.grey[600],
                          fontWeight: sessionState.selectedDate != null
                              ? FontWeight.w600
                              : FontWeight.w500,
                        ),
                      ),
                    ),
                    if (sessionState.selectedDate != null)
                      GestureDetector(
                        onTap: () {
                          ref.read(sessionProvider.notifier).clearDateFilter();
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
            child: PopupMenuButton<SessionStatus>(
              // Changed from SessionStatus?
              initialValue: sessionState.selectedStatus ?? SessionStatus.all,
              offset: const Offset(0, 48),
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              onSelected: (status) {
                ref.read(sessionProvider.notifier).setStatusFilter(status);
              },
              itemBuilder: (context) {
                return [
                  PopupMenuItem<SessionStatus>(
                    value: SessionStatus.all,
                    child: Text(l10n.sessionStatusAll),
                  ),
                  ...SessionStatus.values
                      .where(
                        (s) =>
                            s != SessionStatus.unknown &&
                            s != SessionStatus.all,
                      )
                      .map((status) {
                        return PopupMenuItem<SessionStatus>(
                          value: status,
                          child: Row(
                            children: [
                              Container(
                                width: 8,
                                height: 8,
                                decoration: BoxDecoration(
                                  color: status.color,
                                  shape: BoxShape.circle,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Text(status.localizedLabel(context)),
                            ],
                          ),
                        );
                      }),
                ];
              },
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color:
                      (sessionState.selectedStatus != null &&
                          sessionState.selectedStatus != SessionStatus.all)
                      ? sessionState.selectedStatus!.color.withOpacity(0.05)
                      : Colors.grey[50],
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color:
                        (sessionState.selectedStatus != null &&
                            sessionState.selectedStatus != SessionStatus.all)
                        ? sessionState.selectedStatus!.color.withOpacity(0.2)
                        : Colors.grey[200]!,
                  ),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.filter_list_rounded,
                      size: 20,
                      color:
                          (sessionState.selectedStatus != null &&
                              sessionState.selectedStatus != SessionStatus.all)
                          ? sessionState.selectedStatus!.color
                          : Colors.grey[500],
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        (sessionState.selectedStatus != null &&
                                sessionState.selectedStatus !=
                                    SessionStatus.all)
                            ? sessionState.selectedStatus!.localizedLabel(
                                context,
                              )
                            : l10n.filterStatusPlaceholder,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 13,
                          color:
                              (sessionState.selectedStatus != null &&
                                  sessionState.selectedStatus !=
                                      SessionStatus.all)
                              ? sessionState.selectedStatus!.color
                              : Colors.grey[600],
                          fontWeight:
                              (sessionState.selectedStatus != null &&
                                  sessionState.selectedStatus !=
                                      SessionStatus.all)
                              ? FontWeight.w600
                              : FontWeight.w500,
                        ),
                      ),
                    ),
                    Icon(
                      Icons.keyboard_arrow_down_rounded,
                      size: 18,
                      color:
                          (sessionState.selectedStatus != null &&
                              sessionState.selectedStatus != SessionStatus.all)
                          ? sessionState.selectedStatus!.color
                          : Colors.grey[400],
                    ),
                  ],
                ),
              ),
            ),
          ),

          const SizedBox(width: 8),

          // Clear Filter Button
          if (sessionState.selectedDate != null ||
              (sessionState.selectedStatus != null &&
                  sessionState.selectedStatus != SessionStatus.all))
            InkWell(
              onTap: () {
                ref.read(sessionProvider.notifier).clearAllFilters();
              },
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: Colors.red.withOpacity(0.05),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.red.withOpacity(0.2)),
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
}
