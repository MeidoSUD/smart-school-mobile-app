// Data Models
class SubjectModel {
  final int id;
  final String name;

  final int classId;
  final int levelId;

  SubjectModel({
    required this.id,
    required this.name,
    required this.classId,
    required this.levelId,
  });

  factory SubjectModel.fromJson(Map<String, dynamic> json) {
    return SubjectModel(
      id: json['id'],
      name: json['name_ar'] ?? '',
      classId: json['class_id'],
      levelId: json['education_level_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name, 'class_id': classId, 'level_id': levelId};
  }
}
