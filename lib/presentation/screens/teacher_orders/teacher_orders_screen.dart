import 'package:geniuses_school/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../widgets/teacher_orders/models/dummy_orders.dart';
import '../../widgets/teacher_orders/models/order_request_model.dart';
import '../../widgets/teacher_orders/teach_request_card.dart';
import '../../widgets/teacher_orders/teacher_order_details_sheet.dart';
import '../../widgets/teacher_orders/teacher_order_empty_state.dart';
import '../../widgets/teacher_orders/teacher_order_filters.dart';
import '../../widgets/teacher_orders/teacher_order_search.dart';

class TeacherOrdersScreen extends ConsumerStatefulWidget {
  const TeacherOrdersScreen({super.key});

  @override
  ConsumerState<TeacherOrdersScreen> createState() =>
      _TeacherOrdersScreenState();
}

class _TeacherOrdersScreenState extends ConsumerState<TeacherOrdersScreen> {
  RequestStatus? selectedFilter;
  String searchQuery = '';

  // Initialize with dummy data
  List<OrderRequest> allOrders = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    allOrders = List.from(getDummyOrders(context));
  }

  List<OrderRequest> get filteredOrders {
    List<OrderRequest> filtered = allOrders;

    // Filter by status
    if (selectedFilter != null) {
      filtered = filtered
          .where((order) => order.status == selectedFilter)
          .toList();
    }

    // Filter by search query
    if (searchQuery.isNotEmpty) {
      filtered = filtered.where((order) {
        return order.subject.toLowerCase().contains(
              searchQuery.toLowerCase(),
            ) ||
            order.studentName.toLowerCase().contains(
              searchQuery.toLowerCase(),
            ) ||
            order.description.toLowerCase().contains(searchQuery.toLowerCase());
      }).toList();
    }

    return filtered;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: _buildAppBar(theme),
      body: Column(
        children: [
          TeacherOrderSearch(
            searchQuery: searchQuery,
            onSearchChanged: (value) {
              setState(() {
                searchQuery = value;
              });
            },
          ),
          TeacherOrderFilters(
            allOrders: allOrders,
            selectedFilter: selectedFilter,
            onFilterSelected: (filter) {
              setState(() {
                selectedFilter = filter;
              });
            },
          ),
          _buildOrdersList(theme),
        ],
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(ThemeData theme) {
    final l10n = AppLocalizations.of(context)!;
    return AppBar(
      title: Text(
        l10n.teacherOrdersTitle,
        style: const TextStyle(
          fontWeight: FontWeight.w700,
          color: Colors.white,
        ),
      ),
      backgroundColor: theme.primaryColor,
      foregroundColor: Colors.white,
      elevation: 0,
      actions: [
        IconButton(
          icon: const Icon(Icons.filter_list_off),
          onPressed: () {
            setState(() {
              selectedFilter = null;
              searchQuery = '';
            });
          },
          tooltip: l10n.removeFilters,
        ),
      ],
    );
  }

  Widget _buildOrdersList(ThemeData theme) {
    final orders = filteredOrders;
    final l10n = AppLocalizations.of(context)!;

    return Expanded(
      child: orders.isEmpty
          ? TeacherOrderEmptyState(
              searchQuery: searchQuery,
              selectedFilter: selectedFilter,
            )
          : Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        l10n.requestCount(orders.length),
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                      ),
                      if (selectedFilter != null || searchQuery.isNotEmpty)
                        TextButton.icon(
                          onPressed: () {
                            setState(() {
                              selectedFilter = null;
                              searchQuery = '';
                            });
                          },
                          icon: const Icon(Icons.clear_all, size: 16),
                          label: Text(l10n.removeFilters),
                        ),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.only(bottom: 16),
                    itemCount: orders.length,
                    itemBuilder: (context, index) {
                      final order = orders[index];
                      return TeachRequestCard(
                        subject: order.subject,
                        studentName: order.studentName,
                        date: order.date,
                        description: order.description,
                        price: order.price,
                        status: order.status,
                        onTap: () => _showOrderDetails(context, order),
                        onAccept: order.status == RequestStatus.pending
                            ? () => _handleAccept(order)
                            : null,
                        onDecline: order.status == RequestStatus.pending
                            ? () => _handleDecline(order)
                            : null,
                      );
                    },
                  ),
                ),
              ],
            ),
    );
  }

  void _showOrderDetails(BuildContext context, OrderRequest order) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => TeacherOrderDetailsSheet(
        order: order,
        onAccept: () {
          _handleAccept(order);
        },
        onDecline: () {
          _handleDecline(order);
        },
      ),
    );
  }

  void _handleAccept(OrderRequest order) {
    final l10n = AppLocalizations.of(context)!;
    setState(() {
      final index = allOrders.indexWhere((o) => o.id == order.id);
      if (index != -1) {
        allOrders[index] = order.copyWith(status: RequestStatus.accepted);
      }
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(l10n.requestAccepted(order.studentName)),
        backgroundColor: Colors.green,
        action: SnackBarAction(
          label: l10n.undo,
          textColor: Colors.white,
          onPressed: () {
            setState(() {
              final index = allOrders.indexWhere((o) => o.id == order.id);
              if (index != -1) {
                allOrders[index] = order.copyWith(
                  status: RequestStatus.pending,
                );
              }
            });
          },
        ),
      ),
    );
  }

  void _handleDecline(OrderRequest order) {
    final l10n = AppLocalizations.of(context)!;
    showDialog(
      context: context,
      builder: (context) => Directionality(
        textDirection: TextDirection.rtl,
        child: AlertDialog(
          title: Text(l10n.rejectRequestTitle),
          content: Text(l10n.rejectRequestMessage(order.studentName)),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(l10n.cancel),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                setState(() {
                  allOrders.removeWhere((o) => o.id == order.id);
                });
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(l10n.requestRejected),
                    backgroundColor: Colors.orange,
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
              ),
              child: Text(l10n.reject),
            ),
          ],
        ),
      ),
    );
  }
}
