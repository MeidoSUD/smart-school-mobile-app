import 'package:geniuses_school/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../controllers/teacher_orders_provider.dart';
import '../teacher_all_orders_screen.dart';
import 'order_item_card.dart';
import 'order_shimmer_loading.dart';
import 'section_header.dart';

class OrdersSection extends ConsumerStatefulWidget {
  final GlobalKey? titleKey;

  const OrdersSection({super.key, this.titleKey});

  @override
  ConsumerState<OrdersSection> createState() => _OrdersSectionState();
}

class _OrdersSectionState extends ConsumerState<OrdersSection> {
  int? _applyingOrderId;

  Future<void> _handleApply(int orderId) async {
    setState(() {
      _applyingOrderId = orderId;
    });

    try {
      // Call the controller to handle the logic
      await ref.read(teacherOrdersProvider.notifier).applyForOrder(orderId);

      if (mounted) {
        final l10n = AppLocalizations.of(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(l10n?.orderAppliedSuccess ?? ''),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        final l10n = AppLocalizations.of(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("${l10n?.orderApplyFailed ?? ''}: $e"),
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

    final l10n = AppLocalizations.of(context);

    return state.orders.when(
      skipLoadingOnRefresh: false,
      data: (orders) {
        if (orders.isEmpty) {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: SectionHeader(
                  titleKey: widget.titleKey,
                  title: l10n?.newOrders ?? '',
                  icon: Icons.assignment_outlined,
                  actionText: l10n?.viewAll ?? '',
                  onRefresh: () =>
                      ref.read(teacherOrdersProvider.notifier).refresh(),
                  onAction: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const TeacherAllOrdersScreen(),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 8),
              Container(
                width: double.infinity,
                margin: const EdgeInsets.symmetric(horizontal: 12),
                padding: const EdgeInsets.symmetric(
                  vertical: 32,
                  horizontal: 16,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.04),
                      blurRadius: 16,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.grey[50],
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.assignment_outlined,
                        size: 32,
                        color: Colors.grey[400],
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      l10n?.noNewOrders ?? '',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[800],
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      l10n?.newOrdersWillAppearHere ?? '',
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: Colors.grey[500],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        }

        // Take first 5 orders
        final displayedOrders = orders.take(5).toList();

        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: SectionHeader(
                titleKey: widget.titleKey,
                title: l10n?.newOrders ?? '',
                icon: Icons.assignment_outlined,
                actionText: l10n?.viewAll ?? '',
                onRefresh: () =>
                    ref.read(teacherOrdersProvider.notifier).refresh(),
                onAction: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const TeacherAllOrdersScreen(),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 8),
            ...displayedOrders.map(
              (order) => OrderItemCard(
                order: order,
                isApplying: _applyingOrderId == order.id,
                onApply: () => _handleApply(order.id),
                onTap: () {
                  // Handle order tap
                },
              ),
            ),
            if (orders.length > 5)
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const TeacherAllOrdersScreen(),
                        ),
                      );
                    },
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      side: BorderSide(color: Theme.of(context).primaryColor),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      foregroundColor: Theme.of(context).primaryColor,
                    ),
                    child: Text(
                      l10n?.viewAllOrders ?? '',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
          ],
        );
      },
      loading: () => OrderShimmerLoading(),
      error: (err, stack) => Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                l10n?.errorLoadingOrders ?? '',
                style: TextStyle(color: Colors.red[700]),
              ),
              const SizedBox(height: 8),
              FilledButton.icon(
                onPressed: () =>
                    ref.read(teacherOrdersProvider.notifier).refresh(),
                icon: const Icon(Icons.refresh_rounded, size: 16),
                label: Text(l10n?.retry ?? ''),
                style: FilledButton.styleFrom(
                  backgroundColor: Theme.of(context).primaryColor,
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
    );
  }
}
