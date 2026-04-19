import 'dart:math';

import 'package:geniuses_school/data/models/payment_card_model.dart';
import 'package:geniuses_school/presentation/state/auth_provider.dart';
import 'package:geniuses_school/presentation/state/payments_cards_provider.dart';
import 'package:geniuses_school/presentation/widgets/common/ballsWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:geniuses_school/data/models/payment_request.dart';
import 'package:geniuses_school/presentation/state/moyasar_provider.dart';
import 'package:geniuses_school/presentation/screens/payment/payment_webview_screen.dart';
import '../../../l10n/app_localizations.dart';
import '../../widgets/payment_method/payment_card_view.dart';
import '../../widgets/payment_method/teacher_add_bank_account_sheet.dart';

class PaymentMethodManageScreen extends ConsumerStatefulWidget {
  const PaymentMethodManageScreen({super.key});

  @override
  ConsumerState<PaymentMethodManageScreen> createState() =>
      _PaymentMethodManageScreenState();
}

class _PaymentMethodManageScreenState
    extends ConsumerState<PaymentMethodManageScreen> {
  // Map card type to colors
  List<Color> _getColorsForCardType(String cardType) {
    switch (cardType.toLowerCase()) {
      case 'visa':
        return [const Color(0xFF2E7DFA), const Color(0xFF1E3A8A)];
      case 'mastercard':
        return [const Color(0xFFFB923C), const Color(0xFFDC2626)];
      case 'amex':
        return [const Color(0xFF6EE7B7), const Color(0xFF047857)];
      default:
        return [
          Color((Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0),
          Color((Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0),
        ];
    }
  }

  // Remove method
  Future<void> _removeMethod(int cardId) async {
    try {
      await ref.read(paymentCardProvider.notifier).deletePaymentCard(cardId);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(AppLocalizations.of(context)!.cardDeletedSuccess),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              AppLocalizations.of(context)!.cardAddError(e.toString()),
            ),
          ),
        );
      }
    }
  }

  // Set card as default
  Future<void> _setDefaultCard(int cardId) async {
    try {
      await ref.read(paymentCardProvider.notifier).setDefaultCard(cardId);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(AppLocalizations.of(context)!.cardDefaultSet)),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              AppLocalizations.of(context)!.cardAddError(e.toString()),
            ),
          ),
        );
      }
    }
  }

  // Show add/edit bottom sheet
  void _openAddCardFlow() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        String selectedBrand = 'VISA'; // Default
        return StatefulBuilder(
          builder: (context, setState) {
            return Container(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppLocalizations.of(context)!.addNewCard,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 24),
                  RadioListTile<String>(
                    title: Text(
                      AppLocalizations.of(context)!.creditCardVisaMaster,
                    ),
                    value: 'VISA',
                    groupValue: selectedBrand,
                    onChanged: (val) {
                      if (val != null) setState(() => selectedBrand = val);
                    },
                    contentPadding: EdgeInsets.zero,
                  ),
                  RadioListTile<String>(
                    title: Text(AppLocalizations.of(context)!.mada),
                    value: 'MADA',
                    groupValue: selectedBrand,
                    onChanged: (val) {
                      if (val != null) setState(() => selectedBrand = val);
                    },
                    contentPadding: EdgeInsets.zero,
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context); // Close bottom sheet
                        _initiateAddCardCheckout(selectedBrand);
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        backgroundColor: Theme.of(context).primaryColor,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(AppLocalizations.of(context)!.confirm),
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            );
          },
        );
      },
    );
  }

  void _initiateAddCardCheckout(String brand) {
    ref
        .read(moyasarProvider.notifier)
        .initPayment(
          PaymentRequest(amount: 1.0, currency: 'SAR', paymentBrand: brand),
        );
  }

  void _confirmDelete(PaymentCard card) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(AppLocalizations.of(context)!.deleteCardConfirmTitle),
        content: Text(AppLocalizations.of(context)!.deleteCardConfirmMessage),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(AppLocalizations.of(context)!.cancel),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _removeMethod(card.id!);
            },
            child: Text(
              AppLocalizations.of(context)!.delete,
              style: const TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cardsAsync = ref.watch(paymentCardProvider);
    final authState = ref.watch(authProvider);

    final loc = AppLocalizations.of(context)!;

    ref.listen<MoyasarState>(moyasarProvider, (previous, next) {
      if (next.status == MoyasarStatus.paymentCreated && mounted) {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => PaymentWebViewScreen(
              amount: 1.0,
              currency: loc.currency,
              checkoutId: next.paymentId!,
              redirectUrl: next.redirectUrl!,
              onPaymentComplete: (status) {
                ref.read(moyasarProvider.notifier).reset();
                ref.invalidate(paymentCardProvider);
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text(loc.cardAddedSuccess)));
              },
              onPaymentFailed: (error) {
                ref.read(moyasarProvider.notifier).reset();
                if (error == 'user_cancelled') {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('⚠️ ${loc.paymentCancelled}'),
                      backgroundColor: Colors.orange,
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(error), backgroundColor: Colors.red),
                  );
                }
              },
            ),
          ),
        );
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: authState.user!.role_id == 3
            ? Text(AppLocalizations.of(context)!.manageBankAccount)
            : Text(AppLocalizations.of(context)!.managePaymentMethods),
        backgroundColor: theme.primaryColor,
        foregroundColor: Colors.white,
        elevation: 1,
      ),
      body: Column(
        children: [
          if (authState.user!.role_id == 3)
            Container(
              width: double.infinity,
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.blue[50],
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.blue[200]!),
              ),
              child: Row(
                children: [
                  Icon(Icons.info_outline, color: Colors.blue[700], size: 22),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      loc.bankAccountMemo,
                      style: TextStyle(
                        color: Colors.blue[800],
                        fontSize: 13,
                        height: 1.4,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          Expanded(
            child: Stack(
              children: [
                BallsWidget(
                  size: 40,
                  color: const Color(0xFF5170ff),
                  alignment: const Alignment(1.1, -0.8),
                  opacity: 0.9,
                ),
                BallsWidget(
                  size: 100,
                  color: theme.primaryColorLight,
                  alignment: const Alignment(-1.4, -0.8),
                  opacity: 0.9,
                ),
                BallsWidget(
                  size: 100,
                  color: const Color(0xFF5170ff),
                  alignment: const Alignment(-1.3, 1),
                  opacity: 0.9,
                ),
                cardsAsync.when(
                  data: (cards) {
                    if (cards.isEmpty) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.credit_card_off,
                              size: 80,
                              color: Colors.grey[400],
                            ),
                            const SizedBox(height: 16),
                            Text(
                              AppLocalizations.of(context)!.noCards,
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.grey[600],
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              AppLocalizations.of(context)!.noCardsDescription,
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[500],
                              ),
                            ),
                          ],
                        ),
                      );
                    }

                    return ListView.builder(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      itemCount: cards.length,
                      itemBuilder: (context, index) {
                        final card = cards[index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 8,
                          ),
                          child: PaymentCardView(
                            card: card,
                            colors: _getColorsForCardType(card.cardType),
                            onEdit:
                                () {}, // Edit disabled for PCI compliance (students)
                            onDelete: () => _confirmDelete(card),
                            onSetDefault: () => _setDefaultCard(card.id!),
                            enabledActions: true,
                          ),
                        );
                      },
                    );
                  },
                  loading: () =>
                      const Center(child: CircularProgressIndicator()),
                  error: (error, stack) => SingleChildScrollView(
                    padding: const EdgeInsets.all(20),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.error_outline,
                            size: 60,
                            color: Colors.red[300],
                          ),
                          const SizedBox(height: 16),
                          Text(
                            AppLocalizations.of(
                              context,
                            )!.cardsLoadError(error.toString()),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey[700],
                            ),
                          ),
                          const SizedBox(height: 8),
                          TextButton(
                            onPressed: () {
                              ref.invalidate(paymentCardProvider);
                              ref.invalidate(
                                banksProvider,
                              ); // Also refresh banks
                            },
                            child: Text(AppLocalizations.of(context)!.retry),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: theme.primaryColor,
        foregroundColor: Colors.white,
        onPressed: () {
          if (authState.user!.role_id == 3) {
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              ),
              builder: (context) => const TeacherAddBankAccountSheet(),
            );
          } else {
            _openAddCardFlow();
          }
        },
        icon: const Icon(Icons.add),
        label: authState.user!.role_id == 3
            ? Text(AppLocalizations.of(context)!.addNewBankAccount)
            : Text(AppLocalizations.of(context)!.addNewCard),
      ),
    );
  }
}
