import 'package:geniuses_school/core/utils/logger.dart';
import 'package:geniuses_school/data/models/payment_info_model.dart';
import 'package:geniuses_school/presentation/screens/payment/payment_3ds_webview_screen.dart';
import 'package:geniuses_school/presentation/state/payment_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../l10n/app_localizations.dart';

class CVVVerificationPopup extends ConsumerStatefulWidget {
  final String cardNumber;
  final int? bookingId;
  final String cvv;
  final String cardholderName;
  final String expiryMonth;
  final String expiryYear;
  final String paymentBrand;
  final Function(bool) onConfirm;
  final VoidCallback onCancel;
  final BuildContext rootContext;

  const CVVVerificationPopup({
    super.key,
    this.bookingId,
    required this.cardNumber,
    required this.cardholderName,
    required this.expiryYear,
    required this.expiryMonth,
    required this.onConfirm,
    required this.onCancel,
    required this.rootContext,
    required this.cvv,
    required this.paymentBrand,
  });

  @override
  ConsumerState<CVVVerificationPopup> createState() =>
      _CVVVerificationPopupState();
}

class _CVVVerificationPopupState extends ConsumerState<CVVVerificationPopup> {
  final cvvController = TextEditingController();
  bool isLoading = false;
  String? cvvError;
  bool _hasHandledSuccess = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkPaymentStatus();
    });
  }

  void _checkPaymentStatus() {
    final paymentState = ref.read(paymentProvider).value;
    if (paymentState != null &&
        (paymentState.status == PayStatus.sucess ||
            paymentState.status == PayStatus.requires3ds) &&
        !_hasHandledSuccess) {
      Logger.log("CVVPopup: Found existing success/3DS state in initState");
      _handlePaymentSuccess(paymentState);
    }
  }

  void _handlePaymentSuccess(PayState value) {
    if (_hasHandledSuccess) {
      Logger.log("CVVPopup: Success already handled, skipping");
      return;
    }

    if (!mounted) {
      Logger.log("CVVPopup: Widget not mounted, cannot handle success");
      return;
    }

    _hasHandledSuccess = true;
    Logger.log(
      "CVVPopup: Handling payment success - status: ${value.status}, message: ${value.message}",
    );
    Logger.log("CVVPopup: Payment data: ${value.paymentData}");

    setState(() {
      isLoading = false;
    });

    final paymentData = value.paymentData;
    final requires3ds = value.status == PayStatus.requires3ds;

    Logger.log(
      "CVVPopup: requires3ds check - status: ${value.status}, requires3ds: $requires3ds",
    );
    Logger.log("CVVPopup: paymentData is null: ${paymentData == null}");

    if (requires3ds && paymentData != null) {
      Logger.log("CVVPopup: Checking for redirect_url in paymentData");
      Logger.log("CVVPopup: paymentData keys: ${paymentData.keys}");
      final redirectUrl = paymentData['redirect_url'];
      Logger.log(
        "CVVPopup: redirectUrl is null: ${redirectUrl == null}, is Map: ${redirectUrl is Map}",
      );
      if (redirectUrl != null && redirectUrl is Map) {
        final url = redirectUrl['url'] as String?;
        final parameters = redirectUrl['parameters'] as List?;

        if (url != null && parameters != null) {
          Logger.log("CVVPopup: Opening 3DS WebView with URL: $url");
          Logger.log("CVVPopup: Parameters: $parameters");

          final paymentId = paymentData['payment_id'] as int?;
          final bookingId = paymentData['booking_id'] as int?;
          final transactionReference =
              paymentData['transaction_reference'] as String?;

          final paramsList = parameters
              .map((p) {
                if (p is Map) {
                  return {
                    'name': p['name']?.toString() ?? '',
                    'value': p['value']?.toString() ?? '',
                  };
                }
                return {'name': '', 'value': ''};
              })
              .toList()
              .cast<Map<String, String>>();

          SchedulerBinding.instance.addPostFrameCallback((_) {
            if (!mounted) {
              Logger.log("CVVPopup: Widget not mounted in postFrameCallback");
              return;
            }

            Future.delayed(const Duration(milliseconds: 300)).then((_) {
              if (!mounted) {
                Logger.log("CVVPopup: Widget not mounted after delay");
                return;
              }

              if (Navigator.of(context).canPop()) {
                Navigator.of(context).pop();
              }

              Future.delayed(const Duration(milliseconds: 200)).then((_) {
                if (!mounted) return;

                Navigator.of(widget.rootContext).push(
                  MaterialPageRoute(
                    builder: (context) => Payment3DSWebViewScreen(
                      url: url,
                      parameters: paramsList,
                      paymentId: paymentId,
                      bookingId: bookingId,
                      transactionReference: transactionReference,
                      onComplete: (success, message) {
                        Logger.log(
                          "CVVPopup: 3DS completed - success: $success, message: $message",
                        );
                        if (success) {
                          ScaffoldMessenger.of(widget.rootContext).showSnackBar(
                            SnackBar(
                              content: Text(
                                message ??
                                    AppLocalizations.of(
                                      context,
                                    )!.paymentSuccess,
                              ),
                              backgroundColor: Colors.green,
                              duration: const Duration(seconds: 3),
                            ),
                          );
                          widget.onConfirm(true);
                        } else {
                          ScaffoldMessenger.of(widget.rootContext).showSnackBar(
                            SnackBar(
                              content: Text(
                                message ??
                                    AppLocalizations.of(context)!.paymentFailed,
                              ),
                              backgroundColor: Colors.red,
                              duration: const Duration(seconds: 3),
                            ),
                          );
                        }
                      },
                    ),
                  ),
                );
              });
            });
          });
          return;
        }
      }
    }

    ScaffoldMessenger.of(widget.rootContext).showSnackBar(
      SnackBar(
        content: Text(
          AppLocalizations.of(context)!.paymentMessageSuccess(value.message),
        ),
        backgroundColor: Colors.green,
        duration: const Duration(seconds: 2),
      ),
    );

    SchedulerBinding.instance.addPostFrameCallback((_) {
      if (!mounted) {
        Logger.log("CVVPopup: Widget not mounted in postFrameCallback");
        return;
      }

      Future.delayed(const Duration(milliseconds: 500)).then((_) {
        if (!mounted) {
          Logger.log("CVVPopup: Widget not mounted after delay");
          return;
        }

        Logger.log("CVVPopup: Closing dialog");
        if (Navigator.of(context).canPop()) {
          Navigator.of(context).pop();
        }

        Future.delayed(const Duration(milliseconds: 300)).then((_) {
          Logger.log("CVVPopup: Calling onConfirm(true)");
          if (mounted) {
            widget.onConfirm(true);
          } else {
            Logger.log("CVVPopup: Widget not mounted, cannot call onConfirm");
          }
        });
      });
    });
  }

  @override
  void dispose() {
    cvvController.dispose();
    super.dispose();
  }

  void _handleConfirm() {
    Logger.log("CVVPopup: _handleConfirm called");
    Logger.log(
      "CVVPopup: CVV entered: ${cvvController.text.length} characters",
    );
    Logger.log("CVVPopup: Booking ID: ${widget.bookingId}");

    setState(() {
      cvvError = null;
    });

    if (cvvController.text.isEmpty) {
      setState(() {
        cvvError = AppLocalizations.of(context)!.cvvRequired;
      });
      return;
    }

    if (cvvController.text.length < 3) {
      setState(() {
        cvvError = AppLocalizations.of(context)!.cvvInvalidLength;
      });
      return;
    }

    if (widget.bookingId == null || widget.bookingId == 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(AppLocalizations.of(context)!.bookingIdRequired),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    setState(() {
      isLoading = true;
    });

    ref
        .read(paymentProvider.notifier)
        .makePayment(
          PaymentInfoModel(
            bookingId: widget.bookingId!,
            cardNumber: widget.cardNumber.replaceAll(' ', ''),
            cvv: cvvController.text,
            cardHolder: widget.cardholderName,
            expiryMonth: widget.expiryMonth,
            expiryYear: widget.expiryYear,
            paymentBrand: widget.paymentBrand,
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final paymentState = ref.watch(paymentProvider);

    if (paymentState.value != null &&
        (paymentState.value!.status == PayStatus.sucess ||
            paymentState.value!.status == PayStatus.requires3ds) &&
        !_hasHandledSuccess) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _handlePaymentSuccess(paymentState.value!);
      });
    }

    ref.listen<AsyncValue<PayState>>(paymentProvider, (previous, next) {
      final value = next.value;
      if (value == null) {
        Logger.log("CVVPopup: Payment state value is null in listener");
        return;
      }

      Logger.log(
        "CVVPopup: Payment state changed in listener - status: ${value.status}, message: ${value.message}",
      );
      Logger.log(
        "CVVPopup: Previous status: ${previous?.value?.status}, Next status: ${value.status}",
      );

      if (value.status == PayStatus.loading) {
        Logger.log("CVVPopup: Payment loading...");
        if (mounted) {
          setState(() {
            isLoading = true;
            _hasHandledSuccess = false;
          });
        }
      }

      if (value.status == PayStatus.error) {
        Logger.log("CVVPopup: Payment error - ${value.message}");
        if (mounted) {
          setState(() {
            isLoading = false;
          });
        }
        ScaffoldMessenger.of(widget.rootContext).showSnackBar(
          SnackBar(
            content: Text(
              AppLocalizations.of(context)!.paymentMessageFailed(value.message),
            ),
            backgroundColor: Colors.red,
          ),
        );
      }

      if (value.status == PayStatus.sucess ||
          value.status == PayStatus.requires3ds) {
        Logger.log("CVVPopup: Payment success/3DS detected in listener");
        _handlePaymentSuccess(value);
      }
    });
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Lock Icon
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: theme.primaryColor.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.lock_rounded,
                size: 32,
                color: theme.primaryColor,
              ),
            ),
            const SizedBox(height: 16),

            // Title
            Text(
              AppLocalizations.of(context)!.verifyCard,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1E293B),
              ),
            ),
            const SizedBox(height: 8),

            // Subtitle
            Text(
              AppLocalizations.of(context)!.enterCvvSecurely,
              style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),

            // Card Info Display
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey.shade50,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade200),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Card Number
                  Row(
                    children: [
                      Icon(
                        Icons.credit_card_rounded,
                        size: 20,
                        color: Colors.grey.shade600,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              AppLocalizations.of(context)!.cardNumber,
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey.shade600,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              widget.cardNumber,
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF1E293B),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),

                  // Cardholder Name
                  Row(
                    children: [
                      Icon(
                        Icons.person_rounded,
                        size: 20,
                        color: Colors.grey.shade600,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              AppLocalizations.of(context)!.cardHolderName,
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey.shade600,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              widget.cardholderName,
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF1E293B),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),

                  // Expiry Date
                  Row(
                    children: [
                      Icon(
                        Icons.calendar_today_rounded,
                        size: 20,
                        color: Colors.grey.shade600,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              AppLocalizations.of(context)!.expiryDate,
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey.shade600,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              "${widget.expiryMonth}/${widget.expiryYear}",
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF1E293B),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // CVV Input
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppLocalizations.of(context)!.cvv,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey.shade700,
                  ),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: cvvController,
                  enabled: !isLoading,
                  keyboardType: TextInputType.number,
                  maxLength: 3,
                  obscureText: true,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 3,
                  ),
                  decoration: InputDecoration(
                    hintText: '•••',
                    hintStyle: TextStyle(
                      color: Colors.grey.shade400,
                      fontSize: 24,
                    ),
                    counter: const SizedBox.shrink(),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.grey.shade300),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.grey.shade300),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(
                        color: Theme.of(context).primaryColor,
                        width: 2,
                      ),
                    ),
                    disabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.grey.shade200),
                    ),
                    filled: true,
                    fillColor: Colors.grey.shade50,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 14,
                    ),
                    errorText: cvvError, // Display error message
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Security Notice
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.green.shade50,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.green.shade200),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.verified_rounded,
                    size: 20,
                    color: Colors.green.shade700,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      AppLocalizations.of(context)!.transactionSecure,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.green.shade700,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Buttons
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: isLoading ? null : widget.onCancel,
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.grey.shade600,
                      side: BorderSide(color: Colors.grey.shade300),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      AppLocalizations.of(context)!.cancel,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: isLoading ? null : _handleConfirm,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).primaryColor,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      disabledBackgroundColor: Colors.grey.shade300,
                    ),
                    child: isLoading
                        ? SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                Colors.white.withOpacity(0.8),
                              ),
                            ),
                          )
                        : Text(
                            AppLocalizations.of(context)!.confirmPayment,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
