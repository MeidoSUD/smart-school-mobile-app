import 'package:geniuses_school/presentation/widgets/teacher_orders/models/order_request_model.dart';
import 'package:flutter/material.dart';

import '../../../l10n/app_localizations.dart';

class TeacherOrderFilters extends StatelessWidget {
  final List<OrderRequest> allOrders;
  final RequestStatus? selectedFilter;
  final ValueChanged<RequestStatus?> onFilterSelected;

  const TeacherOrderFilters({
    super.key,
    required this.allOrders,
    required this.selectedFilter,
    required this.onFilterSelected,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      height: 70,
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        children: [
          _buildFilterChip(
            label: AppLocalizations.of(context)!.all,
            count: allOrders.length,
            isSelected: selectedFilter == null,
            onTap: () => onFilterSelected(null),
            color: theme.primaryColor,
          ),
          const SizedBox(width: 8),
          _buildFilterChip(
            label: AppLocalizations.of(context)!.statusPending,
            count: allOrders
                .where((o) => o.status == RequestStatus.pending)
                .length,
            isSelected: selectedFilter == RequestStatus.pending,
            onTap: () => onFilterSelected(RequestStatus.pending),
            color: Colors.amber.shade700,
          ),
          const SizedBox(width: 8),
          _buildFilterChip(
            label: AppLocalizations.of(context)!.statusUrgent,
            count: allOrders
                .where((o) => o.status == RequestStatus.urgent)
                .length,
            isSelected: selectedFilter == RequestStatus.urgent,
            onTap: () => onFilterSelected(RequestStatus.urgent),
            color: Colors.red.shade700,
          ),
          const SizedBox(width: 8),
          _buildFilterChip(
            label: AppLocalizations.of(context)!.statusAccepted,
            count: allOrders
                .where((o) => o.status == RequestStatus.accepted)
                .length,
            isSelected: selectedFilter == RequestStatus.accepted,
            onTap: () => onFilterSelected(RequestStatus.accepted),
            color: Colors.green.shade700,
          ),
          const SizedBox(width: 8),
          _buildFilterChip(
            label: AppLocalizations.of(context)!.statusCompleted,
            count: allOrders
                .where((o) => o.status == RequestStatus.completed)
                .length,
            isSelected: selectedFilter == RequestStatus.completed,
            onTap: () => onFilterSelected(RequestStatus.completed),
            color: Colors.blue.shade700,
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip({
    required String label,
    required int count,
    required bool isSelected,
    required VoidCallback onTap,
    required Color color,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? color : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? color : Colors.grey.shade300,
            width: isSelected ? 2 : 1,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: color.withOpacity(0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ]
              : [],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              label,
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.grey[700],
                fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                fontSize: 14,
              ),
            ),
            const SizedBox(width: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: isSelected
                    ? Colors.white.withOpacity(0.3)
                    : color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                count.toString(),
                style: TextStyle(
                  color: isSelected ? Colors.white : color,
                  fontWeight: FontWeight.w700,
                  fontSize: 12,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
