import 'package:geniuses_school/data/models/class_model.dart';

class LevelModel {
  final int id;
  final String name;
  final List<ClassModel>? classes;
  LevelModel({required this.id, required this.name, this.classes});
  factory LevelModel.fromJson(Map<String, dynamic> json) {
    return LevelModel(
      id: json['id'],
      name: json['name_ar'] ?? '',
      classes: (json['classes'] as List?)
          ?.map((c) => ClassModel.fromJson(c))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'classes': classes?.map((c) => c.toJson()).toList(),
    };
  }

  LevelModel copyWith({int? id, String? name, List<ClassModel>? classes}) {
    return LevelModel(
      id: id ?? this.id,
      name: name ?? this.name,
      classes: classes ?? this.classes,
    );
  }
}
