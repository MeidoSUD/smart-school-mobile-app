class PaymentInfoModel {
  final int bookingId;
  final String cardNumber;
  final String expiryMonth;
  final String expiryYear;
  final String cvv;
  final String cardHolder;
  final String paymentBrand;
  PaymentInfoModel({
    required this.bookingId,
    required this.cardNumber,
    required this.cvv,
    required this.cardHolder,
    required this.expiryMonth,
    required this.expiryYear,
    required this.paymentBrand,
  });

  factory PaymentInfoModel.fromJson(Map<String, dynamic> json) {
    return PaymentInfoModel(
      bookingId: json['booking_id'],
      cardNumber: json['card_number'],
      cardHolder: json['card_holder'] ?? json['card_holder_name'],
      cvv: json['cvv'],
      expiryMonth: json['expiry_month'],
      expiryYear: json['expiry_year'],
      paymentBrand: json['payment_brand'] ?? 'VISA',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'booking_id': bookingId,
      'card_number': cardNumber,
      'card_holder': cardHolder,
      'cvv': cvv,
      'expiry_month': expiryMonth,
      'expiry_year': expiryYear,
      'payment_brand': paymentBrand,
    };
  }

  PaymentInfoModel copyWith({
    int? bookingId,
    String? cardNumber,
    String? expiryMonth,
    String? expiryYear,
    String? cvv,
    String? cardHolder,
    String? paymentBrand,
  }) {
    return PaymentInfoModel(
      bookingId: bookingId ?? this.bookingId,
      cardNumber: cardNumber ?? this.cardNumber,
      expiryMonth: expiryMonth ?? this.expiryMonth,
      expiryYear: expiryYear ?? this.expiryYear,
      cvv: cvv ?? this.cvv,
      cardHolder: cardHolder ?? this.cardHolder,
      paymentBrand: paymentBrand ?? this.paymentBrand,
    );
  }
}
