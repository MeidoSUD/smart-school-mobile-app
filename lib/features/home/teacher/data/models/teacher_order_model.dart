class TeacherOrderModel {
  final int id;
  final int userId;
  final int subjectId;
  final String type;
  final num minPrice;
  final num maxPrice;
  final String status;
  final String? notes;
  final DateTime? createdAt;
  final OrderSubject subject;
  final OrderStudent student;
  final List<OrderSlot> availableSlots;

  TeacherOrderModel({
    required this.id,
    required this.userId,
    required this.subjectId,
    required this.type,
    required this.minPrice,
    required this.maxPrice,
    required this.status,
    this.notes,
    this.createdAt,
    required this.subject,
    required this.student,
    required this.availableSlots,
  });

  factory TeacherOrderModel.fromJson(Map<String, dynamic> json) {
    return TeacherOrderModel(
      id: json['id'] as int,
      userId: json['user_id'] as int,
      subjectId: json['subject_id'] as int,
      type: json['type'] as String,
      minPrice: json['min_price'] as num,
      maxPrice: json['max_price'] as num,
      status: json['status'] as String,
      notes: json['notes'] as String?,
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : null,
      subject: OrderSubject.fromJson(json['subject'] as Map<String, dynamic>),
      student: OrderStudent.fromJson(json['student'] as Map<String, dynamic>),
      availableSlots:
          (json['available_slots'] as List<dynamic>?)
              ?.map((e) => OrderSlot.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }
}

class OrderSubject {
  final int id;
  final String nameEn;
  final String nameAr;

  OrderSubject({required this.id, required this.nameEn, required this.nameAr});

  factory OrderSubject.fromJson(Map<String, dynamic> json) {
    return OrderSubject(
      id: json['id'] as int,
      nameEn: json['name_en'] as String,
      nameAr: json['name_ar'] as String,
    );
  }
}

class OrderStudent {
  final int id;
  final String firstName;
  final String lastName;
  final String? photo;

  OrderStudent({
    required this.id,
    required this.firstName,
    required this.lastName,
    this.photo,
  });

  factory OrderStudent.fromJson(Map<String, dynamic> json) {
    return OrderStudent(
      id: json['id'] as int,
      firstName: json['first_name'] as String,
      lastName: json['last_name'] as String,
      // photo might vary based on API, keeping it nullable for now if it exists or not in this specific response
      // user provided response does not show photo, but it is common in student objects.
      // JSON has role_id, email, phone etc. I will just take name for UI.
    );
  }

  String get fullName => '$firstName $lastName';
}

class OrderSlot {
  final int id;
  final String date;
  final String startTime;
  final String endTime;
  final int duration;

  OrderSlot({
    required this.id,
    required this.date,
    required this.startTime,
    required this.endTime,
    required this.duration,
  });

  factory OrderSlot.fromJson(Map<String, dynamic> json) {
    return OrderSlot(
      id: json['id'] as int,
      date: json['date'] as String,
      startTime: json['start_time'] as String,
      endTime: json['end_time'] as String,
      duration: json['duration'] as int,
    );
  }
}
