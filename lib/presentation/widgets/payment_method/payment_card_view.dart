import 'package:geniuses_school/data/models/payment_card_model.dart';
import 'package:flutter/material.dart';

import '../../../l10n/app_localizations.dart';

class PaymentCardView extends StatelessWidget {
  final PaymentCard card;
  final List<Color> colors;
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  final VoidCallback onSetDefault;
  final bool enabledActions;

  const PaymentCardView({
    super.key,
    required this.card,
    required this.colors,
    required this.onEdit,
    required this.onDelete,
    required this.onSetDefault,
    this.enabledActions = true,
  });

  @override
  Widget build(BuildContext context) {
    final gradient = LinearGradient(colors: colors);

    return Card(
      elevation: 6,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      clipBehavior: Clip.antiAlias,
      child: Container(
        decoration: BoxDecoration(gradient: gradient),
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // top row: type, default badge, and icons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text(
                      card.type == CardType.bankAccount
                          ? card.bankName!.name.toUpperCase()
                          : card.cardType.toUpperCase(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    if (card.isDefault) ...[
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white24,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.white, width: 1),
                        ),
                        child: Text(
                          AppLocalizations.of(context)!.cardDefault,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
                Row(
                  children: const [
                    Icon(Icons.wifi, color: Colors.white70, size: 20),
                    SizedBox(width: 8),
                    Icon(Icons.credit_card, color: Colors.white70, size: 22),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 18),

            // chip + number
            Row(
              children: [
                // chip
                Container(
                  width: 48,
                  height: 36,
                  decoration: BoxDecoration(
                    color: Colors.white70,
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    card.type == CardType.bankAccount
                        ? card.iban!
                        : card.maskedCardNumber,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      letterSpacing: 2,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 18),

            // holder + expiry
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppLocalizations.of(context)!.cardHolderName,
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 11,
                        ),
                      ),
                      Text(
                        card.type == CardType.bankAccount
                            ? card.accountHolderName!
                            : card.accountHolderName!,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                card.type == CardType.card
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            AppLocalizations.of(context)!.expiryDate,
                            style: const TextStyle(
                              color: Colors.white70,
                              fontSize: 11,
                            ),
                          ),
                          Text(
                            "${card.expiryMonth!}/${card.expiryYear!}",
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      )
                    : const SizedBox(),
              ],
            ),

            // action buttons
            if (enabledActions) ...[
              const SizedBox(height: 12),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  if (!card.isDefault)
                    TextButton.icon(
                      onPressed: onSetDefault,
                      icon: const Icon(
                        Icons.star_outline,
                        color: Colors.white,
                        size: 18,
                      ),
                      label: Text(
                        AppLocalizations.of(context)!.cardDefault,
                        style: TextStyle(color: Colors.white, fontSize: 12),
                      ),
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.black26,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 6,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  TextButton.icon(
                    onPressed: onDelete,
                    icon: const Icon(
                      Icons.delete,
                      color: Colors.white,
                      size: 18,
                    ),
                    label: Text(
                      AppLocalizations.of(context)!.delete,
                      style: TextStyle(color: Colors.white, fontSize: 12),
                    ),
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.black26,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 6,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}
