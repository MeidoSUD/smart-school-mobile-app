import 'package:geniuses_school/data/models/all_subjects_model.dart';

class ClassModel {
  final int id;
  final String name;
  final int levelId;
  final List<AllSubjectsModel>? subjects;
  ClassModel({
    required this.id,
    required this.name,
    required this.levelId,
    this.subjects,
  });

  factory ClassModel.fromJson(Map<String, dynamic> json) {
    return ClassModel(
      id: json['id'],
      name: json['name_ar'] ?? '',
      levelId: json['education_level_id'],
      subjects: (json['subjects'] as List?)
          ?.map((s) => AllSubjectsModel.fromJson(s))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'level_id': levelId,
      'subjects': subjects?.map((s) => s.toJson()).toList(),
    };
  }

  ClassModel copyWith({
    int? id,
    String? name,
    int? levelId,
    List<AllSubjectsModel>? subjects,
  }) {
    return ClassModel(
      id: id ?? this.id,
      name: name ?? this.name,
      levelId: levelId ?? this.levelId,
      subjects: subjects ?? this.subjects,
    );
  }
}
