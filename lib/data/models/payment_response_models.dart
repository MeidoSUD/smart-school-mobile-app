class CheckoutResponse {
  final String checkoutId;
  final String paymentId;
  final String redirectUrl;
  final double amount;
  final String currency;

  CheckoutResponse({
    required this.checkoutId,
    required this.paymentId,
    required this.redirectUrl,
    required this.amount,
    required this.currency,
  });

  factory CheckoutResponse.fromJson(Map<String, dynamic> json) {
    return CheckoutResponse(
      checkoutId: json['checkout_id'] ?? '',
      paymentId: json['payment_id']?.toString() ?? '',
      redirectUrl: json['redirect_url'] ?? '',
      amount: (json['amount'] is num)
          ? (json['amount'] as num).toDouble()
          : 0.0,
      currency: json['currency'] ?? '',
    );
  }
}

class PaymentStatusResponse {
  final String paymentId;
  final String status;
  final double amount;
  final String currency;
  final String transactionId;

  PaymentStatusResponse({
    required this.paymentId,
    required this.status,
    required this.amount,
    required this.currency,
    required this.transactionId,
  });

  bool get isPaid => status.toLowerCase() == 'paid';

  factory PaymentStatusResponse.fromJson(Map<String, dynamic> json) {
    return PaymentStatusResponse(
      paymentId: json['payment_id']?.toString() ?? '',
      status: json['status'] ?? 'unknown',
      amount: (json['amount'] is num)
          ? (json['amount'] as num).toDouble()
          : 0.0,
      currency: json['currency'] ?? '',
      transactionId: json['transaction_id'] ?? '',
    );
  }
}

class SavedCard {
  final int id;
  final String cardBrand;
  final String last4;
  final String? expiryMonth;
  final String? expiryYear;
  final bool isDefault;

  SavedCard({
    required this.id,
    required this.cardBrand,
    required this.last4,
    this.expiryMonth,
    this.expiryYear,
    this.isDefault = false,
  });

  factory SavedCard.fromJson(Map<String, dynamic> json) {
    return SavedCard(
      id: json['id'],
      cardBrand: json['card_brand'] ?? '',
      last4: json['last4'] ?? '',
      expiryMonth: json['expiry_month']?.toString(),
      expiryYear: json['expiry_year']?.toString(),
      isDefault: json['is_default'] == 1 || json['is_default'] == true,
    );
  }
}
