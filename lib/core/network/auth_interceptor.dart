import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';
import '../constants/header_keys.dart';
import '../constants/storage_keys.dart';

@lazySingleton
class AuthInterceptor extends Interceptor {
  final FlutterSecureStorage _secureStorage;
  
  AuthInterceptor(this._secureStorage);

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    final token = await _secureStorage.read(key: StorageKeys.token);
    if (token != null && token.isNotEmpty) {
      options.headers[HeaderKeys.authorization] = 'Bearer $token';
    }
    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (err.response?.statusCode == 401) {
      // Handle token refresh or logout
    }
    handler.next(err);
  }
}
