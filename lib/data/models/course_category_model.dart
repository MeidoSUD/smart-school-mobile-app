class CourseCategory {
  final int id;
  final String nameAr;
  final String nameEn;
  final String? descriptionAr;
  final String? descriptionEn;

  CourseCategory({
    required this.id,
    required this.nameAr,
    required this.nameEn,
    this.descriptionAr,
    this.descriptionEn,
  });

  factory CourseCategory.fromJson(Map<String, dynamic> json) {
    final id = json['id'];
    final nameAr = json['name_ar']?.toString() ?? '';
    final nameEn = json['name_en']?.toString() ?? '';
    
    final parsedId = id != null 
        ? (id is int ? id : int.tryParse(id.toString()) ?? 0)
        : 0;
    
    if (parsedId == 0) {
      throw Exception('Category id is invalid: $id');
    }
    if (nameAr.isEmpty) {
      throw Exception('Category name_ar is empty');
    }
    if (nameEn.isEmpty) {
      throw Exception('Category name_en is empty');
    }
    
    return CourseCategory(
      id: parsedId,
      nameAr: nameAr,
      nameEn: nameEn,
      descriptionAr: json['description_ar']?.toString(),
      descriptionEn: json['description_en']?.toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name_ar': nameAr,
      'name_en': nameEn,
      'description_ar': descriptionAr,
      'description_en': descriptionEn,
    };
  }
}
