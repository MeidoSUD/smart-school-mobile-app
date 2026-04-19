import 'dart:io';

import 'package:dio/dio.dart';
import 'package:geniuses_school/data/models/notification_model.dart';
import 'package:geniuses_school/presentation/state/notification_provider.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app_keys.dart';
import 'core/constants/api_endpoints.dart';

class NotificationService {
  static final _messaging = FirebaseMessaging.instance;
  static final _local = FlutterLocalNotificationsPlugin();

  static const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'high_importance_channel',
    'High Importance Notifications',
    description: 'Used for important notifications.',
    importance: Importance.high,
    playSound: true,
  );

  static Future<void> initialize({
    required WidgetRef ref,
    required int userId,
    String? userToken,
  }) async {
    await _messaging.requestPermission(alert: true, badge: true, sound: true);

    const androidInit = AndroidInitializationSettings('@mipmap/ic_launcher');
    const iosInit = DarwinInitializationSettings();
    const initSettings = InitializationSettings(
      android: androidInit,
      iOS: iosInit,
    );
    await _local.initialize(initSettings);

    if (Platform.isAndroid) {
      await _local
          .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin
          >()
          ?.createNotificationChannel(channel);
    }

    FirebaseMessaging.onMessage.listen(
      (message) => _showLocalNotification(message, ref),
    );

    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      debugPrint("🚀 Opened notification: ${message.notification?.title}");
      debugPrint("📊 Notification Data: ${message.data}");
    });

    final token = await _messaging.getToken();
    debugPrint("🔥 FCM TOKEN: $token");

    if (token != null) {
      try {
        await Dio().post(
          ApiEndpoints.saveFCMToken,
          data: {'token': token},
          options: Options(headers: {'Authorization': 'Bearer $userToken'}),
        );
        debugPrint("✅ Token sent to Laravel");
      } catch (e) {
        debugPrint("❌ Failed to send token: $e");
      }
    }

    FirebaseMessaging.instance.onTokenRefresh.listen((newToken) async {
      debugPrint("♻️ FCM token refreshed: $newToken");
      try {
        await Dio().post(
          ApiEndpoints.saveFCMToken,
          data: {'user_id': userId, 'token': newToken},
          options: Options(headers: {'Authorization': 'Bearer $userToken'}),
        );
      } catch (_) {}
    });
  }

  static Future<void> _showLocalNotification(
    RemoteMessage message,
    WidgetRef ref,
  ) async {
    debugPrint("📥 Received message: ${message.notification?.title}");
    debugPrint("📦 Message Data: ${message.data}");

    final notification = message.notification;
    final data = message.data;

    // Logic for specific notification types as requested
    final type = data['type'];
    if (type == 'payment_success') {
      _showToast("Payment confirmed! Redirecting to booking...");
    } else if (type == 'booking_received') {
      _showToast("You have a new student!");
    }

    // Add notification to state management
    await ref
        .read(notificationProvider.notifier)
        .addNotification(
          NotificationModel(
            id: message.messageId.hashCode,
            title: notification?.title ?? 'Notification',
            message: notification?.body ?? '',
            time: DateTime.now(),
            type: type ?? 'reminder',
            isRead: false,
            data: data,
          ),
        );

    if (notification == null) return;

    await _local.show(
      notification.hashCode,
      notification.title,
      notification.body,
      NotificationDetails(
        android: AndroidNotificationDetails(
          channel.id,
          channel.name,
          channelDescription: channel.description,
          importance: Importance.high,
          priority: Priority.high,
          playSound: true,
          // Use @mipmap/ic_launcher as a more reliable fallback icon
          icon:
              message.notification?.android?.smallIcon ?? '@mipmap/ic_launcher',
        ),
        iOS: const DarwinNotificationDetails(
          presentAlert: true,
          presentBadge: true,
          presentSound: true,
        ),
      ),
    );
  }

  static void _showToast(String message) {
    scaffoldMessengerKey.currentState?.clearSnackBars();
    scaffoldMessengerKey.currentState?.showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color(
          0xFF2E3192,
        ), // Use app primary color if possible
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        duration: const Duration(seconds: 4),
      ),
    );
  }
}

@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  debugPrint("📩 Background message: ${message.messageId}");

  if (message.notification == null && message.data.isNotEmpty) {
    final local = FlutterLocalNotificationsPlugin();
    const androidInit = AndroidInitializationSettings('@mipmap/ic_launcher');
    const iosInit = DarwinInitializationSettings();
    const initSettings = InitializationSettings(
      android: androidInit,
      iOS: iosInit,
    );
    await local.initialize(initSettings);

    await local.show(
      message.messageId.hashCode,
      message.data['title'] ??
          'New Notification', // Fallback to displaying a message from data
      message.data['body'] ?? 'You have a new message from the app',
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'high_importance_channel',
          'High Importance Notifications',
          importance: Importance.high,
          priority: Priority.high,
          icon: '@mipmap/ic_launcher',
        ),
        iOS: DarwinNotificationDetails(),
      ),
    );
  }
}
