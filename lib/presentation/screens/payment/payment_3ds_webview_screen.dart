import 'dart:convert';

import 'package:geniuses_school/core/utils/logger.dart';
import 'package:geniuses_school/data/repositories/payment_repository.dart';
import 'package:geniuses_school/l10n/app_localizations.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Payment3DSWebViewScreen extends StatefulWidget {
  final String url;
  final List<Map<String, String>> parameters;
  final int? paymentId;
  final int? bookingId;
  final String? transactionReference;
  final Function(bool success, String? message)? onComplete;

  const Payment3DSWebViewScreen({
    super.key,
    required this.url,
    required this.parameters,
    this.paymentId,
    this.bookingId,
    this.transactionReference,
    this.onComplete,
  });

  @override
  State<Payment3DSWebViewScreen> createState() =>
      _Payment3DSWebViewScreenState();
}

class _Payment3DSWebViewScreenState extends State<Payment3DSWebViewScreen> {
  late final WebViewController _controller;
  bool _isLoading = true;
  bool _hasCompleted = false;
  final PaymentRepository _paymentRepository = PaymentRepository();

  @override
  void initState() {
    super.initState();
    _initializeWebView();
  }

  void _initializeWebView() {
    final fullUrl = _build3DSUrl(widget.url, widget.parameters);
    Logger.log("Payment3DSWebView: Loading URL: $fullUrl");

    _controller = WebViewController();

    if (!kIsWeb) {
      _controller.setJavaScriptMode(JavaScriptMode.unrestricted);
    }

    _controller.setNavigationDelegate(
      NavigationDelegate(
        onPageStarted: (String url) {
          Logger.log("Payment3DSWebView: Page started loading: $url");
          setState(() {
            _isLoading = true;
          });
        },
        onPageFinished: (String url) async {
          Logger.log("Payment3DSWebView: Page finished loading: $url");

          if (url.contains('/api/payments/result') ||
              url.contains('/payment/result')) {
            Logger.log(
              "Payment3DSWebView: Payment result URL detected, checking for JSON content",
            );

            try {
              if (!kIsWeb) {
                final pageContent = await _controller.runJavaScriptReturningResult(
                  'document.body ? document.body.innerText : document.documentElement.innerText',
                );
                Logger.log("Payment3DSWebView: Page content: $pageContent");

                String contentStr = pageContent.toString();
                if (contentStr.startsWith('"') && contentStr.endsWith('"')) {
                  contentStr = contentStr.substring(1, contentStr.length - 1);
                }
                contentStr = contentStr
                    .replaceAll('\\"', '"')
                    .replaceAll('\\n', '\n')
                    .replaceAll('\\r', '');

                if (contentStr.contains('"success"') &&
                    (contentStr.contains('"payment_id"') ||
                        contentStr.contains('"message"'))) {
                  Logger.log(
                    "Payment3DSWebView: JSON response detected in page content",
                  );

                  try {
                    final jsonData =
                        jsonDecode(contentStr) as Map<String, dynamic>;
                    Logger.log(
                      "Payment3DSWebView: Parsed JSON from page: $jsonData",
                    );

                    if (jsonData.containsKey('success') &&
                        (jsonData.containsKey('payment_id') ||
                            jsonData.containsKey('message'))) {
                      Logger.log(
                        "Payment3DSWebView: Valid payment result JSON detected, handling directly",
                      );
                      await _handleJsonResponse(jsonData);
                      return;
                    }
                  } catch (e) {
                    Logger.log(
                      "Payment3DSWebView: Failed to parse JSON from page: $e, content: $contentStr",
                    );
                  }
                }
              }
            } catch (e) {
              Logger.log("Payment3DSWebView: Error reading page content: $e");
            }
          }

          setState(() {
            _isLoading = false;
          });
        },
        onNavigationRequest: (NavigationRequest request) {
          Logger.log("Payment3DSWebView: Navigation request: ${request.url}");

          if (_isCallbackUrl(request.url)) {
            Logger.log(
              "Payment3DSWebView: Callback URL detected: ${request.url}",
            );
            _handleCallback(request.url);
            return NavigationDecision.prevent;
          }

          return NavigationDecision.navigate;
        },
      ),
    );

    _controller.loadRequest(Uri.parse(fullUrl));
  }

  String _build3DSUrl(String baseUrl, List<Map<String, String>> parameters) {
    final uri = Uri.parse(baseUrl);
    final queryParams = <String, String>{};

    for (var param in parameters) {
      final name = param['name'];
      final value = param['value'];
      if (name != null && value != null) {
        queryParams[name] = value;
      }
    }

    final finalUri = uri.replace(queryParameters: queryParams);
    return finalUri.toString();
  }

  bool _isCallbackUrl(String url) {
    final callbackPatterns = [
      '/api/payment/callback',
      '/api/payment/result',
      'payment/callback',
      'payment/result',
    ];

    return callbackPatterns.any((pattern) => url.contains(pattern));
  }

  Future<void> _handleCallback(String callbackUrl) async {
    if (_hasCompleted) {
      Logger.log("Payment3DSWebView: Already handled callback, ignoring");
      return;
    }

    _hasCompleted = true;
    Logger.log("Payment3DSWebView: Handling callback URL: $callbackUrl");

    setState(() {
      _isLoading = true;
    });

    try {
      final uri = Uri.parse(callbackUrl);
      final resourcePath = uri.queryParameters['resourcePath'];
      final idFromCallback = uri.queryParameters['id'];

      final idToUse = widget.transactionReference ?? idFromCallback;

      Logger.log("Payment3DSWebView: Extracted resourcePath: $resourcePath");
      Logger.log(
        "Payment3DSWebView: Extracted id from callback: $idFromCallback",
      );
      Logger.log(
        "Payment3DSWebView: transactionReference: ${widget.transactionReference}",
      );
      Logger.log("Payment3DSWebView: Using id: $idToUse");

      if (resourcePath == null) {
        Logger.log("Payment3DSWebView: No resourcePath found in callback URL");
        if (mounted) {
          final errorMessage = AppLocalizations.of(context)!.paymentNotFound;
          widget.onComplete?.call(false, errorMessage);
          _showErrorDialog(context, errorMessage, 'missing_parameters', null);
        }
        return;
      }

      final result = await _paymentRepository.checkPaymentResult(
        resourcePath: resourcePath,
        id: idToUse,
      );

      if (mounted) {
        final success = result['success'] == true;
        final message = result['message'] as String?;
        final paymentId = result['payment_id'];
        final bookingId = result['booking_id'];
        final status = result['status'] as String?;
        final errorType = result['error_type'] as String?;
        final errorCode = result['error_code'] as String?;

        Logger.log(
          "Payment3DSWebView: Payment result - success: $success, message: $message, payment_id: $paymentId, booking_id: $bookingId, status: $status, error_type: $errorType, error_code: $errorCode",
        );

        if (success) {
          Logger.log("Payment3DSWebView: Payment successful");

          String successMessage =
              message ?? AppLocalizations.of(context)!.paymentSuccessTitle;
          if (bookingId != null) {
            successMessage =
                '$successMessage\n${AppLocalizations.of(context)!.bookingId}: $bookingId';
          }

          widget.onComplete?.call(true, successMessage);

          _showSuccessDialog(context, successMessage, paymentId, bookingId);
        } else {
          Logger.log(
            "Payment3DSWebView: Payment failed - error_type: $errorType",
          );

          String errorMessage =
              message ?? AppLocalizations.of(context)!.paymentFailedTitle;

          if (errorType == 'payment_not_found') {
            errorMessage = AppLocalizations.of(context)!.paymentNotFound;
          } else if (errorType == 'invalid_response_format') {
            errorMessage = AppLocalizations.of(context)!.serverError;
          } else if (errorType == 'unknown_error') {
            errorMessage = AppLocalizations.of(context)!.unknownError;
          } else if (errorCode != null) {
            errorMessage =
                '$errorMessage\n${AppLocalizations.of(context)!.errorCode}: $errorCode';
          }

          widget.onComplete?.call(false, errorMessage);
          _showErrorDialog(context, errorMessage, errorType, errorCode);
        }
      }
    } catch (e) {
      Logger.log("Payment3DSWebView: Error checking payment result: $e");
      if (mounted) {
        String errorMessage = AppLocalizations.of(context)!.unknownError;

        if (e.toString().contains('SocketException') ||
            e.toString().contains('TimeoutException')) {
          errorMessage = AppLocalizations.of(context)!.networkError;
        } else if (e.toString().contains('FormatException')) {
          errorMessage = AppLocalizations.of(context)!.formatError;
        }

        widget.onComplete?.call(false, errorMessage);
        _showErrorDialog(context, errorMessage, 'network_error', null);
      }
    }
  }

  Future<void> _handleJsonResponse(Map<String, dynamic> jsonData) async {
    if (_hasCompleted) {
      Logger.log("Payment3DSWebView: Already handled JSON response, ignoring");
      return;
    }

    _hasCompleted = true;
    Logger.log("Payment3DSWebView: Handling JSON response directly");

    if (!mounted) return;

    setState(() {
      _isLoading = true;
    });

    final success = jsonData['success'] == true;
    final message = jsonData['message'] as String?;
    final paymentId = jsonData['payment_id'];
    final bookingId = jsonData['booking_id'];
    final status = jsonData['status'] as String?;
    final errorType = jsonData['error_type'] as String?;
    final errorCode = jsonData['error_code'] as String?;

    Logger.log(
      "Payment3DSWebView: JSON response - success: $success, message: $message, payment_id: $paymentId, booking_id: $bookingId, status: $status, error_type: $errorType, error_code: $errorCode",
    );

    if (success) {
      Logger.log("Payment3DSWebView: Payment successful from JSON");

      String successMessage =
          message ?? AppLocalizations.of(context)!.paymentSuccessMessage;
      if (bookingId != null) {
        successMessage =
            '$successMessage\n${AppLocalizations.of(context)!.bookingId}: $bookingId';
      }

      widget.onComplete?.call(true, successMessage);

      _showSuccessDialog(context, successMessage, paymentId, bookingId);
    } else {
      Logger.log(
        "Payment3DSWebView: Payment failed from JSON - error_type: $errorType",
      );

      String errorMessage =
          message ?? AppLocalizations.of(context)!.paymentFailedTitle;

      if (errorType == 'payment_not_found') {
        errorMessage = AppLocalizations.of(context)!.paymentNotFound;
      } else if (errorType == 'invalid_response_format') {
        errorMessage = AppLocalizations.of(context)!.serverError;
      } else if (errorType == 'unknown_error') {
        errorMessage = AppLocalizations.of(context)!.unknownError;
      } else if (errorCode != null) {
        errorMessage =
            '$errorMessage\n${AppLocalizations.of(context)!.errorCode}: $errorCode';
      }

      widget.onComplete?.call(false, errorMessage);
      _showErrorDialog(context, errorMessage, errorType, errorCode);
    }
  }

  void _showSuccessDialog(
    BuildContext context,
    String message,
    dynamic paymentId,
    dynamic bookingId,
  ) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            Icon(Icons.check_circle, color: Colors.green, size: 28),
            SizedBox(width: 8),
            Text(AppLocalizations.of(context)!.paymentSuccessTitle),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(message),
            if (paymentId != null) ...[
              const SizedBox(height: 8),
              Text('${AppLocalizations.of(context)!.paymentId}: $paymentId'),
            ],
            if (bookingId != null) ...[
              const SizedBox(height: 4),
              Text('${AppLocalizations.of(context)!.bookingId}: $bookingId'),
            ],
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.of(context).pop(true);
            },
            child: Text(AppLocalizations.of(context)!.ok),
          ),
        ],
      ),
    );
  }

  void _showErrorDialog(
    BuildContext context,
    String message,
    String? errorType,
    String? errorCode,
  ) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            Icon(Icons.error, color: Colors.red, size: 28),
            SizedBox(width: 8),
            Text(AppLocalizations.of(context)!.paymentFailedTitle),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(message),
            if (errorCode != null && errorType != 'payment_not_found') ...[
              const SizedBox(height: 8),
              Text(
                '${AppLocalizations.of(context)!.errorCode}: $errorCode',
                style: const TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ],
            if (errorType == 'payment_not_found') ...[
              const SizedBox(height: 8),
              Text(
                AppLocalizations.of(context)!.contactSupport,
                style: const TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ],
            if (errorType == 'missing_parameters') ...[
              const SizedBox(height: 8),
              Text(
                AppLocalizations.of(context)!.contactSupport,
                style: const TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ],
            if (errorType == 'network_error') ...[
              const SizedBox(height: 8),
              Text(
                AppLocalizations.of(context)!.checkConnectivity,
                style: const TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ],
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.of(context).pop(false);
            },
            child: Text(AppLocalizations.of(context)!.ok),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.paymentVerification),
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () {
            if (!_hasCompleted) {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text(AppLocalizations.of(context)!.cancelOperation),
                  content: Text(
                    AppLocalizations.of(context)!.cancelOperationMessage,
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: Text(AppLocalizations.of(context)!.no),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        Navigator.of(context).pop(false);
                        widget.onComplete?.call(
                          false,
                          AppLocalizations.of(context)!.statusCancelled,
                        );
                      },
                      child: Text(AppLocalizations.of(context)!.yes),
                    ),
                  ],
                ),
              );
            } else {
              Navigator.of(context).pop();
            }
          },
        ),
      ),
      body: Stack(
        children: [
          WebViewWidget(controller: _controller),
          if (_isLoading)
            Container(
              color: Colors.white,
              child: const Center(child: CircularProgressIndicator()),
            ),
        ],
      ),
    );
  }
}
