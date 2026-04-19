import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/models/teacher_order_model.dart';
import '../data/repositories/teacher_orders_repository.dart';

// 1. State class
class TeacherOrdersState {
  final AsyncValue<List<TeacherOrderModel>> orders;
  final DateTime? selectedDate;
  final String? selectedStatus;

  TeacherOrdersState({
    this.orders = const AsyncValue.loading(),
    this.selectedDate,
    this.selectedStatus,
  });

  TeacherOrdersState copyWith({
    AsyncValue<List<TeacherOrderModel>>? orders,
    DateTime? selectedDate,
    String? selectedStatus,
  }) {
    return TeacherOrdersState(
      orders: orders ?? this.orders,
      selectedDate: selectedDate ?? this.selectedDate,
      selectedStatus: selectedStatus ?? this.selectedStatus,
    );
  }

  List<TeacherOrderModel> get filteredOrders {
    final ordersList = orders.value;
    if (ordersList == null) return [];

    var filtered = ordersList;

    // Filter by Date
    if (selectedDate != null) {
      filtered = filtered.where((order) {
        return order.availableSlots.any((slot) {
          try {
            final slotDate = DateTime.parse(slot.date);
            return DateUtils.isSameDay(slotDate, selectedDate);
          } catch (e) {
            return false;
          }
        });
      }).toList();
    }

    // Filter by Status
    if (selectedStatus != null && selectedStatus != 'all') {
      filtered = filtered
          .where((order) => order.status == selectedStatus)
          .toList();
    }

    return filtered;
  }
}

// 2. Notifier
class TeacherOrdersController extends StateNotifier<TeacherOrdersState> {
  final TeacherOrdersRepository _repository;

  TeacherOrdersController(this._repository) : super(TeacherOrdersState()) {
    loadOrders();
  }

  Future<void> loadOrders() async {
    state = state.copyWith(orders: const AsyncValue.loading());
    try {
      final orders = await _repository.getOrders();
      state = state.copyWith(orders: AsyncValue.data(orders));
    } catch (e, st) {
      state = state.copyWith(orders: AsyncValue.error(e, st));
    }
  }

  void setDateFilter(DateTime date) {
    state = state.copyWith(selectedDate: date);
  }

  void setStatusFilter(String? status) {
    state = state.copyWith(selectedStatus: status);
  }

  void clearDateFilter() {
    state = state.copyWith(selectedDate: null);
  }

  // Clear all filters
  void clearAllFilters() {
    state = TeacherOrdersState(
      orders: state.orders,
      selectedDate: null,
      selectedStatus: null,
    );
  }

  Future<void> applyForOrder(int orderId, {String? message}) async {
    try {
      await _repository.applyForOrder(orderId, message: message);
      await loadOrders();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> refresh() async {
    return loadOrders();
  }
}

// 3. Provider
final teacherOrdersProvider =
    StateNotifierProvider<TeacherOrdersController, TeacherOrdersState>((ref) {
      final repo = ref.watch(teacherOrdersRepositoryProvider);
      return TeacherOrdersController(repo);
    });
