import 'package:geniuses_school/core/utils/logger.dart';
import 'package:geniuses_school/data/models/payment_info_model.dart';
import 'package:geniuses_school/data/repositories/payment_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum PayStatus { init, loading, error, sucess, requires3ds }

class PayState {
  final PaymentInfoModel? paymentInfoModel;
  final PayStatus status;
  final String message;
  final Map<String, dynamic>? paymentData;

  PayState({
    this.paymentInfoModel,
    required this.status,
    required this.message,
    this.paymentData,
  });

  PayState copyWith({
    PaymentInfoModel? paymentInfoModel,
    PayStatus? status,
    String? message,
    Map<String, dynamic>? paymentData,
  }) {
    return PayState(
      paymentInfoModel: paymentInfoModel ?? this.paymentInfoModel,
      status: status ?? this.status,
      message: message ?? this.message,
      paymentData: paymentData ?? this.paymentData,
    );
  }
}

class PaymentNotifier extends StateNotifier<AsyncValue<PayState>> {
  final PaymentRepository _repository;
  PaymentNotifier(this._repository) : super(AsyncValue.loading());

  Future<void> makePayment(PaymentInfoModel paymentInfo) async {
    try {
      Logger.log(
        "PaymentNotifier: Starting payment for booking ${paymentInfo.bookingId}",
      );
      state = AsyncValue.data(
        PayState(status: PayStatus.loading, message: "loading"),
      );

      final result = await _repository.pay(paymentInfo);

      Logger.log(
        "PaymentNotifier: Payment result - success: ${result['success']}, message: ${result['message']}",
      );
      Logger.log(
        "PaymentNotifier: Payment data type: ${result['data'].runtimeType}",
      );

      final paymentData = result['data'] is Map
          ? Map<String, dynamic>.from(result['data'])
          : null;
      Logger.log("PaymentNotifier: Extracted paymentData: $paymentData");

      final requires3ds = result['requires_3ds'] == true;
      Logger.log("PaymentNotifier: requires_3ds: $requires3ds");
      Logger.log("PaymentNotifier: Full result keys: ${result.keys}");
      Logger.log("PaymentNotifier: requires_3ds value: ${result['requires_3ds']}");

      PayStatus status;
      if (!result['success']) {
        status = PayStatus.error;
      } else if (requires3ds) {
        status = PayStatus.requires3ds;
      } else {
        status = PayStatus.sucess;
      }

      state = AsyncValue.data(
        PayState(
          paymentInfoModel: null,
          status: status,
          message: result['message'],
          paymentData: paymentData,
        ),
      );

      Logger.log(
        "PaymentNotifier: State updated - status: ${result['success'] ? PayStatus.sucess : PayStatus.error}",
      );
    } catch (e, st) {
      Logger.log("PaymentNotifier: Error occurred - $e");
      Logger.log("PaymentNotifier: Stack trace: $st");
      state = AsyncValue.data(
        PayState(status: PayStatus.error, message: e.toString()),
      );
    }
  }
}

final paymentProvider =
    StateNotifierProvider<PaymentNotifier, AsyncValue<PayState>>((ref) {
      final repository = PaymentRepository();
      return PaymentNotifier(repository);
    });
