import 'package:geniuses_school/core/utils/logger.dart';
import 'package:geniuses_school/data/models/bank_model.dart';
import 'package:geniuses_school/data/models/payment_card_model.dart';
import 'package:geniuses_school/data/repositories/payments_cards_repository.dart';
import 'package:geniuses_school/presentation/state/auth_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final paymentCardRepositoryProvider = Provider(
  (ref) => PaymentsCardsRepository(),
);

class PaymentCardNotifier extends AsyncNotifier<List<PaymentCard>> {
  @override
  Future<List<PaymentCard>> build() async {
    Logger.log("Fetching payment cards...");
    final repo = ref.read(paymentCardRepositoryProvider);
    final user = ref.watch(authProvider).user;
    return await repo.getPaymentCards(roleId: user?.role_id);
  }

  // Add a new payment card
  Future<void> addPaymentCard(PaymentCard card) async {
    final repo = ref.read(paymentCardRepositoryProvider);
    final user = ref.read(authProvider).user;

    // Show loading state
    state = const AsyncLoading();

    try {
      // Call repository to add card
      final addedCard = await repo.addPaymentCard(card, roleId: user?.role_id);

      // Refresh the list to get updated data from server
      final updatedCards = await repo.getPaymentCards(roleId: user?.role_id);
      state = AsyncData(updatedCards);
    } catch (e, st) {
      // On error, restore previous state if available
      final previousCards = state.valueOrNull;
      if (previousCards != null) {
        state = AsyncData(previousCards);
      } else {
        state = AsyncError(e, st);
      }
      rethrow;
    }
  }

  // Update an existing payment card
  Future<void> updatePaymentCard(PaymentCard card) async {
    final repo = ref.read(paymentCardRepositoryProvider);
    final user = ref.read(authProvider).user;

    // Optimistic update - show changes immediately
    final currentCards = state.value ?? [];
    final updatedCards = currentCards
        .map((c) => c.id == card.id ? card : c)
        .toList();
    state = AsyncData(updatedCards);

    try {
      // Call repository to update card
      await repo.updateSinglePaymentCard(card, roleId: user?.role_id);

      // Optionally refresh from server to ensure consistency
      final refreshedCards = await repo.getPaymentCards(roleId: user?.role_id);
      state = AsyncData(refreshedCards);
    } catch (e) {
      // Rollback on error
      state = AsyncData(currentCards);
      rethrow;
    }
  }

  // Delete a payment card
  Future<void> deletePaymentCard(int cardId) async {
    final repo = ref.read(paymentCardRepositoryProvider);
    final user = ref.read(authProvider).user;

    // Optimistic update - remove immediately from UI
    final currentCards = state.value ?? [];
    final updatedCards = currentCards.where((c) => c.id != cardId).toList();
    state = AsyncData(updatedCards);

    try {
      // Call repository to delete card
      await repo.deletePaymentCard(cardId, roleId: user?.role_id);
    } catch (e) {
      // Rollback on error
      state = AsyncData(currentCards);
      rethrow;
    }
  }

  // Set a card as default
  Future<void> setDefaultCard(int cardId) async {
    final repo = ref.read(paymentCardRepositoryProvider);
    final user = ref.read(authProvider).user;

    // Optimistic update - set default immediately
    final currentCards = state.value ?? [];
    final updatedCards = currentCards.map((card) {
      return card.copyWith(isDefault: card.id == cardId);
    }).toList();
    state = AsyncData(updatedCards);

    try {
      // Call repository to set default
      await repo.setDefaultCard(cardId, roleId: user?.role_id);

      // Optionally refresh from server
      final refreshedCards = await repo.getPaymentCards(roleId: user?.role_id);
      state = AsyncData(refreshedCards);
    } catch (e) {
      // Rollback on error
      state = AsyncData(currentCards);
      rethrow;
    }
  }

  // Refresh the list
  Future<void> refresh() async {
    final repo = ref.read(paymentCardRepositoryProvider);
    state = const AsyncLoading();

    try {
      final cards = await repo.getPaymentCards();
      state = AsyncData(cards);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }
}

final paymentCardProvider =
    AsyncNotifierProvider<PaymentCardNotifier, List<PaymentCard>>(() {
      return PaymentCardNotifier();
    });

class BanksNotifier extends AsyncNotifier<List<BankModel>> {
  @override
  Future<List<BankModel>> build() async {
    final repo = ref.read(paymentCardRepositoryProvider);
    return await repo.getBanks();
  }
}

final banksProvider = AsyncNotifierProvider<BanksNotifier, List<BankModel>>(() {
  return BanksNotifier();
});
