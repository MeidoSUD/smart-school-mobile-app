import 'package:geniuses_school/data/models/time_slot.dart';

class AvailableTimes {
  final int day;
  final List<TimeSlot> timeSlots;

  AvailableTimes({required this.day, required this.timeSlots});

  factory AvailableTimes.fromJson(Map<String, dynamic> json) {
    return AvailableTimes(
      day: json['day'] as int,
      timeSlots: (json['time_slots'] as List<dynamic>)
          .map((e) => TimeSlot.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'day': day,
      'time_slots': timeSlots.map((e) => e.toJson()).toList(),
    };
  }

  // Helper method to create a copy with modifications
  AvailableTimes copyWith({int? day, List<TimeSlot>? timeSlots}) {
    return AvailableTimes(
      day: day ?? this.day,
      timeSlots: timeSlots ?? this.timeSlots,
    );
  }
}
