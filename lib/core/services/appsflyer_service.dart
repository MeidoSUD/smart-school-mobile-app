import 'package:appsflyer_sdk/appsflyer_sdk.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppsflyerService {
  static final AppsflyerService _instance = AppsflyerService._internal();

  factory AppsflyerService() {
    return _instance;
  }

  AppsflyerService._internal();

  late AppsflyerSdk _appsflyerSdk;

  Future<void> init() async {
    final devKey = dotenv.env['APPSFLYER_DEV_KEY'] ?? '';
    final appId = dotenv.env['APPSFLYER_APP_ID'] ?? '';

    if (devKey.isEmpty) {
      debugPrint('AppsFlyer Dev Key is missing in .env');
      return;
    }

    final AppsFlyerOptions options = AppsFlyerOptions(
      afDevKey: devKey,
      appId: appId,
      showDebug: kDebugMode,
      timeToWaitForATTUserAuthorization: 10, // for iOS 14.5
      disableAdvertisingIdentifier: false, // Ensure IDFA collection is enabled
    );

    _appsflyerSdk = AppsflyerSdk(options);

    try {
      await _appsflyerSdk.initSdk(
        registerConversionDataCallback: true,
        registerOnAppOpenAttributionCallback: true,
        registerOnDeepLinkingCallback: true,
      );
      
      _appsflyerSdk.onAppOpenAttribution((res) {
        debugPrint("onAppOpenAttribution res: $res");
      });

      _appsflyerSdk.onInstallConversionData((res) {
        debugPrint("onInstallConversionData res: $res");
      });

      _appsflyerSdk.onDeepLinking((DeepLinkResult dp) {
        switch (dp.status) {
          case Status.FOUND:
            debugPrint(dp.deepLink?.toString());
            break;
          case Status.NOT_FOUND:
            debugPrint("deep link not found");
            break;
          case Status.ERROR:
            debugPrint("deep link error: ${dp.error}");
            break;
          case Status.PARSE_ERROR:
            debugPrint("deep link status parsing error");
            break;
        }
      });
      
      debugPrint("AppsFlyer initialized successfully");
    } catch (e) {
      debugPrint("AppsFlyer initialization error: $e");
    }
  }

  void logEvent(String eventName, Map<String, dynamic> eventValues) {
    try {
      _appsflyerSdk.logEvent(eventName, eventValues);
      debugPrint("AppsFlyer logEvent success: $eventName");
    } catch (e) {
      debugPrint("AppsFlyer logEvent error: $e");
    }
  }
}
