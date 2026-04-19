import 'package:geniuses_school/core/utils/logger.dart';
import 'package:geniuses_school/data/models/payment_response_models.dart';
import 'package:geniuses_school/data/repositories/moyasar_repository.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:geniuses_school/l10n/app_localizations.dart';
import 'dart:developer' as developer;

class PaymentWebViewScreen extends StatefulWidget {
  final double amount;
  final String currency;
  final String checkoutId;
  final String redirectUrl;
  final Function(PaymentStatusResponse) onPaymentComplete;
  final Function(String) onPaymentFailed;

  const PaymentWebViewScreen({
    super.key,
    required this.amount,
    required this.currency,
    required this.checkoutId,
    required this.redirectUrl,
    required this.onPaymentComplete,
    required this.onPaymentFailed,
  });

  @override
  State<PaymentWebViewScreen> createState() => _PaymentWebViewScreenState();
}

class _PaymentWebViewScreenState extends State<PaymentWebViewScreen> {
  late final WebViewController _controller;
  bool _isLoading = true;
  String? _errorMessage;
  final MoyasarRepository _repository = MoyasarRepository();

  @override
  void initState() {
    super.initState();

    developer.log('🔵 Opening Moyasar Widget');
    developer.log('📍 URL: ${widget.redirectUrl}');
    developer.log('🆔 Payment ID: ${widget.checkoutId}');
    Logger.log('🔵 Opening Moyasar Widget');
    Logger.log('📍 URL: ${widget.redirectUrl}');
    Logger.log('🆔 Payment ID: ${widget.checkoutId}');

    _initializeWebView();
  }

  void _initializeWebView() {
    try {
      _controller = WebViewController()
        ..setJavaScriptMode(JavaScriptMode.unrestricted)
        ..setNavigationDelegate(
          NavigationDelegate(
            onPageStarted: (String url) {
              developer.log('▶️  Page loading: $url');
              Logger.log('▶️  Page loading: $url');

              setState(() {
                _isLoading = true;
                _errorMessage = null;
              });

              if (url.contains('status=paid') ||
                  url.contains('status=authorized') ||
                  url.contains('payments/callback')) {
                developer.log('✅ Payment completion detected from URL: $url');
                Logger.log('✅ Payment completion detected');
                _handlePaymentCompletion();
              }

              if (url.contains('status=failed')) {
                developer.log('❌ Payment failed detected: $url');
                Logger.log('❌ Payment failed detected');
                widget.onPaymentFailed('payment_failed');
                if (mounted) Navigator.pop(context);
              }
            },
            onPageFinished: (String url) {
              developer.log('✔️  Page loaded: $url');
              Logger.log('✔️  Page loaded: $url');
              setState(() => _isLoading = false);
            },
            onWebResourceError: (WebResourceError error) {
              developer.log(
                '⚠️  WebView Error: ${error.description}',
                error: error,
              );
              Logger.log('⚠️  WebView Error: ${error.description}');
              // DO NOTHING - Never show error screen for web view errors
            },
            onNavigationRequest: (NavigationRequest request) {
              developer.log('🔗 Navigating to: ${request.url}');
              Logger.log('🔗 Navigating to: ${request.url}');

              if (request.url.startsWith('com.geniuses_school.payments') ||
                  request.url.startsWith('com.ewangeniuses.ewanapp.payments')) {
                developer.log('⚡️ Deep link intercepted: ${request.url}');
                Logger.log('⚡️ Deep link intercepted: ${request.url}');

                _handlePaymentCompletion();

                return NavigationDecision.prevent;
              }

              return NavigationDecision.navigate;
            },
          ),
        );

      _controller.loadRequest(Uri.parse(widget.redirectUrl));
    } catch (e) {
      developer.log('❌ WebView initialization error: $e');
      Logger.log('❌ WebView initialization error: $e');
      setState(() {
        _errorMessage = 'Failed to initialize payment widget: $e';
        _isLoading = false;
      });
    }
  }

  Future<void> _handlePaymentCompletion() async {
    setState(() => _isLoading = true);
    try {
      final result = await _repository.checkPaymentStatus(
        paymentId: widget.checkoutId,
        saveCard: true,
      );

      if (result.isPaid) {
        developer.log('✅ Payment confirmed as paid');
        Logger.log('✅ Payment confirmed as paid');
        widget.onPaymentComplete(result);
        if (mounted) Navigator.pop(context);
      } else {
        developer.log('❌ Payment status: ${result.status}');
        Logger.log('❌ Payment status: ${result.status}');
        widget.onPaymentFailed('Payment status: ${result.status}');
        if (mounted) Navigator.pop(context);
      }
    } catch (e) {
      developer.log('❌ Error checking payment status: $e');
      Logger.log('❌ Error checking payment status: $e');
      widget.onPaymentFailed(e.toString());
      if (mounted) Navigator.pop(context);
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  void _handlePaymentCanceled() {
    developer.log('🟡 Payment canceled by user');
    Logger.log('🟡 Payment canceled by user');

    // Notify listeners via callback
    widget.onPaymentFailed('user_cancelled');

    // Close the screen safely
    if (mounted) {
      Navigator.pop(context, {
        'status': 'canceled',
        'message': 'Payment was not completed',
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(loc.confirmPayment),
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: _handlePaymentCanceled,
        ),
      ),
      body: WillPopScope(
        onWillPop: () async {
          _handlePaymentCanceled();
          return true;
        },
        child: Stack(
          children: [
            if (_errorMessage != null)
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.error_outline,
                        size: 64,
                        color: Colors.red,
                      ),
                      const SizedBox(height: 24),
                      const Text(
                        'خطأ في بوابة الدفع',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        _errorMessage!,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(height: 24),
                      Text(
                        'Checkout ID: ${widget.checkoutId}',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 12,
                          fontFamily: 'monospace',
                        ),
                      ),
                      const SizedBox(height: 24),
                      ElevatedButton(
                        onPressed: () {
                          _handlePaymentCanceled();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 32,
                            vertical: 12,
                          ),
                        ),
                        child: const Text('إغلاق'),
                      ),
                    ],
                  ),
                ),
              )
            else if (_isLoading)
              const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(),
                    SizedBox(height: 16),
                    Text('جاري تحميل بوابة الدفع...'),
                  ],
                ),
              )
            else
              WebViewWidget(controller: _controller),
          ],
        ),
      ),
    );
  }
}
