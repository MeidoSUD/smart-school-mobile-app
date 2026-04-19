// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String failedToLoadData(String error) {
    return 'Failed to load data: $error';
  }

  @override
  String get paymentCancelled => 'Payment cancelled';

  @override
  String get bookLessonTitle => 'Book Lesson';

  @override
  String get loadingTeacherData => 'Loading teacher data...';

  @override
  String get invalidCheckoutId => 'Invalid checkout ID received';

  @override
  String get invalidPaymentUrl => 'Invalid payment URL received';

  @override
  String invalidUrl(String url) {
    return 'Invalid URL: $url';
  }

  @override
  String paymentFailedError(String error) {
    return 'Payment failed: $error';
  }

  @override
  String paymentProcessError(String error) {
    return 'Payment process error: $error';
  }

  @override
  String bookingFailedMessage(String message) {
    return 'Failed to book lesson: $message';
  }

  @override
  String get paymentSuccessDefault => 'Payment Successful';

  @override
  String get refresh => 'Refresh';

  @override
  String get noSavedCardsMessage =>
      'No saved cards. You will need to enter your card details in the next step.';

  @override
  String get newPaymentCard => 'New Payment Card';

  @override
  String get useAnotherCard => 'Use another card';

  @override
  String get creditCardVisaMaster => 'Credit Card (Visa/Master)';

  @override
  String get appTitle => 'Geniuses School';

  @override
  String get changeLanguage => 'Change Language';

  @override
  String get login => 'Login';

  @override
  String get email => 'Email';

  @override
  String get password => 'Password';

  @override
  String get forgotPassword => 'Forgot Password?';

  @override
  String get orLoginWith => 'Or login with';

  @override
  String get dontHaveAccount => 'Don\'t have an account?';

  @override
  String get register => 'Register';

  @override
  String get welcomeBack => 'Welcome Back!';

  @override
  String get pleaseLogin => 'Please login to your account';

  @override
  String get emailOrPhone => 'Email or Mobile Number';

  @override
  String get enterEmailOrPhone => 'Enter your email or mobile';

  @override
  String get enterPassword => 'Enter Password';

  @override
  String get requiredField => 'This field is required';

  @override
  String get passwordMinLength => 'Password must be at least 8 characters';

  @override
  String get loggingIn => 'Logging in...';

  @override
  String get registerNow => 'Register Now';

  @override
  String get errorOccurred => 'An error occurred';

  @override
  String get retry => 'Retry';

  @override
  String get goToLogin => 'Go to Login';

  @override
  String get internetConnectionError => 'Internet connection error';

  @override
  String get connectionTimeout => 'Connection timeout';

  @override
  String get sessionExpired => 'Session expired';

  @override
  String get unexpectedError => 'Unexpected error';

  @override
  String get createAccount => 'Create New Account';

  @override
  String get joinCommunity => 'Join Geniuses School Educational Community';

  @override
  String get fullName => 'Full Name';

  @override
  String get firstName => 'First Name';

  @override
  String get lastName => 'Last Name';

  @override
  String get required => 'Required';

  @override
  String get invalidEmail => 'Invalid email';

  @override
  String get phoneNumber => 'Mobile Number';

  @override
  String get tooLong => 'Too long';

  @override
  String get nationality => 'Nationality';

  @override
  String get gender => 'Gender';

  @override
  String get strongPassword => 'Enter a strong password';

  @override
  String get agreeTo => 'I agree to ';

  @override
  String get termsConditions => 'Terms & Conditions';

  @override
  String get and => ' and ';

  @override
  String get privacyPolicy => 'Privacy Policy';

  @override
  String get registerButton => 'Register New Account';

  @override
  String get registering => 'Registering...';

  @override
  String get acceptTermsError => 'Please agree to the Terms & Conditions';

  @override
  String get chooseYourRole => 'Choose Your Role';

  @override
  String get howToUseApp => 'How do you want to use Geniuses School?';

  @override
  String get student => 'Student';

  @override
  String get studentDescription =>
      'Learn new skills, get private lessons, study languages, and join courses to improve your knowledge';

  @override
  String get teacher => 'Teacher';

  @override
  String get teacherDescription =>
      'Give private lessons, teach languages, share your expertise, and provide training courses for students';

  @override
  String get continueText => 'Continue';

  @override
  String get resetPassword => 'Reset Password';

  @override
  String get enterRegisteredPhone =>
      'Enter your registered phone number to receive a verification code';

  @override
  String get codeSent => 'Code Sent!';

  @override
  String get codeSentToPhone =>
      'Verification code has been sent to your phone number';

  @override
  String get sendVerificationCode => 'Send Verification Code';

  @override
  String get enterPhoneNumberError => 'Please enter phone number';

  @override
  String get invalidPhoneNumberError => 'Phone number must be 9 digits';

  @override
  String get codeResent => 'Code sent again';

  @override
  String get codeResendFailed => 'Failed to send code. Try again';

  @override
  String get enterFullCode => 'Please enter the full code';

  @override
  String get errorTryAgain => 'Error. Please try again';

  @override
  String get invalidVerificationCode => 'Invalid verification code';

  @override
  String get networkError =>
      'Failed to connect to server. Please check your internet connection.';

  @override
  String get codeExpired => 'Code expired. Resend it';

  @override
  String get timeoutError => 'Timeout. Try again';

  @override
  String genericError(String error) {
    return 'Error: $error';
  }

  @override
  String get close => 'Close';

  @override
  String get error => 'Error';

  @override
  String get ok => 'OK';

  @override
  String get verify => 'Verify';

  @override
  String get allOrders => 'All Orders';

  @override
  String get noOrders => 'No orders found';

  @override
  String get errorLoadingOrders => 'Error loading orders';

  @override
  String get orderAppliedSuccess => 'Applied successfully';

  @override
  String get orderApplyFailed => 'Failed to apply';

  @override
  String get overview => 'Overview';

  @override
  String get wallet => 'Wallet';

  @override
  String get lessons => 'Lessons';

  @override
  String get requestTeachingSession => 'Request Teaching Session';

  @override
  String get bookPrivateSession => 'Book a private teaching session';

  @override
  String get academicDetails => 'Academic Details';

  @override
  String get educationLevel => 'Education Level';

  @override
  String get selectEducationLevel => 'Select Education Level';

  @override
  String get noEducationLevelsAvailable => 'No education levels available';

  @override
  String get loadingEducationLevelsFailed => 'Failed to load education levels';

  @override
  String get grade => 'Grade';

  @override
  String get selectGrade => 'Select Grade';

  @override
  String get selectGradeFirst => 'Select Grade First';

  @override
  String get noGradesAvailable => 'No grades available';

  @override
  String get selectEducationLevelFirst => 'Select Education Level First';

  @override
  String get loadingGradesFailed => 'Failed to load grades';

  @override
  String get subject => 'Subject';

  @override
  String get selectSubject => 'Select Subject';

  @override
  String get noSubjectsAvailable => 'No subjects available';

  @override
  String get loadingSubjectsFailed => 'Failed to load subjects';

  @override
  String get sessionType => 'Session Type';

  @override
  String get online => 'Online';

  @override
  String get videoSession => 'Video Session';

  @override
  String get inPerson => 'In Person';

  @override
  String get faceToFace => 'Face to Face';

  @override
  String get dateTime => 'Date and Time';

  @override
  String get date => 'Date';

  @override
  String get selectDate => 'Select Date';

  @override
  String get time => 'Time';

  @override
  String get selectTime => 'Select Time';

  @override
  String get durationAndPrice => 'Duration and Price';

  @override
  String get hoursCount => 'Number of Hours';

  @override
  String get enterHoursCount => 'Enter number of hours';

  @override
  String get pricePerHour => 'Price per Hour';

  @override
  String get enterProposedPrice => 'Enter proposed price';

  @override
  String get priority => 'Priority';

  @override
  String get sessionDescription => 'Session Description';

  @override
  String get sessionDetails => 'Session Details';

  @override
  String get writeSessionDetails =>
      'Write details of what you need help with...';

  @override
  String get hoursRequired => 'Number of hours required';

  @override
  String get invalidHours => 'Invalid number of hours';

  @override
  String get priceRequired => 'Price is required';

  @override
  String get invalidPrice => 'Invalid price';

  @override
  String get descriptionRequired => 'Session description required';

  @override
  String get viewAll => 'View All';

  @override
  String get search => 'Search...';

  @override
  String get sendRequest => 'Send Request';

  @override
  String get requestSentSuccess => 'Request sent successfully!';

  @override
  String get requestSentFailed => 'Failed to send request';

  @override
  String get lowPriority => 'Low';

  @override
  String get normalPriority => 'Normal';

  @override
  String get highPriority => 'High';

  @override
  String get urgentPriority => 'Urgent';

  @override
  String get languages => 'Languages';

  @override
  String get courses => 'Courses';

  @override
  String get rating => 'Rating';

  @override
  String get newOrders => 'New Orders';

  @override
  String get noNewOrders => 'No new orders';

  @override
  String get newOrdersWillAppearHere => 'New orders will appear here';

  @override
  String get viewAllOrders => 'View All Orders';

  @override
  String get serviceManagement => 'Service Management';

  @override
  String get manageStagesAndSubjects => 'Manage Stages & Subjects';

  @override
  String get manageCourses => 'Manage Courses';

  @override
  String get manageLanguages => 'Manage Languages';

  @override
  String get mySchedule => 'My Schedule';

  @override
  String get all => 'All';

  @override
  String get pending => 'Pending';

  @override
  String get accepted => 'Accepted';

  @override
  String get rejected => 'Rejected';

  @override
  String get status => 'Status';

  @override
  String get myOrders => 'My Orders';

  @override
  String get unknownSubject => 'Unknown Subject';

  @override
  String get completed => 'Completed';

  @override
  String get cancelled => 'Cancelled';

  @override
  String get notSpecified => 'Not Specified';

  @override
  String get teachersApplicationsCount => 'Teachers Applications';

  @override
  String get price => 'Price';

  @override
  String get currency => 'SAR';

  @override
  String get creationDate => 'Creation Date';

  @override
  String get orderDetailsNotAvailable =>
      'Order details not available currently';

  @override
  String get noOrdersNow => 'No orders currently';

  @override
  String get topTeachers => 'Top Teachers';

  @override
  String get ourServices => 'Our Services';

  @override
  String get trainingCourses => 'Training Courses';

  @override
  String get noCoursesAvailable => 'No courses available.';

  @override
  String get subjects => 'Subjects';

  @override
  String get courseCategories => 'Course Categories';

  @override
  String get errorLoadingCategories => 'Error loading categories';

  @override
  String get noCategoriesAvailable => 'No categories available currently';

  @override
  String get earnings => 'Earnings';

  @override
  String get mySessions => 'My Sessions';

  @override
  String get myProfile => 'My Profile';

  @override
  String get home => 'Home';

  @override
  String get myLessons => 'My Lessons';

  @override
  String get profile => 'Profile';

  @override
  String get addOrder => 'Add Order';

  @override
  String get errorForbidden =>
      'You do not have sufficient permissions to access this resource, please login again';

  @override
  String get errorPrefix => 'Error: ';

  @override
  String get hour => 'hour';

  @override
  String get hourShort => 'hr';

  @override
  String get minute => 'minute';

  @override
  String get minuteShort => 'min';

  @override
  String get session => 'Session';

  @override
  String get unknown => 'Unknown';

  @override
  String get finished => 'Finished';

  @override
  String get upcoming => 'Upcoming';

  @override
  String get join => 'Join';

  @override
  String get start => 'Start';

  @override
  String get apply => 'Apply';

  @override
  String get statusPending => 'Pending';

  @override
  String get statusAccepted => 'Accepted';

  @override
  String get statusRejected => 'Rejected';

  @override
  String get viewAllCategories => 'View All Categories';

  @override
  String get noCategoriesDescription =>
      'When new categories are available, they will appear here';

  @override
  String get myServices => 'My Services';

  @override
  String get service => 'Service';

  @override
  String get perHour => '/ hr';

  @override
  String get reject => 'Reject';

  @override
  String get accept => 'Accept';

  @override
  String get statusUrgent => 'Urgent';

  @override
  String get statusCompleted => 'Completed';

  @override
  String get searchOrdersHint => 'Search orders...';

  @override
  String get noResults => 'No results found';

  @override
  String get tryDifferentSearch => 'Try searching with different words';

  @override
  String get noOrdersFilter => 'No orders with this filter';

  @override
  String get newOrdersDescription => 'New orders will appear here';

  @override
  String get orderInfo => 'Order Information';

  @override
  String get level => 'Level';

  @override
  String get lessonType => 'Lesson Type';

  @override
  String get description => 'Description';

  @override
  String get orderDetails => 'Order Details';

  @override
  String get viewDetailsBook => 'View Details & Book';

  @override
  String availableDays(int count) {
    return '$count Available Days';
  }

  @override
  String otherSubjects(int count) {
    return 'and $count other subjects';
  }

  @override
  String get individualLesson => 'Individual';

  @override
  String get groupLesson => 'Group';

  @override
  String get teacherDashboard => 'Teacher Dashboard';

  @override
  String get today => 'Today';

  @override
  String get thisMonth => 'This Month';

  @override
  String get total => 'Total';

  @override
  String get currentBalance => 'Current Balance';

  @override
  String get totalLessons => 'Total Lessons';

  @override
  String get ongoingLessons => 'Ongoing Lessons';

  @override
  String get newPassword => 'New Password';

  @override
  String get confirmPassword => 'Confirm Password';

  @override
  String get reEnterPassword => 'Re-enter Password';

  @override
  String get setPassword => 'Set Password';

  @override
  String get passwordChanged => 'Password Changed!';

  @override
  String get passwordChangedSuccess => 'New password has been set successfully';

  @override
  String get passwordMismatch => 'Passwords do not match';

  @override
  String get passwordRequired => 'Please enter password';

  @override
  String get confirmPasswordRequired => 'Please confirm password';

  @override
  String get passwordStrengthHint =>
      'Use uppercase, lowercase, numbers, and special characters';

  @override
  String get currentPassword => 'Current Password';

  @override
  String get currentPasswordRequired => 'Please enter current password';

  @override
  String get scheduleEmptyState => 'No appointments for this day';

  @override
  String dayTimes(String day) {
    return '$day Times';
  }

  @override
  String timesCount(int count) {
    return '$count Times';
  }

  @override
  String get noAppointmentsNow => 'No appointments for this day';

  @override
  String get addAppointmentHint => 'Press + to add a new appointment';

  @override
  String get availableTime => 'Available Time';

  @override
  String get bookedTime => 'Booked Time';

  @override
  String get removeTime => 'Remove Time';

  @override
  String get addAvailableTime => 'Add Available Time';

  @override
  String todayDay(String day) {
    return 'Day: $day';
  }

  @override
  String get add => 'Add';

  @override
  String get errorUnauthorized =>
      'Your session has expired, please login again';

  @override
  String get errorConnectionTimeout =>
      'Connection timeout, check your internet';

  @override
  String get errorReceiveTimeout => 'Server took too long to respond';

  @override
  String get errorConnectionError =>
      'Failed to connect to server, check your network';

  @override
  String get errorServerError => 'Error communicating with server';

  @override
  String get errorFormat => 'Data format error';

  @override
  String get errorGeneral =>
      'An unknown error occurred, please try again later';

  @override
  String get errorConnectionFailed => 'Failed to connect to server';

  @override
  String get errorNotFound => 'The requested resource was not found';

  @override
  String get errorCredentials => 'Credentials are incorrect';

  @override
  String get errorUnexpected => 'Unexpected server error';

  @override
  String get cancel => 'Cancel';

  @override
  String get completeProfile => 'Complete Profile';

  @override
  String get completeProfileMessage =>
      'To access lessons, you must complete your account information';

  @override
  String get completeProfileButton => 'Complete Now';

  @override
  String get later => 'Later';

  @override
  String get selectRoleReq => 'Select Role';

  @override
  String get basicInfoReq => 'Basic Information';

  @override
  String get verifyAccountReq => 'Verify Account';

  @override
  String get unsupportedFileType => 'Unsupported file type';

  @override
  String get processingPdf => 'Processing PDF...';

  @override
  String get imageLoadFailed => 'Failed to load image';

  @override
  String get downloadingPdf => 'Downloading PDF...';

  @override
  String get pdfDownloadFailed => 'Failed to download PDF';

  @override
  String get emptyPdfFile => 'Empty PDF file';

  @override
  String pdfPages(int count) {
    return 'PDF ($count pages)';
  }

  @override
  String get pdfFile => 'PDF File';

  @override
  String get clickToUpload => 'Click to upload file';

  @override
  String get uploaded => 'Uploaded';

  @override
  String get fileTypes => 'PNG, JPG or PDF';

  @override
  String get managePaymentMethods => 'Manage Payment Methods';

  @override
  String get manageBankAccount => 'Manage Bank Account';

  @override
  String get selectPaymentMethod => 'Select Payment Method';

  @override
  String amountDue(int amount) {
    return 'Amount Due: $amount SAR';
  }

  @override
  String get savedCards => 'Saved Cards';

  @override
  String cardsLoadError(String error) {
    return 'Error loading cards: $error';
  }

  @override
  String get addNewCard => 'Add New Card';

  @override
  String get addNewBankAccount => 'Add New Bank Account';

  @override
  String get visa => 'Visa';

  @override
  String get masterCard => 'MasterCard';

  @override
  String get mada => 'Mada';

  @override
  String get back => 'Back';

  @override
  String get newCardDetails => 'New Card Details';

  @override
  String get cardType => 'Card Type';

  @override
  String get bankAccountType => 'Bank Account Type';

  @override
  String get cardNumber => 'Card Number';

  @override
  String get cardNumberHint => '0000 0000 0000 0000';

  @override
  String get cardHolderName => 'Cardholder Name';

  @override
  String get cardHolderNameHint => 'Name as on card';

  @override
  String get accountHolderName => 'Account Holder Name';

  @override
  String get expiryDate => 'Expiry Date';

  @override
  String get month => 'Month';

  @override
  String get monthHint => 'MM';

  @override
  String get year => 'Year';

  @override
  String get yearHint => 'YY';

  @override
  String get cvv => 'CVV';

  @override
  String get cvvHint => '000';

  @override
  String get securityNotice =>
      'Your card details are protected by the highest security standards';

  @override
  String get cardDefault => 'Default Card';

  @override
  String get continuePayment => 'Continue Payment';

  @override
  String get verifyCard => 'Verify Your Card';

  @override
  String get enterCvvSecurely => 'Enter CVV to complete payment securely';

  @override
  String get transactionSecure =>
      'Your transaction is protected by the highest security levels';

  @override
  String get confirmPayment => 'Confirm Payment';

  @override
  String get paymentSuccess => 'Payment Successful';

  @override
  String get paymentFailed => 'Payment Failed';

  @override
  String get cvvRequired => 'CVV is required';

  @override
  String get cvvInvalidLength => 'CVV must be at least 3 digits';

  @override
  String get bookingIdRequired =>
      'Error: Booking ID is required to complete payment';

  @override
  String paymentMessageSuccess(String message) {
    return 'Payment Successful: $message';
  }

  @override
  String paymentMessageFailed(String message) {
    return 'Payment Failed: $message';
  }

  @override
  String get cardAddedSuccess => 'Card added successfully';

  @override
  String get cardUpdatedSuccess => 'Card updated successfully';

  @override
  String get cardDeletedSuccess => 'Card deleted successfully';

  @override
  String get cardDefaultSet => 'Default card set successfully';

  @override
  String get deleteCardConfirmTitle => 'Confirm Deletion';

  @override
  String get deleteCardConfirmMessage =>
      'Are you sure you want to delete this payment method?';

  @override
  String get delete => 'Delete';

  @override
  String get deleteAccount => 'Delete Account';

  @override
  String get deleteAccountConfirmation =>
      'Are you sure you want to delete your account? This action cannot be undone.';

  @override
  String get noCards => 'No cards';

  @override
  String get noCardsDescription => 'Click the button below to add a new card';

  @override
  String cardAddError(String error) {
    return 'Error: $error';
  }

  @override
  String get subjectMathAlgebra => 'Math - Algebra';

  @override
  String get subjectPhysicsMechanics => 'Physics - Mechanics';

  @override
  String get subjectOrganicChemistry => 'Organic Chemistry';

  @override
  String get subjectEnglishGrammar => 'English - Grammar';

  @override
  String get subjectBiologyGenetics => 'Biology - Genetics';

  @override
  String get subjectMathStatistics => 'Math - Statistics';

  @override
  String get subjectPhysicsElectricity => 'Physics - Electricity';

  @override
  String get subjectProgrammingPython => 'Programming - Python';

  @override
  String get subjectArabicGrammar => 'Arabic - Grammar';

  @override
  String get subjectGeography => 'Geography';

  @override
  String get levelSecondary => 'Secondary';

  @override
  String get levelIntermediate => 'Intermediate';

  @override
  String get levelUniversity => 'University';

  @override
  String get lessonTypeInPerson => 'In-person';

  @override
  String get lessonTypeOnline => 'Online';

  @override
  String get descMathAlgebra =>
      'Need help understanding quadratic equations and linear functions. Exam coming up.';

  @override
  String get descPhysicsMechanics =>
      'Explanation of Newton\'s laws of motion and practical applications.';

  @override
  String get descOrganicChemistry =>
      'Lessons on organic compounds and chemical reactions.';

  @override
  String get descEnglishGrammar => 'Improving grammar and academic writing.';

  @override
  String get descBiologyGenetics =>
      'Understanding Mendel\'s laws and genetic engineering.';

  @override
  String get descMathStatistics =>
      'Help with descriptive and inferential statistics.';

  @override
  String get descPhysicsElectricity =>
      'Explanation of electric circuits and Ohm\'s law.';

  @override
  String get descProgrammingPython => 'Learning programming basics in Python.';

  @override
  String get descArabicGrammar => 'Explanation of grammar and syntax rules.';

  @override
  String get descGeography => 'Studying physical and human geography.';

  @override
  String get editBankAccount => 'Edit Bank Account';

  @override
  String get addBankAccount => 'Add Bank Account';

  @override
  String get editCard => 'Edit Card';

  @override
  String get addCard => 'Add Payment Card ';

  @override
  String get forReceivingEarnings => 'For receiving your earnings';

  @override
  String get forBookingLessons => 'For booking lessons';

  @override
  String get selectBank => 'Select Bank';

  @override
  String get enterIban => 'Enter IBAN';

  @override
  String get nameAsInBank => 'Name as in Bank';

  @override
  String get tooShort => 'Too short';

  @override
  String get earningsTransferNotice =>
      'Your earnings will be transferred to this account';

  @override
  String get selectType => 'Select Type';

  @override
  String get nameOnCard => 'Name on Card';

  @override
  String get detailsProtected => 'Your details are protected';

  @override
  String get save => 'Save';

  @override
  String get bank => 'Bank';

  @override
  String get iban => 'IBAN Number';

  @override
  String get accountNumber => 'Account Number';

  @override
  String get verificationHeader => 'Code Verification';

  @override
  String get codeSentToUser => 'Verification code sent to';

  @override
  String get resendCodeIn => 'Resend code in ';

  @override
  String get seconds => 'seconds';

  @override
  String get resendCode => 'Resend Code';

  @override
  String get errorLoadingBanks => 'Error loading banks: ';

  @override
  String get invalid => 'Invalid value';

  @override
  String get edit => 'Edit';

  @override
  String get gallery => 'Gallery';

  @override
  String get camera => 'Camera';

  @override
  String get title => 'Title';

  @override
  String get seats => 'Seats';

  @override
  String get registeredStudents => 'Registered Students';

  @override
  String get noStudentData => 'No student data';

  @override
  String seatsCount(int count) {
    return '$count Seats';
  }

  @override
  String hoursShort(int count) {
    return '$count hr';
  }

  @override
  String enter(String field) {
    return 'Enter $field';
  }

  @override
  String get selectRole => 'Select Role';

  @override
  String get decline => 'Decline';

  @override
  String get saveChanges => 'Save Changes';

  @override
  String get changesSaved => 'Changes Saved';

  @override
  String get availableTimesTitle => 'Available Times';

  @override
  String get addTime => 'Add Time';

  @override
  String timeExistsError(String time) {
    return 'Time $time already exists or is too close to another time';
  }

  @override
  String timeAddedSuccess(String time) {
    return 'Time $time added successfully';
  }

  @override
  String timeRemovedSuccess(String time) {
    return 'Time $time removed successfully';
  }

  @override
  String get available => 'Available';

  @override
  String get booked => 'Booked';

  @override
  String get manageSubjectsTitle => 'Subject Management';

  @override
  String get noSubjects => 'No Subjects';

  @override
  String get startAddingSubjects => 'Start adding subjects';

  @override
  String get filterBy => 'Filter By';

  @override
  String get educationalLevel => 'Educational Level';

  @override
  String get schoolClass => 'School Class';

  @override
  String get selectLevel => 'Select Study Level';

  @override
  String get selectClass => 'Select Class';

  @override
  String get selectLevelFirst => 'Select Level First';

  @override
  String get confirmDelete => 'Confirm Delete';

  @override
  String confirmDeleteSubject(String name) {
    return 'Are you sure you want to delete this subject?';
  }

  @override
  String get addClass => 'Add Class';

  @override
  String get addSubject => 'Add Subject';

  @override
  String subjectsOf(String name) {
    return 'Subjects of $name';
  }

  @override
  String classesOf(String name) {
    return 'Classes of $name';
  }

  @override
  String get saturday => 'Saturday';

  @override
  String get sunday => 'Sunday';

  @override
  String get monday => 'Monday';

  @override
  String get tuesday => 'Tuesday';

  @override
  String get wednesday => 'Wednesday';

  @override
  String get thursday => 'Thursday';

  @override
  String get friday => 'Friday';

  @override
  String get editProfile => 'Edit Profile';

  @override
  String get changePassword => 'Change Password';

  @override
  String get manageTimes => 'Manage Times';

  @override
  String get manageLevelsSubjects => 'Manage Levels & Subjects';

  @override
  String get myWallet => 'My Wallet';

  @override
  String get myBookings => 'My Bookings';

  @override
  String get notifications => 'Notifications';

  @override
  String get logout => 'Logout';

  @override
  String get logoutConfirmation => 'Are you sure you want to logout?';

  @override
  String get loggingOut => 'Logging out...';

  @override
  String get confirm => 'Confirm';

  @override
  String get saveSuccess => 'Saved successfully';

  @override
  String saveFailed(String error) {
    return 'Save failed: $error';
  }

  @override
  String get pickFileError => 'Error picking file';

  @override
  String get fileReadError => 'Failed to read file';

  @override
  String get passwordStrengthVeryWeak => 'Very Weak';

  @override
  String get passwordStrengthWeak => 'Weak';

  @override
  String get passwordStrengthMedium => 'Medium';

  @override
  String get passwordStrengthStrong => 'Strong';

  @override
  String get verificationDataMissing => 'Verification data missing';

  @override
  String get setNewPasswordTitle => 'Set New Password';

  @override
  String get setNewPasswordSubtitle =>
      'Please enter a strong and secure password';

  @override
  String get skip => 'Skip';

  @override
  String get next => 'Next';

  @override
  String get onboardingTitle1 => 'Geniuses School is Here';

  @override
  String get onboardingDesc1 =>
      'A success story starts with a vision and becomes reality. We elevate education and build genius humans.';

  @override
  String get onboardingBtn1 => 'What\'s Next?';

  @override
  String get onboardingTitle2 => 'Geniuses School Welcomes You';

  @override
  String get onboardingDesc2 =>
      'Our mission is to build an educated generation capable of facing future challenges.';

  @override
  String get onboardingBtn2 => 'Next...';

  @override
  String get onboardingTitle3 => 'Start Your Journey';

  @override
  String get onboardingDesc3 =>
      'Join our educational community and start your journey towards a bright future.';

  @override
  String get onboardingBtn3 => 'Let\'s Start';

  @override
  String get teacherOrdersTitle => 'Teacher Orders';

  @override
  String get removeFilters => 'Remove Filters';

  @override
  String requestCount(int count) {
    return '$count Request';
  }

  @override
  String requestAccepted(String name) {
    return 'Request for $name accepted';
  }

  @override
  String get undo => 'Undo';

  @override
  String get rejectRequestTitle => 'Reject Request';

  @override
  String rejectRequestMessage(String name) {
    return 'Are you sure you want to reject request from $name?';
  }

  @override
  String get requestRejected => 'Request rejected';

  @override
  String get lessonNotStarted => 'Lesson has not started yet';

  @override
  String roomCreationFailed(String error) {
    return 'Failed to create room: $error';
  }

  @override
  String get lessonNotStartedRetry =>
      'Lesson has not started yet. Please try again later';

  @override
  String joinFailed(String error) {
    return 'Failed to join: $error';
  }

  @override
  String errorTitle(String error) {
    return 'Error: $error';
  }

  @override
  String get cannotOpenLink => 'Cannot open link';

  @override
  String get lessonInProgress => 'Lesson is in progress';

  @override
  String get comingSoon => 'Coming Soon';

  @override
  String get lessonInfo => 'Lesson Info';

  @override
  String get duration => 'Duration';

  @override
  String minutesCount(int count) {
    return '$count Minutes';
  }

  @override
  String get creatingRoom => 'Creating Room...';

  @override
  String get joiningRoom => 'Joining room...';

  @override
  String get createAndJoin => 'Create Room & Join';

  @override
  String get enterLesson => 'Enter Lesson';

  @override
  String get lessonComingSoon => 'Lesson is coming soon';

  @override
  String get pleaseWaitCreating => 'Please wait, setting up room...';

  @override
  String get pleaseWaitJoining => 'Please wait, joining...';

  @override
  String get clickToCreateAndJoin => 'Click to create and join lesson room';

  @override
  String get clickToJoin => 'Click to join lesson room';

  @override
  String get joinButtonAvailableLater =>
      'Join button will be available when lesson starts';

  @override
  String get lessonTime => 'Lesson Time';

  @override
  String get liveNow => 'Live Now';

  @override
  String get errorLoadingData => 'Error loading data';

  @override
  String get noLessonInfo => 'No lesson information';

  @override
  String get activeLesson => 'Active Lesson';

  @override
  String get students => 'Students';

  @override
  String get missedLessonsCount => 'Missed Lessons';

  @override
  String get phoneNumberHint => '5xxxxxxxx';

  @override
  String get aboutTeacher => 'About Teacher';

  @override
  String get subjectsTaught => 'Subjects Taught';

  @override
  String get chooseSessionTimes => 'Choose Session Times';

  @override
  String get bookNowInstruction =>
      'Click \'Book Now\' to choose level, class, subject and suitable time';

  @override
  String get bookNow => 'Book Now';

  @override
  String availableSeatsCount(int count) {
    return '$count Seats Available';
  }

  @override
  String get details => 'Details';

  @override
  String get levelBeginner => 'Beginner';

  @override
  String get levelAdvanced => 'Advanced';

  @override
  String get levelUnknown => 'Unknown';

  @override
  String minMaxStudents(int min, int max) {
    return '$min-$max Students';
  }

  @override
  String get perHourText => 'Per Hour';

  @override
  String get addCourse => 'Add Course';

  @override
  String get coverImageRequired => 'Please select cover image';

  @override
  String get availableSlotsRequired => 'Please add available slots';

  @override
  String get courseAddedSuccess => 'Course added successfully';

  @override
  String get saveCourse => 'Save Course';

  @override
  String get courseTitleAr => 'Course Title (Arabic)';

  @override
  String get courseTitleEn => 'Course Title (English)';

  @override
  String get hours => 'Hours';

  @override
  String get weeklyAvailableSlots => 'Available Slots (Weekly)';

  @override
  String get noSlotsAdded => 'No slots added';

  @override
  String get courseType => 'Course Type';

  @override
  String get typeSingle => 'Single';

  @override
  String get typeGroup => 'Group';

  @override
  String get male => 'Male';

  @override
  String get female => 'Female';

  @override
  String get other => 'Other';

  @override
  String get optional => '(Optional)';

  @override
  String get countryQatar => 'Qatar';

  @override
  String get countryEgypt => 'Egypt';

  @override
  String get countrySaudi => 'Saudi Arabia';

  @override
  String get countrySudan => 'Sudan';

  @override
  String get countryUAE => 'United Arab Emirates';

  @override
  String get countryKuwait => 'Kuwait';

  @override
  String get countryBahrain => 'Bahrain';

  @override
  String get countryOman => 'Oman';

  @override
  String get countryYemen => 'Yemen';

  @override
  String get countryJordan => 'Jordan';

  @override
  String get countrySyria => 'Syria';

  @override
  String get countryLebanon => 'Lebanon';

  @override
  String get countryPalestine => 'Palestine';

  @override
  String get countryIraq => 'Iraq';

  @override
  String get countryLibya => 'Libya';

  @override
  String get countryTunisia => 'Tunisia';

  @override
  String get countryAlgeria => 'Algeria';

  @override
  String get countryMorocco => 'Morocco';

  @override
  String get countryMauritania => 'Mauritania';

  @override
  String get countrySomalia => 'Somalia';

  @override
  String get countryDjibouti => 'Djibouti';

  @override
  String get countryComoros => 'Comoros';

  @override
  String get countryTurkey => 'Turkey';

  @override
  String get countryIndonesia => 'Indonesia';

  @override
  String get countryMalaysia => 'Malaysia';

  @override
  String get countryIndia => 'India';

  @override
  String get countryPakistan => 'Pakistan';

  @override
  String get countryUS => 'United States';

  @override
  String get countryUK => 'United Kingdom';

  @override
  String get accountExists => 'Account Exists';

  @override
  String get accountExistsMessage =>
      'This account already exists. Please login instead.';

  @override
  String get verificationRequired => 'Verify Account';

  @override
  String get continueVerificationMessage =>
      'You have a pending registration. Would you like to continue verification?';

  @override
  String get validationError => 'Validation Error';

  @override
  String get countryFrance => 'France';

  @override
  String get countryGermany => 'Germany';

  @override
  String get countrySpain => 'Spain';

  @override
  String get countryItaly => 'Italy';

  @override
  String get countryRussia => 'Russia';

  @override
  String get countryChina => 'China';

  @override
  String get countryJapan => 'Japan';

  @override
  String get countrySouthKorea => 'South Korea';

  @override
  String get countryCanada => 'Canada';

  @override
  String get countryBrazil => 'Brazil';

  @override
  String get countryAustralia => 'Australia';

  @override
  String get countryNigeria => 'Nigeria';

  @override
  String get countrySouthAfrica => 'South Africa';

  @override
  String get countryMexico => 'Mexico';

  @override
  String get countryArgentina => 'Argentina';

  @override
  String get typePackage => 'Package';

  @override
  String get typeSubscription => 'Subscription';

  @override
  String get sar => 'SAR';

  @override
  String get statusDraft => 'Draft';

  @override
  String get statusPublished => 'Published';

  @override
  String get totalPrice => 'Total Price';

  @override
  String get statusPendingPayment => 'Pending Payment';

  @override
  String get confirmEmailTitle => 'Confirm Email';

  @override
  String get addPhoneNumber => 'Add Phone Number';

  @override
  String get uploadProfilePicture => 'Upload Profile Picture';

  @override
  String get updateProfile => 'Update Profile';

  @override
  String get updateProfileMsg =>
      'This feature is available only for fully registered users';

  @override
  String get chooseEducationLevel => 'Choose Education Level';

  @override
  String get addLocation => 'Add Location';

  @override
  String get confirmEmailMsg => 'You must confirm your email to continue';

  @override
  String get openEmail => 'Open Email';

  @override
  String get clickConfirmLink => 'Click Confirmation Link';

  @override
  String get subscriptionRequired => 'Subscription Required';

  @override
  String get subscriptionMsg =>
      'This feature is available for subscribers only';

  @override
  String get subscribePremium => 'Subscribe to Premium Plan';

  @override
  String get getExclusiveFeatures => 'Get Exclusive Features';

  @override
  String get subscribeNow => 'Subscribe Now';

  @override
  String get goBack => 'Go Back';

  @override
  String get yearsExperience => 'Years Experience';

  @override
  String get teacherBio => 'Teacher Bio';

  @override
  String get teachingDetails => 'Teaching Details';

  @override
  String get specialization => 'Specialization';

  @override
  String get availableClasses => 'Available Classes';

  @override
  String get sendMessage => 'Send Message';

  @override
  String messageSentTo(String name) {
    return 'Message sent to $name';
  }

  @override
  String get previous => 'Previous';

  @override
  String get confirmBooking => 'Confirm Booking';

  @override
  String get bookingNumber => 'Booking Number';

  @override
  String get amountPaid => 'Amount Paid';

  @override
  String get cardEnding => 'Card ending in';

  @override
  String get noTimesAvailable => 'No times available currently';

  @override
  String get chooseSuitableTime => 'Choose Suitable Time';

  @override
  String get chooseDayTimeInstruction =>
      'Choose suitable day and time for the lesson';

  @override
  String get aboutApp => 'About App';

  @override
  String get developer => 'Developer';

  @override
  String get companyName => 'Geniuses School Technology';

  @override
  String get supportEmail => 'Support Email';

  @override
  String get supportPhone => 'Support Phone';

  @override
  String get version => 'Version';

  @override
  String get chooseLessonType => 'Choose Lesson Type';

  @override
  String get chooseLessonTypeInstruction =>
      'Choose the lesson type suitable for you';

  @override
  String get individualLessonSubtitle => 'One on one private lesson';

  @override
  String groupLessonSubtitle(Object max, Object min) {
    return '$min-$max Students';
  }

  @override
  String get chooseSubject => 'Choose Subject';

  @override
  String get chooseSubjectInstruction => 'Choose the subject you want to learn';

  @override
  String get chooseLevel => 'Choose Level';

  @override
  String get chooseLevelInstruction => 'Choose the educational level';

  @override
  String get chooseClass => 'Choose Class';

  @override
  String get chooseClassInstruction => 'Choose the academic year';

  @override
  String get noClassesAvailable => 'No classes available';

  @override
  String get confirmYourBooking => 'Confirm Your Booking';

  @override
  String get yourTeacher => 'Your Teacher';

  @override
  String get bookingDetails => 'Booking Details';

  @override
  String get priceSummary => 'Price Summary';

  @override
  String get hourlyRate => 'Hourly Rate';

  @override
  String get cancellationPolicy =>
      'You can cancel booking 24 hours before the lesson';

  @override
  String get welcomeToGeniuses School => 'Welcome to Geniuses School';

  @override
  String get alreadyHaveAccount => 'Already have an account?';

  @override
  String get sessionIdNotAvailable => 'Session ID not available';

  @override
  String get joinSessionFailed => 'Failed to join session';

  @override
  String get proceedToPayment => 'Proceed to Payment';

  @override
  String get pleaseWait => 'Please wait...';

  @override
  String paymentSuccessWithRef(String ref, String amount, String currency) {
    return 'Payment successful. Ref: $ref';
  }

  @override
  String get servicePrivateLessons => 'Private Lessons';

  @override
  String get servicePrivateLessonsDesc =>
      'Various lessons in all subjects for all school stages.';

  @override
  String get serviceTrainingCourses => 'Training Courses';

  @override
  String get serviceLanguageLearning => 'Language Learning';

  @override
  String get searchCourseHint => 'Search for a course...';

  @override
  String get filterCourses => 'Filter Courses';

  @override
  String get reset => 'Reset';

  @override
  String get category => 'Category';

  @override
  String get maxPrice => 'Max Price';

  @override
  String get chooseCategory => 'Choose Category';

  @override
  String get applyFilters => 'Apply Filters';

  @override
  String get instructor => 'Instructor';

  @override
  String get trainingHour => 'Training Hour';

  @override
  String get enrolledStudent => 'Enrolled Student';

  @override
  String get availableSeat => 'Available Seat';

  @override
  String get coursePrice => 'Course Price';

  @override
  String get certificateIncluded => 'Certificate Included';

  @override
  String get courseDescription => 'Course Description';

  @override
  String get coveredTopics => 'Covered Topics';

  @override
  String get startDate => 'Start Date';

  @override
  String get enrollInCourse => 'Enroll in Course';

  @override
  String get requestEnrollment => 'Request Enrollment';

  @override
  String get enrollmentRequestSent =>
      'Your request has been sent. Our team will contact you within 24 hours.';

  @override
  String get enrollmentRequestTitle => 'Enrollment Request';

  @override
  String get courseFull => 'Course Full';

  @override
  String get confirmEnrollment => 'Confirm Enrollment';

  @override
  String get totalAmount => 'Total Amount';

  @override
  String enrollSuccessMessage(String courseTitle) {
    return 'Successfully enrolled in $courseTitle';
  }

  @override
  String get filterTeachers => 'Filter Teachers';

  @override
  String get serviceType => 'Service Type';

  @override
  String get minRatingLabel => 'Minimum Rating';

  @override
  String get activeFilters => 'Active Filters';

  @override
  String get clearAll => 'Clear All';

  @override
  String get availableBookingTimes => 'Available Booking Times';

  @override
  String bookingConfirmedMsg(String teacherName, String day, String time) {
    return 'Lesson booked with $teacherName on $day at $time';
  }

  @override
  String get choose => 'Choose';

  @override
  String get noData => 'No data';

  @override
  String priceIndicator(int price) {
    return '≤ $price SAR/hr';
  }

  @override
  String ratingIndicator(String rating) {
    return '≥ $rating ⭐';
  }

  @override
  String unreadNotifications(int count) {
    return '$count unread';
  }

  @override
  String get markAllAsRead => 'Mark all as read';

  @override
  String get notificationsMarkedRead => 'All notifications marked as read';

  @override
  String get notificationDeleted => 'Notification deleted';

  @override
  String get errorLoadingNotifications => 'Error loading notifications';

  @override
  String get noNotifications => 'No notifications';

  @override
  String get allCaughtUp => 'You\'re all caught up!';

  @override
  String get totalBalance => 'Total Balance';

  @override
  String get withdrawable => 'Withdrawable';

  @override
  String get weeklyIncome => 'Weekly Income';

  @override
  String get filterDatePlaceholder => 'Date';

  @override
  String get filterStatusPlaceholder => 'Status';

  @override
  String get sessionStatusAll => 'All';

  @override
  String get sessionStatusLive => 'Live';

  @override
  String get sessionStatusEnded => 'Ended';

  @override
  String get sessionStatusCancelled => 'Cancelled';

  @override
  String get sessionStatusScheduled => 'Scheduled';

  @override
  String get sessionStatusWaitForTeacher => 'Waiting for Teacher';

  @override
  String get untitledSession => 'Untitled';

  @override
  String get unspecifiedSubject => 'Unspecified Subject';

  @override
  String get statusLiveNow => 'Live Now';

  @override
  String get statusFinished => 'Finished';

  @override
  String get statusUpcoming => 'Upcoming';

  @override
  String get sessionDetailsTitle => 'Session Details';

  @override
  String get sessionStatusLabel => 'Status';

  @override
  String get sessionDurationLabel => 'Session Duration';

  @override
  String get bookingTypeLabel => 'Booking Type';

  @override
  String get completedLabel => 'Completed';

  @override
  String get referenceNumberLabel => 'Reference Number';

  @override
  String get minutesPlaceholder => '-- min';

  @override
  String get unspecified => 'Unspecified';

  @override
  String get startSessionNow => 'Start Session Now';

  @override
  String get joinSessionNow => 'Join Session Now';

  @override
  String get sessionEndedMessage => 'Session Ended';

  @override
  String get sessionUpcomingMessage => 'Session Upcoming';

  @override
  String get joining => 'Joining...';

  @override
  String get waitSettingUp => 'Please wait, setting up room...';

  @override
  String get waitJoining => 'Please wait, joining...';

  @override
  String get sessionEndedDescription =>
      'This session has ended and is no longer available';

  @override
  String get sessionUpcomingDescription =>
      'Join button will be available when session starts';

  @override
  String get createAndEnterDescription =>
      'Click to create and enter session room';

  @override
  String get enterDescription => 'Click to enter session room';

  @override
  String get confirmLogout => 'Confirm Logout';

  @override
  String get waitingForConnection => 'Waiting for connection...';

  @override
  String couldNotLaunchUrl(String url) {
    return 'Could not launch $url';
  }

  @override
  String errorLabel(String error) {
    return 'Error: $error';
  }

  @override
  String get recentTransactions => 'Recent Transactions';

  @override
  String get confirmDeleteCourse =>
      'Are you sure you want to delete this course?';

  @override
  String get courseDeletedSuccess => 'Course deleted successfully';

  @override
  String get editCourse => 'Edit Course';

  @override
  String get courseUpdatedSuccess => 'Course updated successfully';

  @override
  String get updateCourse => 'Update Course';

  @override
  String coursesAvailableCount(int count) {
    return '$count courses available';
  }

  @override
  String get errorLoadingCourses => 'Error loading courses';

  @override
  String get noCoursesFound => 'No courses found';

  @override
  String get adjustSearchCriteria => 'Try adjusting search criteria';

  @override
  String get privateLessons => 'Private Lessons';

  @override
  String get abilities => 'Abilities & Achievement';

  @override
  String get languageLearning => 'Language Learning';

  @override
  String get textbooks => 'Textbooks';

  @override
  String get withdraw => 'Withdraw';

  @override
  String get noTransactions => 'No transactions available.';

  @override
  String get cancelRequest => 'Cancel Request';

  @override
  String get confirmCancelWithdrawal =>
      'Are you sure you want to cancel this withdrawal request?';

  @override
  String get yesCancel => 'Yes, Cancel';

  @override
  String get requestCancelled => 'Request cancelled successfully';

  @override
  String get withdrawProfits => 'Withdraw Profits';

  @override
  String get noBankAccounts => 'No bank accounts';

  @override
  String get addBankAccountPrompt =>
      'You must add a bank account first before requesting a withdrawal. Do you want to add one now?';

  @override
  String get withdrawRequest => 'Withdrawal Request';

  @override
  String get availableBalance => 'Available Balance';

  @override
  String get selectBankAccount => 'Select Bank Account';

  @override
  String get selectBankHint => 'Select the account to receive funds';

  @override
  String get withdrawalAmount => 'Withdrawal Amount';

  @override
  String get minWithdrawalHint => 'Minimum: 10 SAR';

  @override
  String get enterAmount => 'Please enter amount';

  @override
  String get amountMustBePositive => 'Amount must be positive';

  @override
  String get minWithdrawalError => 'Minimum withdrawal is 10 SAR';

  @override
  String insufficientBalance(String balance) {
    return 'Amount exceeds available balance ($balance SAR)';
  }

  @override
  String get confirmWithdrawal => 'Confirm Withdrawal';

  @override
  String get withdrawalRequested => 'Withdrawal requested successfully';

  @override
  String get statusApproved => 'Approved';

  @override
  String get statusCancelled => 'Cancelled';

  @override
  String get errorSelectBank => 'Please select a bank account';

  @override
  String get no => 'No';

  @override
  String get statusConfirmed => 'Confirmed';

  @override
  String get lessonTypes => 'Lesson Types';

  @override
  String get individualLessons => 'Individual Lessons';

  @override
  String get individualLessonsDesc => 'One-on-one private lesson';

  @override
  String get groupLessons => 'Group Lessons';

  @override
  String get groupLessonsDesc => 'Group of students';

  @override
  String get hourlyRateSAR => 'Hourly Rate (SAR)';

  @override
  String get hourlyRatePerStudentSAR => 'Hourly Rate per Student (SAR)';

  @override
  String get minGroupSize => 'Min Group Size';

  @override
  String get maxGroupSize => 'Max Group Size';

  @override
  String get fieldRequired => 'Required';

  @override
  String get selectStudyLevel => 'Select Study Level';

  @override
  String get selectYourClass => 'Select your class';

  @override
  String get searchTeacherHint => 'Search for a teacher...';

  @override
  String get statusInProgress => 'In Progress';

  @override
  String get statusNew => 'New';

  @override
  String get timeLabel => 'Time:';

  @override
  String get studentCountLabel => 'student';

  @override
  String get perHourLabel => 'SAR / hour';

  @override
  String get educationalServices => 'Educational Services';

  @override
  String get personalInfo => 'Personal Information';

  @override
  String get bioTitle => 'Bio';

  @override
  String get bioHint => 'Brief description about yourself';

  @override
  String get bioLabel => 'Bio';

  @override
  String get servicesProvided => 'Provided Services';

  @override
  String get saveButton => 'Save';

  @override
  String get nextButton => 'Next';

  @override
  String get uploadDocumentsTitle => 'Upload Required Documents';

  @override
  String get uploadDocumentsDesc =>
      'Please upload your graduation certificate and CV to complete registration';

  @override
  String get gradCert => 'Graduation Certificate';

  @override
  String get gradCertDesc => 'University degree or equivalent';

  @override
  String get resume => 'Resume (CV)';

  @override
  String get resumeDesc => 'CV or Academic Portfolio';

  @override
  String get bothFilesRequired =>
      'Both files are required to complete registration';

  @override
  String get allFilesUploaded => 'Great! All required documents uploaded';

  @override
  String get backButton => 'Back';

  @override
  String get saveFinishButton => 'Save & Finish';

  @override
  String get saving => 'Saving...';

  @override
  String get progress => 'Progress';

  @override
  String get uploadFile => 'Upload File';

  @override
  String get loadLanguagesError => 'Error loading languages';

  @override
  String get noLanguagesAdded => 'No languages added';

  @override
  String get addLanguagePrompt => 'Press the add button to add languages';

  @override
  String get addLanguage => 'Add Language';

  @override
  String get addLanguagesTitle => 'Add Languages';

  @override
  String get allLanguagesAdded => 'All available languages are already added';

  @override
  String get addAction => 'Add';

  @override
  String get deleteLanguageConfirm =>
      'Are you sure you want to delete this language?';

  @override
  String get languageDeletedSuccess => 'Language deleted successfully';

  @override
  String get languageDeletedFail => 'Failed to delete language';

  @override
  String get languageAddedSuccess => 'Languages updated successfully';

  @override
  String get languageAddedFail => 'Failed to update languages';

  @override
  String get lessonsTitle => 'Lessons';

  @override
  String get noLessonsForSubject => 'No lessons added yet for';

  @override
  String get addLesson => 'Add Lesson';

  @override
  String get addSubjectTitle => 'Add Subject';

  @override
  String get subjectAddedSuccess => 'Subject added successfully';

  @override
  String get loadingMessage => 'Please wait';

  @override
  String get savingData => 'Saving data...';

  @override
  String get select => 'Select';

  @override
  String get selectNationality => 'Select Nationality';

  @override
  String get completeProfileTitle => 'Complete Your Profile';

  @override
  String get confirmEmailAction => 'Confirm Email';

  @override
  String get addPhoneAction => 'Add Phone Number';

  @override
  String get uploadPhotoAction => 'Upload Profile Picture';

  @override
  String get completeNowButton => 'Complete Now';

  @override
  String get cancelButton => 'Cancel';

  @override
  String get updateProfileTitle => 'Update Profile';

  @override
  String get updateProfileMessage =>
      'This feature is available only for fully registered users';

  @override
  String get addLocationAction => 'Add Your Location';

  @override
  String get emailConfirmationTitle => 'Email Confirmation';

  @override
  String get emailConfirmationMessage =>
      'You must confirm your email to continue';

  @override
  String get openEmailApp => 'Open Email App';

  @override
  String get clickConfirmationLink => 'Click Confirmation Link';

  @override
  String get subscriptionMessage =>
      'This feature is available for subscribers only';

  @override
  String get exclusiveFeatures => 'Get Exclusive Features';

  @override
  String get happeningNow => 'Happening Now';

  @override
  String get newBadge => 'New';

  @override
  String get sarPerHour => 'SAR / Hour';

  @override
  String get daysLabel => 'Days:';

  @override
  String get paymentVerification => 'Payment Verification';

  @override
  String get cancelOperation => 'Cancel Operation';

  @override
  String get cancelOperationMessage =>
      'Do you want to cancel the payment verification?';

  @override
  String get paymentSuccessTitle => 'Payment Successful';

  @override
  String get paymentFailedTitle => 'Payment Failed';

  @override
  String get paymentNotFound =>
      'Payment record not found. Please check data and try again.';

  @override
  String get serverError => 'Invalid response from server. Please try again.';

  @override
  String get unknownError => 'Unknown error occurred. Please try again.';

  @override
  String get formatError => 'Data format error. Please try again.';

  @override
  String get checkConnectivity =>
      'Please check your internet connection and try again.';

  @override
  String get contactSupport =>
      'Please contact support if the problem persists.';

  @override
  String get platformNotSupported =>
      'Sorry, 3D Secure (3DS) verification is not supported on this platform. Please use an Android or iOS device.';

  @override
  String get walletLoadError => 'Error loading wallet';

  @override
  String get cancelRequestTitle => 'Cancel Request';

  @override
  String get withdrawalCancelled => 'Withdrawal request cancelled';

  @override
  String get manageSubjects => 'Manage Subjects';

  @override
  String selectItem(Object item) {
    return 'Select $item';
  }

  @override
  String get schedule => 'Schedule';

  @override
  String get offline => 'Offline';

  @override
  String get todaysLessons => 'Today\'s Lessons';

  @override
  String get expectedIncome => 'Expected Income';

  @override
  String get noLessonsToday => 'No lessons today';

  @override
  String get enjoyYourDay => 'Enjoy your day!';

  @override
  String get paymentSuccessMessage => 'Payment completed successfully';

  @override
  String get teachers => 'Teachers';

  @override
  String teachersAvailable(Object count) {
    return '$count teachers available';
  }

  @override
  String get noTeachersFound => 'No teachers found';

  @override
  String get tryAdjustingSearch => 'Try adjusting search criteria';

  @override
  String get userIdNotFound => 'User ID not found';

  @override
  String get bookingId => 'Booking ID';

  @override
  String get errorCode => 'Error Code';

  @override
  String get paymentId => 'Payment ID';

  @override
  String get yes => 'Yes';

  @override
  String get courseCategoriesTitle => 'Training Course Categories';

  @override
  String get paymentFailedDefault => 'Payment Failed';

  @override
  String bookingSuccessMessage(String bookingRef, String amount) {
    return 'Payment Successful!\nBooking Ref: $bookingRef\nAmount: $amount';
  }

  @override
  String get bookingIdNotFound => 'Error: Booking ID not found';

  @override
  String get kotoby => 'Kotoby';

  @override
  String get bookings => 'Bookings';

  @override
  String get noBookings => 'No bookings found';

  @override
  String get cancelBooking => 'Cancel Booking';

  @override
  String get confirmCancelBooking =>
      'Are you sure you want to cancel this booking?';

  @override
  String get bookingCancelledSuccess => 'Booking cancelled successfully';

  @override
  String get bookingCancellationFailed => 'Failed to cancel booking';

  @override
  String paymentSuccessWithCard(String cardNumber) {
    return 'Payment successful using card ending in $cardNumber';
  }

  @override
  String get noSessions => 'No sessions found';

  @override
  String get errorLoadingSessions => 'Error loading sessions';

  @override
  String get studentInfoLabel => 'Student Information';

  @override
  String get teacherInfoLabel => 'Teacher Information';

  @override
  String get mastercard => 'MasterCard';

  @override
  String launchUrlError(String url) {
    return 'Could not launch $url';
  }

  @override
  String get connectionError => 'Connection Error';

  @override
  String get selectGender => 'Select Gender';

  @override
  String get teaching => 'Teaching';

  @override
  String get learning => 'Learning';

  @override
  String get room => 'Room';

  @override
  String get users => 'Users';

  @override
  String get connectingToClassroom => 'Connecting to classroom...';

  @override
  String get noVideoStreams => 'No video streams available';

  @override
  String get cameraOff => 'Camera Off';

  @override
  String get mute => 'Mute';

  @override
  String get unmute => 'Unmute';

  @override
  String get startVideo => 'Start Video';

  @override
  String get stopVideo => 'Stop Video';

  @override
  String get speakerOn => 'Speaker On';

  @override
  String get speakerOff => 'Speaker Off';

  @override
  String get leave => 'Leave';

  @override
  String get joinClassroom => 'Join Classroom';

  @override
  String youRole(String role) {
    return 'You ($role)';
  }

  @override
  String get hand => 'Hand';

  @override
  String get shareScreen => 'Share';

  @override
  String get muteAll => 'Mute All';

  @override
  String get flipCamera => 'Flip';

  @override
  String get video => 'Video';

  @override
  String get card => 'Card';

  @override
  String get authRequired => 'Login Required';

  @override
  String get loginToSeeProfile =>
      'Please login to view and manage your profile';

  @override
  String get providedServices => 'Services Provided';

  @override
  String get consultationSessions => 'Consultation Sessions';

  @override
  String get privateLesson => 'Private Lesson';

  @override
  String get certificates => 'Certificates';

  @override
  String get reviews => 'Reviews';

  @override
  String get book => 'Book';

  @override
  String get bookSession => 'Book Session';

  @override
  String get lessonsLabel => 'Lessons';

  @override
  String get teacherUnderReview => 'Account Under Review';

  @override
  String get teacherUnderReviewMessage =>
      'Your account is currently under review. Please wait while we verify your information. You can contact support for more details.';

  @override
  String get contactUs => 'Contact Us';

  @override
  String get profile_status_active => 'Your Profile is Active';

  @override
  String get profile_status_inactive => 'Your Profile is Inactive';

  @override
  String get profile_visible_to_students => 'All students can see your profile';

  @override
  String get profile_hidden_from_students => 'No one can see your profile';

  @override
  String get activate_to_start_earning =>
      'Activate your profile to start earning!';

  @override
  String get total_earnings => 'Total';

  @override
  String get errorUserNotFound => 'This account is not registered.';

  @override
  String get endSessionConfirmation =>
      'Are you sure you want to end this session?';

  @override
  String get endSession => 'End Session';

  @override
  String get success => 'Success';

  @override
  String get chooseYourService => 'Choose Your Service';

  @override
  String get uploadCertificate => 'Upload Certificate';

  @override
  String get submit => 'Submit';

  @override
  String get certificateRequired => 'Certificate is required';

  @override
  String get uploadCv => 'Upload CV';

  @override
  String get bio => 'Bio';

  @override
  String get certificateLabel => 'Certificate';

  @override
  String get cvLabel => 'CV';

  @override
  String get selectService => 'Select Service';

  @override
  String get fileTooLarge => 'File too large (max 5MB)';

  @override
  String get continueBtn => 'Continue';

  @override
  String get tutorial_earnings_desc =>
      'Track your daily and monthly earnings at a glance.';

  @override
  String get tutorial_sessions_desc =>
      'View your upcoming lessons and manage your teaching schedule.';

  @override
  String get tutorial_prices_desc =>
      'Update your hourly rates for individual lessons here.';

  @override
  String tutorial_services_desc(String specificTip) {
    return 'Manage your services here! $specificTip Also, remember to add your available slots and link your bank account for easy withdrawals.';
  }

  @override
  String get tutorial_tip_language => 'Add the languages you teach.';

  @override
  String get tutorial_tip_subjects => 'Add your specialized subjects.';

  @override
  String get tutorial_tip_courses => 'Add and manage your training courses.';

  @override
  String get bankAccountMemo =>
      'Here you can add your bank accounts to use for withdrawing your earnings by requesting a bank transfer.';

  @override
  String get totalSessions => 'Total Sessions';

  @override
  String get tutorial_total_sessions_title => 'Total Sessions';

  @override
  String get tutorial_total_sessions_desc =>
      'Choose how many consecutive sessions you\'d like to book in a row. The price will multiply automatically.';

  @override
  String get tutorial_student_home_title_notifications => 'Notifications';

  @override
  String get tutorial_student_home_desc_notifications =>
      'Track your alerts, new requests, and session status here.';

  @override
  String get tutorial_student_home_title_teachers => 'Top Teachers';

  @override
  String get tutorial_student_home_desc_teachers =>
      'Browse our top-rated teachers and book your lessons instantly.';

  @override
  String get tutorial_student_home_title_services => 'Our Services';

  @override
  String get tutorial_student_home_desc_services =>
      'Explore various educational services tailored to your needs.';

  @override
  String get tutorial_student_home_title_courses => 'Training Courses';

  @override
  String get tutorial_student_home_desc_courses =>
      'Join specialized training courses to develop your skills.';

  @override
  String get tutorial_student_home_title_add_order => 'Add Order';

  @override
  String get tutorial_student_home_desc_add_order =>
      'Can\'t find what you\'re looking for? Create a custom teaching request here.';

  @override
  String get tutorial_student_home_title_categories => 'Course Categories';

  @override
  String get tutorial_student_home_desc_categories =>
      'Explore available course categories to find what interests you.';

  @override
  String get session_timing_info =>
      'If you add more sessions, they will be scheduled on the same weekday and same time in the following weeks.';
}
