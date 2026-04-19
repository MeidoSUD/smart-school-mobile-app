class AllSubjectsModel {
  final int id;
  final String name;
  final int classId;

  AllSubjectsModel({
    required this.id,
    required this.name,
    required this.classId,
  });

  factory AllSubjectsModel.fromJson(Map<String, dynamic> json) {
    return AllSubjectsModel(
      id: json['id'],
      name: json['name_ar'] ?? '',
      classId: json['class_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name_ar': name, 'class_id': classId};
  }

  AllSubjectsModel copyWith({int? id, String? name, int? classId}) {
    return AllSubjectsModel(
      id: id ?? this.id,
      name: name ?? this.name,
      classId: classId ?? this.classId,
    );
  }
}
