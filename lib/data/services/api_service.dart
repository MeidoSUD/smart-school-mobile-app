import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../../core/utils/logger.dart';

class ApiService {
  final Dio _dio = Dio();

  ApiService() {
    _dio.interceptors.add(
      PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        compact: true,
        maxWidth: 90,
      ),
    );
  }

  Future<Response> post(String url, dynamic data, Options options) async {
    // Logger.log("--> POST Request to $url");
    try {
      final response = await _dio.post(url, data: data, options: options);
      return response;
    } on DioException catch (e) {
      Logger.log("DioException Status: ${e.response?.statusCode}");
      rethrow; // ✅ Rethrow the DioException, don't convert to string yet
    }
  }

  Future<Response> get(
    String url,
    Options options, {
    Map<String, dynamic>? queryParameters,
  }) async {
    // Logger.log("--> GET Request to $url");
    try {
      final response = await _dio.get(
        url,
        options: options,
        queryParameters: queryParameters,
      );
      return response;
    } on DioException {
      rethrow; // ✅ Rethrow the DioException
    }
  }

  Future<Response> put(String url, dynamic data, Options options) async {
    // Logger.log("--> PUT Request to $url");
    try {
      final response = await _dio.put(url, data: data, options: options);
      return response;
    } on DioException {
      rethrow; // ✅ Rethrow the DioException
    }
  }

  Future<Response> delete(String url, Options options) async {
    // Logger.log("--> DELETE Request to $url");
    try {
      final response = await _dio.delete(url, options: options);
      return response;
    } on DioException {
      rethrow; // ✅ Rethrow the DioException
    }
  }
}
