import 'package:flutter/material.dart';

import '../../presentation/screens/lms/login_screen.dart';
import '../../presentation/screens/lms/lms_home_screen.dart';
import '../../presentation/screens/lms/lms_dashboard_screen.dart';
import '../../presentation/screens/lms/lms_fees_screen.dart';
import '../../presentation/screens/lms/lms_homework_screen.dart';
import '../../presentation/screens/lms/lms_timetable_screen.dart';
import '../../presentation/screens/lms/lms_subjects_screen.dart';
import '../../presentation/screens/lms/lms_syllabus_screen.dart';
import '../../presentation/screens/lms/lms_teachers_screen.dart';
import '../../presentation/screens/lms/lms_library_screen.dart';
import '../../presentation/screens/lms/lms_transport_screen.dart';
import '../../presentation/screens/lms/lms_exams_screen.dart';
import '../../presentation/screens/lms/lms_calendar_screen.dart';
import '../../presentation/screens/lms/lms_online_exam_screen.dart';
import '../../presentation/screens/lms/lms_hostel_screen.dart';
import '../../presentation/screens/lms/lms_visitors_screen.dart';
import '../../presentation/screens/lms/lms_leave_screen.dart';
import '../../presentation/screens/lms/lms_chat_screen.dart';
import '../../presentation/screens/lms/lms_profile_screen.dart';
import '../../presentation/screens/lms/lms_admission_screen.dart';
import 'app_routes.dart';

class AppRouter {
  static Map<String, WidgetBuilder> routes = {
    AppRoutes.lmsLogin: (context) => const LmsLoginScreen(),
    AppRoutes.lmsHome: (context) => const LmsHomeScreen(),
    AppRoutes.lmsDashboard: (context) => const LmsDashboardScreen(),
    AppRoutes.lmsFees: (context) => const LmsFeesScreen(),
    AppRoutes.lmsAttendance: (context) => const LmsAttendanceScreen(),
    AppRoutes.lmsMarks: (context) => const LmsMarksScreen(),
    AppRoutes.lmsHomework: (context) => const LmsHomeworkScreen(),
    AppRoutes.lmsTimetable: (context) => const LmsTimetableScreen(),
    AppRoutes.lmsSubjects: (context) => const LmsSubjectsScreen(),
    AppRoutes.lmsSyllabus: (context) => const LmsSyllabusScreen(),
    AppRoutes.lmsTeachers: (context) => const LmsTeachersScreen(),
    AppRoutes.lmsLibrary: (context) => const LmsLibraryScreen(),
    AppRoutes.lmsTransport: (context) => const LmsTransportScreen(),
    AppRoutes.lmsExams: (context) => const LmsExamsScreen(),
    AppRoutes.lmsCalendar: (context) => const LmsCalendarScreen(),
    AppRoutes.lmsOnlineExam: (context) => const LmsOnlineExamScreen(),
    AppRoutes.lmsHostel: (context) => const LmsHostelScreen(),
    AppRoutes.lmsVisitors: (context) => const LmsVisitorsScreen(),
    AppRoutes.lmsLeave: (context) => const LmsLeaveScreen(),
    AppRoutes.lmsChat: (context) => const LmsChatListScreen(),
    AppRoutes.lmsProfile: (context) => const LmsProfileScreen(),
    AppRoutes.lmsAdmission: (context) => const LmsAdmissionScreen(),
  };
}