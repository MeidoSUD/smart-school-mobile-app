import 'package:geniuses_school/data/models/earnings_model.dart';

class UserProfileModel {
  final int? id;
  final int? user_id;
  final String? user_bio;

  final String? profile_photo;
  final bool? verified;
  final bool? is_active;
  final bool? teach_individual;
  final double individual_hour_price;
  final bool? teach_group;
  final double group_hour_price;
  final int max_group_size;
  final int min_group_size;
  final Map<String, dynamic>? teacher_service;

  final double? current_balance;
  final int? current_lessons;

  final EarningsModel? earnings;

  final int? serviceId;
  final List<TeacherService>? services;

  // Getters for backward compatibility
  int? get total_lessons => earnings?.totalLessons;
  double? get todayEarnings => earnings?.todayEarnings;
  double? get monthEarnings => earnings?.monthEarnings;
  double? get totalEarnings => earnings?.totalEarnings;

  final double rating;
  final int total_students;
  final List<TeacherSubject>? teacher_subjects;
  final List<AvailableDay>? available_times;
  final List<dynamic>? reviews;
  final List<dynamic>? courses;
  final List<dynamic>? languages;

  // final CertificatesModel? certificates;
  final String? certificate;
  final String? resume;
  final CertificateAttachment? certificate_attachment;

  final int? bookings_count;
  final int? subjects_count;
  final int? languages_count;
  final int? courses_count;

  // final PaymentInfoModel? paymentInfo;

  UserProfileModel({
    this.id,
    this.user_id,
    this.user_bio,

    this.profile_photo,
    required this.verified,
    this.certificate,
    this.resume,
    this.teacher_service,
    this.is_active = false,
    this.teach_individual = false,
    this.individual_hour_price = 0.0,
    this.teach_group = false,
    this.group_hour_price = 0.0,
    this.max_group_size = 0,
    this.min_group_size = 0,

    this.current_balance,
    this.current_lessons,
    this.earnings,
    this.serviceId,
    this.services,

    this.rating = 0.0,
    this.total_students = 0,
    this.teacher_subjects,
    this.available_times,
    this.reviews,
    this.courses,
    this.languages,
    this.certificate_attachment,
    this.bookings_count,
    this.subjects_count,
    this.languages_count,
    this.courses_count,
  });

  UserProfileModel copyWith({
    int? id,
    int? user_id,
    String? user_bio,

    String? profile_photo,
    bool? verified,
    // CertificatesModel? certificates,
    String? certificate,
    String? resume,
    Map<String, dynamic>? teacher_service,

    bool? is_active,
    bool? teach_individual,
    double? individual_hour_price,
    bool? teach_group,
    double? group_hour_price,
    int? max_group_size,
    int? min_group_size,

    double? current_balance,
    int? current_lessons,
    EarningsModel? earnings,
    int? serviceId,
    List<TeacherService>? services,

    double? rating,
    int? total_students,
    List<TeacherSubject>? teacher_subjects,
    List<AvailableDay>? available_times,
    List<dynamic>? reviews,
    List<dynamic>? courses,
    List<dynamic>? languages,
    CertificateAttachment? certificate_attachment,
    int? bookings_count,
    int? subjects_count,
    int? languages_count,
    int? courses_count,
  }) {
    return UserProfileModel(
      id: id ?? this.id,
      user_id: user_id ?? this.user_id,
      user_bio: user_bio ?? this.user_bio,

      profile_photo: profile_photo ?? this.profile_photo,
      verified: verified ?? this.verified,
      certificate: certificate ?? this.certificate,
      resume: resume ?? this.resume,
      teacher_service: teacher_service ?? this.teacher_service,
      is_active: is_active ?? this.is_active,
      teach_individual: teach_individual ?? this.teach_individual,
      individual_hour_price:
          individual_hour_price ?? this.individual_hour_price,
      teach_group: teach_group ?? this.teach_group,
      group_hour_price: group_hour_price ?? this.group_hour_price,
      max_group_size: max_group_size ?? this.max_group_size,
      min_group_size: min_group_size ?? this.min_group_size,
      current_balance: current_balance ?? this.current_balance,
      current_lessons: current_lessons ?? this.current_lessons,
      earnings: earnings ?? this.earnings,
      serviceId: serviceId ?? this.serviceId,
      services: services ?? this.services,
      rating: rating ?? this.rating,
      total_students: total_students ?? this.total_students,
      teacher_subjects: teacher_subjects ?? this.teacher_subjects,
      available_times: available_times ?? this.available_times,
      reviews: reviews ?? this.reviews,
      courses: courses ?? this.courses,
      languages: languages ?? this.languages,
      certificate_attachment:
          certificate_attachment ?? this.certificate_attachment,
      bookings_count: bookings_count ?? this.bookings_count,
      subjects_count: subjects_count ?? this.subjects_count,
      languages_count: languages_count ?? this.languages_count,
      courses_count: courses_count ?? this.courses_count,
    );
  }

  factory UserProfileModel.fromJson(Map<String, dynamic> json) {
    return UserProfileModel(
      id: json['id'],
      user_id: json['user_id'],
      user_bio: json['bio'],
      profile_photo: json['profile_photo'],
      verified: (json['verified'] == 1 || json['verified'] == true),
      certificate: json['certificate'],
      resume: json['resume'],
      teacher_service:
          json['services'] != null && (json['services'] as List).isNotEmpty
          ? Map<String, dynamic>.from(json['services'][0])
          : null,
      is_active: (json['is_active'] == 1 || json['is_active'] == true),
      teach_individual:
          (json['teach_individual'] == 1 || json['teach_individual'] == true),
      individual_hour_price: (json['individual_hour_price'] != null)
          ? (json['individual_hour_price'] as num).toDouble()
          : 0.0,
      teach_group: (json['teach_group'] == 1 || json['teach_group'] == true),
      group_hour_price: (json['group_hour_price'] != null)
          ? (json['group_hour_price'] as num).toDouble()
          : 0.0,
      max_group_size: json['max_group_size'] ?? 0,
      min_group_size: json['min_group_size'] ?? 0,
      current_balance: (json['current_balance'] != null)
          ? (json['current_balance'] as num).toDouble()
          : 0.0,
      current_lessons: json['currentLessons'] ?? json['current_lessons'] ?? 0,
      earnings: json['earnings'] != null
          ? EarningsModel.fromJson(json['earnings'])
          : null,
      serviceId: json['service'],
      services: json['services'] != null
          ? (json['services'] as List)
                .map((i) => TeacherService.fromJson(i))
                .toList()
          : [],
      rating: json['rating'] != null ? (json['rating'] as num).toDouble() : 0.0,
      total_students: json['total_students'] ?? 0,
      teacher_subjects: json['teacher_subjects'] != null
          ? (json['teacher_subjects'] as List)
                .map((i) => TeacherSubject.fromJson(i))
                .toList()
          : [],
      available_times: json['available_times'] != null
          ? (json['available_times'] as List)
                .map((i) => AvailableDay.fromJson(i))
                .toList()
          : [],
      reviews: json['reviews'] ?? [],
      courses: json['courses'] ?? [],
      languages: json['languages'] ?? [],
      certificate_attachment: json['certificate_attachment'] != null
          ? CertificateAttachment.fromJson(json['certificate_attachment'])
          : null,
      bookings_count: json['bookings_count'],
      subjects_count: json['subjects_count'],
      languages_count: json['languages_count'],
      courses_count: json['courses_count'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': user_id,
      'user_bio': user_bio,
      'profile_photo': profile_photo,
      'verified': verified,
      'certificate': certificate,
      'resume': resume,
      'teacher_service': teacher_service,
      'is_active': is_active,
      'teach_individual': teach_individual,
      'individual_hour_price': individual_hour_price,
      'teach_group': teach_group,
      'group_hour_price': group_hour_price,
      'max_group_size': max_group_size,
      'min_group_size': min_group_size,
      'current_balance': current_balance,
      'current_lessons': current_lessons,
      'earnings': earnings?.toJson(),
      'service': serviceId,
      'services': services?.map((e) => e.toJson()).toList(),
      'rating': rating,
      'total_students': total_students,
      'teacher_subjects': teacher_subjects?.map((e) => e.toJson()).toList(),
      'available_times': available_times?.map((e) => e.toJson()).toList(),
      'reviews': reviews,
      'courses': courses,
      'languages': languages,
      'certificate_attachment': certificate_attachment?.toJson(),
      'bookings_count': bookings_count,
      'subjects_count': subjects_count,
      'languages_count': languages_count,
      'courses_count': courses_count,
    };
  }
}

class TeacherService {
  final int? id;
  final int? teacherId;
  final int? serviceId;
  final String? keyName;
  final String? nameEn;
  final String? nameAr;
  final String? descriptionEn;
  final String? descriptionAr;
  final String? image;
  final int? status;
  final bool? verified;

  TeacherService({
    this.id,
    this.teacherId,
    this.serviceId,
    this.keyName,
    this.nameEn,
    this.nameAr,
    this.descriptionEn,
    this.descriptionAr,
    this.image,
    this.status,
    this.verified,
  });

  factory TeacherService.fromJson(Map<String, dynamic> json) {
    return TeacherService(
      id: json['id'],
      teacherId: json['teacher_id'],
      serviceId: json['service_id'],
      keyName: json['key_name'],
      nameEn: json['name_en'],
      nameAr: json['name_ar'],
      descriptionEn: json['description_en'],
      descriptionAr: json['description_ar'],
      image: json['image'],
      status: json['status'],
      verified: json['verified'] == true || json['verified'] == 1,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'teacher_id': teacherId,
      'service_id': serviceId,
      'key_name': keyName,
      'name_en': nameEn,
      'name_ar': nameAr,
      'description_en': descriptionEn,
      'description_ar': descriptionAr,
      'image': image,
      'status': status,
      'verified': verified,
    };
  }
}

class CertificateAttachment {
  final int? id;
  final String? fileName;
  final String? filePath;
  final String? createdAt;

  CertificateAttachment({
    this.id,
    this.fileName,
    this.filePath,
    this.createdAt,
  });

  factory CertificateAttachment.fromJson(Map<String, dynamic> json) {
    return CertificateAttachment(
      id: json['id'],
      fileName: json['file_name'],
      filePath: json['file_path'],
      createdAt: json['created_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'file_name': fileName,
      'file_path': filePath,
      'created_at': createdAt,
    };
  }
}

class AvailableDay {
  final int? id;
  final String? day;
  final List<AvailableTimeSlot>? times;

  AvailableDay({this.id, this.day, this.times});

  factory AvailableDay.fromJson(Map<String, dynamic> json) {
    return AvailableDay(
      id: json['id'],
      day: json['day'],
      times: json['times'] != null
          ? (json['times'] as List)
                .map((i) => AvailableTimeSlot.fromJson(i))
                .toList()
          : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'day': day,
      'times': times?.map((e) => e.toJson()).toList(),
    };
  }
}

class AvailableTimeSlot {
  final int? id;
  final String? time;

  AvailableTimeSlot({this.id, this.time});

  factory AvailableTimeSlot.fromJson(Map<String, dynamic> json) {
    return AvailableTimeSlot(id: json['id'], time: json['time']);
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'time': time};
  }
}

class TeacherSubject {
  final int? id;
  final int? teacherId;
  final int? subjectId;
  final String? title;
  final int? classId;
  final int? classLevelId;
  final String? classLevelTitle;
  final String? classTitle;

  TeacherSubject({
    this.id,
    this.teacherId,
    this.subjectId,
    this.title,
    this.classId,
    this.classLevelId,
    this.classLevelTitle,
    this.classTitle,
  });

  factory TeacherSubject.fromJson(Map<String, dynamic> json) {
    return TeacherSubject(
      id: json['id'],
      teacherId: json['teacher_id'],
      subjectId: json['subject_id'],
      title: json['title'],
      classId: json['class_id'],
      classLevelId: json['class_level_id'],
      classLevelTitle: json['class_level_title'],
      classTitle: json['class_title'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'teacher_id': teacherId,
      'subject_id': subjectId,
      'title': title,
      'class_id': classId,
      'class_level_id': classLevelId,
      'class_level_title': classLevelTitle,
      'class_title': classTitle,
    };
  }
}
