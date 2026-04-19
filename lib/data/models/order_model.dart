import 'package:flutter/material.dart';

class OrderModel {
  final int id;
  final int? subjectId;
  final String? description;
  final TimeOfDay? time;
  final DateTime? date;
  final double? price;
  final int? hoursCount;
  final String? priority;

  OrderModel({
    required this.id,
    this.subjectId,
    this.description,
    this.date,
    this.hoursCount,
    this.price,
    this.priority,
    this.time,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      id: json['id'],
      description: json['description'],
      date: json['date'],
      time: json['time'],
      hoursCount: json['hours_count'],
      price: json['price'],
      priority: json['priority'],
      subjectId: json['subject_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'description': description,
      'date': date,
      'time': time,
      'hours_count': hoursCount,
      'priority': priority,
      'subject_id': subjectId,
      'price': price,
    };
  }

  OrderModel copyWith({
    int? id,
    String? description,
    int? subjectId,
    String? priority,
    int? hoursCount,
    DateTime? date,
    TimeOfDay? time,
    double? price,
  }) {
    return OrderModel(
      id: id ?? this.id,
      description: description ?? this.description,
      subjectId: subjectId ?? this.subjectId,
      price: price ?? this.price,
      priority: priority ?? this.priority,
      date: date ?? this.date,
      time: time ?? this.time,
      hoursCount: hoursCount ?? this.hoursCount,
    );
  }
}
