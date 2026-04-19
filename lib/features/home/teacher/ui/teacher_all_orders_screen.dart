import 'package:geniuses_school/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../controllers/teacher_orders_provider.dart';
import 'widgets/order_filter_header.dart';
import 'widgets/order_item_card.dart';
import 'widgets/order_shimmer_loading.dart';

class TeacherAllOrdersScreen extends ConsumerStatefulWidget {
  const TeacherAllOrdersScreen({super.key});

  @override
  ConsumerState<TeacherAllOrdersScreen> createState() =>
      _TeacherAllOrdersScreenState();
}

class _TeacherAllOrdersScreenState
    extends ConsumerState<TeacherAllOrdersScreen> {
  int? _applyingOrderId;

  Future<void> _handleApply(int orderId) async {
    setState(() {
      _applyingOrderId = orderId;
    });

    try {
      await ref
          .read(teacherOrdersProvider.notifier)
          .applyForOrder(orderId);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(AppLocalizations.of(context)!.orderAppliedSuccess),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              "${AppLocalizations.of(context)!.orderApplyFailed}: $e",
            ),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _applyingOrderId = null;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(teacherOrdersProvider);
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: Colors.grey[50], // Light background
      body: RefreshIndicator(
        onRefresh: () async {
          return ref.read(teacherOrdersProvider.notifier).refresh();
        },
        child: CustomScrollView(
          slivers: [
            // Stylish Sliver App Bar
            SliverAppBar(
              floating: false,
              pinned: true,
              snap: false,
              elevation: 0,
              backgroundColor: theme.primaryColor,
              title: Text(
                AppLocalizations.of(context)!.allOrders,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16, // Slightly smaller font
                  color: Colors.white,
                ),
              ),
              centerTitle: true,
              flexibleSpace: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      theme.primaryColor,
                      theme.primaryColor.withValues(alpha: 0.8),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
              ),
            ),
            const SliverToBoxAdapter(child: OrderFilterHeader()),

            // Content
            state.orders.when(
              skipLoadingOnRefresh: false,
              data: (_) {
                final orders = state.filteredOrders;
                if (orders.isEmpty) {
                  return SliverFillRemaining(
                    child: Center(
                      child: Text(AppLocalizations.of(context)!.noOrders),
                    ),
                  );
                }

                return SliverPadding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate((context, index) {
                      final order = orders[index];
                      return OrderItemCard(
                        order: order,
                        isApplying: _applyingOrderId == order.id,
                        onApply: () => _handleApply(order.id),
                        onTap: () {},
                      );
                    }, childCount: orders.length),
                  ),
                );
              },
              loading: () => SliverToBoxAdapter(
                child: const OrderShimmerLoading(
                  showHeader: false,
                  itemCount: 10,
                ),
              ),
              error: (err, stack) => SliverFillRemaining(
                hasScrollBody: false,
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        AppLocalizations.of(context)!.errorLoadingOrders,
                        style: TextStyle(color: Colors.red[700]),
                      ),
                      const SizedBox(height: 8),
                      FilledButton.icon(
                        onPressed: () =>
                            ref.read(teacherOrdersProvider.notifier).refresh(),
                        icon: const Icon(Icons.refresh_rounded, size: 16),
                        label: Text(AppLocalizations.of(context)!.retry),
                        style: FilledButton.styleFrom(
                          backgroundColor: theme.primaryColor,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // Bottom padding
            const SliverPadding(padding: EdgeInsets.only(bottom: 20)),
          ],
        ),
      ),
    );
  }
}
