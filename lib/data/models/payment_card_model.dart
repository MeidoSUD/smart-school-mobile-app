// Sample payment card model

import 'package:geniuses_school/data/models/bank_model.dart';

enum CardType { card, bankAccount }

class PaymentCard {
  final int? id;
  final int? bankId; // Refactored from bank_id
  final CardType type;
  final String? cardNumber;
  final BankModel? bankName;
  final String? iban;
  final String? accountHolderName;
  final String? cardholderName; // Keep for student cards
  final String? accountNumber; // New for teacher bank accounts
  final int? expiryMonth;
  final int? expiryYear;
  final String? cvv;
  final bool isDefault;

  final String cardType; // 'visa', 'mastercard', 'amex'

  PaymentCard({
    this.id,
    this.cardNumber,
    required this.type,
    this.cardholderName,
    this.expiryMonth,
    this.expiryYear,
    this.cvv,
    this.isDefault = false,
    this.cardType = 'visa',
    this.bankName,
    this.bankId,
    this.iban,
    this.accountHolderName,
    this.accountNumber,
  });

  // Get last 4 digits
  String get lastFourDigits => cardNumber?.isNotEmpty == true
      ? cardNumber!.substring(cardNumber!.length - 4)
      : '';

  String get maskedCardNumber {
    if (cardNumber == null || cardNumber!.isEmpty) return '';
    return '**** **** **** $lastFourDigits';
  }

  String get paymentBrand {
    switch (cardType.toLowerCase()) {
      case 'visa':
        return 'VISA';
      case 'mastercard':
      case 'master':
        return 'MASTER';
      case 'mada':
        return 'MADA';
      default:
        return 'VISA';
    }
  }

  // toJson method
  Map<String, dynamic> toJson() {
    if (type == CardType.bankAccount) {
      return {
        'id': id,
        'bank_id': bankId,
        'account_holder_name': accountHolderName,
        'account_number': accountNumber,
        'iban': iban,
        'is_default': isDefault,
      };
    }
    return {
      'id': id,
      'type': 'card',
      'card_number': cardNumber,
      'card_holder_name': cardholderName,
      'card_expiry_month': expiryMonth?.toString().padLeft(2, '0'),
      'card_expiry_year': expiryYear?.toString().padLeft(2, '0'),
      'card_cvc': cvv,
      'is_default': isDefault,
      'payment_method_id': cardType == 'visa'
          ? 1
          : cardType == 'mastercard'
          ? 2
          : 3,
    };
  }

  factory PaymentCard.fromJson(Map<String, dynamic> json) {
    // Check if it's a Moyasar card (student)
    if (json.containsKey('card_display')) {
      final expiry = (json['expiry'] as String? ?? '').split('/');
      int month = 1;
      int year = 2025;
      if (expiry.length == 2) {
        month = int.tryParse(expiry[0]) ?? 1;
        year = int.tryParse(expiry[1]) ?? 2025;
      }

      return PaymentCard(
        id: json['id'],
        type: CardType.card,
        cardNumber: '**** **** **** ${json['last4']}',
        cardholderName: json['nickname'] ?? json['card_display'],
        expiryMonth: month,
        expiryYear: year,
        cvv: '***',
        isDefault: json['is_default'] ?? false,
        cardType: (json['card_brand'] as String? ?? 'visa').toLowerCase(),
      );
    }

    // Teacher bank account or generic card
    final isBank =
        json['bank_id'] != null ||
        json['bank'] != null ||
        json['banks'] != null;

    return PaymentCard(
      id: json['id'],
      type: isBank ? CardType.bankAccount : CardType.card,
      cardNumber: json['card_number'] ?? '',
      cardholderName: json['card_holder_name'] ?? '',
      expiryMonth: json['card_expiry_month'],
      expiryYear: json['card_expiry_year'],
      cvv: json['card_cvc']?.toString() ?? "000",
      isDefault: (json['is_default'] == 1 || json['is_default'] == true),
      cardType: (json['card_type'] ?? 'visa').toLowerCase(),
      bankName: json['bank'] != null
          ? BankModel.fromJson(json['bank'])
          : (json['banks'] != null ? BankModel.fromJson(json['banks']) : null),
      iban: json['iban'],
      accountHolderName: json['account_holder_name'],
      accountNumber: json['account_number'],
      bankId: json['bank_id'],
    );
  }

  //copy with
  PaymentCard copyWith({
    int? id,
    String? cardNumber,
    int? bankId,
    String? cardholderName,
    int? expiryMonth,
    int? expiryYear,
    String? cvv,
    bool? isDefault,
    String? cardType,
    BankModel? bankName,
    String? iban,
    String? accountHolderName,
    String? accountNumber,
    CardType? type,
  }) {
    return PaymentCard(
      id: id ?? this.id,
      cardNumber: cardNumber ?? this.cardNumber,
      cardholderName: cardholderName ?? this.cardholderName,
      expiryMonth: expiryMonth ?? this.expiryMonth,
      expiryYear: expiryYear ?? this.expiryYear,
      cvv: cvv ?? this.cvv,
      isDefault: isDefault ?? this.isDefault,
      cardType: cardType ?? this.cardType,
      bankName: bankName ?? this.bankName,
      iban: iban ?? this.iban,
      accountHolderName: accountHolderName ?? this.accountHolderName,
      accountNumber: accountNumber ?? this.accountNumber,
      type: type ?? this.type,
      bankId: bankId ?? this.bankId,
    );
  }
}
