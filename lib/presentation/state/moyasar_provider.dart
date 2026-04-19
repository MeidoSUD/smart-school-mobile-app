import 'package:geniuses_school/core/utils/logger.dart';
import 'package:geniuses_school/data/models/payment_request.dart';
import 'package:geniuses_school/data/models/payment_response_models.dart';
import 'package:geniuses_school/data/repositories/moyasar_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum MoyasarStatus {
  initial,
  creatingPayment,
  paymentCreated,
  paymentProcessing,
  success,
  error,
}

class MoyasarState {
  final MoyasarStatus status;
  final String? paymentId;
  final String? redirectUrl;
  final String? errorMessage;
  final PaymentStatusResponse? paymentData;
  final List<SavedCard> savedCards;

  MoyasarState({
    this.status = MoyasarStatus.initial,
    this.paymentId,
    this.redirectUrl,
    this.errorMessage,
    this.paymentData,
    this.savedCards = const [],
  });

  MoyasarState copyWith({
    MoyasarStatus? status,
    String? paymentId,
    String? redirectUrl,
    String? errorMessage,
    PaymentStatusResponse? paymentData,
    List<SavedCard>? savedCards,
  }) {
    return MoyasarState(
      status: status ?? this.status,
      paymentId: paymentId ?? this.paymentId,
      redirectUrl: redirectUrl ?? this.redirectUrl,
      errorMessage: errorMessage ?? this.errorMessage,
      paymentData: paymentData ?? this.paymentData,
      savedCards: savedCards ?? this.savedCards,
    );
  }
}

class MoyasarNotifier extends StateNotifier<MoyasarState> {
  final MoyasarRepository _repository;

  MoyasarNotifier(this._repository) : super(MoyasarState());

  Future<void> initPayment(PaymentRequest request) async {
    state = state.copyWith(
      status: MoyasarStatus.creatingPayment,
      errorMessage: null,
    );
    try {
      final checkout = await _repository.createPayment(request);

      state = state.copyWith(
        status: MoyasarStatus.paymentCreated,
        paymentId: checkout.checkoutId,
        redirectUrl: checkout.redirectUrl,
      );
    } catch (e) {
      Logger.log("Moyasar initPayment failed: $e");
      state = state.copyWith(
        status: MoyasarStatus.error,
        errorMessage: e.toString(),
      );
    }
  }

  Future<void> checkStatus({
    required String paymentId,
    bool saveCard = false,
    String? cardBrand,
  }) async {
    state = state.copyWith(
      status: MoyasarStatus.paymentProcessing,
      errorMessage: null,
    );
    try {
      final result = await _repository.checkPaymentStatus(
        paymentId: paymentId,
        saveCard: saveCard,
        cardBrand: cardBrand,
      );

      if (result.isPaid) {
        state = state.copyWith(
          status: MoyasarStatus.success,
          paymentData: result,
        );
      } else {
        state = state.copyWith(
          status: MoyasarStatus.error,
          errorMessage: 'Payment failed with status: ${result.status}',
        );
      }
    } catch (e) {
      Logger.log("Moyasar checkStatus failed: $e");
      state = state.copyWith(
        status: MoyasarStatus.error,
        errorMessage: e.toString(),
      );
    }
  }

  Future<void> fetchSavedCards() async {
    try {
      final cards = await _repository.getSavedCards();
      state = state.copyWith(savedCards: cards);
    } catch (e) {
      Logger.log("Moyasar fetchSavedCards failed: $e");
    }
  }

  Future<void> deleteCard(int cardId) async {
    try {
      await _repository.deleteSavedCard(cardId);
      await fetchSavedCards();
    } catch (e) {
      Logger.log("Moyasar deleteCard failed: $e");
      state = state.copyWith(errorMessage: e.toString());
    }
  }

  Future<void> setDefaultCard(int cardId) async {
    try {
      await _repository.setDefaultCard(cardId);
      await fetchSavedCards();
    } catch (e) {
      Logger.log("Moyasar setDefaultCard failed: $e");
      state = state.copyWith(errorMessage: e.toString());
    }
  }

  void reset() {
    state = MoyasarState();
  }
}

final moyasarProvider = StateNotifierProvider<MoyasarNotifier, MoyasarState>((
  ref,
) {
  return MoyasarNotifier(MoyasarRepository());
});
