import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geniuses_school/data/models/notification_model.dart';
import 'package:geniuses_school/data/repositories/notification_repository.dart';

// Repository provider
final notificationRepositoryProvider = Provider<NotificationRepository>((ref) {
  return NotificationRepository();
});

// Notification state class
class NotificationState {
  final List<NotificationModel> notifications;
  final bool isLoading;
  final String? error;
  

  NotificationState({
    this.notifications = const [],
    this.isLoading = false,
    this.error,
  });

  NotificationState copyWith({
    List<NotificationModel>? notifications,
    bool? isLoading,
    String? error,
  }) {
    return NotificationState(
      notifications: notifications ?? this.notifications,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }

  // Get count of unread notifications
  int get unreadCount => notifications.where((n) => !n.isRead).length;

  // Get only unread notifications
  List<NotificationModel> get unreadNotifications =>
      notifications.where((n) => !n.isRead).toList();

  // Get only read notifications
  List<NotificationModel> get readNotifications =>
      notifications.where((n) => n.isRead).toList();
}

// Notification provider
class NotificationNotifier extends StateNotifier<NotificationState> {
  final NotificationRepository _repository;

  NotificationNotifier(this._repository) : super(NotificationState());

  // Fetch all notifications
  Future<void> fetchNotifications() async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final notifications = await _repository.getNotifications();
      state = state.copyWith(
        notifications: notifications,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }

  // Mark a single notification as read
  Future<void> markAsRead(int notificationId) async {
    
    try {
      // Call API to mark as read
      await _repository.setIsRead(notificationId);

      // Update local state
      final updatedNotifications = state.notifications.map((n) {
        if (n.id == notificationId) {
          return n.copyWith(isRead: true);
        }
        return n;
      }).toList();

      state = state.copyWith(notifications: updatedNotifications);
    } catch (e) {
      state = state.copyWith(error: e.toString());
      rethrow;
    }
  }

  // Mark all notifications as read
  Future<void> markAllAsRead() async {
    try {
      // Get all unread notification IDs
         await _repository.markAllAsRead();
      final updatedNotifications = state.notifications.map((n) {
        return n.copyWith(isRead: true);
      }).toList();

      state = state.copyWith(notifications: updatedNotifications);
    } catch (e) {
      state = state.copyWith(error: e.toString());
      rethrow;
    }
  }

  // Dismiss/Delete a notification
  Future<void> dismissNotification(int notificationId) async {
    try {
      // Remove from local state immediately for better UX
      final updatedNotifications = state.notifications
          .where((n) => n.id != notificationId)
          .toList();
      
      state = state.copyWith(notifications: updatedNotifications);

      // TODO: Call API to delete notification when endpoint is available
      await _repository.deleteNotification(notificationId);
    } catch (e) {
      state = state.copyWith(error: e.toString());
      rethrow;
    }
  }

  // Clear all notifications
  void clearAllNotifications() {
    state = state.copyWith(notifications: []);
  }

  // Refresh notifications (pull to refresh)
  Future<void> refreshNotifications() async {
    await fetchNotifications();
  }

  Future<void> addNotification(NotificationModel notification) async {
    final updatedNotifications = [notification, ...state.notifications];
    state = state.copyWith(notifications: updatedNotifications);
  }

  // Get notifications by type
  List<NotificationModel> getNotificationsByType(String type) {
    return state.notifications.where((n) => n.type == type).toList();
  }


}

// Provider instance
final notificationProvider =
    StateNotifierProvider<NotificationNotifier, NotificationState>((ref) {
  final repository = ref.watch(notificationRepositoryProvider);
  return NotificationNotifier(repository);
});

// Convenience providers for specific data
final unreadCountProvider = Provider<int>((ref) {
  final state = ref.watch(notificationProvider);
  return state.unreadCount;
});

final unreadNotificationsProvider = Provider<List<NotificationModel>>((ref) {
  final state = ref.watch(notificationProvider);
  return state.unreadNotifications;
});

final readNotificationsProvider = Provider<List<NotificationModel>>((ref) {
  final state = ref.watch(notificationProvider);
  return state.readNotifications;
});