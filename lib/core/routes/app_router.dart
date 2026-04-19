import 'package:flutter/material.dart';

import '../../presentation/screens/auth/login_screen.dart';
import '../../presentation/screens/auth/register_screen.dart';
import '../../presentation/screens/auth/teacher_complete_profile_screen.dart';
import '../../presentation/screens/courses/add_course_screen.dart';
import '../../presentation/screens/auth/roles_screen.dart';
import '../../presentation/screens/auth/send_phone_number_screen.dart';
import '../../presentation/screens/booking/bookings_screen.dart';
import '../../presentation/screens/common/web_view_screen.dart';
import '../../presentation/screens/courses/courses_manage_screen.dart';
import '../../presentation/screens/courses/courses_screen.dart';
import '../../presentation/screens/courses/course_categories_screen.dart';
import '../../presentation/screens/courses/edit_course_screen.dart';
import '../../data/models/course_model.dart';
import '../../presentation/screens/home/home_screen.dart';
import '../../presentation/screens/lessons/lessons_screen.dart';
import '../../presentation/screens/lessons/my_lessons_screen.dart';
import '../../presentation/screens/lessons_managements/lessons_manage_screen.dart';
import '../../presentation/screens/lessons_managements/levels_manage_screen.dart';
import '../../presentation/screens/notifications/notifications_screen.dart';
import '../../presentation/screens/onboarding/onboarding_screen.dart';
import '../../presentation/screens/payment/payment_method_manage_screen.dart';
import '../../presentation/screens/payment/profit_manage_screen.dart';
import '../../presentation/screens/profile/edit_profile_screen.dart';
import '../../presentation/screens/change_password/change_password_screen.dart';
import '../../presentation/screens/schedule/schedule_screen.dart';
import '../../presentation/screens/set_password/set_new_password_screen.dart';
import '../../presentation/screens/splash/splash_screen.dart';
import '../../presentation/screens/student_orders/student_orders_screen.dart';
import '../../presentation/screens/teacher_orders/teacher_orders_screen.dart';
import '../../presentation/screens/languages/languages_manage_screen.dart';
import '../../presentation/screens/settings/about_screen.dart';
import 'app_routes.dart';

class AppRouter {
  static Map<String, WidgetBuilder> routes = {
    AppRoutes.home: (context) => const HomeScreen(),
    AppRoutes.login: (context) => const LoginScreen(),
    AppRoutes.onboarding: (context) => const OnboardingScreen(),
    AppRoutes.splash: (context) => const SplashScreen(),
    AppRoutes.register: (context) => const RegisterScreen(),
    AppRoutes.lessons: (context) => const LessonsScreen(),
    AppRoutes.courses: (context) {
      final args = ModalRoute.of(context)?.settings.arguments;
      int? categoryId;
      if (args != null && args is Map<String, dynamic>) {
        categoryId = args['categoryId'] as int?;
      }
      return CoursesScreen(categoryId: categoryId);
    },
    AppRoutes.orders: (context) => const TeacherOrdersScreen(),
    AppRoutes.myLessons: (context) => const MyLessonsScreen(),
    AppRoutes.editProfile: (context) => const EditProfileScreen(),
    AppRoutes.editPassword: (context) => const SetNewPasswordScreen(),
    AppRoutes.changePassword: (context) => const ChangePasswordScreen(),
    AppRoutes.roles: (context) => const RolesScreen(),
    AppRoutes.levelsManage: (context) => const SubjectsManageScreen(),
    AppRoutes.lessonsManage: (context) => const LessonsManageScreen(),
    AppRoutes.scheduleManage: (context) => const ScheduleScreen(),
    AppRoutes.coursesManage: (context) => const CoursesManageScreen(),
    AppRoutes.profitManage: (context) => const ProfitManageScreen(),
    AppRoutes.paymentManage: (context) => const PaymentMethodManageScreen(),
    AppRoutes.sendPhone: (context) => const SendPhoneNumberScreen(),
    AppRoutes.notifications: (context) => const NotificationsScreen(),
    AppRoutes.webview: (context) => const WebViewScreen(),
    AppRoutes.bookings: (context) => const BookingsScreen(),
    AppRoutes.studentOrders: (context) => const StudentOrdersScreen(),
    AppRoutes.addCourse: (context) => const AddCourseScreen(),
    AppRoutes.courseCategories: (context) => const CourseCategoriesScreen(),
    AppRoutes.editCourse: (context) {
      final course = ModalRoute.of(context)!.settings.arguments as Course;
      return EditCourseScreen(course: course);
    },
    AppRoutes.languagesManage: (context) => const LanguagesManageScreen(),
    AppRoutes.about: (context) => const AboutScreen(),
    AppRoutes.teacherCompleteProfile: (context) =>
        const TeacherCompleteProfileScreen(),
  };
}
