class ApiEndpoints {
  static const String URL =
      "https://portal.ewan-geniuses.com"; // for Android emulator
  // static const String URL =
  //     "https://rural-chip-violation-generator.trycloudflare.com";
  // static const String URL = "https://vernice-narial-gustily.ngrok-free.dev";
  //static const String URL = "https://vernice-narial-gustily.ngrok-free.dev";
  static const String baseUrl = "$URL/api"; // replace with Laravel endpoint

  // Auth
  static const String login = "$baseUrl/auth/login";
  static const String register = "$baseUrl/auth/register";
  static const String registerTeacher = "$baseUrl/auth/register-teacher";
  static const String registerStudent = "$baseUrl/auth/register-student";
  static const String verify = "$baseUrl/auth/verify";
  static const String resendCode = "$baseUrl/auth/resend-code";
  static const String sendCode = "$baseUrl/auth/reset-password";
  static const String verifyResetCode = "$baseUrl/auth/verify-reset-code";
  static const String confirmPassword = "$baseUrl/auth/confirm-password";
  static const String changePassword = "$baseUrl/auth/change-password";
  static const String logout = "$baseUrl/auth/logout";
  static const String getUser = "$baseUrl/auth/user/details";
  static const String updateProfile = "$baseUrl/profile/profile/update";
  static const String getProfile = "$baseUrl/profile/profile";
  static const String createProfile = "$baseUrl/profile/profile";
  static const String deleteAccount = "$baseUrl/profile/delete";
  static const String teacherInfo = "$baseUrl/profile/teacher/info";
  static const String teacherActiveStatus = "$baseUrl/teacher/active-status";
  static const String teacherGetServices = "$baseUrl/teacher/get-services";
  static const String addTeacherService = "$baseUrl/teacher/teacher-service";
  static const String uploadTeacherCertificate =
      "$baseUrl/teacher/teacher-upload-certificate";

  // Subjects
  static const String getCommonSubjects = "$baseUrl/common-subjects";
  static const String getSubjects = "$baseUrl/teacher/subjects";
  static const String updateSubject = "$baseUrl/teacher/subjects";
  static const String getLevels = "$baseUrl/education-levels";
  static const String getClasses = "$baseUrl/teacher/classes";
  // #Sessions
  static const String getStudentSessions = "$baseUrl/student/sessions";
  static const String getTeacherSessions = "$baseUrl/teacher/sessions";
  // start session as teacher
  static const String createSession = "$baseUrl/teacher/sessions/{id}/start";
  // join session as student
  static const String joinSession = "$baseUrl/student/sessions/{id}/join";
  // end session as teacher
  static const String endSession = "$baseUrl/teacher/sessions/{id}/end";

  // Available Times
  static const String getAvailableTimes = "$baseUrl/teacher/availability";
  static const String updateAvailableTimes = "$baseUrl/teacher/availability";
  static const String deleteAvailableTimesBatch =
      "$baseUrl/teacher/availability";

  // Teachers
  static const String getTeachers = "$baseUrl/teachers";
  // teacher orders
  static const String getTeacherOrders = "$baseUrl/teacher/orders/browse";
  static const String applyForOrder = "$baseUrl/teacher/orders/{id}/apply";

  // Payment Cards
  static const String studentPaymentMethods =
      "$baseUrl/student/payment-methods";
  static const String teacherPaymentMethods =
      "$baseUrl/teacher/payment-methods";
  static const String getBanks = "$baseUrl/banks";
  static const String deletePaymentCard = "$baseUrl/payment-cards/delete";
  static const String setDefaultCard = "$baseUrl/payment-cards/set-default";
  static const String payments = "$baseUrl/student/booking/pay";

  // Moyasar Payment Gateway
  static const String moyasarCheckout = "$baseUrl/student/payments/checkout";
  static const String moyasarStatus = "$baseUrl/student/payments/status";
  static const String moyasarSavedCards =
      "$baseUrl/student/payments/saved-cards";
  static String moyasarSetDefaultCard(int id) =>
      "$baseUrl/student/payments/saved-cards/$id/default";
  static String moyasarDeleteCard(int id) =>
      "$baseUrl/student/payments/saved-cards/$id";

  // Bookings
  static const String booking = "$baseUrl/student/booking";
  static const String getStudentBookings = "$baseUrl/student/booking";
  static String cancelBooking(int bookingId) =>
      "$baseUrl/student/booking/$bookingId/cancel";

  // Classroom
  static const String createClassroom = "$baseUrl/teacher/session/id/start";
  static const String joinClassroom = "$baseUrl/student/sessions/id/start";

  // Orders
  static const String createOrder = "$baseUrl/student/orders";
  static const String getOrders = "$baseUrl/student/orders";
  static String getOrder(int orderId) => "$baseUrl/student/orders/$orderId";
  static String updateOrder(int orderId) => "$baseUrl/student/orders/$orderId";
  static String deleteOrder(int orderId) => "$baseUrl/student/orders/$orderId";
  static String getOrderApplications(int orderId) =>
      "$baseUrl/student/orders/$orderId/applications";
  static String acceptOrderApplication(int orderId, int applicationId) =>
      "$baseUrl/student/orders/$orderId/applications/$applicationId/accept";

  // Education Levels & Classes
  static const String getEducationLevels = "$baseUrl/education-levels";
  static String getClassesByLevel(int educationLevelId) =>
      "$baseUrl/classes/$educationLevelId";
  static String getSubjectsByClass(int classId) =>
      "$baseUrl/subjectsClasses/$classId";
  static const String getServices = "$baseUrl/services";
  // notifications
  static const String getNotifications = "$baseUrl/notifications";
  static String markNotificationAsRead(int notificationId) =>
      "$baseUrl/notifications/$notificationId/mark-as-read";
  static String deleteNotification(int notificationId) =>
      "$baseUrl/notifications/$notificationId/delete";
  static const String markAllNotificationsAsRead =
      "$baseUrl/notifications/mark-all-as-read";
  static const String saveFCMToken = "$baseUrl/save-fcm-token";

  // Courses
  static const String getCourses = "$baseUrl/courses";
  static String getCourse(int courseId) => "$baseUrl/courses/$courseId";
  static const String getCourseCategories = "$baseUrl/categories";
  static const String enrollInCourse = "$baseUrl/student/booking/course";
  static String requestEnrollment(int courseId) =>
      "$baseUrl/student/courses/$courseId/request-enrollment";

  // Teacher Courses
  static const String teacherCourses = "$baseUrl/teacher/courses";
  static String teacherCourse(int id) => "$baseUrl/teacher/courses/$id";

  // Teacher Wallet & Payouts
  static const String getWallet = "$baseUrl/teacher/wallet";
  static const String requestWithdrawal = "$baseUrl/teacher/wallet/withdraw";
  static const String listWithdrawals = "$baseUrl/teacher/wallet/withdrawals";
  static String cancelWithdrawal(int id) =>
      "$baseUrl/teacher/wallet/withdrawals/$id";

  // Languages
  static String getTeacherLanguages(int teacherId) =>
      "$baseUrl/teacher/language-study/$teacherId";
  static const String addTeacherLanguages =
      "$baseUrl/teacher/language-study/languages";
  static const String updateTeacherLanguages =
      "$baseUrl/teacher/language-study/languages";
  static String deleteTeacherLanguage(int languageId) =>
      "$baseUrl/teacher/language-study/languages/$languageId";
  static const String getAllLanguages = "$baseUrl/language-study";

  // Reviews
  static String addTeacherReview(int teacherId) =>
      "$baseUrl/teachers/$teacherId/reviews";
  static String getTeacherReviews(int teacherId) =>
      "$baseUrl/teachers/$teacherId/reviews";
  static String getSessionReview(int sessionId) =>
      "$baseUrl/sessions/$sessionId/review";
  static const String getMySessionReviews = "$baseUrl/my-session-reviews";

  // Ads
  static const String getAds = "$baseUrl/ads";
}
