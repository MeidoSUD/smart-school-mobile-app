import 'package:geniuses_school/presentation/widgets/teacher_orders/models/order_request_model.dart';
import 'package:flutter/material.dart';

import '../../../l10n/app_localizations.dart';

class TeacherOrderEmptyState extends StatelessWidget {
  final String searchQuery;
  final RequestStatus? selectedFilter;

  const TeacherOrderEmptyState({
    super.key,
    required this.searchQuery,
    required this.selectedFilter,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(32),
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              searchQuery.isNotEmpty ? Icons.search_off : Icons.inbox,
              size: 64,
              color: Colors.grey[400],
            ),
          ),
          const SizedBox(height: 16),
          Text(
            searchQuery.isNotEmpty
                ? AppLocalizations.of(context)!.noResults
                : AppLocalizations.of(context)!.noOrders,
            style: theme.textTheme.titleMedium?.copyWith(
              color: Colors.grey[600],
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            searchQuery.isNotEmpty
                ? AppLocalizations.of(context)!.tryDifferentSearch
                : selectedFilter != null
                ? AppLocalizations.of(context)!.noOrdersFilter
                : AppLocalizations.of(context)!.newOrdersDescription,
            style: TextStyle(color: Colors.grey[500], fontSize: 14),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
