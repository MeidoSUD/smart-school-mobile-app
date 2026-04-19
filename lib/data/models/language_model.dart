class Language {
  final int id;
  final String nameEn;
  final String nameAr;
  final int? status;

  Language({
    required this.id,
    required this.nameEn,
    required this.nameAr,
    this.status,
  });

  factory Language.fromJson(Map<String, dynamic> json) {
    return Language(
      id: json['id'] is int ? json['id'] : int.tryParse(json['id'].toString()) ?? 0,
      nameEn: json['name_en']?.toString() ?? '',
      nameAr: json['name_ar']?.toString() ?? '',
      status: json['status'] != null
          ? (json['status'] is int ? json['status'] : int.tryParse(json['status'].toString()))
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name_en': nameEn,
      'name_ar': nameAr,
      'status': status,
    };
  }
}


