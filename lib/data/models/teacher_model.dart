class AvailableTimeSlot {
  final int id;
  final String time;

  AvailableTimeSlot({required this.id, required this.time});

  factory AvailableTimeSlot.fromJson(Map<String, dynamic> json) {
    return AvailableTimeSlot(id: json['id'] ?? 0, time: json['time'] ?? "");
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'time': time};
  }
}

class TeacherCourse {
  final int id;
  final String name;
  final String? description;
  final double? price;
  final int? durationHours;
  final String? status;
  final String? coverImage;

  TeacherCourse({
    required this.id,
    required this.name,
    this.description,
    this.price,
    this.durationHours,
    this.status,
    this.coverImage,
  });

  factory TeacherCourse.fromJson(Map<String, dynamic> json) {
    return TeacherCourse(
      id: json['id'] ?? 0,
      name: json['name'] ?? "",
      description: json['description'],
      price: json['price'] != null ? (json['price'] as num).toDouble() : null,
      durationHours: json['duration_hours'],
      status: json['status'],
      coverImage: json['cover_image'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'price': price,
      'duration_hours': durationHours,
      'status': status,
      'cover_image': coverImage,
    };
  }
}

class TeacherService {
  final int id;
  final String? keyName;
  final String? nameEn;
  final String? nameAr;
  final String? descriptionEn;
  final String? descriptionAr;

  TeacherService({
    required this.id,
    this.keyName,
    this.nameEn,
    this.nameAr,
    this.descriptionEn,
    this.descriptionAr,
  });

  factory TeacherService.fromJson(Map<String, dynamic> json) {
    return TeacherService(
      id: json['id'] ?? 0,
      keyName: json['key_name'],
      nameEn: json['name_en'],
      nameAr: json['name_ar'],
      descriptionEn: json['description_en'],
      descriptionAr: json['description_ar'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'key_name': keyName,
      'name_en': nameEn,
      'name_ar': nameAr,
      'description_en': descriptionEn,
      'description_ar': descriptionAr,
    };
  }
}

class AvailableDay {
  final int id;
  final String day;
  final List<AvailableTimeSlot> times;

  AvailableDay({required this.id, required this.day, required this.times});

  factory AvailableDay.fromJson(Map<String, dynamic> json) {
    return AvailableDay(
      id: json['id'] ?? 0,
      day: json['day'] ?? "",
      times:
          (json['times'] as List?)
              ?.map((t) => AvailableTimeSlot.fromJson(t))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'day': day,
      'times': times.map((t) => t.toJson()).toList(),
    };
  }
}

class TeacherLevel {
  final int id;
  final int teacherId;
  final String title;

  TeacherLevel({
    required this.id,
    required this.teacherId,
    required this.title,
  });

  factory TeacherLevel.fromJson(Map<String, dynamic> json) {
    return TeacherLevel(
      id: json['id'] ?? 0,
      teacherId: json['teacher_id'] ?? 0,
      title: json['title'] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'teacher_id': teacherId, 'title': title};
  }
}

class TeacherClass {
  final int id;
  final int teacherId;
  final String title;
  final int levelId;

  TeacherClass({
    required this.id,
    required this.teacherId,
    required this.title,
    required this.levelId,
  });

  factory TeacherClass.fromJson(Map<String, dynamic> json) {
    return TeacherClass(
      id: json['id'] ?? 0,
      teacherId: json['teacher_id'] ?? 0,
      title: json['title'] ?? "",
      levelId: json['level_id'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'teacher_id': teacherId,
      'title': title,
      'level_id': levelId,
    };
  }
}

class TeacherSubject {
  final int id;
  final int teacherId;
  final String title;
  final int classId;
  final int categoryId;
  final int subjectId;
  final String? classTitle;
  final String? classLevelTitle;
  final String? classLevelId;
  final double? hourlyRate;
  final String? proficiency;

  TeacherSubject({
    required this.id,
    required this.teacherId,
    required this.title,
    required this.classId,
    required this.categoryId,
    required this.classTitle,
    required this.classLevelTitle,
    required this.classLevelId,
    required this.subjectId,
    this.hourlyRate,
    this.proficiency,
  });

  factory TeacherSubject.fromJson(Map<String, dynamic> json) {
    return TeacherSubject(
      id: json['id'] ?? 0,
      teacherId: json['teacher_id'] ?? 0,
      title: json['title'] ?? "",
      classId: json['class_id'] ?? 0,
      categoryId: json['category_id'] ?? 0,
      hourlyRate: json['hourly_rate'] != null
          ? (json['hourly_rate'] as num).toDouble()
          : null,
      proficiency: json['proficiency'],
      classTitle: json['class_title'],
      classLevelTitle: json['class_level_title'],
      classLevelId: json['class_level_id']?.toString(),
      subjectId: json['subject_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'teacher_id': teacherId,
      'title': title,
      'class_id': classId,
      'category_id': categoryId,
      'hourly_rate': hourlyRate,
      'proficiency': proficiency,
      'class_title': classTitle,
      'class_level_title': classLevelTitle,
      'class_level_id': classLevelId,
      'subject_id': subjectId,
    };
  }
}

class TeacherLanguage {
  final int id;
  final int languageId;
  final String? nameEn;
  final String? nameAr;

  TeacherLanguage({
    required this.id,
    required this.languageId,
    this.nameEn,
    this.nameAr,
  });

  factory TeacherLanguage.fromJson(Map<String, dynamic> json) {
    return TeacherLanguage(
      id: json['id'] ?? 0,
      languageId: json['language_id'] ?? 0,
      nameEn: json['name_en'],
      nameAr: json['name_ar'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'language_id': languageId,
      'name_en': nameEn,
      'name_ar': nameAr,
    };
  }
}

class Review {
  final int id;
  final String studentName;
  final double rating;
  final String comment;
  final String date;

  Review({
    required this.id,
    required this.studentName,
    required this.rating,
    required this.comment,
    required this.date,
  });

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      id: json['id'] ?? 0,
      studentName: json['student_name'] ?? "",
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
      comment: json['comment'] ?? "",
      date: json['date'] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'student_name': studentName,
      'rating': rating,
      'comment': comment,
      'date': date,
    };
  }
}

class TeacherModel {
  final int id;
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? phoneNumber;
  final String? emailVerifiedAt;
  final int roleId;
  final String? gender;
  final String? nationality;
  final String? verificationCode;
  final String? socialProvider;
  final String? socialProviderId;
  final int isActive;
  final String? profileImage;
  final List<Review> reviews;
  final double rating;
  final String bio;
  final int totalStudents;
  final bool verified;
  final String service;
  final List<AvailableDay> availableTimes;
  final bool teachIndividual;
  final double? individualHourPrice;
  final bool teachGroup;
  final double? groupHourPrice;
  final int? maxGroupSize;
  final int? minGroupSize;
  final List<TeacherLevel> teacherLevels;
  final List<TeacherClass> teacherClasses;
  final List<TeacherSubject> teacherSubjects;
  final List<TeacherLanguage> teacherLanguages;
  final List<TeacherCourse> teacherCourses;

  final List<TeacherService> services;
  final int? serviceId;

  TeacherModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phoneNumber,
    this.emailVerifiedAt,
    required this.roleId,
    required this.gender,
    required this.nationality,
    this.verificationCode,
    this.socialProvider,
    this.socialProviderId,
    required this.isActive,
    this.profileImage,
    required this.reviews,
    required this.rating,
    required this.bio,
    required this.totalStudents,
    required this.verified,
    required this.service,
    required this.availableTimes,
    required this.teachIndividual,
    this.individualHourPrice,
    required this.teachGroup,
    this.groupHourPrice,
    this.maxGroupSize,
    this.minGroupSize,
    required this.teacherLevels,
    required this.teacherClasses,
    required this.teacherSubjects,
    required this.teacherLanguages,
    required this.teacherCourses,

    required this.services,
    this.serviceId,
  });

  // Helper getter for full name
  String get fullName => "$firstName $lastName";

  factory TeacherModel.fromJson(Map<String, dynamic> json) {
    return TeacherModel(
      id: json['id'] ?? 0,
      firstName: json['first_name'] ?? "",
      lastName: json['last_name'] ?? "",
      email: json['email'] ?? "",
      phoneNumber: json['phone_number'] ?? "",
      emailVerifiedAt: json['email_verified_at'],
      roleId: json['role_id'] ?? 0,
      gender: json['gender'] ?? "",
      nationality: json['nationality'] ?? "",
      verificationCode: json['verification_code'],
      socialProvider: json['social_provider'],
      socialProviderId: json['social_provider_id'],
      isActive: json['is_active'] ?? 0,
      profileImage: json['profile']?['profile_photo'],
      reviews:
          (json['profile']?['reviews'] as List?)
              ?.map((r) => Review.fromJson(r))
              .toList() ??
          [],
      rating: (json['profile']?['rating'] as num?)?.toDouble() ?? 0.0,
      bio: json['profile']?['bio'] ?? "",
      totalStudents: json['profile']?['total_students'] ?? 0,
      verified: json['profile']?['verified'] ?? false,
      service: json['profile']?['service'].toString() ?? "",
      availableTimes:
          (json['profile']?['available_times'] as List?)
              ?.map((d) => AvailableDay.fromJson(d))
              .toList() ??
          [],
      teachIndividual: json['profile']?['teach_individual'] ?? false,
      individualHourPrice: json['profile']?['individual_hour_price'] != null
          ? (json['profile']?['individual_hour_price'] as num).toDouble()
          : 0.0,
      teachGroup: json['profile']?['teach_group'] ?? false,
      groupHourPrice: json['profile']?['group_hour_price'] != null
          ? (json['profile']?['group_hour_price'] as num).toDouble()
          : 0.0,
      maxGroupSize: json['profile']?['max_group_size'],
      minGroupSize: json['profile']?['min_group_size'],
      teacherLevels:
          (json['profile']?['teacher_levels'] as List?)
              ?.map((l) => TeacherLevel.fromJson(l))
              .toList() ??
          [],
      teacherClasses:
          (json['profile']?['teacher_classes'] as List?)
              ?.map((c) => TeacherClass.fromJson(c))
              .toList() ??
          [],
      teacherSubjects:
          (json['profile']?['teacher_subjects'] as List?)
              ?.map((s) => TeacherSubject.fromJson(s))
              .toList() ??
          [],
      teacherLanguages:
          (json['profile']?['languages'] as List?)
              ?.map((l) => TeacherLanguage.fromJson(l))
              .toList() ??
          [],
      teacherCourses:
          (json['profile']?['courses'] as List?)
              ?.map((c) => TeacherCourse.fromJson(c))
              .toList() ??
          [],
      services:
          (json['profile']?['services'] as List?)
              ?.map((s) => TeacherService.fromJson(s))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, List<String>> availableTimesMap = {};
    for (var day in availableTimes) {
      availableTimesMap[day.day] = day.times.map((t) => t.time).toList();
    }

    List<Map<String, dynamic>> availableTimesList = availableTimes
        .map(
          (day) => {
            "id": day.id,
            "day": day.day,
            "times": day.times
                .map((t) => {"id": t.id, "time": t.time})
                .toList(),
          },
        )
        .toList();

    List<Map<String, dynamic>> teacherClassesList = teacherClasses
        .map((c) => {"id": c.id, "title": c.title, "level_id": c.levelId})
        .toList();

    List<Map<String, dynamic>> teacherSubjectsList = teacherSubjects
        .map(
          (s) => {
            "id": s.id,
            "subject_id": s.subjectId,
            "title": s.title,
            "class_id": s.classId,
            "class_title": s.classTitle,
            "class_level_title": s.classLevelTitle,
            "class_level_id": s.classLevelId,
          },
        )
        .toList();

    List<Map<String, dynamic>> teacherLanguagesList = teacherLanguages
        .map((l) => l.toJson())
        .toList();

    List<Map<String, dynamic>> teacherCoursesList = teacherCourses
        .map((c) => c.toJson())
        .toList();

    List<Map<String, dynamic>> servicesList = services
        .map((s) => s.toJson())
        .toList();

    String subjectCategory = "";
    String educationLevel = "";
    List<String> classes = [];

    if (teacherSubjects.isNotEmpty) {
      subjectCategory = teacherSubjects.first.title;
      educationLevel = teacherSubjects.first.classLevelTitle ?? "";

      classes = teacherSubjects
          .map((s) => s.classTitle ?? "")
          .where((c) => c.isNotEmpty)
          .toSet()
          .toList();
    }

    String serviceName = "";
    if (service.isNotEmpty) {
      try {
        final serviceId = int.tryParse(service);
        if (serviceId != null) {
          if (serviceId == 6) {
            serviceName = "قدرات و تحصيل";
          } else if (serviceId == 4) {
            serviceName = "دورات تدريبية";
          } else if (serviceId == 3) {
            serviceName = "دروس خصوصية";
          } else if (serviceId == 2) {
            serviceName = "تعلم لغات";
          } else {
            serviceName = service;
          }
        } else {
          serviceName = service;
        }
      } catch (e) {
        serviceName = service;
      }
    }

    return {
      'id': id,
      'first_name': firstName,
      'last_name': lastName,
      'name': "${firstName ?? ""} ${lastName ?? ""}".trim(),
      'email': email,
      'phone_number': phoneNumber,
      'email_verified_at': emailVerifiedAt,
      'role_id': roleId,
      'gender': gender,
      'nationality': nationality?.toLowerCase(),
      'verification_code': verificationCode,
      'social_provider': socialProvider,
      'social_provider_id': socialProviderId,
      'is_active': isActive,
      'profile_image': profileImage,
      'reviews': reviews.map((r) => r.toJson()).toList(),
      'rating': rating,
      'bio': bio,
      'total_students': totalStudents,
      'years_experience': 0,
      'verified': verified,
      'service': serviceName,
      'available_times': availableTimesList,
      'available_times_map': availableTimesMap,
      'teach_individual': teachIndividual ? 1 : 0,
      'individual_hour_price': individualHourPrice,
      'teach_group': teachGroup ? 1 : 0,
      'group_hour_price': groupHourPrice,
      'max_group_size': maxGroupSize,
      'min_group_size': minGroupSize,
      'price_hour': individualHourPrice,
      'subject_category': subjectCategory,
      'education_level': educationLevel,
      'classes': classes,
      'teacher_levels': teacherLevels.map((l) => l.toJson()).toList(),
      'teacher_classes': teacherClassesList,
      'teacher_subjects': teacherSubjectsList,
      'languages': teacherLanguagesList,
      'courses': teacherCoursesList,
      'services': servicesList,
      'service_id': serviceId,
      'teach_languages': teacherLanguages.isNotEmpty ? 1 : 0,
    };
  }

  // CopyWith method for easy updates
  TeacherModel copyWith({
    int? id,
    String? firstName,
    String? lastName,
    String? email,
    String? phoneNumber,
    String? emailVerifiedAt,
    int? roleId,
    String? gender,
    String? nationality,
    String? verificationCode,
    String? socialProvider,
    String? socialProviderId,
    int? isActive,
    String? profileImage,
    List<Review>? reviews,
    double? rating,
    String? bio,
    int? totalStudents,
    bool? verified,
    String? service,
    List<AvailableDay>? availableTimes,
    bool? teachIndividual,
    double? individualHourPrice,
    bool? teachGroup,
    double? groupHourPrice,
    int? maxGroupSize,
    int? minGroupSize,
    List<TeacherLevel>? teacherLevels,
    List<TeacherClass>? teacherClasses,
    List<TeacherSubject>? teacherSubjects,
    List<TeacherLanguage>? teacherLanguages,
    List<TeacherCourse>? teacherCourses,

    List<TeacherService>? services,
    int? serviceId,
  }) {
    return TeacherModel(
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      emailVerifiedAt: emailVerifiedAt ?? this.emailVerifiedAt,
      roleId: roleId ?? this.roleId,
      gender: gender ?? this.gender,
      nationality: nationality ?? this.nationality,
      verificationCode: verificationCode ?? this.verificationCode,
      socialProvider: socialProvider ?? this.socialProvider,
      socialProviderId: socialProviderId ?? this.socialProviderId,
      isActive: isActive ?? this.isActive,
      profileImage: profileImage ?? this.profileImage,
      reviews: reviews ?? this.reviews,
      rating: rating ?? this.rating,
      bio: bio ?? this.bio,
      totalStudents: totalStudents ?? this.totalStudents,
      verified: verified ?? this.verified,
      service: service ?? this.service,
      availableTimes: availableTimes ?? this.availableTimes,
      teachIndividual: teachIndividual ?? this.teachIndividual,
      individualHourPrice: individualHourPrice ?? this.individualHourPrice,
      teachGroup: teachGroup ?? this.teachGroup,
      groupHourPrice: groupHourPrice ?? this.groupHourPrice,
      maxGroupSize: maxGroupSize ?? this.maxGroupSize,
      minGroupSize: minGroupSize ?? this.minGroupSize,
      teacherLevels: teacherLevels ?? this.teacherLevels,
      teacherClasses: teacherClasses ?? this.teacherClasses,
      teacherSubjects: teacherSubjects ?? this.teacherSubjects,
      teacherLanguages: teacherLanguages ?? this.teacherLanguages,
      teacherCourses: teacherCourses ?? this.teacherCourses,
      services: services ?? this.services,
      serviceId: serviceId ?? this.serviceId,
    );
  }
}

// ============================================
// Usage Example
// ============================================

/*
// Parse from JSON
final teacher = TeacherModel.fromJson(jsonData);

// Access data
print(teacher.fullName); // "meido momo"
print(teacher.individualHourPrice); // 100.0
print(teacher.availableTimes[0].day); // "الاحد"
print(teacher.availableTimes[0].times[0].time); // "5:00 PM"
print(teacher.teacherSubjects[0].title); // "رياضيات"

// Convert to JSON
final json = teacher.toJson();

// Update teacher
final updatedTeacher = teacher.copyWith(
  rating: 4.9,
  totalStudents: 125,
);
*/
