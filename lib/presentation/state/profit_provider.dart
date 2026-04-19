import 'package:geniuses_school/data/models/wallet_model.dart';
import 'package:geniuses_school/data/repositories/profit_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProfitState {
  final AsyncValue<WalletModel> wallet;
  final AsyncValue<List<WithdrawalModel>> withdrawals;

  ProfitState({required this.wallet, required this.withdrawals});

  ProfitState copyWith({
    AsyncValue<WalletModel>? wallet,
    AsyncValue<List<WithdrawalModel>>? withdrawals,
  }) {
    return ProfitState(
      wallet: wallet ?? this.wallet,
      withdrawals: withdrawals ?? this.withdrawals,
    );
  }
}

class ProfitNotifier extends StateNotifier<ProfitState> {
  final ProfitRepository _repository;

  ProfitNotifier(this._repository)
    : super(
        ProfitState(
          wallet: const AsyncValue.loading(),
          withdrawals: const AsyncValue.loading(),
        ),
      ) {
    loadWallet();
  }

  Future<void> loadWallet() async {
    state = state.copyWith(wallet: const AsyncValue.loading());
    try {
      final wallet = await _repository.getWallet();
      state = state.copyWith(wallet: AsyncValue.data(wallet));
    } catch (error, stackTrace) {
      state = state.copyWith(wallet: AsyncValue.error(error, stackTrace));
    }
  }

  Future<void> loadWithdrawals({String? status}) async {
    state = state.copyWith(withdrawals: const AsyncValue.loading());
    try {
      final withdrawals = await _repository.getWithdrawals(status: status);
      state = state.copyWith(withdrawals: AsyncValue.data(withdrawals));
    } catch (error, stackTrace) {
      state = state.copyWith(withdrawals: AsyncValue.error(error, stackTrace));
    }
  }

  Future<void> requestWithdrawal(double amount, int paymentMethodId) async {
    try {
      await _repository.requestWithdrawal(amount, paymentMethodId);
      await loadWallet(); // Refresh balance and history
    } catch (error) {
      // You might want to handle this differently (e.g., a separate error state or rethrowing)
      rethrow;
    }
  }

  Future<void> cancelWithdrawal(int id) async {
    try {
      await _repository.cancelWithdrawal(id);
      await loadWallet();
    } catch (error) {
      rethrow;
    }
  }
}

final profitProvider = StateNotifierProvider<ProfitNotifier, ProfitState>((
  ref,
) {
  final repository = ProfitRepository();
  return ProfitNotifier(repository);
});
