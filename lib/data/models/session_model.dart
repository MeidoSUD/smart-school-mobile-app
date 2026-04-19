class SessionsResponse {
  bool? success;
  SessionsData? data;
  Pagination? pagination;

  SessionsResponse({this.success, this.data, this.pagination});

  SessionsResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? SessionsData.fromJson(json['data']) : null;
    pagination = json['pagination'] != null
        ? Pagination.fromJson(json['pagination'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    if (pagination != null) {
      data['pagination'] = pagination!.toJson();
    }
    return data;
  }
}

class SessionsData {
  int? currentPage;
  List<StudentSession>? data;
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  List<Links>? links;
  String? nextPageUrl;
  String? path;
  int? perPage;
  String? prevPageUrl;
  int? to;
  int? total;

  SessionsData({
    this.currentPage,
    this.data,
    this.firstPageUrl,
    this.from,
    this.lastPage,
    this.lastPageUrl,
    this.links,
    this.nextPageUrl,
    this.path,
    this.perPage,
    this.prevPageUrl,
    this.to,
    this.total,
  });

  SessionsData.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = <StudentSession>[];
      json['data'].forEach((v) {
        data!.add(StudentSession.fromJson(v));
      });
    }
    firstPageUrl = json['first_page_url'];
    from = json['from'];
    lastPage = json['last_page'];
    lastPageUrl = json['last_page_url'];
    if (json['links'] != null) {
      links = <Links>[];
      json['links'].forEach((v) {
        links!.add(Links.fromJson(v));
      });
    }
    nextPageUrl = json['next_page_url'];
    path = json['path'];
    perPage = json['per_page'];
    prevPageUrl = json['prev_page_url'];
    to = json['to'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['current_page'] = currentPage;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['first_page_url'] = firstPageUrl;
    data['from'] = from;
    data['last_page'] = lastPage;
    data['last_page_url'] = lastPageUrl;
    if (links != null) {
      data['links'] = links!.map((v) => v.toJson()).toList();
    }
    data['next_page_url'] = nextPageUrl;
    data['path'] = path;
    data['per_page'] = perPage;
    data['prev_page_url'] = prevPageUrl;
    data['to'] = to;
    data['total'] = total;
    return data;
  }
}

class StudentSession {
  int? id;
  int? bookingId;
  int? sessionNumber;
  String? sessionTitle;
  String? sessionDate;
  String? dayName;
  int? dayNumber;
  String? startTime;
  String? endTime;
  int? duration;
  String? status;
  SessionUser? teacher;
  SessionUser? student;
  SessionMeeting? meeting;
  SessionSubject? subject;
  SessionBooking? booking;
  SessionInfo? sessionInfo;
  SessionRatings? ratings;

  StudentSession({
    this.id,
    this.bookingId,
    this.sessionNumber,
    this.sessionTitle,
    this.sessionDate,
    this.dayName,
    this.dayNumber,
    this.startTime,
    this.endTime,
    this.duration,
    this.status,
    this.teacher,
    this.student,
    this.meeting,
    this.subject,
    this.booking,
    this.sessionInfo,
    this.ratings,
  });

  StudentSession.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    bookingId = json['booking_id'];
    sessionNumber = json['session_number'];
    sessionTitle = json['session_title'];
    sessionDate = json['session_date'];
    dayName = json['day_name'];
    dayNumber = json['day_number'];
    startTime = json['start_time'];
    endTime = json['end_time'];
    duration = json['duration'];
    status = json['status'];
    teacher = json['teacher'] != null
        ? SessionUser.fromJson(json['teacher'])
        : null;
    student = json['student'] != null
        ? SessionUser.fromJson(json['student'])
        : null;
    meeting = json['meeting'] != null
        ? SessionMeeting.fromJson(json['meeting'])
        : null;
    subject = json['subject'] != null
        ? SessionSubject.fromJson(json['subject'])
        : null;
    booking = json['booking'] != null
        ? SessionBooking.fromJson(json['booking'])
        : null;
    sessionInfo = json['session_info'] != null
        ? SessionInfo.fromJson(json['session_info'])
        : null;
    ratings = json['ratings'] != null
        ? SessionRatings.fromJson(json['ratings'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['booking_id'] = bookingId;
    data['session_number'] = sessionNumber;
    data['session_title'] = sessionTitle;
    data['session_date'] = sessionDate;
    data['day_name'] = dayName;
    data['day_number'] = dayNumber;
    data['start_time'] = startTime;
    data['end_time'] = endTime;
    data['duration'] = duration;
    data['status'] = status;
    if (teacher != null) {
      data['teacher'] = teacher!.toJson();
    }
    if (student != null) {
      data['student'] = student!.toJson();
    }
    if (meeting != null) {
      data['meeting'] = meeting!.toJson();
    }
    if (subject != null) {
      data['subject'] = subject!.toJson();
    }
    if (booking != null) {
      data['booking'] = booking!.toJson();
    }
    if (sessionInfo != null) {
      data['session_info'] = sessionInfo!.toJson();
    }
    if (ratings != null) {
      data['ratings'] = ratings!.toJson();
    }
    return data;
  }
}

class SessionUser {
  int? id;
  String? name;
  String? email;

  SessionUser({this.id, this.name, this.email});

  SessionUser.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['email'] = email;
    return data;
  }
}

class SessionMeeting {
  String? meetingId;
  String? joinUrl;
  String? hostUrl;

  SessionMeeting({this.meetingId, this.joinUrl, this.hostUrl});

  SessionMeeting.fromJson(Map<String, dynamic> json) {
    meetingId = json['meeting_id'];
    joinUrl = json['join_url'];
    hostUrl = json['host_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['meeting_id'] = meetingId;
    data['join_url'] = joinUrl;
    data['host_url'] = hostUrl;
    return data;
  }
}

class SessionSubject {
  int? id;
  String? nameEn;
  String? nameAr;

  SessionSubject({this.id, this.nameEn, this.nameAr});

  SessionSubject.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nameEn = json['name_en'];
    nameAr = json['name_ar'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name_en'] = nameEn;
    data['name_ar'] = nameAr;
    return data;
  }
}

class SessionBooking {
  int? id;
  String? reference;
  String? type;
  int? totalSessions;
  int? completedSessions;

  SessionBooking({
    this.id,
    this.reference,
    this.type,
    this.totalSessions,
    this.completedSessions,
  });

  SessionBooking.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    reference = json['reference'];
    type = json['type'];
    totalSessions = json['total_sessions'];
    completedSessions = json['completed_sessions'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['reference'] = reference;
    data['type'] = type;
    data['total_sessions'] = totalSessions;
    data['completed_sessions'] = completedSessions;
    return data;
  }
}

class SessionInfo {
  String? startedAt;
  String? endedAt;
  String? teacherNotes;
  String? homework;
  String? materialsShared;

  SessionInfo({
    this.startedAt,
    this.endedAt,
    this.teacherNotes,
    this.homework,
    this.materialsShared,
  });

  SessionInfo.fromJson(Map<String, dynamic> json) {
    startedAt = json['started_at'];
    endedAt = json['ended_at'];
    teacherNotes = json['teacher_notes'];
    homework = json['homework'];
    materialsShared = json['materials_shared'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['started_at'] = startedAt;
    data['ended_at'] = endedAt;
    data['teacher_notes'] = teacherNotes;
    data['homework'] = homework;
    data['materials_shared'] = materialsShared;
    return data;
  }
}

class SessionRatings {
  double? studentRating;
  double? teacherRating;

  SessionRatings({this.studentRating, this.teacherRating});

  SessionRatings.fromJson(Map<String, dynamic> json) {
    studentRating = json['student_rating'] != null
        ? double.tryParse(json['student_rating'].toString())
        : null;
    teacherRating = json['teacher_rating'] != null
        ? double.tryParse(json['teacher_rating'].toString())
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['student_rating'] = studentRating;
    data['teacher_rating'] = teacherRating;
    return data;
  }
}

class Links {
  String? url;
  String? label;
  bool? active;

  Links({this.url, this.label, this.active});

  Links.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    label = json['label'];
    active = json['active'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['url'] = url;
    data['label'] = label;
    data['active'] = active;
    return data;
  }
}

class Pagination {
  int? currentPage;
  int? lastPage;
  int? perPage;
  int? total;

  Pagination({this.currentPage, this.lastPage, this.perPage, this.total});

  Pagination.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    lastPage = json['last_page'];
    perPage = json['per_page'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['current_page'] = currentPage;
    data['last_page'] = lastPage;
    data['per_page'] = perPage;
    data['total'] = total;
    return data;
  }
}
