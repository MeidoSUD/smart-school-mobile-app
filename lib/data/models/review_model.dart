class ReviewModel {
  final int id;
  final int reviewerId;
  final int reviewedId;
  final int? sessionId;
  final int? courseId;
  final int rating;
  final String? comment;
  final DateTime createdAt;
  final DateTime updatedAt;
  final ReviewerModel? reviewer;
  final ReviewerModel? reviewedUser;
  final SessionModel? session;

  ReviewModel({
    required this.id,
    required this.reviewerId,
    required this.reviewedId,
    this.sessionId,
    this.courseId,
    required this.rating,
    this.comment,
    required this.createdAt,
    required this.updatedAt,
    this.reviewer,
    this.reviewedUser,
    this.session,
  });

  factory ReviewModel.fromJson(Map<String, dynamic> json) {
    return ReviewModel(
      id: json['id'] ?? 0,
      reviewerId: json['reviewer_id'] ?? 0,
      reviewedId: json['reviewed_id'] ?? 0,
      sessionId: json['session_id'],
      courseId: json['course_id'],
      rating: json['rating'] ?? 0,
      comment: json['comment'],
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : DateTime.now(),
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'])
          : DateTime.now(),
      reviewer: json['reviewer'] != null
          ? ReviewerModel.fromJson(json['reviewer'])
          : null,
      reviewedUser: json['reviewedUser'] != null
          ? ReviewerModel.fromJson(json['reviewedUser'])
          : null,
      session: json['session'] != null
          ? SessionModel.fromJson(json['session'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'reviewer_id': reviewerId,
      'reviewed_id': reviewedId,
      'session_id': sessionId,
      'course_id': courseId,
      'rating': rating,
      'comment': comment,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      if (reviewer != null) 'reviewer': reviewer!.toJson(),
      if (reviewedUser != null) 'reviewedUser': reviewedUser!.toJson(),
      if (session != null) 'session': session!.toJson(),
    };
  }
}

class ReviewerModel {
  final int id;
  final String name;
  final String? email;
  final String? profileImage;

  ReviewerModel({
    required this.id,
    required this.name,
    this.email,
    this.profileImage,
  });

  factory ReviewerModel.fromJson(Map<String, dynamic> json) {
    return ReviewerModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      email: json['email'],
      profileImage: json['profile_image'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'profile_image': profileImage,
    };
  }
}

class SessionModel {
  final int id;
  final String sessionTitle;
  final String sessionDate;
  final String status;
  final String? startTime;
  final String? endTime;

  SessionModel({
    required this.id,
    required this.sessionTitle,
    required this.sessionDate,
    required this.status,
    this.startTime,
    this.endTime,
  });

  factory SessionModel.fromJson(Map<String, dynamic> json) {
    return SessionModel(
      id: json['id'] ?? 0,
      sessionTitle: json['session_title'] ?? '',
      sessionDate: json['session_date'] ?? '',
      status: json['status'] ?? '',
      startTime: json['start_time'],
      endTime: json['end_time'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'session_title': sessionTitle,
      'session_date': sessionDate,
      'status': status,
      'start_time': startTime,
      'end_time': endTime,
    };
  }
}
