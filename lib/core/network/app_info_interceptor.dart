import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../constants/header_keys.dart';
import '../constants/storage_keys.dart';
import '../storage/storage_service.dart';

@lazySingleton
class AppInfoInterceptor extends Interceptor {
  final StorageService _storageService;

  PackageInfo? _packageInfo;
  String? _deviceModel;
  String? _osVersion;
  Future<void>? _initFuture;

  AppInfoInterceptor(this._storageService);

  Future<void> _loadInfo() async {
    try {
      _packageInfo = await PackageInfo.fromPlatform();

      final deviceInfo = DeviceInfoPlugin();
      if (Platform.isAndroid) {
        final androidInfo = await deviceInfo.androidInfo;
        _deviceModel = '${androidInfo.manufacturer} ${androidInfo.model}';
        _osVersion = 'Android ${androidInfo.version.release}';
      } else if (Platform.isIOS) {
        final iosInfo = await deviceInfo.iosInfo;
        _deviceModel = iosInfo.utsname.machine;
        _osVersion = 'iOS ${iosInfo.systemVersion}';
      }
    } catch (_) {
      // Fail silently: headers will simply be missing.
    }
  }

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    // Platform & Language
    options.headers[HeaderKeys.platform] = Platform.operatingSystem;
    final lang = _storageService.getString(StorageKeys.locale) ?? 'en';
    options.headers[HeaderKeys.language] = lang;

    // Load Info
    if (_packageInfo == null) {
      _initFuture ??= _loadInfo();
      await _initFuture;
    }

    // App Info
    if (_packageInfo != null) {
      options.headers[HeaderKeys.appVersion] = _packageInfo!.version;
      options.headers[HeaderKeys.buildNumber] = _packageInfo!.buildNumber;
    }

    // Device Info
    if (_deviceModel != null) {
      options.headers[HeaderKeys.deviceModel] = _deviceModel;
    }
    if (_osVersion != null) options.headers[HeaderKeys.osVersion] = _osVersion;

    handler.next(options);
  }
}
