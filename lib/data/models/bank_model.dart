class BankModel {
  final int id;
  final String name;
  final String? code;
  final String? country;
  final String? swiftCode;

  BankModel({
    required this.id,
    required this.name,
    this.code,
    this.country,
    this.swiftCode,
  });

  factory BankModel.fromJson(Map<String, dynamic> json) {
    return BankModel(
      id: json['id'],
      name: json['name_ar'] ?? json['name'] ?? '',
      code: json['code'],
      country: json['country'],
      swiftCode: json['swift_code'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'code': code,
      'country': country,
      'swift_code': swiftCode,
    };
  }

  BankModel copyWith({
    int? id,
    String? name,
    String? code,
    String? country,
    String? swiftCode,
  }) {
    return BankModel(
      id: id ?? this.id,
      name: name ?? this.name,
      code: code ?? this.code,
      country: country ?? this.country,
      swiftCode: swiftCode ?? this.swiftCode,
    );
  }
}
