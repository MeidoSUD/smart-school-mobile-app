class LoginResponse {
  final String? token;
  final String? refreshToken;
  final LmsUserModel? user;
  final String status;
  final String? message;

  LoginResponse({
    this.token,
    this.refreshToken,
    this.user,
    this.status = 'success',
    this.message,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    final rawData = json['data'];
    final Map<String, dynamic>? data = rawData is Map<String, dynamic> ? rawData : null;
    
    return LoginResponse(
      token: data?['token']?.toString(),
      refreshToken: data?['refresh_token']?.toString(),
      user: data?['user'] is Map<String, dynamic> 
          ? LmsUserModel.fromJson(data!['user'] as Map<String, dynamic>) 
          : null,
      status: json['status']?.toString() ?? 'success',
      message: json['message']?.toString(),
    );
  }
}

class LmsUserModel {
  final int id;
  final String role;
  final String firstname;
  final String lastname;
  final String? email;
  final String? phone;
  final String? photo;
  final String? gender;
  final String? nationality;
  final String? studentId;
  final String? parentPhone;

  LmsUserModel({
    required this.id,
    required this.role,
    required this.firstname,
    required this.lastname,
    this.email,
    this.phone,
    this.photo,
    this.gender,
    this.nationality,
    this.studentId,
    this.parentPhone,
  });

  factory LmsUserModel.fromJson(Map<String, dynamic> json) {
    return LmsUserModel(
      id: int.tryParse(json['id']?.toString() ?? '0') ?? 0,
      role: json['role'] ?? '',
      firstname: json['firstname'] ?? '',
      lastname: json['lastname'] ?? '',
      email: json['email'],
      phone: json['phone'],
      photo: json['photo'],
      gender: json['gender'],
      nationality: json['nationality'],
      studentId: json['student_id'],
      parentPhone: json['parent_phone'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'role': role,
      'firstname': firstname,
      'lastname': lastname,
      if (email != null) 'email': email,
      if (phone != null) 'phone': phone,
      if (photo != null) 'photo': photo,
      if (gender != null) 'gender': gender,
      if (nationality != null) 'nationality': nationality,
      if (studentId != null) 'student_id': studentId,
      if (parentPhone != null) 'parent_phone': parentPhone,
    };
  }

  String get fullName => '$firstname $lastname';
}

class DashboardModel {
  final int attendancePercentage;
  final List<HomeworkModel> homeworkList;
  final List<NotificationModel> notificationList;
  final Map<String, dynamic> subjectsData;
  final Map<String, dynamic> timetable;
  final List<VisitorModel> visitorList;
  final List<BookModel> bookList;
  final List<TeacherModel> teacherList;

  DashboardModel({
    required this.attendancePercentage,
    required this.homeworkList,
    required this.notificationList,
    required this.subjectsData,
    required this.timetable,
    required this.visitorList,
    required this.bookList,
    required this.teacherList,
  });

  factory DashboardModel.fromJson(Map<String, dynamic> json) {
    final data = json['data'] as Map<String, dynamic>?;
    return DashboardModel(
      attendancePercentage: data?['attendence_percentage'] ?? 0,
      homeworkList: (data?['homeworklist'] as List?)
              ?.map((e) => HomeworkModel.fromJson(e))
              .toList() ??
          [],
      notificationList: (data?['notificationlist'] as List?)
              ?.map((e) => NotificationModel.fromJson(e))
              .toList() ??
          [],
      subjectsData: data?['subjects_data'] ?? {},
      timetable: data?['timetable'] ?? {},
      visitorList: (data?['visitor_list'] as List?)
              ?.map((e) => VisitorModel.fromJson(e))
              .toList() ??
          [],
      bookList: (data?['bookList'] as List?)
              ?.map((e) => BookModel.fromJson(e))
              .toList() ??
          [],
      teacherList: (data?['teacherlist'] as List?)
              ?.map((e) => TeacherModel.fromJson(e))
              .toList() ??
          [],
    );
  }
}

class HomeworkModel {
  final int id;
  final String title;
  final String? description;
  final String? subject;
  final String? dueDate;
  final String? status;
  final String? createdAt;

  HomeworkModel({
    required this.id,
    required this.title,
    this.description,
    this.subject,
    this.dueDate,
    this.status,
    this.createdAt,
  });

  factory HomeworkModel.fromJson(Map<String, dynamic> json) {
    return HomeworkModel(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      description: json['description'],
      subject: json['subject'],
      dueDate: json['due_date'],
      status: json['status'],
      createdAt: json['created_at'],
    );
  }
}

class NotificationModel {
  final int id;
  final String title;
  final String? message;
  final String? date;
  final bool isRead;

  NotificationModel({
    required this.id,
    required this.title,
    this.message,
    this.date,
    this.isRead = false,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      message: json['message'],
      date: json['date'],
      isRead: json['is_read'] ?? false,
    );
  }
}

class TeacherModel {
  final int id;
  final String name;
  final String? photo;
  final String? subject;
  final String? phone;
  final double rating;

  TeacherModel({
    required this.id,
    required this.name,
    this.photo,
    this.subject,
    this.phone,
    this.rating = 0,
  });

  factory TeacherModel.fromJson(Map<String, dynamic> json) {
    return TeacherModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      photo: json['photo'],
      subject: json['subject'],
      phone: json['phone'],
      rating: (json['rate'] ?? json['rating'] ?? 0).toDouble(),
    );
  }
}

class VisitorModel {
  final int id;
  final String name;
  final String? reason;
  final String? visitDate;
  final String? phone;

  VisitorModel({
    required this.id,
    required this.name,
    this.reason,
    this.visitDate,
    this.phone,
  });

  factory VisitorModel.fromJson(Map<String, dynamic> json) {
    return VisitorModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      reason: json['reason'],
      visitDate: json['visit_date'],
      phone: json['phone'],
    );
  }
}

class BookModel {
  final int id;
  final String title;
  final String? author;
  final String? issueDate;
  final String? returnDate;

  BookModel({
    required this.id,
    required this.title,
    this.author,
    this.issueDate,
    this.returnDate,
  });

  factory BookModel.fromJson(Map<String, dynamic> json) {
    return BookModel(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      author: json['author'],
      issueDate: json['issue_date'],
      returnDate: json['return_date'],
    );
  }
}

class AttendanceModel {
  final int id;
  final String date;
  final String status;
  final String? remark;

  AttendanceModel({
    required this.id,
    required this.date,
    required this.status,
    this.remark,
  });

  factory AttendanceModel.fromJson(Map<String, dynamic> json) {
    return AttendanceModel(
      id: json['id'] ?? 0,
      date: json['date'] ?? '',
      status: json['status'] ?? '',
      remark: json['remark'],
    );
  }
}

class FeeModel {
  final int id;
  final String title;
  final double amount;
  final String? dueDate;
  final String? status;
  final String? description;

  FeeModel({
    required this.id,
    required this.title,
    required this.amount,
    this.dueDate,
    this.status,
    this.description,
  });

  factory FeeModel.fromJson(Map<String, dynamic> json) {
    return FeeModel(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      amount: (json['amount'] ?? 0).toDouble(),
      dueDate: json['due_date'],
      status: json['status'],
      description: json['description'],
    );
  }
}

class MarkModel {
  final int id;
  final String subject;
  final double? marks;
  final double? totalMarks;
  final String? grade;
  final String? examType;

  MarkModel({
    required this.id,
    required this.subject,
    this.marks,
    this.totalMarks,
    this.grade,
    this.examType,
  });

  factory MarkModel.fromJson(Map<String, dynamic> json) {
    return MarkModel(
      id: json['id'] ?? 0,
      subject: json['subject'] ?? '',
      marks: json['marks']?.toDouble(),
      totalMarks: json['total_marks']?.toDouble(),
      grade: json['grade'],
      examType: json['exam_type'],
    );
  }
}

class SubjectModel {
  final int id;
  final String name;
  final String? code;
  final String? teacher;

  SubjectModel({
    required this.id,
    required this.name,
    this.code,
    this.teacher,
  });

  factory SubjectModel.fromJson(Map<String, dynamic> json) {
    return SubjectModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      code: json['code'],
      teacher: json['teacher'],
    );
  }
}

class SyllabusModel {
  final int id;
  final String subject;
  final String? topic;
  final String? status;

  SyllabusModel({
    required this.id,
    required this.subject,
    this.topic,
    this.status,
  });

  factory SyllabusModel.fromJson(Map<String, dynamic> json) {
    return SyllabusModel(
      id: json['id'] ?? 0,
      subject: json['subject'] ?? '',
      topic: json['topic'],
      status: json['status'],
    );
  }
}

class TimetableModel {
  final int id;
  final String day;
  final String subject;
  final String time;
  final String? room;

  TimetableModel({
    required this.id,
    required this.day,
    required this.subject,
    required this.time,
    this.room,
  });

  factory TimetableModel.fromJson(Map<String, dynamic> json) {
    return TimetableModel(
      id: json['id'] ?? 0,
      day: json['day'] ?? '',
      subject: json['subject'] ?? '',
      time: json['time'] ?? '',
      room: json['room'],
    );
  }
}

class LeaveModel {
  final int id;
  final String fromDate;
  final String toDate;
  final String? reason;
  final String status;
  final String? appliedDate;

  LeaveModel({
    required this.id,
    required this.fromDate,
    required this.toDate,
    this.reason,
    this.status = 'pending',
    this.appliedDate,
  });

  factory LeaveModel.fromJson(Map<String, dynamic> json) {
    return LeaveModel(
      id: json['id'] ?? 0,
      fromDate: json['from_date'] ?? '',
      toDate: json['to_date'] ?? '',
      reason: json['reason'],
      status: json['status'] ?? 'pending',
      appliedDate: json['applied_date'],
    );
  }
}

class ChatUserModel {
  final int id;
  final String name;
  final String? photo;
  final String? lastMessage;
  final String? time;

  ChatUserModel({
    required this.id,
    required this.name,
    this.photo,
    this.lastMessage,
    this.time,
  });

  factory ChatUserModel.fromJson(Map<String, dynamic> json) {
    return ChatUserModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      photo: json['photo'],
      lastMessage: json['last_message'],
      time: json['time'],
    );
  }
}

class ChatMessageModel {
  final int id;
  final String message;
  final String sender;
  final String time;
  final bool isMe;

  ChatMessageModel({
    required this.id,
    required this.message,
    required this.sender,
    required this.time,
    this.isMe = false,
  });

  factory ChatMessageModel.fromJson(Map<String, dynamic> json) {
    return ChatMessageModel(
      id: json['id'] ?? 0,
      message: json['message'] ?? '',
      sender: json['sender'] ?? '',
      time: json['time'] ?? '',
      isMe: json['is_me'] ?? false,
    );
  }
}

class TransportModel {
  final String route;
  final String? driverName;
  final String? driverPhone;
  final String? busNumber;
  final String? pickupTime;
  final String? pickupPoint;

  TransportModel({
    required this.route,
    this.driverName,
    this.driverPhone,
    this.busNumber,
    this.pickupTime,
    this.pickupPoint,
  });

  factory TransportModel.fromJson(Map<String, dynamic> json) {
    return TransportModel(
      route: json['route'] ?? '',
      driverName: json['driver_name'],
      driverPhone: json['driver_phone'],
      busNumber: json['bus_number'],
      pickupTime: json['pickup_time'],
      pickupPoint: json['pickup_point'],
    );
  }
}

class ExamModel {
  final int id;
  final String subject;
  final String? date;
  final String? time;
  final String? room;

  ExamModel({
    required this.id,
    required this.subject,
    this.date,
    this.time,
    this.room,
  });

  factory ExamModel.fromJson(Map<String, dynamic> json) {
    return ExamModel(
      id: json['id'] ?? 0,
      subject: json['subject'] ?? '',
      date: json['date'],
      time: json['time'],
      room: json['room'],
    );
  }
}

class ExamResultModel {
  final int id;
  final String subject;
  final double marks;
  final double totalMarks;
  final String grade;
  final String? remarks;

  ExamResultModel({
    required this.id,
    required this.subject,
    required this.marks,
    required this.totalMarks,
    required this.grade,
    this.remarks,
  });

  factory ExamResultModel.fromJson(Map<String, dynamic> json) {
    return ExamResultModel(
      id: json['id'] ?? 0,
      subject: json['subject'] ?? '',
      marks: (json['marks'] ?? 0).toDouble(),
      totalMarks: (json['total_marks'] ?? 100).toDouble(),
      grade: json['grade'] ?? '',
      remarks: json['remarks'],
    );
  }
}

class CalendarEventModel {
  final int id;
  final String title;
  final String? description;
  final String date;
  final String? time;

  CalendarEventModel({
    required this.id,
    required this.title,
    this.description,
    required this.date,
    this.time,
  });

  factory CalendarEventModel.fromJson(Map<String, dynamic> json) {
    return CalendarEventModel(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      description: json['description'],
      date: json['date'] ?? '',
      time: json['time'],
    );
  }
}

class HostelModel {
  final String name;
  final String? roomNumber;
  final String? block;
  final String? bedNumber;

  HostelModel({
    required this.name,
    this.roomNumber,
    this.block,
    this.bedNumber,
  });

  factory HostelModel.fromJson(Map<String, dynamic> json) {
    return HostelModel(
      name: json['name'] ?? '',
      roomNumber: json['room_number'],
      block: json['block'],
      bedNumber: json['bed_number'],
    );
  }
}

class OnlineExamModel {
  final int id;
  final String title;
  final String? subject;
  final int? duration;
  final int? totalQuestions;
  final String? status;

  OnlineExamModel({
    required this.id,
    required this.title,
    this.subject,
    this.duration,
    this.totalQuestions,
    this.status,
  });

  factory OnlineExamModel.fromJson(Map<String, dynamic> json) {
    return OnlineExamModel(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      subject: json['subject'],
      duration: json['duration'],
      totalQuestions: json['total_questions'],
      status: json['status'],
    );
  }
}

class ContentModel {
  final int id;
  final String title;
  final String type;
  final String? fileUrl;
  final String? description;

  ContentModel({
    required this.id,
    required this.title,
    required this.type,
    this.fileUrl,
    this.description,
  });

  factory ContentModel.fromJson(Map<String, dynamic> json) {
    return ContentModel(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      type: json['type'] ?? '',
      fileUrl: json['file_url'],
      description: json['description'],
    );
  }
}