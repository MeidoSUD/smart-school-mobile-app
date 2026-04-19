class Teacher {
  final int id;
  final String firstName;
  final String lastName;
  final String? profilePhoto;
  Teacher({
    required this.id,
    required this.firstName,
    required this.lastName,
    this.profilePhoto,
  });

  factory Teacher.fromJson(Map<String, dynamic> json) {
    final profile = json['profile'] as Map<String, dynamic>?;
    return Teacher(
      id: json['id'] ?? 0,
      firstName: json['first_name'] ?? '',
      lastName: json['last_name'] ?? '',
      profilePhoto: profile?['profile_photo'] ?? json['profile_photo'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'first_name': firstName,
      'last_name': lastName,
      'profile_photo': profilePhoto,
    };
  }
}

class BooksModel {
  final int id;
  final String reference;
  final Teacher teacher;
  final String type;
  final String price;
  final String status;
  final String subject;
  final String day;
  final String time;

  BooksModel({
    required this.id,
    required this.reference,
    required this.teacher,
    required this.type,
    required this.price,
    required this.status,
    required this.subject,
    required this.day,
    required this.time,
  });

  factory BooksModel.fromJson(Map<String, dynamic> json) {
    final sessionInfo = json['session_info'] as Map<String, dynamic>? ?? {};
    final schedule = json['schedule'] as Map<String, dynamic>? ?? {};
    final pricing = json['pricing'] as Map<String, dynamic>? ?? {};
    final subject = json['subject'] as Map<String, dynamic>? ?? {};
    
    String day = 'الأحد';
    if (schedule['first_session_date'] != null) {
      try {
        final date = DateTime.parse(schedule['first_session_date']);
        final weekdays = ['الأحد', 'الإثنين', 'الثلاثاء', 'الأربعاء', 'الخميس', 'الجمعة', 'السبت'];
        day = weekdays[date.weekday % 7];
      } catch (e) {
        day = schedule['session_day'] ?? 'الأحد';
      }
    }
    
    String timeStr = '';
    if (schedule['first_session_time'] != null) {
      try {
        final time = DateTime.parse(schedule['first_session_time']);
        timeStr = time.toLocal().toIso8601String().split('T')[1].split('.')[0];
      } catch (e) {
        timeStr = schedule['first_session_time'].toString();
      }
    }
    
    return BooksModel(
      id: json['id'] ?? 0,
      reference: json['reference'] ?? '',
      teacher: Teacher.fromJson(json['teacher'] ?? {}),
      type: sessionInfo['type'] ?? 'single',
      price: pricing['total_amount']?.toString() ?? '0',
      status: json['status'] ?? '',
      subject: subject['name_ar'] ?? subject['name_en'] ?? 'مادة غير محددة',
      day: day,
      time: timeStr,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'reference': reference,
      'teacher': teacher.toJson(),
      'type': type,
      'price': price,
      'status': status,
      'subject': subject,
      'day': day,
      'time': time,
    };
  }
}
