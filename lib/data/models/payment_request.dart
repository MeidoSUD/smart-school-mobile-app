class PaymentRequest {
  final double amount;
  final String currency; // Usually 'SAR' for Saudi Arabia
  final String? paymentBrand; // OPTIONAL: 'VISA', 'MASTERCARD', 'MADA'
  final String? merchantTransactionId; // OPTIONAL: Your transaction ID
  final int? savedCardId; // OPTIONAL: For using saved cards

  PaymentRequest({
    required this.amount,
    required this.currency,
    this.paymentBrand,
    this.merchantTransactionId,
    this.savedCardId,
  });

  Map<String, dynamic> toJson() => {
    'amount': amount,
    'currency': currency,
    if (paymentBrand != null) 'payment_brand': paymentBrand,
    if (merchantTransactionId != null)
      'merchant_transaction_id': merchantTransactionId,
    if (savedCardId != null) 'saved_card_id': savedCardId,
  };

  factory PaymentRequest.fromJson(Map<String, dynamic> json) => PaymentRequest(
    amount: (json['amount'] as num).toDouble(),
    currency: json['currency'],
    paymentBrand: json['payment_brand'],
    merchantTransactionId: json['merchant_transaction_id'],
    savedCardId: json['saved_card_id'],
  );
}
