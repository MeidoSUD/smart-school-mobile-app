import 'package:geniuses_school/app_keys.dart';
import 'package:geniuses_school/core/utils/logger.dart';
import 'package:geniuses_school/data/models/payment_card_model.dart';
import 'package:geniuses_school/presentation/state/auth_provider.dart';
import 'package:geniuses_school/presentation/state/payments_cards_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/routes/app_routes.dart';
import '../../../l10n/app_localizations.dart';

class PaymentCardsSheet extends ConsumerStatefulWidget {
  final Function(PaymentCard) onCardSelected;
  final int bookingPrice;

  const PaymentCardsSheet({
    super.key,
    required this.onCardSelected,
    required this.bookingPrice,
  });

  @override
  ConsumerState<PaymentCardsSheet> createState() => _PaymentCardsSheetState();
}

class _PaymentCardsSheetState extends ConsumerState<PaymentCardsSheet> {
  // Sample saved cards
  PaymentCard? selectedCard;

  bool showAddNewCard = false;
  bool isDef = false;
  @override
  Widget build(BuildContext context) {
    final cardsAsyncValue = ref.watch(paymentCardProvider);

    return cardsAsyncValue.when(
      data: (cards) {
        if (selectedCard == null && cards.isNotEmpty) {
          selectedCard = cards.firstWhere(
            (card) => card.isDefault,
            orElse: () => cards.first,
          );
        }

        return _buildUI(context);
      },
      loading: () =>
          const Center(child: CircularProgressIndicator(color: Colors.white)),
      error: (e, s) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          scaffoldMessengerKey.currentState?.showSnackBar(
            SnackBar(
              content: Text(
                '${AppLocalizations.of(context)!.errorPrefix}${e.toString()}',
              ),
              backgroundColor: Colors.red,
              duration: const Duration(seconds: 3),
            ),
          );
          Navigator.pop(context);
        });
        return const SizedBox.shrink();
      },
    );
  }

  Widget _buildUI(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.75,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        children: [
          // Handle
          Container(
            height: 4,
            width: 40,
            margin: const EdgeInsets.symmetric(vertical: 12),
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(2),
            ),
          ),

          // Header
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: Row(
              children: [
                Icon(
                  Icons.credit_card_rounded,
                  size: 28,
                  color: Theme.of(context).primaryColor,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppLocalizations.of(context)!.selectPaymentMethod,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1E293B),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        AppLocalizations.of(
                          context,
                        )!.amountDue(widget.bookingPrice),
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          const Divider(height: 1),

          // Content
          Expanded(
            child: showAddNewCard
                ? _buildAddNewCardForm()
                : _buildSavedCardsList(),
          ),

          // Footer with action buttons
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            child: Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Theme.of(context).primaryColor,
                      side: BorderSide(color: Theme.of(context).primaryColor),
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
                  flex: 2,
                  child: ElevatedButton(
                    onPressed: selectedCard != null || showAddNewCard
                        ? () {
                            Logger.log(
                              "Selected card to pay: ${selectedCard!.cardNumber}",
                            );
                            widget.onCardSelected(selectedCard!);
                            // Navigator.pop(context);
                          }
                        : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).primaryColor,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      disabledBackgroundColor: Colors.grey.shade300,
                    ),
                    child: Text(
                      AppLocalizations.of(context)!.continuePayment,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSavedCardsList() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Consumer(
            builder: (context, ref, _) {
              final cardsAsyncValue = ref.watch(paymentCardProvider);

              return cardsAsyncValue.when(
                data: (cards) {
                  return Column(
                    children: [
                      Text(
                        AppLocalizations.of(context)!.savedCards,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey.shade700,
                        ),
                      ),
                      const SizedBox(height: 16),
                      ...cards.map(
                        (card) => Padding(
                          padding: const EdgeInsets.only(bottom: 16),
                          child: _buildPaymentCardWidget(card),
                        ),
                      ),
                    ],
                  );
                },
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (error, stack) => Center(
                  child: Text(
                    AppLocalizations.of(
                      context,
                    )!.cardsLoadError(error.toString()),
                    style: const TextStyle(color: Colors.red),
                  ),
                ),
              );
            },
          ),
          // Saved cards

          // Add new card button
          InkWell(
            onTap: () {
              Navigator.pop(context); // Close the bottom sheet
              Navigator.pushNamed(
                context,
                AppRoutes.paymentManage,
              ); // Open manage screen
            },
            borderRadius: BorderRadius.circular(16),
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey.shade300,
                  width: 2,
                  strokeAlign: BorderSide.strokeAlignCenter,
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.add_rounded,
                    size: 24,
                    color: Theme.of(context).primaryColor,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    AppLocalizations.of(context)!.addNewCard,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentCardWidget(PaymentCard card) {
    final isSelected = selectedCard?.id == card.id;

    return InkWell(
      onTap: () {
        setState(() {
          selectedCard = card;
        });
      },
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          gradient: isSelected
              ? LinearGradient(
                  colors: [
                    Theme.of(context).primaryColor.withOpacity(0.8),
                    Theme.of(context).primaryColor,
                  ],
                )
              : LinearGradient(
                  colors: [Colors.grey.shade100, Colors.grey.shade50],
                ),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected
                ? Theme.of(context).primaryColor
                : Colors.grey.shade200,
            width: 2,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: Theme.of(context).primaryColor.withOpacity(0.3),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ]
              : null,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top row with logo and selection
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                card.type == CardType.bankAccount
                    ? Text(
                        card.bankName!.name,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: isSelected
                              ? Colors.white
                              : Colors.grey.shade600,
                        ),
                      )
                    : _buildCardTypeLogo(card.cardType, isSelected),
                if (isSelected)
                  Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: isSelected ? Colors.white : Colors.transparent,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.check_circle_rounded,
                      color: isSelected
                          ? Theme.of(context).primaryColor
                          : Colors.transparent,
                      size: 24,
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 24),

            // Card number
            Text(
              card.type == CardType.bankAccount
                  ? card.iban!
                  : card.maskedCardNumber,
              style: TextStyle(
                fontSize: 16,
                letterSpacing: 2,
                fontWeight: FontWeight.w600,
                color: isSelected ? Colors.white : Colors.grey.shade700,
              ),
            ),
            const SizedBox(height: 16),

            // Cardholder and expiry
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppLocalizations.of(context)!.accountHolderName,
                        style: TextStyle(
                          fontSize: 11,
                          color: isSelected
                              ? Colors.white70
                              : Colors.grey.shade600,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        card.type == CardType.bankAccount
                            ? card.accountHolderName!
                            : card.cardholderName!,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: isSelected
                              ? Colors.white
                              : Colors.grey.shade700,
                        ),
                      ),
                    ],
                  ),
                ),

                card.type == CardType.bankAccount
                    ? SizedBox.shrink()
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            AppLocalizations.of(context)!.expiryDate,
                            style: TextStyle(
                              fontSize: 11,
                              color: isSelected
                                  ? Colors.white70
                                  : Colors.grey.shade600,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '${card.expiryMonth}/${card.expiryYear}',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: isSelected
                                  ? Colors.white
                                  : Colors.grey.shade700,
                            ),
                          ),
                        ],
                      ),
              ],
            ),

            // Default badge
            if (card.isDefault) ...[
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: isSelected
                      ? Colors.white24
                      : Colors.blue.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  AppLocalizations.of(context)!.cardDefault,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: isSelected ? Colors.white : Colors.blue.shade700,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildCardTypeLogo(String cardType, bool isSelected) {
    final logos = {'visa': 'VISA', 'mastercard': 'Mastercard', 'amex': 'AMEX'};

    return Text(
      logos[cardType] ?? AppLocalizations.of(context)!.card,
      style: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.bold,
        color: isSelected ? Colors.white : Colors.grey.shade600,
      ),
    );
  }

  Widget _buildAddNewCardForm() {
    final authState = ref.read(authProvider);
    String selectedCardType = "visa";
    int selectedBankId = 0;
    final typeCtrl = TextEditingController();

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Back button
          InkWell(
            onTap: () {
              setState(() {
                showAddNewCard = false;
              });
            },
            child: Row(
              children: [
                Icon(
                  Icons.arrow_back_ios_rounded,
                  size: 20,
                  color: Theme.of(context).primaryColor,
                ),
                const SizedBox(width: 8),
                Text(
                  AppLocalizations.of(context)!.back,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          // Form title
          Text(
            AppLocalizations.of(context)!.newCardDetails,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1E293B),
            ),
          ),
          const SizedBox(height: 24),

          // card type selector could go here
          authState.user!.role_id == 3
              ? Consumer(
                  builder: (context, ref, _) {
                    final bankState = ref.watch(banksProvider);
                    return bankState.when(
                      loading: () {
                        return const Center(child: CircularProgressIndicator());
                      },
                      error: (error, stack) {
                        return Text(
                          "${AppLocalizations.of(context)!.errorLoadingBanks}$error",
                        );
                      },
                      data: (banks) {
                        return DropdownButtonFormField<int>(
                          initialValue: banks[0].id,
                          decoration: InputDecoration(
                            labelText: AppLocalizations.of(
                              context,
                            )!.bankAccountType,
                            border: const OutlineInputBorder(),
                          ),
                          items: banks.map((bank) {
                            return DropdownMenuItem<int>(
                              value: bank.id,
                              child: Text(bank.name),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              selectedBankId = value ?? banks[0].id;
                              typeCtrl.text = selectedBankId.toString();
                            });
                          },
                        );
                      },
                    );
                  },
                )
              : DropdownButtonFormField<String>(
                  initialValue: selectedCardType,
                  decoration: InputDecoration(
                    labelText: AppLocalizations.of(context)!.cardType,
                    border: OutlineInputBorder(),
                  ),
                  items: [
                    DropdownMenuItem(
                      value: "visa",
                      child: Text(AppLocalizations.of(context)!.visa),
                    ),
                    DropdownMenuItem(
                      value: "mastercard",
                      child: Text(AppLocalizations.of(context)!.mastercard),
                    ),
                    DropdownMenuItem(
                      value: "mada",
                      child: Text(AppLocalizations.of(context)!.mada),
                    ),
                  ],
                  onChanged: (value) {
                    setState(() {
                      selectedCardType = value ?? "visa";
                      typeCtrl.text = selectedCardType;
                    });
                  },
                ),

          const SizedBox(height: 16),

          // Card number input
          _buildInputField(
            onChange: (value) {
              setState(() {
                if (selectedCard != null) {
                  selectedCard = selectedCard!.copyWith(
                    cardNumber: value,
                    iban: value,
                  );
                }
              });
            },
            label: AppLocalizations.of(context)!.cardNumber,
            hint: AppLocalizations.of(context)!.cardNumberHint,
            icon: Icons.credit_card_rounded,
          ),
          const SizedBox(height: 16),

          // Cardholder name input
          _buildInputField(
            onChange: (value) {
              setState(() {
                if (selectedCard != null) {
                  selectedCard = selectedCard!.copyWith(
                    cardholderName: value,
                    accountHolderName: value,
                  );
                }
              });
            },
            label: AppLocalizations.of(context)!.cardHolderName,
            hint: AppLocalizations.of(context)!.cardHolderNameHint,
            icon: Icons.person_rounded,
          ),
          const SizedBox(height: 16),

          // Expiry and CVV row
          Row(
            children: [
              Expanded(
                child: _buildInputField(
                  onChange: (value) {
                    setState(() {
                      if (selectedCard != null) {
                        selectedCard = selectedCard!.copyWith(
                          expiryMonth: int.parse(value),
                        );
                      }
                    });
                  },
                  label: AppLocalizations.of(context)!.month,
                  hint: AppLocalizations.of(context)!.monthHint,
                  icon: Icons.calendar_today_rounded,
                ),
              ),
              const SizedBox(width: 16),

              Expanded(
                child: _buildInputField(
                  onChange: (value) {
                    setState(() {
                      if (selectedCard != null) {
                        selectedCard = selectedCard!.copyWith(
                          expiryYear: int.parse(value),
                        );
                      }
                    });
                  },
                  label: AppLocalizations.of(context)!.year,
                  hint: AppLocalizations.of(context)!.yearHint,
                  icon: Icons.calendar_today_rounded,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildInputField(
                  onChange: (value) {
                    setState(() {
                      if (selectedCard != null) {
                        selectedCard = selectedCard!.copyWith(cvv: value);
                      }
                    });
                  },
                  label: AppLocalizations.of(context)!.cvv,
                  hint: AppLocalizations.of(context)!.cvvHint,
                  icon: Icons.lock_rounded,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),

          // Save as default checkbox

          // Security notice
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.blue.shade50,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.blue.shade200),
            ),
            child: Row(
              children: [
                Icon(Icons.lock_rounded, color: Colors.blue.shade700, size: 20),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    AppLocalizations.of(context)!.securityNotice,
                    style: TextStyle(fontSize: 13, color: Colors.blue.shade700),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInputField({
    required String label,
    required String hint,
    required IconData icon,
    required ValueChanged<String> onChange, // Updated to accept a String
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Color(0xFF1E293B),
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          onChanged: onChange,
          decoration: InputDecoration(
            hintText: hint,
            prefixIcon: Icon(icon),
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
            filled: true,
            fillColor: Colors.grey.shade50,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 14,
            ),
          ),
        ),
      ],
    );
  }
}
