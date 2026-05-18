import 'package:flutter/material.dart';

class AppConstants {
  const AppConstants._();

  // App Mode: Set to true to use dummy data for testing
  static const bool useDummyData = true;

  static const String appName = 'Smart School';
  static const double defaultPadding = 16.0;
  static const double defaultRadius = 12.0;
  static const Color primaryColor = Color(0xFF2196F3);
  static const Color secondaryColor = Color(0xFFFF9800);
  static const Color successColor = Color(0xFF4CAF50);
  static const Color errorColor = Color(0xFFF44336);
  static const Color backgroundColor = Color(0xFFF5F5F5);
  static const Color cardColor = Color(0xFFFFFFFF);
  static const Color textColor = Color(0xFF212121);

  static const int connectTimeout = 30000;
  static const int receiveTimeout = 30000;

  // Asset Paths
  static const String logo = 'assets/images/logo.png';
  static const String logoWithName = 'assets/images/logowithname.png';
  static const String onboarding1 = 'assets/images/onboarding1.png';
  static const String onboarding2 = 'assets/images/onboarding2.png';
  static const String onboarding3 = 'assets/images/onboarding3.png';

  // Menu Icons
  static const String feesIcon = 'assets/images/fees.png';
  static const String attendanceIcon = 'assets/images/lessons.png';
  static const String marksIcon = 'assets/images/marks.png';
  static const String homeworkIcon = 'assets/images/homework.png';
  static const String timetableIcon = 'assets/images/lessons.png';
  static const String subjectsIcon = 'assets/images/subjects.png';
  static const String syllabusIcon = 'assets/images/subjects.png';
  static const String teachersIcon = 'assets/images/teachers.png';
  static const String chatIcon = 'assets/images/chat.png';
  static const String libraryIcon = 'assets/images/library.png';
  static const String transportIcon = 'assets/images/transport.png';
  static const String examsIcon = 'assets/images/exams.png';
  static const String onlineExamIcon = 'assets/images/onlineexams.png';
  static const String calendarIcon = 'assets/images/calender.png';
  static const String hostelIcon = 'assets/images/hostel.png';
  static const String visitorsIcon = 'assets/images/vistitors.png';
  static const String leaveIcon = 'assets/images/leave.png';
  static const String profileIcon = 'assets/images/profile.png';
}
