import 'dart:io';
import 'package:app_tracking_transparency/app_tracking_transparency.dart';
import 'package:flutter/foundation.dart';

class ATTService {
  /// Requests tracking authorization on iOS.
  /// 
  /// This should be called after the splash screen/onboarding but before
  /// initializing any tracking SDKs like AppsFlyer.
  static Future<void> requestTrackingAuthorization() async {
    if (!Platform.isIOS) {
      debugPrint("ATT: Not iOS, skipping tracking authorization.");
      return;
    }

    try {
      final status = await AppTrackingTransparency.trackingAuthorizationStatus;
      debugPrint("ATT: Current status: $status");

      if (status == TrackingStatus.notDetermined) {
        // Wait for the application to be active (recommended for iOS 15+)
        // This gives the system time to handle the transition from splash/onboarding
        await Future.delayed(const Duration(milliseconds: 500));
        
        final newStatus = await AppTrackingTransparency.requestTrackingAuthorization();
        debugPrint("ATT: New status: $newStatus");
      }
    } catch (e) {
      debugPrint("ATT: Error requesting tracking authorization: $e");
    }
  }

  /// Returns the current tracking authorization status.
  static Future<TrackingStatus> get status async {
    if (!Platform.isIOS) {
      return TrackingStatus.notSupported;
    }
    return await AppTrackingTransparency.trackingAuthorizationStatus;
  }
}
