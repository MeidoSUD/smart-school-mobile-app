class BookingModel {
  final int id;
  final int teacherId;
  final int timeSlotId;
  final String lessonType;
  final int subjectId;
  final int serviceId;
  final int? totalSessions;

  BookingModel({
    required this.id,
    required this.teacherId,
    required this.timeSlotId,
    required this.lessonType,
    required this.subjectId,
    required this.serviceId,
    this.totalSessions,
  });

  factory BookingModel.fromJson(Map<String, dynamic> json) {
    return BookingModel(
      id: json['id'],
      teacherId: json['teacher_id'],
      timeSlotId: json['time_slot_id'],
      lessonType: json['lesson_type'],
      subjectId: json['subject_id'],
      serviceId: json['service_id'],
      totalSessions: json['total_sessions'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'teacher_id': teacherId,
      'timeslot_id': timeSlotId,
      'type': lessonType,
      'service_id': serviceId,
      'total_sessions': totalSessions ?? 1,
      if (serviceId == 2) 'language_id': subjectId else 'subject_id': subjectId,
    };
  }
}
