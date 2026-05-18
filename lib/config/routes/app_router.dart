import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../routes/route_keys.dart';
import '../../features/auth/presentation/screens/login_screen.dart';
import '../../features/home/presentation/screens/home_screen.dart';
import '../../features/splash/presentation/screens/splash_screen.dart';
import '../../features/dashboard/presentation/screens/dashboard_screen.dart';
import '../../features/fees/presentation/screens/fees_screen.dart';
import '../../features/attendance/presentation/screens/attendance_screen.dart';
import '../../features/homework/presentation/screens/homework_screen.dart';
import '../../features/timetable/presentation/screens/timetable_screen.dart';
import '../../features/subjects/presentation/screens/subjects_screen.dart';
import '../../features/syllabus/presentation/screens/syllabus_screen.dart';
import '../../features/teachers/presentation/screens/teachers_screen.dart';
import '../../features/exams/presentation/screens/exams_screen.dart';
import '../../features/chat/presentation/screens/chat_screen.dart';
import '../../features/library/presentation/screens/library_screen.dart';
import '../../features/transport/presentation/screens/transport_screen.dart';
import '../../features/leave/presentation/screens/leave_screen.dart';
import '../../features/visitors/presentation/screens/visitors_screen.dart';
import '../../features/hostel/presentation/screens/hostel_screen.dart';
import '../../features/online_exam/presentation/screens/online_exam_screen.dart';
import '../../features/calendar/presentation/screens/calendar_screen.dart';
import '../../features/admission/presentation/screens/admission_screen.dart';
import '../../features/profile/presentation/screens/profile_screen.dart';
import '../../features/settings/presentation/screens/settings_screen.dart';

final GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>();

final appRouter = GoRouter(
  navigatorKey: rootNavigatorKey,
  initialLocation: RouteKeys.splash,
  routes: [
    GoRoute(
      path: RouteKeys.splash,
      name: RouteKeys.splash,
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: RouteKeys.login,
      name: RouteKeys.login,
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: RouteKeys.home,
      name: RouteKeys.home,
      builder: (context, state) => const HomeScreen(),
      routes: [
        GoRoute(
          path: RouteKeys.dashboard,
          name: RouteKeys.dashboard,
          builder: (context, state) => const DashboardScreen(),
        ),
        GoRoute(
          path: RouteKeys.profile,
          name: RouteKeys.profile,
          builder: (context, state) => const ProfileScreen(),
        ),
        GoRoute(
          path: RouteKeys.fees,
          name: RouteKeys.fees,
          builder: (context, state) => const FeesScreen(),
        ),
        GoRoute(
          path: RouteKeys.attendance,
          name: RouteKeys.attendance,
          builder: (context, state) => const AttendanceScreen(),
        ),
        GoRoute(
          path: RouteKeys.homework,
          name: RouteKeys.homework,
          builder: (context, state) => const HomeworkScreen(),
        ),
        GoRoute(
          path: RouteKeys.timetable,
          name: RouteKeys.timetable,
          builder: (context, state) => const TimetableScreen(),
        ),
        GoRoute(
          path: RouteKeys.subjects,
          name: RouteKeys.subjects,
          builder: (context, state) => const SubjectsScreen(),
        ),
        GoRoute(
          path: RouteKeys.syllabus,
          name: RouteKeys.syllabus,
          builder: (context, state) => const SyllabusScreen(),
        ),
        GoRoute(
          path: RouteKeys.teachers,
          name: RouteKeys.teachers,
          builder: (context, state) => const TeachersScreen(),
        ),
        GoRoute(
          path: RouteKeys.exams,
          name: RouteKeys.exams,
          builder: (context, state) => const ExamsScreen(),
        ),
        GoRoute(
          path: RouteKeys.chat,
          name: RouteKeys.chat,
          builder: (context, state) => const ChatScreen(),
        ),
        GoRoute(
          path: RouteKeys.library,
          name: RouteKeys.library,
          builder: (context, state) => const LibraryScreen(),
        ),
        GoRoute(
          path: RouteKeys.transport,
          name: RouteKeys.transport,
          builder: (context, state) => const TransportScreen(),
        ),
        GoRoute(
          path: RouteKeys.leave,
          name: RouteKeys.leave,
          builder: (context, state) => const LeaveScreen(),
        ),
        GoRoute(
          path: RouteKeys.visitors,
          name: RouteKeys.visitors,
          builder: (context, state) => const VisitorsScreen(),
        ),
        GoRoute(
          path: RouteKeys.hostel,
          name: RouteKeys.hostel,
          builder: (context, state) => const HostelScreen(),
        ),
        GoRoute(
          path: RouteKeys.onlineExam,
          name: RouteKeys.onlineExam,
          builder: (context, state) => const OnlineExamScreen(),
        ),
        GoRoute(
          path: RouteKeys.calendar,
          name: RouteKeys.calendar,
          builder: (context, state) => const CalendarScreen(),
        ),
        GoRoute(
          path: RouteKeys.admission,
          name: RouteKeys.admission,
          builder: (context, state) => const AdmissionScreen(),
        ),
        GoRoute(
          path: RouteKeys.settings,
          name: RouteKeys.settings,
          builder: (context, state) => const SettingsScreen(),
        ),
      ],
    ),
  ],
);
