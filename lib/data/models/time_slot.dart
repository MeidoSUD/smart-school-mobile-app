// models/day_availability.dart
import 'package:flutter/material.dart';

import 'session_model.dart';

class TimeSlot {
  final int id;
  final StudentSession? session;
  final TimeOfDay time; // 0-23
  final bool isAvailable;
  TimeSlot({required this.id, required this.time, this.session,this.isAvailable = true});

  factory TimeSlot.fromJson(Map<String, dynamic> json) {
    final timeParts = json['time'].split(':');
    final hour = int.parse(timeParts[0]);
    final minute = int.parse(timeParts[1]);
    return TimeSlot(
      id: json['id'],
      time: TimeOfDay(hour: hour, minute: minute),
      session: json['session'] != null
          ? StudentSession.fromJson(json['session'])
          : null,
          isAvailable: json['is_available'] ?? true,
    );
  }

  Map<String, dynamic> toJson() {
    final hour = time.hour.toString().padLeft(2, '0');
    final minute = time.minute.toString().padLeft(2, '0');
    return {'id': id, 'time': '$hour:$minute', 'session': session?.toJson(), 'is_available': isAvailable};
  }
}
