// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String failedToLoadData(String error) {
    return 'فشل تحميل البيانات: $error';
  }

  @override
  String get paymentCancelled => 'تم إلغاء عملية الدفع';

  @override
  String get bookLessonTitle => 'حجز الدرس';

  @override
  String get loadingTeacherData => 'جاري تحميل بيانات المعلم...';

  @override
  String get invalidCheckoutId => 'تم استلام معرف دفع غير صالح';

  @override
  String get invalidPaymentUrl => 'تم استلام رابط دفع غير صالح';

  @override
  String invalidUrl(String url) {
    return 'رابط غير صالح: $url';
  }

  @override
  String paymentFailedError(String error) {
    return 'فشل الدفع: $error';
  }

  @override
  String paymentProcessError(String error) {
    return 'خطأ في عملية الدفع: $error';
  }

  @override
  String bookingFailedMessage(String message) {
    return 'فشل في حجز الدرس: $message';
  }

  @override
  String get paymentSuccessDefault => 'تم الدفع بنجاح';

  @override
  String get refresh => 'تحديث';

  @override
  String get noSavedCardsMessage =>
      'لا توجد بطاقات محفوظة. ستحتاج إلى إدخال تفاصيل بطاقتك في الخطوة التالية.';

  @override
  String get newPaymentCard => 'بطاقة دفع جديدة';

  @override
  String get useAnotherCard => 'استخدم بطاقة أخرى';

  @override
  String get creditCardVisaMaster => 'بطاقة ائتمانية (فيزا/ماستر)';

  @override
  String get appTitle => 'مدرسة العباقرة';

  @override
  String get changeLanguage => 'تغيير اللغة';

  @override
  String get login => 'تسجيل الدخول';

  @override
  String get email => 'البريد الإلكتروني';

  @override
  String get password => 'كلمة المرور';

  @override
  String get forgotPassword => 'هل نسيت كلمة المرور؟';

  @override
  String get orLoginWith => 'أو سجل الدخول بـ';

  @override
  String get dontHaveAccount => 'ليس لديك حساب؟';

  @override
  String get register => 'إنشاء حساب';

  @override
  String get welcomeBack => 'أهلاً بك!';

  @override
  String get pleaseLogin => 'يرجى تسجيل الدخول للمتابعة';

  @override
  String get emailOrPhone => 'البريد الإلكتروني أو رقم الجوال';

  @override
  String get enterEmailOrPhone => 'أدخل بريدك أو رقم جوالك';

  @override
  String get enterPassword => 'أدخل كلمة المرور';

  @override
  String get requiredField => 'هذا الحقل مطلوب';

  @override
  String get passwordMinLength => 'كلمة المرور يجب أن تكون 8 أحرف على الأقل';

  @override
  String get loggingIn => 'جاري تسجيل الدخول...';

  @override
  String get registerNow => 'سجل الآن';

  @override
  String get errorOccurred => 'حدث خطأ';

  @override
  String get retry => 'إعادة المحاولة';

  @override
  String get goToLogin => 'الذهاب لتسجيل الدخول';

  @override
  String get internetConnectionError => 'خطأ في الاتصال بالإنترنت';

  @override
  String get connectionTimeout => 'انتهت مهلة الاتصال';

  @override
  String get sessionExpired => 'انتهت صلاحية الجلسة';

  @override
  String get unexpectedError => 'حدث خطأ غير متوقع';

  @override
  String get createAccount => 'إنشاء حساب جديد';

  @override
  String get joinCommunity => 'انضم إلى مجتمع مدرسة العباقرة التعليمي';

  @override
  String get fullName => 'الاسم الكامل';

  @override
  String get firstName => 'الاسم الأول';

  @override
  String get lastName => 'الاسم الأخير';

  @override
  String get required => 'مطلوب';

  @override
  String get invalidEmail => 'بريد إلكتروني غير صالح';

  @override
  String get phoneNumber => 'رقم الجوال';

  @override
  String get tooLong => 'رقم طويل جداً';

  @override
  String get nationality => 'الجنسية';

  @override
  String get gender => 'الجنس';

  @override
  String get strongPassword => 'أدخل كلمة مرور قوية';

  @override
  String get agreeTo => 'أوافق على ';

  @override
  String get termsConditions => 'الشروط والأحكام';

  @override
  String get and => ' و ';

  @override
  String get privacyPolicy => 'سياسة الخصوصية';

  @override
  String get registerButton => 'تسجيل حساب جديد';

  @override
  String get registering => 'جاري التسجيل...';

  @override
  String get acceptTermsError => 'يرجى الموافقة على الشروط والأحكام';

  @override
  String get chooseYourRole => 'اختر دورك';

  @override
  String get howToUseApp => 'كيف تريد أن تستخدم مدرسة العباقرة؟';

  @override
  String get student => 'طالب';

  @override
  String get studentDescription =>
      'تعلم مهارات جديدة، احصل على دروس خصوصية، ادرس اللغات، وانضم للكورسات لتطوير معرفتك';

  @override
  String get teacher => 'المعلم';

  @override
  String get teacherDescription =>
      'قدم دروساً خصوصية، علم اللغات، شارك خبرتك، وقدم دورات تدريبية للطلاب';

  @override
  String get continueText => 'متابعة';

  @override
  String get resetPassword => 'استعادة كلمة المرور';

  @override
  String get enterRegisteredPhone =>
      'أدخل رقم هاتفك المسجل وسنرسل لك رمز التحقق';

  @override
  String get codeSent => 'تم إرسال الرمز!';

  @override
  String get codeSentToPhone => 'تم إرسال رمز التحقق إلى رقم هاتفك';

  @override
  String get sendVerificationCode => 'إرسال رمز التحقق';

  @override
  String get enterPhoneNumberError => 'يرجى إدخال رقم الهاتف';

  @override
  String get invalidPhoneNumberError => 'يجب أن يتكون رقم الهاتف من 9 أرقام';

  @override
  String get codeResent => 'تم إرسال الرمز مرة أخرى';

  @override
  String get codeResendFailed => 'فشل إرسال الرمز. حاول مرة أخرى';

  @override
  String get enterFullCode => 'يرجى إدخال الرمز كاملاً';

  @override
  String get errorTryAgain => 'حدث خطأ. يرجى المحاولة مرة أخرى';

  @override
  String get invalidVerificationCode => 'رمز التحقق غير صحيح';

  @override
  String get networkError =>
      'فشل الاتصال بالخادم. يرجى التحقق من الاتصال بالإنترنت والمحاولة مرة أخرى.';

  @override
  String get codeExpired => 'انتهت صلاحية الرمز. أعد إرساله';

  @override
  String get timeoutError => 'انتهت المهلة. حاول مرة أخرى';

  @override
  String genericError(String error) {
    return 'خطأ: $error';
  }

  @override
  String get close => 'إغلاق';

  @override
  String get error => 'خطأ';

  @override
  String get ok => 'موافق';

  @override
  String get verify => 'تحقق';

  @override
  String get allOrders => 'جميع الطلبات';

  @override
  String get noOrders => 'لا توجد طلبات';

  @override
  String get errorLoadingOrders => 'خطأ في تحميل الطلبات';

  @override
  String get orderAppliedSuccess => 'تم التقديم على الطلب بنجاح';

  @override
  String get orderApplyFailed => 'فشل التقديم';

  @override
  String get overview => 'نظرة عامة';

  @override
  String get wallet => 'المحفظة';

  @override
  String get lessons => 'الدروس';

  @override
  String get requestTeachingSession => 'طلب جلسة تدريس';

  @override
  String get bookPrivateSession => 'احجز جلسة تدريس خصوصية';

  @override
  String get academicDetails => 'التفاصيل';

  @override
  String get educationLevel => 'المرحلة التعليمية';

  @override
  String get selectEducationLevel => 'اختر مستواك التعليمي';

  @override
  String get noEducationLevelsAvailable => 'لا توجد مراحل تعليمية متاحة';

  @override
  String get loadingEducationLevelsFailed => 'فشل تحميل المراحل التعليمية';

  @override
  String get grade => 'الصف الدراسي';

  @override
  String get selectGrade => 'اختر الصف الدراسي';

  @override
  String get selectGradeFirst => 'اختر الصف أولاً';

  @override
  String get noGradesAvailable => 'لا توجد صفوف متاحة';

  @override
  String get selectEducationLevelFirst => 'اختر المرحلة أولاً';

  @override
  String get loadingGradesFailed => 'فشل تحميل الصفوف';

  @override
  String get subject => 'المادة';

  @override
  String get selectSubject => 'اختر المادة الدراسية';

  @override
  String get noSubjectsAvailable => 'لا توجد مواد متاحة';

  @override
  String get loadingSubjectsFailed => 'فشل تحميل المواد';

  @override
  String get sessionType => 'نوع الجلسة';

  @override
  String get online => 'أونلاين';

  @override
  String get videoSession => 'جلسة عبر الفيديو';

  @override
  String get inPerson => 'حضوري';

  @override
  String get faceToFace => 'لقاء وجهاً لوجه';

  @override
  String get dateTime => 'التاريخ والوقت';

  @override
  String get date => 'التاريخ';

  @override
  String get selectDate => 'اختر التاريخ';

  @override
  String get time => 'الوقت';

  @override
  String get selectTime => 'اختيار الوقت';

  @override
  String get durationAndPrice => 'المدة والسعر';

  @override
  String get hoursCount => 'عدد الساعات';

  @override
  String get enterHoursCount => 'أدخل عدد الساعات';

  @override
  String get pricePerHour => 'السعر للساعة';

  @override
  String get enterProposedPrice => 'أدخل السعر المقترح';

  @override
  String get priority => 'الأولوية';

  @override
  String get sessionDescription => 'وصف الجلسة';

  @override
  String get sessionDetails => 'تفاصيل الجلسة';

  @override
  String get writeSessionDetails => 'اكتب تفاصيل ما تحتاج المساعدة فيه...';

  @override
  String get hoursRequired => 'عدد الساعات مطلوب';

  @override
  String get invalidHours => 'عدد الساعات غير صحيح';

  @override
  String get priceRequired => 'يرجى إدخال السعر';

  @override
  String get invalidPrice => 'السعر غير صحيح';

  @override
  String get descriptionRequired => 'وصف الجلسة مطلوب';

  @override
  String get viewAll => 'عرض الكل';

  @override
  String get search => 'بحث...';

  @override
  String get sendRequest => 'إرسال الطلب';

  @override
  String get requestSentSuccess => 'تم إرسال الطلب بنجاح!';

  @override
  String get requestSentFailed => 'فشل إرسال الطلب';

  @override
  String get lowPriority => 'منخفضة';

  @override
  String get normalPriority => 'عادية';

  @override
  String get highPriority => 'عالية';

  @override
  String get urgentPriority => 'عاجلة';

  @override
  String get languages => 'اللغات';

  @override
  String get courses => 'الكورسات';

  @override
  String get rating => 'التقييم';

  @override
  String get newOrders => 'الطلبات الجديدة';

  @override
  String get noNewOrders => 'لا توجد طلبات جديدة';

  @override
  String get newOrdersWillAppearHere => 'عند توفر طلبات جديدة ستظهر هنا';

  @override
  String get viewAllOrders => 'عرض جميع الطلبات';

  @override
  String get serviceManagement => 'إدارة الخدمات';

  @override
  String get manageStagesAndSubjects => 'إدارة المراحل الدراسية والمواد';

  @override
  String get manageCourses => 'إدارة الدورات التدريبية';

  @override
  String get manageLanguages => 'إدارة اللغات';

  @override
  String get mySchedule => 'جدول دروسي';

  @override
  String get all => 'الكل';

  @override
  String get pending => 'قيد الانتظار';

  @override
  String get accepted => 'تم القبول';

  @override
  String get rejected => 'مرفوض';

  @override
  String get status => 'الحالة';

  @override
  String get myOrders => 'طلباتي';

  @override
  String get unknownSubject => 'مادة غير محددة';

  @override
  String get completed => 'مكتمل';

  @override
  String get cancelled => 'ملغي';

  @override
  String get notSpecified => 'غير محدد';

  @override
  String get teachersApplicationsCount => 'عدد طلبات المعلمين';

  @override
  String get price => 'السعر';

  @override
  String get currency => '﷼';

  @override
  String get creationDate => 'تاريخ الإنشاء';

  @override
  String get orderDetailsNotAvailable => 'تفاصيل الطلب غير متاحة حالياً';

  @override
  String get noOrdersNow => 'لا توجد طلبات حالياً';

  @override
  String get topTeachers => 'أفضل المعلمين';

  @override
  String get ourServices => 'خدماتنا';

  @override
  String get trainingCourses => 'الدورات التدريبية';

  @override
  String get noCoursesAvailable => 'لا توجد دورات متاحة.';

  @override
  String get subjects => 'المواد';

  @override
  String get courseCategories => 'تصنيفات الدورات';

  @override
  String get errorLoadingCategories => 'خطأ في تحميل التصنيفات';

  @override
  String get noCategoriesAvailable => 'لا توجد فئات متاحة حالياً';

  @override
  String get earnings => 'الأرباح';

  @override
  String get mySessions => 'جلساتي';

  @override
  String get myProfile => 'الملف الشخصي';

  @override
  String get home => 'الرئيسية';

  @override
  String get myLessons => 'دروسي';

  @override
  String get profile => 'حسابي';

  @override
  String get addOrder => 'إضافة طلب';

  @override
  String get errorForbidden =>
      'ليس لديك صلاحيات كافية للوصول لهذا الموارد، يرجى تسجيل الدخول مجدداً';

  @override
  String get errorPrefix => 'حدث خطأ: ';

  @override
  String get hour => 'ساعة';

  @override
  String get hourShort => 'س';

  @override
  String get minute => 'دقيقة';

  @override
  String get minuteShort => 'د';

  @override
  String get session => 'جلسة';

  @override
  String get unknown => 'غير معروف';

  @override
  String get finished => 'منتهية';

  @override
  String get upcoming => 'قريباً';

  @override
  String get join => 'انضم';

  @override
  String get start => 'لنبدأ';

  @override
  String get apply => 'تقديم';

  @override
  String get statusPending => 'قيد الانتظار';

  @override
  String get statusAccepted => 'مقبول';

  @override
  String get statusRejected => 'مرفوض';

  @override
  String get viewAllCategories => 'عرض جميع الفئات';

  @override
  String get noCategoriesDescription => 'عند توفر فئات جديدة ستظهر هنا';

  @override
  String get myServices => 'خدماتي';

  @override
  String get service => 'خدمة';

  @override
  String get perHour => '/ ساعة';

  @override
  String get reject => 'رفض';

  @override
  String get accept => 'قبول';

  @override
  String get statusUrgent => 'عاجل';

  @override
  String get statusCompleted => 'مكتمل';

  @override
  String get searchOrdersHint => 'البحث في الطلبات...';

  @override
  String get noResults => 'لا توجد نتائج';

  @override
  String get tryDifferentSearch => 'جرب البحث بكلمات أخرى';

  @override
  String get noOrdersFilter => 'لا توجد طلبات بهذا الفلتر';

  @override
  String get newOrdersDescription => 'سيتم عرض الطلبات الجديدة هنا';

  @override
  String get orderInfo => 'معلومات الطلب';

  @override
  String get level => 'المستوى';

  @override
  String get lessonType => 'نوع الدرس';

  @override
  String get description => 'الوصف';

  @override
  String get orderDetails => 'تفاصيل الطلب';

  @override
  String get viewDetailsBook => 'عرض التفاصيل والحجز';

  @override
  String availableDays(int count) {
    return '$count أيام متاحة';
  }

  @override
  String otherSubjects(int count) {
    return 'و $count مواد أخرى';
  }

  @override
  String get individualLesson => 'فردي';

  @override
  String get groupLesson => 'جماعي';

  @override
  String get teacherDashboard => '📊 لوحة المعلم';

  @override
  String get today => 'اليوم';

  @override
  String get thisMonth => 'هذا الشهر';

  @override
  String get total => 'المجموع';

  @override
  String get currentBalance => 'الرصيد الحالي';

  @override
  String get totalLessons => 'الدروس الكلية';

  @override
  String get ongoingLessons => 'الدروس الجارية';

  @override
  String get newPassword => 'كلمة المرور الجديدة';

  @override
  String get confirmPassword => 'تأكيد كلمة المرور';

  @override
  String get reEnterPassword => 'أعد إدخال كلمة المرور';

  @override
  String get setPassword => 'تعيين كلمة المرور';

  @override
  String get passwordChanged => 'تم تغيير كلمة المرور!';

  @override
  String get passwordChangedSuccess => 'تم تعيين كلمة المرور الجديدة بنجاح';

  @override
  String get passwordMismatch => 'كلمة المرور غير متطابقة';

  @override
  String get passwordRequired => 'يرجى إدخال كلمة المرور';

  @override
  String get confirmPasswordRequired => 'يرجى تأكيد كلمة المرور';

  @override
  String get passwordStrengthHint =>
      'استخدم حروف كبيرة وصغيرة، أرقام، ورموز خاصة';

  @override
  String get currentPassword => 'كلمة المرور الحالية';

  @override
  String get currentPasswordRequired => 'يرجى إدخال كلمة المرور الحالية';

  @override
  String get scheduleEmptyState => 'لا توجد مواعيد لهذا اليوم';

  @override
  String dayTimes(String day) {
    return 'أوقات $day';
  }

  @override
  String timesCount(int count) {
    return '$count أوقات';
  }

  @override
  String get noAppointmentsNow => 'لا توجد مواعيد لهذا اليوم';

  @override
  String get addAppointmentHint => 'اضغط على + لإضافة موعد جديد';

  @override
  String get availableTime => 'وقت متاح';

  @override
  String get bookedTime => 'وقت محجوز';

  @override
  String get removeTime => 'حذف الوقت';

  @override
  String get addAvailableTime => 'إضافة وقت متاح';

  @override
  String todayDay(String day) {
    return 'اليوم: $day';
  }

  @override
  String get add => 'إضافة';

  @override
  String get errorUnauthorized => 'انتهت جلستك، يرجى تسجيل الدخول مجدداً';

  @override
  String get errorConnectionTimeout =>
      'انتهت مهلة الاتصال بالخادم، تحقق من الإنترنت';

  @override
  String get errorReceiveTimeout => 'الخادم لم يستجب في الوقت المحدد';

  @override
  String get errorConnectionError => 'فشل الاتصال بالخادم، تحقق من الشبكة';

  @override
  String get errorServerError => 'حدث خطأ أثناء الاتصال بالخادم';

  @override
  String get errorFormat => 'خطأ في تنسيق البيانات';

  @override
  String get errorGeneral => 'حدث خطأ غير معروف، يرجى المحاولة لاحقاً';

  @override
  String get errorConnectionFailed => 'فشل الاتصال بالخادم';

  @override
  String get errorNotFound => 'المورد المطلوب غير موجود';

  @override
  String get errorCredentials => 'بيانات الدخول غير صحيحة';

  @override
  String get errorUnexpected => 'خطأ غير متوقع في الخادم';

  @override
  String get cancel => 'إلغاء';

  @override
  String get completeProfile => 'إكمال الملف الشخصي';

  @override
  String get completeProfileMessage =>
      'للوصول إلى الدروس، يجب إكمال معلومات حسابك';

  @override
  String get completeProfileButton => 'إكمال الآن';

  @override
  String get later => 'لاحقاً';

  @override
  String get selectRoleReq => 'اختر الدور';

  @override
  String get basicInfoReq => 'المعلومات الأساسية';

  @override
  String get verifyAccountReq => 'تأكيد الحساب';

  @override
  String get unsupportedFileType => 'نوع ملف غير مدعوم';

  @override
  String get processingPdf => 'جاري معالجة PDF...';

  @override
  String get imageLoadFailed => 'فشل تحميل الصورة';

  @override
  String get downloadingPdf => 'جاري تحميل PDF...';

  @override
  String get pdfDownloadFailed => 'فشل تحميل PDF';

  @override
  String get emptyPdfFile => 'ملف PDF فارغ';

  @override
  String pdfPages(int count) {
    return 'PDF ($count صفحة)';
  }

  @override
  String get pdfFile => 'ملف PDF';

  @override
  String get clickToUpload => 'اضغط لرفع الملف';

  @override
  String get uploaded => 'تم الرفع';

  @override
  String get fileTypes => 'PNG, JPG أو PDF';

  @override
  String get managePaymentMethods => 'إدارة طرق الدفع';

  @override
  String get manageBankAccount => 'إدارة الحساب البنكي';

  @override
  String get selectPaymentMethod => 'اختر طريقة الدفع';

  @override
  String amountDue(int amount) {
    return 'المبلغ المستحق: $amount ريال';
  }

  @override
  String get savedCards => 'بطاقاتك المحفوظة';

  @override
  String cardsLoadError(String error) {
    return 'خطأ في تحميل البطاقات: $error';
  }

  @override
  String get addNewCard => 'إضافة بطاقة جديدة';

  @override
  String get addNewBankAccount => 'إضافة حساب بنكي';

  @override
  String get visa => 'فيزا';

  @override
  String get masterCard => 'MasterCard';

  @override
  String get mada => 'مدى';

  @override
  String get back => 'العودة';

  @override
  String get newCardDetails => 'بيانات البطاقة الجديدة';

  @override
  String get cardType => 'نوع البطاقة';

  @override
  String get bankAccountType => 'نوع الحساب البنكي';

  @override
  String get cardNumber => 'رقم البطاقة';

  @override
  String get cardNumberHint => '0000 0000 0000 0000';

  @override
  String get cardHolderName => 'اسم حامل البطاقة';

  @override
  String get cardHolderNameHint => 'الاسم كما يظهر على البطاقة';

  @override
  String get accountHolderName => 'اسم صاحب الحساب';

  @override
  String get expiryDate => 'تاريخ الانتهاء';

  @override
  String get month => 'الشهر';

  @override
  String get monthHint => 'MM';

  @override
  String get year => 'السنة';

  @override
  String get yearHint => 'YY';

  @override
  String get cvv => 'CVV';

  @override
  String get cvvHint => '000';

  @override
  String get securityNotice => 'بيانات بطاقتك محمية بأعلى معايير الأمان';

  @override
  String get cardDefault => 'الحساب الافتراضية';

  @override
  String get continuePayment => 'متابعة الدفع';

  @override
  String get verifyCard => 'تحقق من بطاقتك';

  @override
  String get enterCvvSecurely => 'أدخل رمز CVV لإكمال الدفع بأمان';

  @override
  String get transactionSecure => 'معاملتك محمية بأعلى مستويات الأمان';

  @override
  String get confirmPayment => 'تأكيد الدفع';

  @override
  String get paymentSuccess => 'تم الدفع بنجاح';

  @override
  String get paymentFailed => 'فشل في الدفع';

  @override
  String get cvvRequired => 'رمز CVV مطلوب';

  @override
  String get cvvInvalidLength => 'رمز CVV يجب أن يكون 3 أرقام على الأقل';

  @override
  String get bookingIdRequired => 'خطأ: رقم الحجز مطلوب لإتمام عملية الدفع';

  @override
  String paymentMessageSuccess(String message) {
    return 'تم الدفع بنجاح: $message';
  }

  @override
  String paymentMessageFailed(String message) {
    return 'فشل في الدفع: $message';
  }

  @override
  String get cardAddedSuccess => 'تمت إضافة البطاقة بنجاح';

  @override
  String get cardUpdatedSuccess => 'تم تحديث البطاقة بنجاح';

  @override
  String get cardDeletedSuccess => 'تم حذف البطاقة بنجاح';

  @override
  String get cardDefaultSet => 'تم تعيين البطاقة الافتراضية بنجاح';

  @override
  String get deleteCardConfirmTitle => 'تأكيد الحذف';

  @override
  String get deleteCardConfirmMessage => 'هل أنت متأكد من حذف طريقة الدفع هذه؟';

  @override
  String get delete => 'حذف';

  @override
  String get deleteAccount => 'حذف الحساب';

  @override
  String get deleteAccountConfirmation =>
      'هل أنت متأكد أنك تريد حذف حسابك؟ لا يمكن التراجع عن هذا الإجراء.';

  @override
  String get noCards => 'لا توجد بطاقات';

  @override
  String get noCardsDescription => 'اضغط على الزر أدناه لإضافة بطاقة جديدة';

  @override
  String cardAddError(String error) {
    return 'خطأ: $error';
  }

  @override
  String get subjectMathAlgebra => 'الرياضيات - الجبر';

  @override
  String get subjectPhysicsMechanics => 'الفيزياء - الميكانيكا';

  @override
  String get subjectOrganicChemistry => 'الكيمياء العضوية';

  @override
  String get subjectEnglishGrammar => 'اللغة الإنجليزية - قواعد';

  @override
  String get subjectBiologyGenetics => 'الأحياء - علم الوراثة';

  @override
  String get subjectMathStatistics => 'الرياضيات - الإحصاء';

  @override
  String get subjectPhysicsElectricity => 'الفيزياء - الكهرباء';

  @override
  String get subjectProgrammingPython => 'البرمجة - Python';

  @override
  String get subjectArabicGrammar => 'اللغة العربية - النحو';

  @override
  String get subjectGeography => 'الجغرافيا';

  @override
  String get levelSecondary => 'الثانوي';

  @override
  String get levelIntermediate => 'متوسط';

  @override
  String get levelUniversity => 'الجامعي';

  @override
  String get lessonTypeInPerson => 'حضوري';

  @override
  String get lessonTypeOnline => 'أونلاين';

  @override
  String get descMathAlgebra =>
      'أحتاج مساعدة في فهم المعادلات التربيعية والدوال الخطية. لدي امتحان قريب.';

  @override
  String get descPhysicsMechanics =>
      'شرح قوانين نيوتن للحركة وتطبيقاتها العملية.';

  @override
  String get descOrganicChemistry =>
      'دروس في المركبات العضوية والتفاعلات الكيميائية.';

  @override
  String get descEnglishGrammar => 'تحسين القواعد والكتابة الأكاديمية.';

  @override
  String get descBiologyGenetics => 'فهم قوانين مندل والهندسة الوراثية.';

  @override
  String get descMathStatistics => 'مساعدة في الإحصاء الوصفي والاستنتاجي.';

  @override
  String get descPhysicsElectricity => 'شرح الدوائر الكهربائية وقانون أوم.';

  @override
  String get descProgrammingPython => 'تعلم أساسيات البرمجة بلغة بايثون.';

  @override
  String get descArabicGrammar => 'شرح قواعد النحو والإعراب.';

  @override
  String get descGeography => 'دراسة الجغرافيا الطبيعية والبشرية.';

  @override
  String get editBankAccount => 'تعديل حساب بنكي';

  @override
  String get addBankAccount => 'إضافة حساب بنكي';

  @override
  String get editCard => 'تعديل بطاقة';

  @override
  String get addCard => ' إضافة بطاقة دفع';

  @override
  String get forReceivingEarnings => 'لاستقبال أرباحك';

  @override
  String get forBookingLessons => 'لحجز الدروس';

  @override
  String get selectBank => 'اختر البنك';

  @override
  String get enterIban => 'أدخل الآيبان';

  @override
  String get nameAsInBank => 'الاسم كما في البنك';

  @override
  String get tooShort => 'قصير جداً';

  @override
  String get earningsTransferNotice => 'سيتم تحويل أرباحك لهذا الحساب';

  @override
  String get selectType => 'اختر النوع';

  @override
  String get nameOnCard => 'الاسم على البطاقة';

  @override
  String get detailsProtected => 'معلوماتك محمية';

  @override
  String get save => 'حفظ';

  @override
  String get bank => 'البنك';

  @override
  String get iban => 'رقم الآيبان (IBAN)';

  @override
  String get accountNumber => 'رقم الحساب';

  @override
  String get verificationHeader => 'التحقق من الرمز';

  @override
  String get codeSentToUser => 'تم إرسال رمز التحقق إلى';

  @override
  String get resendCodeIn => 'إعادة إرسال الرمز خلال ';

  @override
  String get seconds => 'ثانية';

  @override
  String get resendCode => 'إعادة إرسال الرمز';

  @override
  String get errorLoadingBanks => 'خطأ في تحميل البنوك: ';

  @override
  String get invalid => 'قيمة غير صحيحة';

  @override
  String get edit => 'تعديل';

  @override
  String get gallery => 'المعرض';

  @override
  String get camera => 'الكاميرا';

  @override
  String get title => 'العنوان';

  @override
  String get seats => 'المقاعد';

  @override
  String get registeredStudents => 'الطلاب المسجلين';

  @override
  String get noStudentData => 'لا توجد بيانات للطالب';

  @override
  String seatsCount(int count) {
    return '$count مقعد';
  }

  @override
  String hoursShort(int count) {
    return '$count ساعة';
  }

  @override
  String enter(String field) {
    return 'أدخل $field';
  }

  @override
  String get selectRole => 'اختر الدور';

  @override
  String get decline => 'رفض';

  @override
  String get saveChanges => 'حفظ التغييرات';

  @override
  String get changesSaved => 'تم حفظ التغييرات';

  @override
  String get availableTimesTitle => 'الأوقات المتاحة';

  @override
  String get addTime => 'إضافة وقت';

  @override
  String timeExistsError(String time) {
    return 'الوقت $time موجود بالفعل أو قريب جدًا من وقت آخر';
  }

  @override
  String timeAddedSuccess(String time) {
    return 'تم إضافة الوقت $time بنجاح';
  }

  @override
  String timeRemovedSuccess(String time) {
    return 'تم حذف الوقت $time بنجاح';
  }

  @override
  String get available => 'متاح';

  @override
  String get booked => 'محجوز';

  @override
  String get manageSubjectsTitle => 'إدارة المواد الدراسية';

  @override
  String get noSubjects => 'لا توجد مواد';

  @override
  String get startAddingSubjects => 'ابدأ بإضافة مواد';

  @override
  String get filterBy => 'تصفية حسب';

  @override
  String get educationalLevel => 'المرحلة الدراسية';

  @override
  String get schoolClass => 'الصف الدراسي';

  @override
  String get selectLevel => 'اختر المرحلة الدراسية';

  @override
  String get selectClass => 'اختر الصف الدراسي';

  @override
  String get selectLevelFirst => 'اختر المرحلة الدراسية أولاً';

  @override
  String get confirmDelete => 'تأكيد الحذف';

  @override
  String confirmDeleteSubject(String name) {
    return 'هل أنت متأكد من حذف هذه المادة؟';
  }

  @override
  String get addClass => 'إضافة صف';

  @override
  String get addSubject => 'إضافة مادة';

  @override
  String subjectsOf(String name) {
    return 'مواد $name';
  }

  @override
  String classesOf(String name) {
    return 'صفوف $name';
  }

  @override
  String get saturday => 'السبت';

  @override
  String get sunday => 'الأحد';

  @override
  String get monday => 'الاثنين';

  @override
  String get tuesday => 'الثلاثاء';

  @override
  String get wednesday => 'الأربعاء';

  @override
  String get thursday => 'الخميس';

  @override
  String get friday => 'الجمعة';

  @override
  String get editProfile => 'تعديل الملف الشخصي';

  @override
  String get changePassword => 'تعديل كلمة المرور';

  @override
  String get manageTimes => 'إدارة الاوقات';

  @override
  String get manageLevelsSubjects => 'إدارة المراحل الدراسية والمواد';

  @override
  String get myWallet => 'محفظتي';

  @override
  String get myBookings => 'الحجوزات';

  @override
  String get notifications => 'الاشعارات';

  @override
  String get logout => 'تسجيل الخروج';

  @override
  String get logoutConfirmation => 'هل أنت متأكد من تسجيل الخروج؟';

  @override
  String get loggingOut => 'جاري تسجيل الخروج...';

  @override
  String get confirm => 'تأكيد';

  @override
  String get saveSuccess => 'تم الحفظ بنجاح';

  @override
  String saveFailed(String error) {
    return 'فشل الحفظ: $error';
  }

  @override
  String get pickFileError => 'حدث خطأ أثناء اختيار الملف';

  @override
  String get fileReadError => 'فشل في قراءة الملف';

  @override
  String get passwordStrengthVeryWeak => 'ضعيفة جداً';

  @override
  String get passwordStrengthWeak => 'ضعيفة';

  @override
  String get passwordStrengthMedium => 'متوسطة';

  @override
  String get passwordStrengthStrong => 'قوية';

  @override
  String get verificationDataMissing => 'بيانات التحقق مفقودة';

  @override
  String get setNewPasswordTitle => 'تعيين كلمة مرور جديدة';

  @override
  String get setNewPasswordSubtitle => 'يرجى إدخال كلمة مرور قوية وآمنة';

  @override
  String get skip => 'تخطي';

  @override
  String get next => 'التالي';

  @override
  String get onboardingTitle1 => 'مدرسة العباقرة هنا';

  @override
  String get onboardingDesc1 =>
      'قصة نجاح تبدأ برؤية و تتحقق على ارض الواقع. نرتقي بالعلم ونصنع انسان عبقري';

  @override
  String get onboardingBtn1 => 'ثم مــاذا؟';

  @override
  String get onboardingTitle2 => 'مدرسة العباقرة ترحب بكم';

  @override
  String get onboardingDesc2 =>
      'رسالتنا هي ان نبني جيل متعلم قادر على مواجهة تحديات المستقبل';

  @override
  String get onboardingBtn2 => 'التالي...';

  @override
  String get onboardingTitle3 => 'ابدأ رحلتك التعليميه';

  @override
  String get onboardingDesc3 =>
      'انضم الى مجتمعنا التعليمي وابدأ رحلتك نحو مستقبل مشرق';

  @override
  String get onboardingBtn3 => 'لنبدأ';

  @override
  String get teacherOrdersTitle => 'طلبات التدريس';

  @override
  String get removeFilters => 'إزالة الفلاتر';

  @override
  String requestCount(int count) {
    return '$count طلب';
  }

  @override
  String requestAccepted(String name) {
    return 'تم قبول طلب $name';
  }

  @override
  String get undo => 'تراجع';

  @override
  String get rejectRequestTitle => 'رفض الطلب';

  @override
  String rejectRequestMessage(String name) {
    return 'هل أنت متأكد من رفض طلب $name؟';
  }

  @override
  String get requestRejected => 'تم رفض الطلب';

  @override
  String get lessonNotStarted => 'الدرس لم يبدأ بعد';

  @override
  String roomCreationFailed(String error) {
    return 'فشل في إنشاء الغرفة: $error';
  }

  @override
  String get lessonNotStartedRetry => 'الدرس لم يبدأ بعد. يرجى المحاولة لاحقاً';

  @override
  String joinFailed(String error) {
    return 'فشل في الانضمام: $error';
  }

  @override
  String errorTitle(String error) {
    return 'حدث خطأ: $error';
  }

  @override
  String get cannotOpenLink => 'لا يمكن فتح الرابط';

  @override
  String get lessonInProgress => 'الدرس جاري الآن';

  @override
  String get comingSoon => 'قادم قريباً';

  @override
  String get lessonInfo => 'معلومات الدرس';

  @override
  String get duration => 'المدة';

  @override
  String minutesCount(int count) {
    return '$count دقيقة';
  }

  @override
  String get creatingRoom => 'جاري إنشاء الغرفة...';

  @override
  String get joiningRoom => 'جاري الانضمام...';

  @override
  String get createAndJoin => 'إنشاء الغرفة والدخول';

  @override
  String get enterLesson => 'الدخول للدرس';

  @override
  String get lessonComingSoon => 'الدرس قادم قريباً';

  @override
  String get pleaseWaitCreating => 'يرجى الانتظار، جاري إعداد الغرفة...';

  @override
  String get pleaseWaitJoining => 'يرجى الانتظار، جاري الانضمام...';

  @override
  String get clickToCreateAndJoin => 'انقر لإنشاء غرفة الدرس والدخول إليها';

  @override
  String get clickToJoin => 'انقر للدخول إلى غرفة الدرس';

  @override
  String get joinButtonAvailableLater => 'سيكون زر الدخول متاحاً عند بدء الدرس';

  @override
  String get lessonTime => 'وقت الدرس';

  @override
  String get liveNow => 'يعمل الآن';

  @override
  String get errorLoadingData => 'حدث خطأ أثناء تحميل البيانات';

  @override
  String get noLessonInfo => 'لا توجد معلومات الدرس';

  @override
  String get activeLesson => 'درس نشط';

  @override
  String get students => 'الطلاب';

  @override
  String get missedLessonsCount => 'عدد الدروس الفائتة';

  @override
  String get phoneNumberHint => '5xxxxxxxx';

  @override
  String get aboutTeacher => 'نبذة عن المعلم';

  @override
  String get subjectsTaught => 'المواد التي يدرسها';

  @override
  String get chooseSessionTimes => 'اختر أوقات الحصص';

  @override
  String get bookNowInstruction =>
      'اضغط على زر \'احجز الآن\' لاختيار المرحلة والصف والمادة والوقت المناسب';

  @override
  String get bookNow => 'احجز الآن';

  @override
  String availableSeatsCount(int count) {
    return '$count مقعد متاح';
  }

  @override
  String get details => 'التفاصيل';

  @override
  String get levelBeginner => 'مبتدئ';

  @override
  String get levelAdvanced => 'متقدم';

  @override
  String get levelUnknown => 'غير معروف';

  @override
  String minMaxStudents(int min, int max) {
    return '$min-$max طلاب';
  }

  @override
  String get perHourText => 'للساعة';

  @override
  String get addCourse => 'إضافة دورة';

  @override
  String get coverImageRequired => 'يرجى اختيار صورة الغلاف';

  @override
  String get availableSlotsRequired => 'يرجى إضافة مواعيد متاحة';

  @override
  String get courseAddedSuccess => 'تم إضافة الدورة بنجاح';

  @override
  String get saveCourse => 'حفظ الدورة';

  @override
  String get courseTitleAr => 'اسم الدورة (بالعربية)';

  @override
  String get courseTitleEn => 'اسم الدورة (بالإنجليزية)';

  @override
  String get hours => 'الساعات';

  @override
  String get weeklyAvailableSlots => 'المواعيد المتاحة (أسبوعياً)';

  @override
  String get noSlotsAdded => 'لا توجد مواعيد مضافة';

  @override
  String get courseType => 'نوع الدورة';

  @override
  String get typeSingle => 'فردية';

  @override
  String get typeGroup => 'جماعية';

  @override
  String get male => 'ذكر';

  @override
  String get female => 'أنثى';

  @override
  String get other => 'أخرى';

  @override
  String get optional => '(اختياري)';

  @override
  String get countryQatar => 'قطر';

  @override
  String get countryEgypt => 'مصر';

  @override
  String get countrySaudi => 'السعودية';

  @override
  String get countrySudan => 'السودان';

  @override
  String get countryUAE => 'الإمارات';

  @override
  String get countryKuwait => 'الكويت';

  @override
  String get countryBahrain => 'البحرين';

  @override
  String get countryOman => 'عمان';

  @override
  String get countryYemen => 'اليمن';

  @override
  String get countryJordan => 'الأردن';

  @override
  String get countrySyria => 'سوريا';

  @override
  String get countryLebanon => 'لبنان';

  @override
  String get countryPalestine => 'فلسطين';

  @override
  String get countryIraq => 'العراق';

  @override
  String get countryLibya => 'ليبيا';

  @override
  String get countryTunisia => 'تونس';

  @override
  String get countryAlgeria => 'الجزائر';

  @override
  String get countryMorocco => 'المغرب';

  @override
  String get countryMauritania => 'موريتانيا';

  @override
  String get countrySomalia => 'الصومال';

  @override
  String get countryDjibouti => 'جيبوتي';

  @override
  String get countryComoros => 'جزر القمر';

  @override
  String get countryTurkey => 'تركيا';

  @override
  String get countryIndonesia => 'إندونيسيا';

  @override
  String get countryMalaysia => 'ماليزيا';

  @override
  String get countryIndia => 'الهند';

  @override
  String get countryPakistan => 'باكستان';

  @override
  String get countryUS => 'الولايات المتحدة';

  @override
  String get countryUK => 'المملكة المتحدة';

  @override
  String get accountExists => 'الحساب موجود';

  @override
  String get accountExistsMessage =>
      'هذا الحساب موجود بالفعل. يرجى تسجيل الدخول.';

  @override
  String get verificationRequired => 'تحقق من الحساب';

  @override
  String get continueVerificationMessage =>
      'لديك تسجيل معلق. هل تريد المتابعة؟';

  @override
  String get validationError => 'خطأ في التحقق';

  @override
  String get countryFrance => 'فرنسا';

  @override
  String get countryGermany => 'ألمانيا';

  @override
  String get countrySpain => 'إسبانيا';

  @override
  String get countryItaly => 'إيطاليا';

  @override
  String get countryRussia => 'روسيا';

  @override
  String get countryChina => 'الصين';

  @override
  String get countryJapan => 'اليابان';

  @override
  String get countrySouthKorea => 'كوريا الجنوبية';

  @override
  String get countryCanada => 'كندا';

  @override
  String get countryBrazil => 'البرازيل';

  @override
  String get countryAustralia => 'أستراليا';

  @override
  String get countryNigeria => 'نيجيريا';

  @override
  String get countrySouthAfrica => 'جنوب أفريقيا';

  @override
  String get countryMexico => 'المكسيك';

  @override
  String get countryArgentina => 'الأرجنتين';

  @override
  String get typePackage => 'باقة';

  @override
  String get typeSubscription => 'اشتراك';

  @override
  String get sar => 'ريال';

  @override
  String get statusDraft => 'مسودة';

  @override
  String get statusPublished => 'منشور';

  @override
  String get totalPrice => 'السعر الإجمالي';

  @override
  String get statusPendingPayment => 'بانتظار الدفع';

  @override
  String get confirmEmailTitle => 'تأكيد البريد الإلكتروني';

  @override
  String get addPhoneNumber => 'إضافة رقم الهاتف';

  @override
  String get uploadProfilePicture => 'رفع صورة شخصية';

  @override
  String get updateProfile => 'تحديث الملف الشخصي';

  @override
  String get updateProfileMsg =>
      'هذه الميزة متاحة فقط للمستخدمين المسجلين كاملاً';

  @override
  String get chooseEducationLevel => 'اختر مستواك التعليمي';

  @override
  String get addLocation => 'أضف موقعك';

  @override
  String get confirmEmailMsg => 'يجب تأكيد بريدك الإلكتروني للمتابعة';

  @override
  String get openEmail => 'افتح البريد الإلكتروني';

  @override
  String get clickConfirmLink => 'اضغط على رابط التأكيد';

  @override
  String get subscriptionRequired => 'اشتراك مطلوب';

  @override
  String get subscriptionMsg => 'هذه الميزة متاحة للمشتركين فقط';

  @override
  String get subscribePremium => 'اشترك في الخطة المميزة';

  @override
  String get getExclusiveFeatures => 'احصل على مميزات حصرية';

  @override
  String get subscribeNow => 'اشترك الآن';

  @override
  String get goBack => 'العودة';

  @override
  String get yearsExperience => 'سنوات خبرة';

  @override
  String get teacherBio => 'نبذة عن المعلم';

  @override
  String get teachingDetails => 'تفاصيل التدريس';

  @override
  String get specialization => 'التخصص';

  @override
  String get availableClasses => 'الصفوف المتاحة';

  @override
  String get sendMessage => 'إرسال رسالة';

  @override
  String messageSentTo(String name) {
    return 'تم إرسال رسالة إلى $name';
  }

  @override
  String get previous => 'السابق';

  @override
  String get confirmBooking => 'تأكيد الحجز';

  @override
  String get bookingNumber => 'رقم الحجز';

  @override
  String get amountPaid => 'المبلغ المدفوع';

  @override
  String get cardEnding => 'البطاقة المنتهية برقم';

  @override
  String get noTimesAvailable => 'لا توجد أوقات متاحة حالياً';

  @override
  String get chooseSuitableTime => 'اختر الوقت المناسب';

  @override
  String get chooseDayTimeInstruction => 'اختر اليوم والوقت المناسب للحصة';

  @override
  String get aboutApp => 'حول التطبيق';

  @override
  String get developer => 'المطور';

  @override
  String get companyName => 'مدرسة العباقرة للتكنولوجيا';

  @override
  String get supportEmail => 'البريد الإلكتروني للدعم';

  @override
  String get supportPhone => 'هاتف الدعم';

  @override
  String get version => 'الإصدار';

  @override
  String get chooseLessonType => 'اختر نوع الدرس';

  @override
  String get chooseLessonTypeInstruction => 'اختر نوع الدرس المناسب لك';

  @override
  String get individualLessonSubtitle => 'درس خاص واحد لواحد';

  @override
  String groupLessonSubtitle(Object max, Object min) {
    return '$min-$max طلاب';
  }

  @override
  String get chooseSubject => 'اختر المادة';

  @override
  String get chooseSubjectInstruction => 'اختر المادة التي تريد دراستها';

  @override
  String get chooseLevel => 'اختر المرحلة';

  @override
  String get chooseLevelInstruction => 'اختر المرحلة الدراسية';

  @override
  String get chooseClass => 'اختر الصف';

  @override
  String get chooseClassInstruction => 'اختر الصف الدراسي';

  @override
  String get noClassesAvailable => 'لا توجد صفوف متاحة';

  @override
  String get confirmYourBooking => 'تأكيد حجزك';

  @override
  String get yourTeacher => 'معلمك';

  @override
  String get bookingDetails => 'تفاصيل الحجز';

  @override
  String get priceSummary => 'ملخص التكلفة';

  @override
  String get hourlyRate => 'سعر الساعة';

  @override
  String get cancellationPolicy => 'يمكنك إلغاء الحجز قبل 24 ساعة من الدرس';

  @override
  String get welcomeToGeniuses School => 'مرحباً بكم في مدرسة العباقرة';

  @override
  String get alreadyHaveAccount => 'لديك حساب بالفعل؟';

  @override
  String get sessionIdNotAvailable => 'رقم الجلسة غير متوفر';

  @override
  String get joinSessionFailed => 'فشل الانضمام للجلسة';

  @override
  String get proceedToPayment => 'متابعة الدفع';

  @override
  String get pleaseWait => 'الرجاء الانتظار ...';

  @override
  String paymentSuccessWithRef(String ref, String amount, String currency) {
    return 'تم الدفع بنجاح. رقم المرجع: $ref';
  }

  @override
  String get servicePrivateLessons => 'الدروس الخصوصية';

  @override
  String get servicePrivateLessonsDesc =>
      'دروس متنوعة بكل المواد التعليمية لجميع المراحل الدراسية.';

  @override
  String get serviceTrainingCourses => 'دورات تدريبية';

  @override
  String get serviceLanguageLearning => 'تعليم لغات';

  @override
  String get searchCourseHint => 'ابحث عن دورة...';

  @override
  String get filterCourses => 'تصفية الدورات';

  @override
  String get reset => 'إعادة تعيين';

  @override
  String get category => 'التصنيف';

  @override
  String get maxPrice => 'الحد الأقصى للسعر';

  @override
  String get chooseCategory => 'اختر التصنيف';

  @override
  String get applyFilters => 'تطبيق الفلاتر';

  @override
  String get instructor => 'المدرب';

  @override
  String get trainingHour => 'ساعة تدريبية';

  @override
  String get enrolledStudent => 'طالب مسجل';

  @override
  String get availableSeat => 'مقعد متاح';

  @override
  String get coursePrice => 'سعر الدورة';

  @override
  String get certificateIncluded => 'شامل الشهادة';

  @override
  String get courseDescription => 'وصف الدورة';

  @override
  String get coveredTopics => 'المواضيع المغطاة';

  @override
  String get startDate => 'تاريخ البدء';

  @override
  String get enrollInCourse => 'التسجيل في الدورة';

  @override
  String get requestEnrollment => 'طلب التحاق';

  @override
  String get enrollmentRequestSent =>
      'تم إرسال طلبك بنجاح. سيتواصل معك فريقنا خلال ٢٤ ساعة.';

  @override
  String get enrollmentRequestTitle => 'طلب التحاق';

  @override
  String get courseFull => 'الدورة مكتملة';

  @override
  String get confirmEnrollment => 'تأكيد التسجيل';

  @override
  String get totalAmount => 'المبلغ الإجمالي';

  @override
  String enrollSuccessMessage(String courseTitle) {
    return 'تم التسجيل بنجاح في دورة $courseTitle';
  }

  @override
  String get filterTeachers => 'تصفية المعلمين';

  @override
  String get serviceType => 'نوع الخدمة';

  @override
  String get minRatingLabel => 'الحد الأدنى للتقييم';

  @override
  String get activeFilters => 'الفلاتر النشطة';

  @override
  String get clearAll => 'مسح الكل';

  @override
  String get availableBookingTimes => 'الأوقات المتاحة للحجز';

  @override
  String bookingConfirmedMsg(String teacherName, String day, String time) {
    return 'تم حجز الدرس مع $teacherName يوم $day في $time';
  }

  @override
  String get choose => 'اختر';

  @override
  String get noData => 'لا توجد بيانات';

  @override
  String priceIndicator(int price) {
    return '≤ $price ريال/ساعة';
  }

  @override
  String ratingIndicator(String rating) {
    return '≥ $rating ⭐';
  }

  @override
  String unreadNotifications(int count) {
    return '$count غير مقروء';
  }

  @override
  String get markAllAsRead => 'تمييز الكل كمقروء';

  @override
  String get notificationsMarkedRead => 'تم تمييز جميع الإشعارات كمقروءة';

  @override
  String get notificationDeleted => 'تم حذف الإشعار';

  @override
  String get errorLoadingNotifications => 'حدث خطأ في تحميل الإشعارات';

  @override
  String get noNotifications => 'لا توجد إشعارات';

  @override
  String get allCaughtUp => 'أنت على اطلاع بكل شيء!';

  @override
  String get totalBalance => 'الرصيد الكلي';

  @override
  String get withdrawable => 'قابل للسحب';

  @override
  String get weeklyIncome => 'الدخل الأسبوعي';

  @override
  String get filterDatePlaceholder => 'التاريخ';

  @override
  String get filterStatusPlaceholder => 'الحالة';

  @override
  String get sessionStatusAll => 'الكل';

  @override
  String get sessionStatusLive => 'مباشر';

  @override
  String get sessionStatusEnded => 'منتهية';

  @override
  String get sessionStatusCancelled => 'ملغية';

  @override
  String get sessionStatusScheduled => 'مجدولة';

  @override
  String get sessionStatusWaitForTeacher => 'بانتظار المعلم';

  @override
  String get untitledSession => 'بدون عنوان';

  @override
  String get unspecifiedSubject => 'مادة غير محددة';

  @override
  String get statusLiveNow => 'مباشر الآن';

  @override
  String get statusFinished => 'منتهية';

  @override
  String get statusUpcoming => 'قادمة';

  @override
  String get sessionDetailsTitle => 'تفاصيل الجلسة';

  @override
  String get sessionStatusLabel => 'الحالة';

  @override
  String get sessionDurationLabel => 'مدة الجلسة';

  @override
  String get bookingTypeLabel => 'نوع الحجز';

  @override
  String get completedLabel => 'المكتمل';

  @override
  String get referenceNumberLabel => 'رقم المرجع';

  @override
  String get minutesPlaceholder => '-- دقيقة';

  @override
  String get unspecified => 'غير محدد';

  @override
  String get startSessionNow => 'ابدأ الجلسة الآن';

  @override
  String get joinSessionNow => 'انضم للجلسة الآن';

  @override
  String get sessionEndedMessage => 'الجلسة منتهية';

  @override
  String get sessionUpcomingMessage => 'الجلسة قادمة قريباً';

  @override
  String get joining => 'جاري الانضمام...';

  @override
  String get waitSettingUp => 'يرجى الانتظار، جاري إعداد الغرفة...';

  @override
  String get waitJoining => 'يرجى الانتظار، جاري الانضمام...';

  @override
  String get sessionEndedDescription =>
      'هذه الجلسة انتهت ولم تعد متاحة للانضمام';

  @override
  String get sessionUpcomingDescription =>
      'سيكون زر الدخول متاحاً عند بدء الجلسة';

  @override
  String get createAndEnterDescription =>
      'انقر لإنشاء غرفة الجلسة والدخول إليها';

  @override
  String get enterDescription => 'انقر للدخول إلى غرفة الجلسة';

  @override
  String get confirmLogout => 'تأكيد تسجيل الخروج';

  @override
  String get waitingForConnection => 'بانتظار الاتصال...';

  @override
  String couldNotLaunchUrl(String url) {
    return 'تعذر فتح الرابط $url';
  }

  @override
  String errorLabel(String error) {
    return 'خطأ: $error';
  }

  @override
  String get recentTransactions => 'المعاملات الأخيرة';

  @override
  String get confirmDeleteCourse => 'هل أنت متأكد أنك تريد حذف هذا الكورس؟';

  @override
  String get courseDeletedSuccess => 'تم حذف الكورس بنجاح';

  @override
  String get editCourse => 'تعديل الدورة';

  @override
  String get courseUpdatedSuccess => 'تم تحديث الدورة بنجاح';

  @override
  String get updateCourse => 'تحديث الدورة';

  @override
  String coursesAvailableCount(int count) {
    return '$count دورة متاحة';
  }

  @override
  String get errorLoadingCourses => 'حدث خطأ في تحميل الدورات';

  @override
  String get noCoursesFound => 'لم يتم العثور على دورات';

  @override
  String get adjustSearchCriteria => 'جرب تعديل معايير البحث';

  @override
  String get privateLessons => 'دروس خصوصية';

  @override
  String get abilities => 'قدرات و تحصيل';

  @override
  String get languageLearning => 'تعليم لغات';

  @override
  String get textbooks => 'الكتب الدراسية';

  @override
  String get withdraw => 'سحب';

  @override
  String get noTransactions => 'لا توجد معاملات متاحة.';

  @override
  String get cancelRequest => 'إلغاء الطلب';

  @override
  String get confirmCancelWithdrawal =>
      'هل أنت متأكد أنك تريد إلغاء طلب السحب هذا؟';

  @override
  String get yesCancel => 'نعم، إلغاء';

  @override
  String get requestCancelled => 'تم إلغاء الطلب بنجاح';

  @override
  String get withdrawProfits => 'سحب الأرباح';

  @override
  String get noBankAccounts => 'لا توجد حسابات بنكية';

  @override
  String get addBankAccountPrompt =>
      'يجب عليك إضافة حساب بنكي أولاً قبل تقديم طلب السحب. هل تريد الذهاب لإضافة حساب بنكي؟';

  @override
  String get withdrawRequest => 'طلب سحب أرباح';

  @override
  String get availableBalance => 'الرصيد المتاح';

  @override
  String get selectBankAccount => 'اختر الحساب البنكي';

  @override
  String get selectBankHint => 'أختر الحساب الذي ستتلقى فيه الأموال';

  @override
  String get withdrawalAmount => 'المبلغ المراد سحبه';

  @override
  String get minWithdrawalHint => 'الحد الأدنى: 10 ريال سعودي';

  @override
  String get enterAmount => 'يرجى إدخال المبلغ';

  @override
  String get amountMustBePositive => 'المبلغ يجب أن يكون أكبر من صفر';

  @override
  String get minWithdrawalError => 'الحد الأدنى للسحب هو 10 ريال';

  @override
  String insufficientBalance(String balance) {
    return 'المبلغ يتجاوز الرصيد المتاح ($balance ريال)';
  }

  @override
  String get confirmWithdrawal => 'تأكيد السحب';

  @override
  String get withdrawalRequested => 'تم تقديم طلب السحب بنجاح';

  @override
  String get statusApproved => 'تمت الموافقة';

  @override
  String get statusCancelled => 'ملغى';

  @override
  String get errorSelectBank => 'يرجى اختيار حساب بنكي';

  @override
  String get no => 'لا';

  @override
  String get statusConfirmed => 'مؤكد';

  @override
  String get lessonTypes => 'نوع الدروس المقدمة';

  @override
  String get individualLessons => 'دروس فردية';

  @override
  String get individualLessonsDesc => 'درس خاص واحد لواحد';

  @override
  String get groupLessons => 'دروس جماعية';

  @override
  String get groupLessonsDesc => 'مجموعة من الطلاب';

  @override
  String get hourlyRateSAR => 'سعر الساعة (ريال)';

  @override
  String get hourlyRatePerStudentSAR => 'سعر الساعة لكل طالب (ريال)';

  @override
  String get minGroupSize => 'أقل عدد';

  @override
  String get maxGroupSize => 'أكثر عدد';

  @override
  String get fieldRequired => 'مطلوب';

  @override
  String get selectStudyLevel => 'اختر الصف الدراسي';

  @override
  String get selectYourClass => 'اختر صفك الدراسي';

  @override
  String get searchTeacherHint => 'ابحث عن معلم...';

  @override
  String get statusInProgress => 'جاري الان';

  @override
  String get statusNew => 'جديد';

  @override
  String get timeLabel => 'الساعة:';

  @override
  String get studentCountLabel => 'طالب';

  @override
  String get perHourLabel => 'SAR / ساعة';

  @override
  String get educationalServices => 'الخدمات التعليمية';

  @override
  String get personalInfo => 'المعلومات الشخصية';

  @override
  String get bioTitle => 'نبذة تعريفية';

  @override
  String get bioHint => 'نبذة مختصرة عن نفسك';

  @override
  String get bioLabel => 'النبذة التعريفية';

  @override
  String get servicesProvided => 'الخدمات المقدمة';

  @override
  String get saveButton => 'حفظ';

  @override
  String get nextButton => 'التالي';

  @override
  String get uploadDocumentsTitle => 'رفع المستندات المطلوبة';

  @override
  String get uploadDocumentsDesc =>
      'يرجى رفع شهادة التخرج والسيرة الذاتية لإتمام التسجيل';

  @override
  String get gradCert => 'شهادة التخرج';

  @override
  String get gradCertDesc => 'شهادة التخرج الجامعية أو ما يعادلها';

  @override
  String get resume => 'السيرة الذاتية';

  @override
  String get resumeDesc => 'السيرة الذاتية أو ملف الإنجازات الأكاديمية';

  @override
  String get bothFilesRequired => 'يجب رفع كلا الملفين لإكمال عملية التسجيل';

  @override
  String get allFilesUploaded => 'رائع! تم رفع جميع المستندات المطلوبة';

  @override
  String get backButton => 'رجوع';

  @override
  String get saveFinishButton => 'حفظ وإنهاء';

  @override
  String get saving => 'جاري الحفظ...';

  @override
  String get progress => 'التقدم';

  @override
  String get uploadFile => 'رفع الملف';

  @override
  String get loadLanguagesError => 'حدث خطأ في تحميل اللغات';

  @override
  String get noLanguagesAdded => 'لا توجد لغات مضافة';

  @override
  String get addLanguagePrompt => 'اضغط على زر الإضافة لإضافة لغات';

  @override
  String get addLanguage => 'إضافة لغة';

  @override
  String get addLanguagesTitle => 'إضافة لغات';

  @override
  String get allLanguagesAdded => 'جميع اللغات المتاحة مضافة بالفعل';

  @override
  String get addAction => 'إضافة';

  @override
  String get deleteLanguageConfirm => 'هل أنت متأكد من حذف هذه اللغة؟';

  @override
  String get languageDeletedSuccess => 'تم حذف اللغة بنجاح';

  @override
  String get languageDeletedFail => 'فشل حذف اللغة';

  @override
  String get languageAddedSuccess => 'تم تحديث اللغات بنجاح';

  @override
  String get languageAddedFail => 'فشل تحديث اللغات';

  @override
  String get lessonsTitle => 'دروس';

  @override
  String get noLessonsForSubject => 'لا توجد دروس مضافة بعد لـ';

  @override
  String get addLesson => 'إضافة درس';

  @override
  String get addSubjectTitle => 'إضافة مادة دراسية';

  @override
  String get subjectAddedSuccess => 'تمت إضافة المادة بنجاح';

  @override
  String get loadingMessage => 'يرجى الانتظار';

  @override
  String get savingData => 'جاري حفظ البيانات...';

  @override
  String get select => 'المختار';

  @override
  String get selectNationality => 'اختر الجنسية';

  @override
  String get completeProfileTitle => 'أكمل بياناتك';

  @override
  String get confirmEmailAction => 'تأكيد البريد الإلكتروني';

  @override
  String get addPhoneAction => 'إضافة رقم الهاتف';

  @override
  String get uploadPhotoAction => 'رفع صورة شخصية';

  @override
  String get completeNowButton => 'إكمال الآن';

  @override
  String get cancelButton => 'إلغاء';

  @override
  String get updateProfileTitle => 'تحديث الملف الشخصي';

  @override
  String get updateProfileMessage =>
      'هذه الميزة متاحة فقط للمستخدمين المسجلين كاملاً';

  @override
  String get addLocationAction => 'أضف موقعك';

  @override
  String get emailConfirmationTitle => 'تأكيد البريد الإلكتروني';

  @override
  String get emailConfirmationMessage => 'يجب تأكيد بريدك الإلكتروني للمتابعة';

  @override
  String get openEmailApp => 'افتح البريد الإلكتروني';

  @override
  String get clickConfirmationLink => 'اضغط على رابط التأكيد';

  @override
  String get subscriptionMessage => 'هذه الميزة متاحة للمشتركين فقط';

  @override
  String get exclusiveFeatures => 'احصل على مميزات حصرية';

  @override
  String get happeningNow => 'جاري الان';

  @override
  String get newBadge => 'جديد';

  @override
  String get sarPerHour => 'SAR / ساعة';

  @override
  String get daysLabel => 'الأيام:';

  @override
  String get paymentVerification => 'التحقق من الدفع';

  @override
  String get cancelOperation => 'إلغاء العملية';

  @override
  String get cancelOperationMessage => 'هل تريد إلغاء عملية التحقق من الدفع؟';

  @override
  String get paymentSuccessTitle => 'نجح الدفع';

  @override
  String get paymentFailedTitle => 'فشل الدفع';

  @override
  String get paymentNotFound =>
      'لم يتم العثور على سجل الدفع. يرجى التحقق من البيانات والمحاولة مرة أخرى.';

  @override
  String get serverError =>
      'استجابة غير صحيحة من الخادم. يرجى المحاولة مرة أخرى.';

  @override
  String get unknownError => 'حدث خطأ غير معروف. يرجى المحاولة مرة أخرى.';

  @override
  String get formatError => 'خطأ في تنسيق البيانات. يرجى المحاولة مرة أخرى.';

  @override
  String get checkConnectivity =>
      'يرجى التحقق من الاتصال بالإنترنت والمحاولة مرة أخرى.';

  @override
  String get contactSupport =>
      'يرجى التواصل مع الدعم الفني إذا استمرت المشكلة.';

  @override
  String get platformNotSupported =>
      'عذراً، التحقق الثلاثي (3DS) غير مدعوم على هذه المنصة. يرجى استخدام جهاز أندرويد أو iOS.';

  @override
  String get walletLoadError => 'خطأ في تحميل المحفظة';

  @override
  String get cancelRequestTitle => 'إلغاء الطلب';

  @override
  String get withdrawalCancelled => 'تم إلغاء طلب السحب';

  @override
  String get manageSubjects => 'إدارة المواد الدراسية';

  @override
  String selectItem(Object item) {
    return 'اختر $item';
  }

  @override
  String get schedule => 'جدول المواعيد';

  @override
  String get offline => 'حضوري';

  @override
  String get todaysLessons => 'الدروس اليوم';

  @override
  String get expectedIncome => 'الدخل المتوقع';

  @override
  String get noLessonsToday => 'لا توجد دروس اليوم';

  @override
  String get enjoyYourDay => 'استمتع بيومك!';

  @override
  String get paymentSuccessMessage => 'تم الدفع بنجاح';

  @override
  String get teachers => 'المعلمون';

  @override
  String teachersAvailable(Object count) {
    return '$count معلم متاح';
  }

  @override
  String get noTeachersFound => 'لم يتم العثور على معلمين';

  @override
  String get tryAdjustingSearch => 'جرب تعديل معايير البحث';

  @override
  String get userIdNotFound => 'لم يتم العثور على معرف المستخدم';

  @override
  String get bookingId => 'رقم الحجز';

  @override
  String get errorCode => 'رمز الخطأ';

  @override
  String get paymentId => 'رقم الدفع';

  @override
  String get yes => 'نعم';

  @override
  String get courseCategoriesTitle => 'فئات الدورات التدريبية';

  @override
  String get paymentFailedDefault => 'فشل في الدفع';

  @override
  String bookingSuccessMessage(String bookingRef, String amount) {
    return 'تم الدفع بنجاح!\nرقم الحجز: $bookingRef\nالمبلغ: $amount';
  }

  @override
  String get bookingIdNotFound => 'خطأ: لم يتم العثور على رقم الحجز';

  @override
  String get kotoby => 'كتبي';

  @override
  String get bookings => 'الحجوزات';

  @override
  String get noBookings => 'لا توجد حجوزات حالياً';

  @override
  String get cancelBooking => 'إلغاء الحجز';

  @override
  String get confirmCancelBooking => 'هل أنت متأكد من إلغاء هذا الحجز؟';

  @override
  String get bookingCancelledSuccess => 'تم إلغاء الحجز بنجاح';

  @override
  String get bookingCancellationFailed => 'فشل إلغاء الحجز';

  @override
  String paymentSuccessWithCard(String cardNumber) {
    return 'تم الدفع بنجاح باستخدام البطاقة المنتهية برقم $cardNumber';
  }

  @override
  String get noSessions => 'لا توجد جلسات';

  @override
  String get errorLoadingSessions => 'حدث خطأ في تحميل الحصص';

  @override
  String get studentInfoLabel => 'معلومات الطالب';

  @override
  String get teacherInfoLabel => 'معلومات المعلم';

  @override
  String get mastercard => 'ماستركارد';

  @override
  String launchUrlError(String url) {
    return 'تعذر فتح الرابط $url';
  }

  @override
  String get connectionError => 'خطأ في الاتصال';

  @override
  String get selectGender => 'اختر الجنس';

  @override
  String get teaching => 'تدريس';

  @override
  String get learning => 'تعلم';

  @override
  String get room => 'غرفة';

  @override
  String get users => 'مستخدمين';

  @override
  String get connectingToClassroom => 'جاري الاتصال بالغرفة...';

  @override
  String get noVideoStreams => 'لا يوجد بث فيديو متاح';

  @override
  String get cameraOff => 'الكاميرا مغلقة';

  @override
  String get mute => 'كتم الصوت';

  @override
  String get unmute => 'إلغاء الكتم';

  @override
  String get startVideo => 'تشغيل الفيديو';

  @override
  String get stopVideo => 'إيقاف الفيديو';

  @override
  String get speakerOn => 'مكبر الصوت';

  @override
  String get speakerOff => 'سماعة الهاتف';

  @override
  String get leave => 'مغادرة';

  @override
  String get joinClassroom => 'انضمام للغرفة';

  @override
  String youRole(String role) {
    return 'أنت ($role)';
  }

  @override
  String get hand => 'اليد';

  @override
  String get shareScreen => 'مشاركة';

  @override
  String get muteAll => 'كتم الكل';

  @override
  String get flipCamera => 'قلب';

  @override
  String get video => 'فيديو';

  @override
  String get card => 'بطاقة';

  @override
  String get authRequired => 'تسجيل الدخول مطلوب';

  @override
  String get loginToSeeProfile => 'يرجى تسجيل الدخول لعرض وإدارة ملفك الشخصي';

  @override
  String get providedServices => 'الخدمات المقدمة';

  @override
  String get consultationSessions => 'جلسات استشارية';

  @override
  String get privateLesson => 'درس خصوصي';

  @override
  String get certificates => 'الشهادات';

  @override
  String get reviews => 'المراجعات';

  @override
  String get book => 'حجز جلسة';

  @override
  String get bookSession => 'حجز جلسة';

  @override
  String get lessonsLabel => 'دروس';

  @override
  String get teacherUnderReview => 'الحساب قيد المراجعة';

  @override
  String get teacherUnderReviewMessage =>
      'حسابك قيد المراجعة حالياً. يرجى الانتظار لحين التحقق من بياناتك. يمكنك التواصل مع الدعم الفني لمزيد من التفاصيل.';

  @override
  String get contactUs => 'اتصل بنا';

  @override
  String get profile_status_active => 'الحساب مفعل';

  @override
  String get profile_status_inactive => 'الحساب غير مفعل';

  @override
  String get profile_visible_to_students =>
      'جميع الطلاب يمكنهم رؤية ملفك الشخصي';

  @override
  String get profile_hidden_from_students => 'لا أحد يمكنه رؤية ملفك الشخصي';

  @override
  String get activate_to_start_earning => 'تفعيل الحساب لبدء الربح';

  @override
  String get total_earnings => 'إجمالي';

  @override
  String get errorUserNotFound => 'هذا الحساب غير مسجل لدينا.';

  @override
  String get endSessionConfirmation => 'هل أنت متأكد من إنهاء هذه الجلسة؟';

  @override
  String get endSession => 'إنهاء الجلسة';

  @override
  String get success => 'نجاح';

  @override
  String get chooseYourService => 'اختر خدمتك';

  @override
  String get uploadCertificate => 'رفع الشهادة';

  @override
  String get submit => 'إرسال';

  @override
  String get certificateRequired => 'الشهادة مطلوبة';

  @override
  String get uploadCv => 'رفع السيرة الذاتية';

  @override
  String get bio => 'نبذة تعريفية';

  @override
  String get certificateLabel => 'الشهادة';

  @override
  String get cvLabel => 'السيرة الذاتية';

  @override
  String get selectService => 'اختر الخدمة';

  @override
  String get fileTooLarge => 'حجم الملف كبير جداً (الحد الأقصى 5 ميجابايت)';

  @override
  String get continueBtn => 'متابعة';

  @override
  String get tutorial_earnings_desc =>
      'تابع أرباحك اليومية والشهرية من هنا بكل سهولة.';

  @override
  String get tutorial_sessions_desc =>
      'هنا تظهر دروسك القادمة واليومية لتنظيم وقتك.';

  @override
  String get tutorial_prices_desc => 'يمكنك عرض وتعديل أسعارك من هنا مباشرة.';

  @override
  String tutorial_services_desc(String specificTip) {
    return 'تحكم في خدماتك من هنا! $specificTip وتذكر أيضاً إضافة مواعيدك المتاحة وربط حسابك البنكي لسحب أرباحك بسهولة.';
  }

  @override
  String get tutorial_tip_language => 'أضف اللغات التي تدرسها.';

  @override
  String get tutorial_tip_subjects => 'أضف المواد التي تتخصص بها.';

  @override
  String get tutorial_tip_courses => 'أضف وأدر دوراتك التدريبية.';

  @override
  String get bankAccountMemo =>
      'يمكنك هنا إضافة حساباتك البنكية لاستخدامها في سحب أرباحك عن طريق طلب تحويل بنكي.';

  @override
  String get totalSessions => 'مجموع الحصص';

  @override
  String get tutorial_total_sessions_title => 'مجموع الحصص';

  @override
  String get tutorial_total_sessions_desc =>
      'اختر عدد الحصص المتتالية التي ترغب في حجزها وتحديد أوقاتها لاحقاً. سيتم مضاعفة السعر تلقائياً.';

  @override
  String get tutorial_student_home_title_notifications => 'الإشعارات';

  @override
  String get tutorial_student_home_desc_notifications =>
      'من هنا تتابع التنبيهات والطلبات الجديدة وحالة حصصك.';

  @override
  String get tutorial_student_home_title_teachers => 'أفضل المعلمين';

  @override
  String get tutorial_student_home_desc_teachers =>
      'تصفح قائمة بأفضل المعلمين واحجز حصصك مباشرة.';

  @override
  String get tutorial_student_home_title_services => 'خدماتنا';

  @override
  String get tutorial_student_home_desc_services =>
      'اكتشف الخدمات التعليمية المتنوعة التي نقدمها لك.';

  @override
  String get tutorial_student_home_title_courses => 'الدورات التدريبية';

  @override
  String get tutorial_student_home_desc_courses =>
      'انضم إلى دوراتنا التدريبية المميزة لتطوير مهاراتك.';

  @override
  String get tutorial_student_home_title_add_order => 'إضافة طلب';

  @override
  String get tutorial_student_home_desc_add_order =>
      'إذا لم تجد ما تبحث عنه، يمكنك إنشاء طلب تدريس مخصص من هنا.';

  @override
  String get tutorial_student_home_title_categories => 'تصنيفات الدورات';

  @override
  String get tutorial_student_home_desc_categories =>
      'استكشف تصنيفات الدورات المتاحة لتجد ما يناسب اهتماماتك.';

  @override
  String get session_timing_info =>
      'إذا قمت بزيادة عدد الحصص، فسيتم جدولتها في نفس اليوم ونفس الوقت في الأسابيع التالية.';
}
