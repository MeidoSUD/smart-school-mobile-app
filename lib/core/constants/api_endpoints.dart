class ApiEndpoints {
  static const String baseUrl =
      'https://raise-occupied-impacts-cheats.trycloudflare.com/api';

  // Auth
  static const String login = '/auth/login';
  static const String logout = '/auth/logout';
  static const String changePassword = '/auth/changepass';

  // Dashboard & Profile
  static const String dashboard = '/user/dashboard';
  static const String profile = '/user/profile';

  // Fees
  static const String fees = '/user/fees';
  static const String getFees = '/user/getfees';

  // Attendance
  static const String attendance = '/attendence';
  static String getAttendance({String? start, String? end}) =>
      '$baseUrl/attendence/getAttendence?start=$start&end=$end';

  // Marks
  static const String marks = '/mark/marklist';

  // Homework
  static const String homework = '/homework';
  static String homeworkDetail(int id, int status) =>
      '$baseUrl/homework/homework_detail/$id/$status';
  static const String homeworkUpload = '/homework/upload_docs';

  // Timetable
  static const String timetable = '/timetable';

  // Subjects
  static const String subjects = '/subject';

  // Syllabus
  static const String syllabus = '/syllabus';
  static const String syllabusStatus = '/syllabus/status';

  // Teachers
  static const String teachers = '/teacher';
  static const String teacherRating = '/teacher/rating';

  // Notifications
  static const String notifications = '/notification';
  static const String notificationStatus = '/notification/updatestatus';

  // Chat
  static const String chatMyUser = '/chat/myuser';
  static const String chatRecord = '/chat/getChatRecord';
  static const String newMessage = '/chat/newMessage';

  // Leave
  static const String applyLeave = '/apply_leave';
  static const String addLeave = '/apply_leave/add';

  // Library
  static const String books = '/book';
  static const String bookIssue = '/book/issue';

  // Transport
  static const String route = '/route';

  // Content
  static const String contentStudyMaterial = '/content/studymaterial';

  // Exams
  static const String examResult = '/exam/examresult';
  static const String examSchedule = '/examschedule';

  // Visitors
  static const String visitors = '/visitors';

  // Calendar
  static const String calendarEvents = '/calendar/getevents';

  // Online Exam
  static const String onlineExam = '/onlineexam';
  static const String onlineExamSubmit = '/onlineexam/submit';

  // Hostel
  static const String hostel = '/hostel';
}
