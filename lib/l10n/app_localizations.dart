import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en'),
  ];

  /// No description provided for @failedToLoadData.
  ///
  /// In en, this message translates to:
  /// **'Failed to load data: {error}'**
  String failedToLoadData(String error);

  /// No description provided for @paymentCancelled.
  ///
  /// In en, this message translates to:
  /// **'Payment cancelled'**
  String get paymentCancelled;

  /// No description provided for @bookLessonTitle.
  ///
  /// In en, this message translates to:
  /// **'Book Lesson'**
  String get bookLessonTitle;

  /// No description provided for @loadingTeacherData.
  ///
  /// In en, this message translates to:
  /// **'Loading teacher data...'**
  String get loadingTeacherData;

  /// No description provided for @invalidCheckoutId.
  ///
  /// In en, this message translates to:
  /// **'Invalid checkout ID received'**
  String get invalidCheckoutId;

  /// No description provided for @invalidPaymentUrl.
  ///
  /// In en, this message translates to:
  /// **'Invalid payment URL received'**
  String get invalidPaymentUrl;

  /// No description provided for @invalidUrl.
  ///
  /// In en, this message translates to:
  /// **'Invalid URL: {url}'**
  String invalidUrl(String url);

  /// No description provided for @paymentFailedError.
  ///
  /// In en, this message translates to:
  /// **'Payment failed: {error}'**
  String paymentFailedError(String error);

  /// No description provided for @paymentProcessError.
  ///
  /// In en, this message translates to:
  /// **'Payment process error: {error}'**
  String paymentProcessError(String error);

  /// No description provided for @bookingFailedMessage.
  ///
  /// In en, this message translates to:
  /// **'Failed to book lesson: {message}'**
  String bookingFailedMessage(String message);

  /// No description provided for @paymentSuccessDefault.
  ///
  /// In en, this message translates to:
  /// **'Payment Successful'**
  String get paymentSuccessDefault;

  /// No description provided for @refresh.
  ///
  /// In en, this message translates to:
  /// **'Refresh'**
  String get refresh;

  /// No description provided for @noSavedCardsMessage.
  ///
  /// In en, this message translates to:
  /// **'No saved cards. You will need to enter your card details in the next step.'**
  String get noSavedCardsMessage;

  /// No description provided for @newPaymentCard.
  ///
  /// In en, this message translates to:
  /// **'New Payment Card'**
  String get newPaymentCard;

  /// No description provided for @useAnotherCard.
  ///
  /// In en, this message translates to:
  /// **'Use another card'**
  String get useAnotherCard;

  /// No description provided for @creditCardVisaMaster.
  ///
  /// In en, this message translates to:
  /// **'Credit Card (Visa/Master)'**
  String get creditCardVisaMaster;

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'Geniuses School'**
  String get appTitle;

  /// No description provided for @changeLanguage.
  ///
  /// In en, this message translates to:
  /// **'Change Language'**
  String get changeLanguage;

  /// No description provided for @login.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get login;

  /// No description provided for @email.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @forgotPassword.
  ///
  /// In en, this message translates to:
  /// **'Forgot Password?'**
  String get forgotPassword;

  /// No description provided for @orLoginWith.
  ///
  /// In en, this message translates to:
  /// **'Or login with'**
  String get orLoginWith;

  /// No description provided for @dontHaveAccount.
  ///
  /// In en, this message translates to:
  /// **'Don\'t have an account?'**
  String get dontHaveAccount;

  /// No description provided for @register.
  ///
  /// In en, this message translates to:
  /// **'Register'**
  String get register;

  /// No description provided for @welcomeBack.
  ///
  /// In en, this message translates to:
  /// **'Welcome Back!'**
  String get welcomeBack;

  /// No description provided for @pleaseLogin.
  ///
  /// In en, this message translates to:
  /// **'Please login to your account'**
  String get pleaseLogin;

  /// No description provided for @emailOrPhone.
  ///
  /// In en, this message translates to:
  /// **'Email or Mobile Number'**
  String get emailOrPhone;

  /// No description provided for @enterEmailOrPhone.
  ///
  /// In en, this message translates to:
  /// **'Enter your email or mobile'**
  String get enterEmailOrPhone;

  /// No description provided for @enterPassword.
  ///
  /// In en, this message translates to:
  /// **'Enter Password'**
  String get enterPassword;

  /// No description provided for @requiredField.
  ///
  /// In en, this message translates to:
  /// **'This field is required'**
  String get requiredField;

  /// No description provided for @passwordMinLength.
  ///
  /// In en, this message translates to:
  /// **'Password must be at least 8 characters'**
  String get passwordMinLength;

  /// No description provided for @loggingIn.
  ///
  /// In en, this message translates to:
  /// **'Logging in...'**
  String get loggingIn;

  /// No description provided for @registerNow.
  ///
  /// In en, this message translates to:
  /// **'Register Now'**
  String get registerNow;

  /// No description provided for @errorOccurred.
  ///
  /// In en, this message translates to:
  /// **'An error occurred'**
  String get errorOccurred;

  /// No description provided for @retry.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get retry;

  /// No description provided for @goToLogin.
  ///
  /// In en, this message translates to:
  /// **'Go to Login'**
  String get goToLogin;

  /// No description provided for @internetConnectionError.
  ///
  /// In en, this message translates to:
  /// **'Internet connection error'**
  String get internetConnectionError;

  /// No description provided for @connectionTimeout.
  ///
  /// In en, this message translates to:
  /// **'Connection timeout'**
  String get connectionTimeout;

  /// No description provided for @sessionExpired.
  ///
  /// In en, this message translates to:
  /// **'Session expired'**
  String get sessionExpired;

  /// No description provided for @unexpectedError.
  ///
  /// In en, this message translates to:
  /// **'Unexpected error'**
  String get unexpectedError;

  /// No description provided for @createAccount.
  ///
  /// In en, this message translates to:
  /// **'Create New Account'**
  String get createAccount;

  /// No description provided for @joinCommunity.
  ///
  /// In en, this message translates to:
  /// **'Join Geniuses School Educational Community'**
  String get joinCommunity;

  /// No description provided for @fullName.
  ///
  /// In en, this message translates to:
  /// **'Full Name'**
  String get fullName;

  /// No description provided for @firstName.
  ///
  /// In en, this message translates to:
  /// **'First Name'**
  String get firstName;

  /// No description provided for @lastName.
  ///
  /// In en, this message translates to:
  /// **'Last Name'**
  String get lastName;

  /// No description provided for @required.
  ///
  /// In en, this message translates to:
  /// **'Required'**
  String get required;

  /// No description provided for @invalidEmail.
  ///
  /// In en, this message translates to:
  /// **'Invalid email'**
  String get invalidEmail;

  /// No description provided for @phoneNumber.
  ///
  /// In en, this message translates to:
  /// **'Mobile Number'**
  String get phoneNumber;

  /// No description provided for @tooLong.
  ///
  /// In en, this message translates to:
  /// **'Too long'**
  String get tooLong;

  /// No description provided for @nationality.
  ///
  /// In en, this message translates to:
  /// **'Nationality'**
  String get nationality;

  /// No description provided for @gender.
  ///
  /// In en, this message translates to:
  /// **'Gender'**
  String get gender;

  /// No description provided for @strongPassword.
  ///
  /// In en, this message translates to:
  /// **'Enter a strong password'**
  String get strongPassword;

  /// No description provided for @agreeTo.
  ///
  /// In en, this message translates to:
  /// **'I agree to '**
  String get agreeTo;

  /// No description provided for @termsConditions.
  ///
  /// In en, this message translates to:
  /// **'Terms & Conditions'**
  String get termsConditions;

  /// No description provided for @and.
  ///
  /// In en, this message translates to:
  /// **' and '**
  String get and;

  /// No description provided for @privacyPolicy.
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get privacyPolicy;

  /// No description provided for @registerButton.
  ///
  /// In en, this message translates to:
  /// **'Register New Account'**
  String get registerButton;

  /// No description provided for @registering.
  ///
  /// In en, this message translates to:
  /// **'Registering...'**
  String get registering;

  /// No description provided for @acceptTermsError.
  ///
  /// In en, this message translates to:
  /// **'Please agree to the Terms & Conditions'**
  String get acceptTermsError;

  /// No description provided for @chooseYourRole.
  ///
  /// In en, this message translates to:
  /// **'Choose Your Role'**
  String get chooseYourRole;

  /// No description provided for @howToUseApp.
  ///
  /// In en, this message translates to:
  /// **'How do you want to use Geniuses School?'**
  String get howToUseApp;

  /// No description provided for @student.
  ///
  /// In en, this message translates to:
  /// **'Student'**
  String get student;

  /// No description provided for @studentDescription.
  ///
  /// In en, this message translates to:
  /// **'Learn new skills, get private lessons, study languages, and join courses to improve your knowledge'**
  String get studentDescription;

  /// No description provided for @teacher.
  ///
  /// In en, this message translates to:
  /// **'Teacher'**
  String get teacher;

  /// No description provided for @teacherDescription.
  ///
  /// In en, this message translates to:
  /// **'Give private lessons, teach languages, share your expertise, and provide training courses for students'**
  String get teacherDescription;

  /// No description provided for @continueText.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get continueText;

  /// No description provided for @resetPassword.
  ///
  /// In en, this message translates to:
  /// **'Reset Password'**
  String get resetPassword;

  /// No description provided for @enterRegisteredPhone.
  ///
  /// In en, this message translates to:
  /// **'Enter your registered phone number to receive a verification code'**
  String get enterRegisteredPhone;

  /// No description provided for @codeSent.
  ///
  /// In en, this message translates to:
  /// **'Code Sent!'**
  String get codeSent;

  /// No description provided for @codeSentToPhone.
  ///
  /// In en, this message translates to:
  /// **'Verification code has been sent to your phone number'**
  String get codeSentToPhone;

  /// No description provided for @sendVerificationCode.
  ///
  /// In en, this message translates to:
  /// **'Send Verification Code'**
  String get sendVerificationCode;

  /// No description provided for @enterPhoneNumberError.
  ///
  /// In en, this message translates to:
  /// **'Please enter phone number'**
  String get enterPhoneNumberError;

  /// No description provided for @invalidPhoneNumberError.
  ///
  /// In en, this message translates to:
  /// **'Phone number must be 9 digits'**
  String get invalidPhoneNumberError;

  /// No description provided for @codeResent.
  ///
  /// In en, this message translates to:
  /// **'Code sent again'**
  String get codeResent;

  /// No description provided for @codeResendFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed to send code. Try again'**
  String get codeResendFailed;

  /// No description provided for @enterFullCode.
  ///
  /// In en, this message translates to:
  /// **'Please enter the full code'**
  String get enterFullCode;

  /// No description provided for @errorTryAgain.
  ///
  /// In en, this message translates to:
  /// **'Error. Please try again'**
  String get errorTryAgain;

  /// No description provided for @invalidVerificationCode.
  ///
  /// In en, this message translates to:
  /// **'Invalid verification code'**
  String get invalidVerificationCode;

  /// No description provided for @networkError.
  ///
  /// In en, this message translates to:
  /// **'Failed to connect to server. Please check your internet connection.'**
  String get networkError;

  /// No description provided for @codeExpired.
  ///
  /// In en, this message translates to:
  /// **'Code expired. Resend it'**
  String get codeExpired;

  /// No description provided for @timeoutError.
  ///
  /// In en, this message translates to:
  /// **'Timeout. Try again'**
  String get timeoutError;

  /// No description provided for @genericError.
  ///
  /// In en, this message translates to:
  /// **'Error: {error}'**
  String genericError(String error);

  /// No description provided for @close.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get close;

  /// No description provided for @error.
  ///
  /// In en, this message translates to:
  /// **'Error'**
  String get error;

  /// No description provided for @ok.
  ///
  /// In en, this message translates to:
  /// **'OK'**
  String get ok;

  /// No description provided for @verify.
  ///
  /// In en, this message translates to:
  /// **'Verify'**
  String get verify;

  /// No description provided for @allOrders.
  ///
  /// In en, this message translates to:
  /// **'All Orders'**
  String get allOrders;

  /// No description provided for @noOrders.
  ///
  /// In en, this message translates to:
  /// **'No orders found'**
  String get noOrders;

  /// No description provided for @errorLoadingOrders.
  ///
  /// In en, this message translates to:
  /// **'Error loading orders'**
  String get errorLoadingOrders;

  /// No description provided for @orderAppliedSuccess.
  ///
  /// In en, this message translates to:
  /// **'Applied successfully'**
  String get orderAppliedSuccess;

  /// No description provided for @orderApplyFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed to apply'**
  String get orderApplyFailed;

  /// No description provided for @overview.
  ///
  /// In en, this message translates to:
  /// **'Overview'**
  String get overview;

  /// No description provided for @wallet.
  ///
  /// In en, this message translates to:
  /// **'Wallet'**
  String get wallet;

  /// No description provided for @lessons.
  ///
  /// In en, this message translates to:
  /// **'Lessons'**
  String get lessons;

  /// No description provided for @requestTeachingSession.
  ///
  /// In en, this message translates to:
  /// **'Request Teaching Session'**
  String get requestTeachingSession;

  /// No description provided for @bookPrivateSession.
  ///
  /// In en, this message translates to:
  /// **'Book a private teaching session'**
  String get bookPrivateSession;

  /// No description provided for @academicDetails.
  ///
  /// In en, this message translates to:
  /// **'Academic Details'**
  String get academicDetails;

  /// No description provided for @educationLevel.
  ///
  /// In en, this message translates to:
  /// **'Education Level'**
  String get educationLevel;

  /// No description provided for @selectEducationLevel.
  ///
  /// In en, this message translates to:
  /// **'Select Education Level'**
  String get selectEducationLevel;

  /// No description provided for @noEducationLevelsAvailable.
  ///
  /// In en, this message translates to:
  /// **'No education levels available'**
  String get noEducationLevelsAvailable;

  /// No description provided for @loadingEducationLevelsFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed to load education levels'**
  String get loadingEducationLevelsFailed;

  /// No description provided for @grade.
  ///
  /// In en, this message translates to:
  /// **'Grade'**
  String get grade;

  /// No description provided for @selectGrade.
  ///
  /// In en, this message translates to:
  /// **'Select Grade'**
  String get selectGrade;

  /// No description provided for @selectGradeFirst.
  ///
  /// In en, this message translates to:
  /// **'Select Grade First'**
  String get selectGradeFirst;

  /// No description provided for @noGradesAvailable.
  ///
  /// In en, this message translates to:
  /// **'No grades available'**
  String get noGradesAvailable;

  /// No description provided for @selectEducationLevelFirst.
  ///
  /// In en, this message translates to:
  /// **'Select Education Level First'**
  String get selectEducationLevelFirst;

  /// No description provided for @loadingGradesFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed to load grades'**
  String get loadingGradesFailed;

  /// No description provided for @subject.
  ///
  /// In en, this message translates to:
  /// **'Subject'**
  String get subject;

  /// No description provided for @selectSubject.
  ///
  /// In en, this message translates to:
  /// **'Select Subject'**
  String get selectSubject;

  /// No description provided for @noSubjectsAvailable.
  ///
  /// In en, this message translates to:
  /// **'No subjects available'**
  String get noSubjectsAvailable;

  /// No description provided for @loadingSubjectsFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed to load subjects'**
  String get loadingSubjectsFailed;

  /// No description provided for @sessionType.
  ///
  /// In en, this message translates to:
  /// **'Session Type'**
  String get sessionType;

  /// No description provided for @online.
  ///
  /// In en, this message translates to:
  /// **'Online'**
  String get online;

  /// No description provided for @videoSession.
  ///
  /// In en, this message translates to:
  /// **'Video Session'**
  String get videoSession;

  /// No description provided for @inPerson.
  ///
  /// In en, this message translates to:
  /// **'In Person'**
  String get inPerson;

  /// No description provided for @faceToFace.
  ///
  /// In en, this message translates to:
  /// **'Face to Face'**
  String get faceToFace;

  /// No description provided for @dateTime.
  ///
  /// In en, this message translates to:
  /// **'Date and Time'**
  String get dateTime;

  /// No description provided for @date.
  ///
  /// In en, this message translates to:
  /// **'Date'**
  String get date;

  /// No description provided for @selectDate.
  ///
  /// In en, this message translates to:
  /// **'Select Date'**
  String get selectDate;

  /// No description provided for @time.
  ///
  /// In en, this message translates to:
  /// **'Time'**
  String get time;

  /// No description provided for @selectTime.
  ///
  /// In en, this message translates to:
  /// **'Select Time'**
  String get selectTime;

  /// No description provided for @durationAndPrice.
  ///
  /// In en, this message translates to:
  /// **'Duration and Price'**
  String get durationAndPrice;

  /// No description provided for @hoursCount.
  ///
  /// In en, this message translates to:
  /// **'Number of Hours'**
  String get hoursCount;

  /// No description provided for @enterHoursCount.
  ///
  /// In en, this message translates to:
  /// **'Enter number of hours'**
  String get enterHoursCount;

  /// No description provided for @pricePerHour.
  ///
  /// In en, this message translates to:
  /// **'Price per Hour'**
  String get pricePerHour;

  /// No description provided for @enterProposedPrice.
  ///
  /// In en, this message translates to:
  /// **'Enter proposed price'**
  String get enterProposedPrice;

  /// No description provided for @priority.
  ///
  /// In en, this message translates to:
  /// **'Priority'**
  String get priority;

  /// No description provided for @sessionDescription.
  ///
  /// In en, this message translates to:
  /// **'Session Description'**
  String get sessionDescription;

  /// No description provided for @sessionDetails.
  ///
  /// In en, this message translates to:
  /// **'Session Details'**
  String get sessionDetails;

  /// No description provided for @writeSessionDetails.
  ///
  /// In en, this message translates to:
  /// **'Write details of what you need help with...'**
  String get writeSessionDetails;

  /// No description provided for @hoursRequired.
  ///
  /// In en, this message translates to:
  /// **'Number of hours required'**
  String get hoursRequired;

  /// No description provided for @invalidHours.
  ///
  /// In en, this message translates to:
  /// **'Invalid number of hours'**
  String get invalidHours;

  /// No description provided for @priceRequired.
  ///
  /// In en, this message translates to:
  /// **'Price is required'**
  String get priceRequired;

  /// No description provided for @invalidPrice.
  ///
  /// In en, this message translates to:
  /// **'Invalid price'**
  String get invalidPrice;

  /// No description provided for @descriptionRequired.
  ///
  /// In en, this message translates to:
  /// **'Session description required'**
  String get descriptionRequired;

  /// No description provided for @viewAll.
  ///
  /// In en, this message translates to:
  /// **'View All'**
  String get viewAll;

  /// No description provided for @search.
  ///
  /// In en, this message translates to:
  /// **'Search...'**
  String get search;

  /// No description provided for @sendRequest.
  ///
  /// In en, this message translates to:
  /// **'Send Request'**
  String get sendRequest;

  /// No description provided for @requestSentSuccess.
  ///
  /// In en, this message translates to:
  /// **'Request sent successfully!'**
  String get requestSentSuccess;

  /// No description provided for @requestSentFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed to send request'**
  String get requestSentFailed;

  /// No description provided for @lowPriority.
  ///
  /// In en, this message translates to:
  /// **'Low'**
  String get lowPriority;

  /// No description provided for @normalPriority.
  ///
  /// In en, this message translates to:
  /// **'Normal'**
  String get normalPriority;

  /// No description provided for @highPriority.
  ///
  /// In en, this message translates to:
  /// **'High'**
  String get highPriority;

  /// No description provided for @urgentPriority.
  ///
  /// In en, this message translates to:
  /// **'Urgent'**
  String get urgentPriority;

  /// No description provided for @languages.
  ///
  /// In en, this message translates to:
  /// **'Languages'**
  String get languages;

  /// No description provided for @courses.
  ///
  /// In en, this message translates to:
  /// **'Courses'**
  String get courses;

  /// No description provided for @rating.
  ///
  /// In en, this message translates to:
  /// **'Rating'**
  String get rating;

  /// No description provided for @newOrders.
  ///
  /// In en, this message translates to:
  /// **'New Orders'**
  String get newOrders;

  /// No description provided for @noNewOrders.
  ///
  /// In en, this message translates to:
  /// **'No new orders'**
  String get noNewOrders;

  /// No description provided for @newOrdersWillAppearHere.
  ///
  /// In en, this message translates to:
  /// **'New orders will appear here'**
  String get newOrdersWillAppearHere;

  /// No description provided for @viewAllOrders.
  ///
  /// In en, this message translates to:
  /// **'View All Orders'**
  String get viewAllOrders;

  /// No description provided for @serviceManagement.
  ///
  /// In en, this message translates to:
  /// **'Service Management'**
  String get serviceManagement;

  /// No description provided for @manageStagesAndSubjects.
  ///
  /// In en, this message translates to:
  /// **'Manage Stages & Subjects'**
  String get manageStagesAndSubjects;

  /// No description provided for @manageCourses.
  ///
  /// In en, this message translates to:
  /// **'Manage Courses'**
  String get manageCourses;

  /// No description provided for @manageLanguages.
  ///
  /// In en, this message translates to:
  /// **'Manage Languages'**
  String get manageLanguages;

  /// No description provided for @mySchedule.
  ///
  /// In en, this message translates to:
  /// **'My Schedule'**
  String get mySchedule;

  /// No description provided for @all.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get all;

  /// No description provided for @pending.
  ///
  /// In en, this message translates to:
  /// **'Pending'**
  String get pending;

  /// No description provided for @accepted.
  ///
  /// In en, this message translates to:
  /// **'Accepted'**
  String get accepted;

  /// No description provided for @rejected.
  ///
  /// In en, this message translates to:
  /// **'Rejected'**
  String get rejected;

  /// No description provided for @status.
  ///
  /// In en, this message translates to:
  /// **'Status'**
  String get status;

  /// No description provided for @myOrders.
  ///
  /// In en, this message translates to:
  /// **'My Orders'**
  String get myOrders;

  /// No description provided for @unknownSubject.
  ///
  /// In en, this message translates to:
  /// **'Unknown Subject'**
  String get unknownSubject;

  /// No description provided for @completed.
  ///
  /// In en, this message translates to:
  /// **'Completed'**
  String get completed;

  /// No description provided for @cancelled.
  ///
  /// In en, this message translates to:
  /// **'Cancelled'**
  String get cancelled;

  /// No description provided for @notSpecified.
  ///
  /// In en, this message translates to:
  /// **'Not Specified'**
  String get notSpecified;

  /// No description provided for @teachersApplicationsCount.
  ///
  /// In en, this message translates to:
  /// **'Teachers Applications'**
  String get teachersApplicationsCount;

  /// No description provided for @price.
  ///
  /// In en, this message translates to:
  /// **'Price'**
  String get price;

  /// No description provided for @currency.
  ///
  /// In en, this message translates to:
  /// **'SAR'**
  String get currency;

  /// No description provided for @creationDate.
  ///
  /// In en, this message translates to:
  /// **'Creation Date'**
  String get creationDate;

  /// No description provided for @orderDetailsNotAvailable.
  ///
  /// In en, this message translates to:
  /// **'Order details not available currently'**
  String get orderDetailsNotAvailable;

  /// No description provided for @noOrdersNow.
  ///
  /// In en, this message translates to:
  /// **'No orders currently'**
  String get noOrdersNow;

  /// No description provided for @topTeachers.
  ///
  /// In en, this message translates to:
  /// **'Top Teachers'**
  String get topTeachers;

  /// No description provided for @ourServices.
  ///
  /// In en, this message translates to:
  /// **'Our Services'**
  String get ourServices;

  /// No description provided for @trainingCourses.
  ///
  /// In en, this message translates to:
  /// **'Training Courses'**
  String get trainingCourses;

  /// No description provided for @noCoursesAvailable.
  ///
  /// In en, this message translates to:
  /// **'No courses available.'**
  String get noCoursesAvailable;

  /// No description provided for @subjects.
  ///
  /// In en, this message translates to:
  /// **'Subjects'**
  String get subjects;

  /// No description provided for @courseCategories.
  ///
  /// In en, this message translates to:
  /// **'Course Categories'**
  String get courseCategories;

  /// No description provided for @errorLoadingCategories.
  ///
  /// In en, this message translates to:
  /// **'Error loading categories'**
  String get errorLoadingCategories;

  /// No description provided for @noCategoriesAvailable.
  ///
  /// In en, this message translates to:
  /// **'No categories available currently'**
  String get noCategoriesAvailable;

  /// No description provided for @earnings.
  ///
  /// In en, this message translates to:
  /// **'Earnings'**
  String get earnings;

  /// No description provided for @mySessions.
  ///
  /// In en, this message translates to:
  /// **'My Sessions'**
  String get mySessions;

  /// No description provided for @myProfile.
  ///
  /// In en, this message translates to:
  /// **'My Profile'**
  String get myProfile;

  /// No description provided for @home.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// No description provided for @myLessons.
  ///
  /// In en, this message translates to:
  /// **'My Lessons'**
  String get myLessons;

  /// No description provided for @profile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profile;

  /// No description provided for @addOrder.
  ///
  /// In en, this message translates to:
  /// **'Add Order'**
  String get addOrder;

  /// No description provided for @errorForbidden.
  ///
  /// In en, this message translates to:
  /// **'You do not have sufficient permissions to access this resource, please login again'**
  String get errorForbidden;

  /// No description provided for @errorPrefix.
  ///
  /// In en, this message translates to:
  /// **'Error: '**
  String get errorPrefix;

  /// No description provided for @hour.
  ///
  /// In en, this message translates to:
  /// **'hour'**
  String get hour;

  /// No description provided for @hourShort.
  ///
  /// In en, this message translates to:
  /// **'hr'**
  String get hourShort;

  /// No description provided for @minute.
  ///
  /// In en, this message translates to:
  /// **'minute'**
  String get minute;

  /// No description provided for @minuteShort.
  ///
  /// In en, this message translates to:
  /// **'min'**
  String get minuteShort;

  /// No description provided for @session.
  ///
  /// In en, this message translates to:
  /// **'Session'**
  String get session;

  /// No description provided for @unknown.
  ///
  /// In en, this message translates to:
  /// **'Unknown'**
  String get unknown;

  /// No description provided for @finished.
  ///
  /// In en, this message translates to:
  /// **'Finished'**
  String get finished;

  /// No description provided for @upcoming.
  ///
  /// In en, this message translates to:
  /// **'Upcoming'**
  String get upcoming;

  /// No description provided for @join.
  ///
  /// In en, this message translates to:
  /// **'Join'**
  String get join;

  /// No description provided for @start.
  ///
  /// In en, this message translates to:
  /// **'Start'**
  String get start;

  /// No description provided for @apply.
  ///
  /// In en, this message translates to:
  /// **'Apply'**
  String get apply;

  /// No description provided for @statusPending.
  ///
  /// In en, this message translates to:
  /// **'Pending'**
  String get statusPending;

  /// No description provided for @statusAccepted.
  ///
  /// In en, this message translates to:
  /// **'Accepted'**
  String get statusAccepted;

  /// No description provided for @statusRejected.
  ///
  /// In en, this message translates to:
  /// **'Rejected'**
  String get statusRejected;

  /// No description provided for @viewAllCategories.
  ///
  /// In en, this message translates to:
  /// **'View All Categories'**
  String get viewAllCategories;

  /// No description provided for @noCategoriesDescription.
  ///
  /// In en, this message translates to:
  /// **'When new categories are available, they will appear here'**
  String get noCategoriesDescription;

  /// No description provided for @myServices.
  ///
  /// In en, this message translates to:
  /// **'My Services'**
  String get myServices;

  /// No description provided for @service.
  ///
  /// In en, this message translates to:
  /// **'Service'**
  String get service;

  /// No description provided for @perHour.
  ///
  /// In en, this message translates to:
  /// **'/ hr'**
  String get perHour;

  /// No description provided for @reject.
  ///
  /// In en, this message translates to:
  /// **'Reject'**
  String get reject;

  /// No description provided for @accept.
  ///
  /// In en, this message translates to:
  /// **'Accept'**
  String get accept;

  /// No description provided for @statusUrgent.
  ///
  /// In en, this message translates to:
  /// **'Urgent'**
  String get statusUrgent;

  /// No description provided for @statusCompleted.
  ///
  /// In en, this message translates to:
  /// **'Completed'**
  String get statusCompleted;

  /// No description provided for @searchOrdersHint.
  ///
  /// In en, this message translates to:
  /// **'Search orders...'**
  String get searchOrdersHint;

  /// No description provided for @noResults.
  ///
  /// In en, this message translates to:
  /// **'No results found'**
  String get noResults;

  /// No description provided for @tryDifferentSearch.
  ///
  /// In en, this message translates to:
  /// **'Try searching with different words'**
  String get tryDifferentSearch;

  /// No description provided for @noOrdersFilter.
  ///
  /// In en, this message translates to:
  /// **'No orders with this filter'**
  String get noOrdersFilter;

  /// No description provided for @newOrdersDescription.
  ///
  /// In en, this message translates to:
  /// **'New orders will appear here'**
  String get newOrdersDescription;

  /// No description provided for @orderInfo.
  ///
  /// In en, this message translates to:
  /// **'Order Information'**
  String get orderInfo;

  /// No description provided for @level.
  ///
  /// In en, this message translates to:
  /// **'Level'**
  String get level;

  /// No description provided for @lessonType.
  ///
  /// In en, this message translates to:
  /// **'Lesson Type'**
  String get lessonType;

  /// No description provided for @description.
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get description;

  /// No description provided for @orderDetails.
  ///
  /// In en, this message translates to:
  /// **'Order Details'**
  String get orderDetails;

  /// No description provided for @viewDetailsBook.
  ///
  /// In en, this message translates to:
  /// **'View Details & Book'**
  String get viewDetailsBook;

  /// No description provided for @availableDays.
  ///
  /// In en, this message translates to:
  /// **'{count} Available Days'**
  String availableDays(int count);

  /// No description provided for @otherSubjects.
  ///
  /// In en, this message translates to:
  /// **'and {count} other subjects'**
  String otherSubjects(int count);

  /// No description provided for @individualLesson.
  ///
  /// In en, this message translates to:
  /// **'Individual'**
  String get individualLesson;

  /// No description provided for @groupLesson.
  ///
  /// In en, this message translates to:
  /// **'Group'**
  String get groupLesson;

  /// No description provided for @teacherDashboard.
  ///
  /// In en, this message translates to:
  /// **'Teacher Dashboard'**
  String get teacherDashboard;

  /// No description provided for @today.
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get today;

  /// No description provided for @thisMonth.
  ///
  /// In en, this message translates to:
  /// **'This Month'**
  String get thisMonth;

  /// No description provided for @total.
  ///
  /// In en, this message translates to:
  /// **'Total'**
  String get total;

  /// No description provided for @currentBalance.
  ///
  /// In en, this message translates to:
  /// **'Current Balance'**
  String get currentBalance;

  /// No description provided for @totalLessons.
  ///
  /// In en, this message translates to:
  /// **'Total Lessons'**
  String get totalLessons;

  /// No description provided for @ongoingLessons.
  ///
  /// In en, this message translates to:
  /// **'Ongoing Lessons'**
  String get ongoingLessons;

  /// No description provided for @newPassword.
  ///
  /// In en, this message translates to:
  /// **'New Password'**
  String get newPassword;

  /// No description provided for @confirmPassword.
  ///
  /// In en, this message translates to:
  /// **'Confirm Password'**
  String get confirmPassword;

  /// No description provided for @reEnterPassword.
  ///
  /// In en, this message translates to:
  /// **'Re-enter Password'**
  String get reEnterPassword;

  /// No description provided for @setPassword.
  ///
  /// In en, this message translates to:
  /// **'Set Password'**
  String get setPassword;

  /// No description provided for @passwordChanged.
  ///
  /// In en, this message translates to:
  /// **'Password Changed!'**
  String get passwordChanged;

  /// No description provided for @passwordChangedSuccess.
  ///
  /// In en, this message translates to:
  /// **'New password has been set successfully'**
  String get passwordChangedSuccess;

  /// No description provided for @passwordMismatch.
  ///
  /// In en, this message translates to:
  /// **'Passwords do not match'**
  String get passwordMismatch;

  /// No description provided for @passwordRequired.
  ///
  /// In en, this message translates to:
  /// **'Please enter password'**
  String get passwordRequired;

  /// No description provided for @confirmPasswordRequired.
  ///
  /// In en, this message translates to:
  /// **'Please confirm password'**
  String get confirmPasswordRequired;

  /// No description provided for @passwordStrengthHint.
  ///
  /// In en, this message translates to:
  /// **'Use uppercase, lowercase, numbers, and special characters'**
  String get passwordStrengthHint;

  /// No description provided for @currentPassword.
  ///
  /// In en, this message translates to:
  /// **'Current Password'**
  String get currentPassword;

  /// No description provided for @currentPasswordRequired.
  ///
  /// In en, this message translates to:
  /// **'Please enter current password'**
  String get currentPasswordRequired;

  /// No description provided for @scheduleEmptyState.
  ///
  /// In en, this message translates to:
  /// **'No appointments for this day'**
  String get scheduleEmptyState;

  /// No description provided for @dayTimes.
  ///
  /// In en, this message translates to:
  /// **'{day} Times'**
  String dayTimes(String day);

  /// No description provided for @timesCount.
  ///
  /// In en, this message translates to:
  /// **'{count} Times'**
  String timesCount(int count);

  /// No description provided for @noAppointmentsNow.
  ///
  /// In en, this message translates to:
  /// **'No appointments for this day'**
  String get noAppointmentsNow;

  /// No description provided for @addAppointmentHint.
  ///
  /// In en, this message translates to:
  /// **'Press + to add a new appointment'**
  String get addAppointmentHint;

  /// No description provided for @availableTime.
  ///
  /// In en, this message translates to:
  /// **'Available Time'**
  String get availableTime;

  /// No description provided for @bookedTime.
  ///
  /// In en, this message translates to:
  /// **'Booked Time'**
  String get bookedTime;

  /// No description provided for @removeTime.
  ///
  /// In en, this message translates to:
  /// **'Remove Time'**
  String get removeTime;

  /// No description provided for @addAvailableTime.
  ///
  /// In en, this message translates to:
  /// **'Add Available Time'**
  String get addAvailableTime;

  /// No description provided for @todayDay.
  ///
  /// In en, this message translates to:
  /// **'Day: {day}'**
  String todayDay(String day);

  /// No description provided for @add.
  ///
  /// In en, this message translates to:
  /// **'Add'**
  String get add;

  /// No description provided for @errorUnauthorized.
  ///
  /// In en, this message translates to:
  /// **'Your session has expired, please login again'**
  String get errorUnauthorized;

  /// No description provided for @errorConnectionTimeout.
  ///
  /// In en, this message translates to:
  /// **'Connection timeout, check your internet'**
  String get errorConnectionTimeout;

  /// No description provided for @errorReceiveTimeout.
  ///
  /// In en, this message translates to:
  /// **'Server took too long to respond'**
  String get errorReceiveTimeout;

  /// No description provided for @errorConnectionError.
  ///
  /// In en, this message translates to:
  /// **'Failed to connect to server, check your network'**
  String get errorConnectionError;

  /// No description provided for @errorServerError.
  ///
  /// In en, this message translates to:
  /// **'Error communicating with server'**
  String get errorServerError;

  /// No description provided for @errorFormat.
  ///
  /// In en, this message translates to:
  /// **'Data format error'**
  String get errorFormat;

  /// No description provided for @errorGeneral.
  ///
  /// In en, this message translates to:
  /// **'An unknown error occurred, please try again later'**
  String get errorGeneral;

  /// No description provided for @errorConnectionFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed to connect to server'**
  String get errorConnectionFailed;

  /// No description provided for @errorNotFound.
  ///
  /// In en, this message translates to:
  /// **'The requested resource was not found'**
  String get errorNotFound;

  /// No description provided for @errorCredentials.
  ///
  /// In en, this message translates to:
  /// **'Credentials are incorrect'**
  String get errorCredentials;

  /// No description provided for @errorUnexpected.
  ///
  /// In en, this message translates to:
  /// **'Unexpected server error'**
  String get errorUnexpected;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @completeProfile.
  ///
  /// In en, this message translates to:
  /// **'Complete Profile'**
  String get completeProfile;

  /// No description provided for @completeProfileMessage.
  ///
  /// In en, this message translates to:
  /// **'To access lessons, you must complete your account information'**
  String get completeProfileMessage;

  /// No description provided for @completeProfileButton.
  ///
  /// In en, this message translates to:
  /// **'Complete Now'**
  String get completeProfileButton;

  /// No description provided for @later.
  ///
  /// In en, this message translates to:
  /// **'Later'**
  String get later;

  /// No description provided for @selectRoleReq.
  ///
  /// In en, this message translates to:
  /// **'Select Role'**
  String get selectRoleReq;

  /// No description provided for @basicInfoReq.
  ///
  /// In en, this message translates to:
  /// **'Basic Information'**
  String get basicInfoReq;

  /// No description provided for @verifyAccountReq.
  ///
  /// In en, this message translates to:
  /// **'Verify Account'**
  String get verifyAccountReq;

  /// No description provided for @unsupportedFileType.
  ///
  /// In en, this message translates to:
  /// **'Unsupported file type'**
  String get unsupportedFileType;

  /// No description provided for @processingPdf.
  ///
  /// In en, this message translates to:
  /// **'Processing PDF...'**
  String get processingPdf;

  /// No description provided for @imageLoadFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed to load image'**
  String get imageLoadFailed;

  /// No description provided for @downloadingPdf.
  ///
  /// In en, this message translates to:
  /// **'Downloading PDF...'**
  String get downloadingPdf;

  /// No description provided for @pdfDownloadFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed to download PDF'**
  String get pdfDownloadFailed;

  /// No description provided for @emptyPdfFile.
  ///
  /// In en, this message translates to:
  /// **'Empty PDF file'**
  String get emptyPdfFile;

  /// No description provided for @pdfPages.
  ///
  /// In en, this message translates to:
  /// **'PDF ({count} pages)'**
  String pdfPages(int count);

  /// No description provided for @pdfFile.
  ///
  /// In en, this message translates to:
  /// **'PDF File'**
  String get pdfFile;

  /// No description provided for @clickToUpload.
  ///
  /// In en, this message translates to:
  /// **'Click to upload file'**
  String get clickToUpload;

  /// No description provided for @uploaded.
  ///
  /// In en, this message translates to:
  /// **'Uploaded'**
  String get uploaded;

  /// No description provided for @fileTypes.
  ///
  /// In en, this message translates to:
  /// **'PNG, JPG or PDF'**
  String get fileTypes;

  /// No description provided for @managePaymentMethods.
  ///
  /// In en, this message translates to:
  /// **'Manage Payment Methods'**
  String get managePaymentMethods;

  /// No description provided for @manageBankAccount.
  ///
  /// In en, this message translates to:
  /// **'Manage Bank Account'**
  String get manageBankAccount;

  /// No description provided for @selectPaymentMethod.
  ///
  /// In en, this message translates to:
  /// **'Select Payment Method'**
  String get selectPaymentMethod;

  /// No description provided for @amountDue.
  ///
  /// In en, this message translates to:
  /// **'Amount Due: {amount} SAR'**
  String amountDue(int amount);

  /// No description provided for @savedCards.
  ///
  /// In en, this message translates to:
  /// **'Saved Cards'**
  String get savedCards;

  /// No description provided for @cardsLoadError.
  ///
  /// In en, this message translates to:
  /// **'Error loading cards: {error}'**
  String cardsLoadError(String error);

  /// No description provided for @addNewCard.
  ///
  /// In en, this message translates to:
  /// **'Add New Card'**
  String get addNewCard;

  /// No description provided for @addNewBankAccount.
  ///
  /// In en, this message translates to:
  /// **'Add New Bank Account'**
  String get addNewBankAccount;

  /// No description provided for @visa.
  ///
  /// In en, this message translates to:
  /// **'Visa'**
  String get visa;

  /// No description provided for @masterCard.
  ///
  /// In en, this message translates to:
  /// **'MasterCard'**
  String get masterCard;

  /// No description provided for @mada.
  ///
  /// In en, this message translates to:
  /// **'Mada'**
  String get mada;

  /// No description provided for @back.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get back;

  /// No description provided for @newCardDetails.
  ///
  /// In en, this message translates to:
  /// **'New Card Details'**
  String get newCardDetails;

  /// No description provided for @cardType.
  ///
  /// In en, this message translates to:
  /// **'Card Type'**
  String get cardType;

  /// No description provided for @bankAccountType.
  ///
  /// In en, this message translates to:
  /// **'Bank Account Type'**
  String get bankAccountType;

  /// No description provided for @cardNumber.
  ///
  /// In en, this message translates to:
  /// **'Card Number'**
  String get cardNumber;

  /// No description provided for @cardNumberHint.
  ///
  /// In en, this message translates to:
  /// **'0000 0000 0000 0000'**
  String get cardNumberHint;

  /// No description provided for @cardHolderName.
  ///
  /// In en, this message translates to:
  /// **'Cardholder Name'**
  String get cardHolderName;

  /// No description provided for @cardHolderNameHint.
  ///
  /// In en, this message translates to:
  /// **'Name as on card'**
  String get cardHolderNameHint;

  /// No description provided for @accountHolderName.
  ///
  /// In en, this message translates to:
  /// **'Account Holder Name'**
  String get accountHolderName;

  /// No description provided for @expiryDate.
  ///
  /// In en, this message translates to:
  /// **'Expiry Date'**
  String get expiryDate;

  /// No description provided for @month.
  ///
  /// In en, this message translates to:
  /// **'Month'**
  String get month;

  /// No description provided for @monthHint.
  ///
  /// In en, this message translates to:
  /// **'MM'**
  String get monthHint;

  /// No description provided for @year.
  ///
  /// In en, this message translates to:
  /// **'Year'**
  String get year;

  /// No description provided for @yearHint.
  ///
  /// In en, this message translates to:
  /// **'YY'**
  String get yearHint;

  /// No description provided for @cvv.
  ///
  /// In en, this message translates to:
  /// **'CVV'**
  String get cvv;

  /// No description provided for @cvvHint.
  ///
  /// In en, this message translates to:
  /// **'000'**
  String get cvvHint;

  /// No description provided for @securityNotice.
  ///
  /// In en, this message translates to:
  /// **'Your card details are protected by the highest security standards'**
  String get securityNotice;

  /// No description provided for @cardDefault.
  ///
  /// In en, this message translates to:
  /// **'Default Card'**
  String get cardDefault;

  /// No description provided for @continuePayment.
  ///
  /// In en, this message translates to:
  /// **'Continue Payment'**
  String get continuePayment;

  /// No description provided for @verifyCard.
  ///
  /// In en, this message translates to:
  /// **'Verify Your Card'**
  String get verifyCard;

  /// No description provided for @enterCvvSecurely.
  ///
  /// In en, this message translates to:
  /// **'Enter CVV to complete payment securely'**
  String get enterCvvSecurely;

  /// No description provided for @transactionSecure.
  ///
  /// In en, this message translates to:
  /// **'Your transaction is protected by the highest security levels'**
  String get transactionSecure;

  /// No description provided for @confirmPayment.
  ///
  /// In en, this message translates to:
  /// **'Confirm Payment'**
  String get confirmPayment;

  /// No description provided for @paymentSuccess.
  ///
  /// In en, this message translates to:
  /// **'Payment Successful'**
  String get paymentSuccess;

  /// No description provided for @paymentFailed.
  ///
  /// In en, this message translates to:
  /// **'Payment Failed'**
  String get paymentFailed;

  /// No description provided for @cvvRequired.
  ///
  /// In en, this message translates to:
  /// **'CVV is required'**
  String get cvvRequired;

  /// No description provided for @cvvInvalidLength.
  ///
  /// In en, this message translates to:
  /// **'CVV must be at least 3 digits'**
  String get cvvInvalidLength;

  /// No description provided for @bookingIdRequired.
  ///
  /// In en, this message translates to:
  /// **'Error: Booking ID is required to complete payment'**
  String get bookingIdRequired;

  /// No description provided for @paymentMessageSuccess.
  ///
  /// In en, this message translates to:
  /// **'Payment Successful: {message}'**
  String paymentMessageSuccess(String message);

  /// No description provided for @paymentMessageFailed.
  ///
  /// In en, this message translates to:
  /// **'Payment Failed: {message}'**
  String paymentMessageFailed(String message);

  /// No description provided for @cardAddedSuccess.
  ///
  /// In en, this message translates to:
  /// **'Card added successfully'**
  String get cardAddedSuccess;

  /// No description provided for @cardUpdatedSuccess.
  ///
  /// In en, this message translates to:
  /// **'Card updated successfully'**
  String get cardUpdatedSuccess;

  /// No description provided for @cardDeletedSuccess.
  ///
  /// In en, this message translates to:
  /// **'Card deleted successfully'**
  String get cardDeletedSuccess;

  /// No description provided for @cardDefaultSet.
  ///
  /// In en, this message translates to:
  /// **'Default card set successfully'**
  String get cardDefaultSet;

  /// No description provided for @deleteCardConfirmTitle.
  ///
  /// In en, this message translates to:
  /// **'Confirm Deletion'**
  String get deleteCardConfirmTitle;

  /// No description provided for @deleteCardConfirmMessage.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete this payment method?'**
  String get deleteCardConfirmMessage;

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// No description provided for @deleteAccount.
  ///
  /// In en, this message translates to:
  /// **'Delete Account'**
  String get deleteAccount;

  /// No description provided for @deleteAccountConfirmation.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete your account? This action cannot be undone.'**
  String get deleteAccountConfirmation;

  /// No description provided for @noCards.
  ///
  /// In en, this message translates to:
  /// **'No cards'**
  String get noCards;

  /// No description provided for @noCardsDescription.
  ///
  /// In en, this message translates to:
  /// **'Click the button below to add a new card'**
  String get noCardsDescription;

  /// No description provided for @cardAddError.
  ///
  /// In en, this message translates to:
  /// **'Error: {error}'**
  String cardAddError(String error);

  /// No description provided for @subjectMathAlgebra.
  ///
  /// In en, this message translates to:
  /// **'Math - Algebra'**
  String get subjectMathAlgebra;

  /// No description provided for @subjectPhysicsMechanics.
  ///
  /// In en, this message translates to:
  /// **'Physics - Mechanics'**
  String get subjectPhysicsMechanics;

  /// No description provided for @subjectOrganicChemistry.
  ///
  /// In en, this message translates to:
  /// **'Organic Chemistry'**
  String get subjectOrganicChemistry;

  /// No description provided for @subjectEnglishGrammar.
  ///
  /// In en, this message translates to:
  /// **'English - Grammar'**
  String get subjectEnglishGrammar;

  /// No description provided for @subjectBiologyGenetics.
  ///
  /// In en, this message translates to:
  /// **'Biology - Genetics'**
  String get subjectBiologyGenetics;

  /// No description provided for @subjectMathStatistics.
  ///
  /// In en, this message translates to:
  /// **'Math - Statistics'**
  String get subjectMathStatistics;

  /// No description provided for @subjectPhysicsElectricity.
  ///
  /// In en, this message translates to:
  /// **'Physics - Electricity'**
  String get subjectPhysicsElectricity;

  /// No description provided for @subjectProgrammingPython.
  ///
  /// In en, this message translates to:
  /// **'Programming - Python'**
  String get subjectProgrammingPython;

  /// No description provided for @subjectArabicGrammar.
  ///
  /// In en, this message translates to:
  /// **'Arabic - Grammar'**
  String get subjectArabicGrammar;

  /// No description provided for @subjectGeography.
  ///
  /// In en, this message translates to:
  /// **'Geography'**
  String get subjectGeography;

  /// No description provided for @levelSecondary.
  ///
  /// In en, this message translates to:
  /// **'Secondary'**
  String get levelSecondary;

  /// No description provided for @levelIntermediate.
  ///
  /// In en, this message translates to:
  /// **'Intermediate'**
  String get levelIntermediate;

  /// No description provided for @levelUniversity.
  ///
  /// In en, this message translates to:
  /// **'University'**
  String get levelUniversity;

  /// No description provided for @lessonTypeInPerson.
  ///
  /// In en, this message translates to:
  /// **'In-person'**
  String get lessonTypeInPerson;

  /// No description provided for @lessonTypeOnline.
  ///
  /// In en, this message translates to:
  /// **'Online'**
  String get lessonTypeOnline;

  /// No description provided for @descMathAlgebra.
  ///
  /// In en, this message translates to:
  /// **'Need help understanding quadratic equations and linear functions. Exam coming up.'**
  String get descMathAlgebra;

  /// No description provided for @descPhysicsMechanics.
  ///
  /// In en, this message translates to:
  /// **'Explanation of Newton\'s laws of motion and practical applications.'**
  String get descPhysicsMechanics;

  /// No description provided for @descOrganicChemistry.
  ///
  /// In en, this message translates to:
  /// **'Lessons on organic compounds and chemical reactions.'**
  String get descOrganicChemistry;

  /// No description provided for @descEnglishGrammar.
  ///
  /// In en, this message translates to:
  /// **'Improving grammar and academic writing.'**
  String get descEnglishGrammar;

  /// No description provided for @descBiologyGenetics.
  ///
  /// In en, this message translates to:
  /// **'Understanding Mendel\'s laws and genetic engineering.'**
  String get descBiologyGenetics;

  /// No description provided for @descMathStatistics.
  ///
  /// In en, this message translates to:
  /// **'Help with descriptive and inferential statistics.'**
  String get descMathStatistics;

  /// No description provided for @descPhysicsElectricity.
  ///
  /// In en, this message translates to:
  /// **'Explanation of electric circuits and Ohm\'s law.'**
  String get descPhysicsElectricity;

  /// No description provided for @descProgrammingPython.
  ///
  /// In en, this message translates to:
  /// **'Learning programming basics in Python.'**
  String get descProgrammingPython;

  /// No description provided for @descArabicGrammar.
  ///
  /// In en, this message translates to:
  /// **'Explanation of grammar and syntax rules.'**
  String get descArabicGrammar;

  /// No description provided for @descGeography.
  ///
  /// In en, this message translates to:
  /// **'Studying physical and human geography.'**
  String get descGeography;

  /// No description provided for @editBankAccount.
  ///
  /// In en, this message translates to:
  /// **'Edit Bank Account'**
  String get editBankAccount;

  /// No description provided for @addBankAccount.
  ///
  /// In en, this message translates to:
  /// **'Add Bank Account'**
  String get addBankAccount;

  /// No description provided for @editCard.
  ///
  /// In en, this message translates to:
  /// **'Edit Card'**
  String get editCard;

  /// No description provided for @addCard.
  ///
  /// In en, this message translates to:
  /// **'Add Payment Card '**
  String get addCard;

  /// No description provided for @forReceivingEarnings.
  ///
  /// In en, this message translates to:
  /// **'For receiving your earnings'**
  String get forReceivingEarnings;

  /// No description provided for @forBookingLessons.
  ///
  /// In en, this message translates to:
  /// **'For booking lessons'**
  String get forBookingLessons;

  /// No description provided for @selectBank.
  ///
  /// In en, this message translates to:
  /// **'Select Bank'**
  String get selectBank;

  /// No description provided for @enterIban.
  ///
  /// In en, this message translates to:
  /// **'Enter IBAN'**
  String get enterIban;

  /// No description provided for @nameAsInBank.
  ///
  /// In en, this message translates to:
  /// **'Name as in Bank'**
  String get nameAsInBank;

  /// No description provided for @tooShort.
  ///
  /// In en, this message translates to:
  /// **'Too short'**
  String get tooShort;

  /// No description provided for @earningsTransferNotice.
  ///
  /// In en, this message translates to:
  /// **'Your earnings will be transferred to this account'**
  String get earningsTransferNotice;

  /// No description provided for @selectType.
  ///
  /// In en, this message translates to:
  /// **'Select Type'**
  String get selectType;

  /// No description provided for @nameOnCard.
  ///
  /// In en, this message translates to:
  /// **'Name on Card'**
  String get nameOnCard;

  /// No description provided for @detailsProtected.
  ///
  /// In en, this message translates to:
  /// **'Your details are protected'**
  String get detailsProtected;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @bank.
  ///
  /// In en, this message translates to:
  /// **'Bank'**
  String get bank;

  /// No description provided for @iban.
  ///
  /// In en, this message translates to:
  /// **'IBAN Number'**
  String get iban;

  /// No description provided for @accountNumber.
  ///
  /// In en, this message translates to:
  /// **'Account Number'**
  String get accountNumber;

  /// No description provided for @verificationHeader.
  ///
  /// In en, this message translates to:
  /// **'Code Verification'**
  String get verificationHeader;

  /// No description provided for @codeSentToUser.
  ///
  /// In en, this message translates to:
  /// **'Verification code sent to'**
  String get codeSentToUser;

  /// No description provided for @resendCodeIn.
  ///
  /// In en, this message translates to:
  /// **'Resend code in '**
  String get resendCodeIn;

  /// No description provided for @seconds.
  ///
  /// In en, this message translates to:
  /// **'seconds'**
  String get seconds;

  /// No description provided for @resendCode.
  ///
  /// In en, this message translates to:
  /// **'Resend Code'**
  String get resendCode;

  /// No description provided for @errorLoadingBanks.
  ///
  /// In en, this message translates to:
  /// **'Error loading banks: '**
  String get errorLoadingBanks;

  /// No description provided for @invalid.
  ///
  /// In en, this message translates to:
  /// **'Invalid value'**
  String get invalid;

  /// No description provided for @edit.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get edit;

  /// No description provided for @gallery.
  ///
  /// In en, this message translates to:
  /// **'Gallery'**
  String get gallery;

  /// No description provided for @camera.
  ///
  /// In en, this message translates to:
  /// **'Camera'**
  String get camera;

  /// No description provided for @title.
  ///
  /// In en, this message translates to:
  /// **'Title'**
  String get title;

  /// No description provided for @seats.
  ///
  /// In en, this message translates to:
  /// **'Seats'**
  String get seats;

  /// No description provided for @registeredStudents.
  ///
  /// In en, this message translates to:
  /// **'Registered Students'**
  String get registeredStudents;

  /// No description provided for @noStudentData.
  ///
  /// In en, this message translates to:
  /// **'No student data'**
  String get noStudentData;

  /// No description provided for @seatsCount.
  ///
  /// In en, this message translates to:
  /// **'{count} Seats'**
  String seatsCount(int count);

  /// No description provided for @hoursShort.
  ///
  /// In en, this message translates to:
  /// **'{count} hr'**
  String hoursShort(int count);

  /// No description provided for @enter.
  ///
  /// In en, this message translates to:
  /// **'Enter {field}'**
  String enter(String field);

  /// No description provided for @selectRole.
  ///
  /// In en, this message translates to:
  /// **'Select Role'**
  String get selectRole;

  /// No description provided for @decline.
  ///
  /// In en, this message translates to:
  /// **'Decline'**
  String get decline;

  /// No description provided for @saveChanges.
  ///
  /// In en, this message translates to:
  /// **'Save Changes'**
  String get saveChanges;

  /// No description provided for @changesSaved.
  ///
  /// In en, this message translates to:
  /// **'Changes Saved'**
  String get changesSaved;

  /// No description provided for @availableTimesTitle.
  ///
  /// In en, this message translates to:
  /// **'Available Times'**
  String get availableTimesTitle;

  /// No description provided for @addTime.
  ///
  /// In en, this message translates to:
  /// **'Add Time'**
  String get addTime;

  /// No description provided for @timeExistsError.
  ///
  /// In en, this message translates to:
  /// **'Time {time} already exists or is too close to another time'**
  String timeExistsError(String time);

  /// No description provided for @timeAddedSuccess.
  ///
  /// In en, this message translates to:
  /// **'Time {time} added successfully'**
  String timeAddedSuccess(String time);

  /// No description provided for @timeRemovedSuccess.
  ///
  /// In en, this message translates to:
  /// **'Time {time} removed successfully'**
  String timeRemovedSuccess(String time);

  /// No description provided for @available.
  ///
  /// In en, this message translates to:
  /// **'Available'**
  String get available;

  /// No description provided for @booked.
  ///
  /// In en, this message translates to:
  /// **'Booked'**
  String get booked;

  /// No description provided for @manageSubjectsTitle.
  ///
  /// In en, this message translates to:
  /// **'Subject Management'**
  String get manageSubjectsTitle;

  /// No description provided for @noSubjects.
  ///
  /// In en, this message translates to:
  /// **'No Subjects'**
  String get noSubjects;

  /// No description provided for @startAddingSubjects.
  ///
  /// In en, this message translates to:
  /// **'Start adding subjects'**
  String get startAddingSubjects;

  /// No description provided for @filterBy.
  ///
  /// In en, this message translates to:
  /// **'Filter By'**
  String get filterBy;

  /// No description provided for @educationalLevel.
  ///
  /// In en, this message translates to:
  /// **'Educational Level'**
  String get educationalLevel;

  /// No description provided for @schoolClass.
  ///
  /// In en, this message translates to:
  /// **'School Class'**
  String get schoolClass;

  /// No description provided for @selectLevel.
  ///
  /// In en, this message translates to:
  /// **'Select Study Level'**
  String get selectLevel;

  /// No description provided for @selectClass.
  ///
  /// In en, this message translates to:
  /// **'Select Class'**
  String get selectClass;

  /// No description provided for @selectLevelFirst.
  ///
  /// In en, this message translates to:
  /// **'Select Level First'**
  String get selectLevelFirst;

  /// No description provided for @confirmDelete.
  ///
  /// In en, this message translates to:
  /// **'Confirm Delete'**
  String get confirmDelete;

  /// No description provided for @confirmDeleteSubject.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete this subject?'**
  String confirmDeleteSubject(String name);

  /// No description provided for @addClass.
  ///
  /// In en, this message translates to:
  /// **'Add Class'**
  String get addClass;

  /// No description provided for @addSubject.
  ///
  /// In en, this message translates to:
  /// **'Add Subject'**
  String get addSubject;

  /// No description provided for @subjectsOf.
  ///
  /// In en, this message translates to:
  /// **'Subjects of {name}'**
  String subjectsOf(String name);

  /// No description provided for @classesOf.
  ///
  /// In en, this message translates to:
  /// **'Classes of {name}'**
  String classesOf(String name);

  /// No description provided for @saturday.
  ///
  /// In en, this message translates to:
  /// **'Saturday'**
  String get saturday;

  /// No description provided for @sunday.
  ///
  /// In en, this message translates to:
  /// **'Sunday'**
  String get sunday;

  /// No description provided for @monday.
  ///
  /// In en, this message translates to:
  /// **'Monday'**
  String get monday;

  /// No description provided for @tuesday.
  ///
  /// In en, this message translates to:
  /// **'Tuesday'**
  String get tuesday;

  /// No description provided for @wednesday.
  ///
  /// In en, this message translates to:
  /// **'Wednesday'**
  String get wednesday;

  /// No description provided for @thursday.
  ///
  /// In en, this message translates to:
  /// **'Thursday'**
  String get thursday;

  /// No description provided for @friday.
  ///
  /// In en, this message translates to:
  /// **'Friday'**
  String get friday;

  /// No description provided for @editProfile.
  ///
  /// In en, this message translates to:
  /// **'Edit Profile'**
  String get editProfile;

  /// No description provided for @changePassword.
  ///
  /// In en, this message translates to:
  /// **'Change Password'**
  String get changePassword;

  /// No description provided for @manageTimes.
  ///
  /// In en, this message translates to:
  /// **'Manage Times'**
  String get manageTimes;

  /// No description provided for @manageLevelsSubjects.
  ///
  /// In en, this message translates to:
  /// **'Manage Levels & Subjects'**
  String get manageLevelsSubjects;

  /// No description provided for @myWallet.
  ///
  /// In en, this message translates to:
  /// **'My Wallet'**
  String get myWallet;

  /// No description provided for @myBookings.
  ///
  /// In en, this message translates to:
  /// **'My Bookings'**
  String get myBookings;

  /// No description provided for @notifications.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get notifications;

  /// No description provided for @logout.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get logout;

  /// No description provided for @logoutConfirmation.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to logout?'**
  String get logoutConfirmation;

  /// No description provided for @loggingOut.
  ///
  /// In en, this message translates to:
  /// **'Logging out...'**
  String get loggingOut;

  /// No description provided for @confirm.
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get confirm;

  /// No description provided for @saveSuccess.
  ///
  /// In en, this message translates to:
  /// **'Saved successfully'**
  String get saveSuccess;

  /// No description provided for @saveFailed.
  ///
  /// In en, this message translates to:
  /// **'Save failed: {error}'**
  String saveFailed(String error);

  /// No description provided for @pickFileError.
  ///
  /// In en, this message translates to:
  /// **'Error picking file'**
  String get pickFileError;

  /// No description provided for @fileReadError.
  ///
  /// In en, this message translates to:
  /// **'Failed to read file'**
  String get fileReadError;

  /// No description provided for @passwordStrengthVeryWeak.
  ///
  /// In en, this message translates to:
  /// **'Very Weak'**
  String get passwordStrengthVeryWeak;

  /// No description provided for @passwordStrengthWeak.
  ///
  /// In en, this message translates to:
  /// **'Weak'**
  String get passwordStrengthWeak;

  /// No description provided for @passwordStrengthMedium.
  ///
  /// In en, this message translates to:
  /// **'Medium'**
  String get passwordStrengthMedium;

  /// No description provided for @passwordStrengthStrong.
  ///
  /// In en, this message translates to:
  /// **'Strong'**
  String get passwordStrengthStrong;

  /// No description provided for @verificationDataMissing.
  ///
  /// In en, this message translates to:
  /// **'Verification data missing'**
  String get verificationDataMissing;

  /// No description provided for @setNewPasswordTitle.
  ///
  /// In en, this message translates to:
  /// **'Set New Password'**
  String get setNewPasswordTitle;

  /// No description provided for @setNewPasswordSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Please enter a strong and secure password'**
  String get setNewPasswordSubtitle;

  /// No description provided for @skip.
  ///
  /// In en, this message translates to:
  /// **'Skip'**
  String get skip;

  /// No description provided for @next.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get next;

  /// No description provided for @onboardingTitle1.
  ///
  /// In en, this message translates to:
  /// **'Geniuses School is Here'**
  String get onboardingTitle1;

  /// No description provided for @onboardingDesc1.
  ///
  /// In en, this message translates to:
  /// **'A success story starts with a vision and becomes reality. We elevate education and build genius humans.'**
  String get onboardingDesc1;

  /// No description provided for @onboardingBtn1.
  ///
  /// In en, this message translates to:
  /// **'What\'s Next?'**
  String get onboardingBtn1;

  /// No description provided for @onboardingTitle2.
  ///
  /// In en, this message translates to:
  /// **'Geniuses School Welcomes You'**
  String get onboardingTitle2;

  /// No description provided for @onboardingDesc2.
  ///
  /// In en, this message translates to:
  /// **'Our mission is to build an educated generation capable of facing future challenges.'**
  String get onboardingDesc2;

  /// No description provided for @onboardingBtn2.
  ///
  /// In en, this message translates to:
  /// **'Next...'**
  String get onboardingBtn2;

  /// No description provided for @onboardingTitle3.
  ///
  /// In en, this message translates to:
  /// **'Start Your Journey'**
  String get onboardingTitle3;

  /// No description provided for @onboardingDesc3.
  ///
  /// In en, this message translates to:
  /// **'Join our educational community and start your journey towards a bright future.'**
  String get onboardingDesc3;

  /// No description provided for @onboardingBtn3.
  ///
  /// In en, this message translates to:
  /// **'Let\'s Start'**
  String get onboardingBtn3;

  /// No description provided for @teacherOrdersTitle.
  ///
  /// In en, this message translates to:
  /// **'Teacher Orders'**
  String get teacherOrdersTitle;

  /// No description provided for @removeFilters.
  ///
  /// In en, this message translates to:
  /// **'Remove Filters'**
  String get removeFilters;

  /// No description provided for @requestCount.
  ///
  /// In en, this message translates to:
  /// **'{count} Request'**
  String requestCount(int count);

  /// No description provided for @requestAccepted.
  ///
  /// In en, this message translates to:
  /// **'Request for {name} accepted'**
  String requestAccepted(String name);

  /// No description provided for @undo.
  ///
  /// In en, this message translates to:
  /// **'Undo'**
  String get undo;

  /// No description provided for @rejectRequestTitle.
  ///
  /// In en, this message translates to:
  /// **'Reject Request'**
  String get rejectRequestTitle;

  /// No description provided for @rejectRequestMessage.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to reject request from {name}?'**
  String rejectRequestMessage(String name);

  /// No description provided for @requestRejected.
  ///
  /// In en, this message translates to:
  /// **'Request rejected'**
  String get requestRejected;

  /// No description provided for @lessonNotStarted.
  ///
  /// In en, this message translates to:
  /// **'Lesson has not started yet'**
  String get lessonNotStarted;

  /// No description provided for @roomCreationFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed to create room: {error}'**
  String roomCreationFailed(String error);

  /// No description provided for @lessonNotStartedRetry.
  ///
  /// In en, this message translates to:
  /// **'Lesson has not started yet. Please try again later'**
  String get lessonNotStartedRetry;

  /// No description provided for @joinFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed to join: {error}'**
  String joinFailed(String error);

  /// No description provided for @errorTitle.
  ///
  /// In en, this message translates to:
  /// **'Error: {error}'**
  String errorTitle(String error);

  /// No description provided for @cannotOpenLink.
  ///
  /// In en, this message translates to:
  /// **'Cannot open link'**
  String get cannotOpenLink;

  /// No description provided for @lessonInProgress.
  ///
  /// In en, this message translates to:
  /// **'Lesson is in progress'**
  String get lessonInProgress;

  /// No description provided for @comingSoon.
  ///
  /// In en, this message translates to:
  /// **'Coming Soon'**
  String get comingSoon;

  /// No description provided for @lessonInfo.
  ///
  /// In en, this message translates to:
  /// **'Lesson Info'**
  String get lessonInfo;

  /// No description provided for @duration.
  ///
  /// In en, this message translates to:
  /// **'Duration'**
  String get duration;

  /// No description provided for @minutesCount.
  ///
  /// In en, this message translates to:
  /// **'{count} Minutes'**
  String minutesCount(int count);

  /// No description provided for @creatingRoom.
  ///
  /// In en, this message translates to:
  /// **'Creating Room...'**
  String get creatingRoom;

  /// No description provided for @joiningRoom.
  ///
  /// In en, this message translates to:
  /// **'Joining room...'**
  String get joiningRoom;

  /// No description provided for @createAndJoin.
  ///
  /// In en, this message translates to:
  /// **'Create Room & Join'**
  String get createAndJoin;

  /// No description provided for @enterLesson.
  ///
  /// In en, this message translates to:
  /// **'Enter Lesson'**
  String get enterLesson;

  /// No description provided for @lessonComingSoon.
  ///
  /// In en, this message translates to:
  /// **'Lesson is coming soon'**
  String get lessonComingSoon;

  /// No description provided for @pleaseWaitCreating.
  ///
  /// In en, this message translates to:
  /// **'Please wait, setting up room...'**
  String get pleaseWaitCreating;

  /// No description provided for @pleaseWaitJoining.
  ///
  /// In en, this message translates to:
  /// **'Please wait, joining...'**
  String get pleaseWaitJoining;

  /// No description provided for @clickToCreateAndJoin.
  ///
  /// In en, this message translates to:
  /// **'Click to create and join lesson room'**
  String get clickToCreateAndJoin;

  /// No description provided for @clickToJoin.
  ///
  /// In en, this message translates to:
  /// **'Click to join lesson room'**
  String get clickToJoin;

  /// No description provided for @joinButtonAvailableLater.
  ///
  /// In en, this message translates to:
  /// **'Join button will be available when lesson starts'**
  String get joinButtonAvailableLater;

  /// No description provided for @lessonTime.
  ///
  /// In en, this message translates to:
  /// **'Lesson Time'**
  String get lessonTime;

  /// No description provided for @liveNow.
  ///
  /// In en, this message translates to:
  /// **'Live Now'**
  String get liveNow;

  /// No description provided for @errorLoadingData.
  ///
  /// In en, this message translates to:
  /// **'Error loading data'**
  String get errorLoadingData;

  /// No description provided for @noLessonInfo.
  ///
  /// In en, this message translates to:
  /// **'No lesson information'**
  String get noLessonInfo;

  /// No description provided for @activeLesson.
  ///
  /// In en, this message translates to:
  /// **'Active Lesson'**
  String get activeLesson;

  /// No description provided for @students.
  ///
  /// In en, this message translates to:
  /// **'Students'**
  String get students;

  /// No description provided for @missedLessonsCount.
  ///
  /// In en, this message translates to:
  /// **'Missed Lessons'**
  String get missedLessonsCount;

  /// No description provided for @phoneNumberHint.
  ///
  /// In en, this message translates to:
  /// **'5xxxxxxxx'**
  String get phoneNumberHint;

  /// No description provided for @aboutTeacher.
  ///
  /// In en, this message translates to:
  /// **'About Teacher'**
  String get aboutTeacher;

  /// No description provided for @subjectsTaught.
  ///
  /// In en, this message translates to:
  /// **'Subjects Taught'**
  String get subjectsTaught;

  /// No description provided for @chooseSessionTimes.
  ///
  /// In en, this message translates to:
  /// **'Choose Session Times'**
  String get chooseSessionTimes;

  /// No description provided for @bookNowInstruction.
  ///
  /// In en, this message translates to:
  /// **'Click \'Book Now\' to choose level, class, subject and suitable time'**
  String get bookNowInstruction;

  /// No description provided for @bookNow.
  ///
  /// In en, this message translates to:
  /// **'Book Now'**
  String get bookNow;

  /// No description provided for @availableSeatsCount.
  ///
  /// In en, this message translates to:
  /// **'{count} Seats Available'**
  String availableSeatsCount(int count);

  /// No description provided for @details.
  ///
  /// In en, this message translates to:
  /// **'Details'**
  String get details;

  /// No description provided for @levelBeginner.
  ///
  /// In en, this message translates to:
  /// **'Beginner'**
  String get levelBeginner;

  /// No description provided for @levelAdvanced.
  ///
  /// In en, this message translates to:
  /// **'Advanced'**
  String get levelAdvanced;

  /// No description provided for @levelUnknown.
  ///
  /// In en, this message translates to:
  /// **'Unknown'**
  String get levelUnknown;

  /// No description provided for @minMaxStudents.
  ///
  /// In en, this message translates to:
  /// **'{min}-{max} Students'**
  String minMaxStudents(int min, int max);

  /// No description provided for @perHourText.
  ///
  /// In en, this message translates to:
  /// **'Per Hour'**
  String get perHourText;

  /// No description provided for @addCourse.
  ///
  /// In en, this message translates to:
  /// **'Add Course'**
  String get addCourse;

  /// No description provided for @coverImageRequired.
  ///
  /// In en, this message translates to:
  /// **'Please select cover image'**
  String get coverImageRequired;

  /// No description provided for @availableSlotsRequired.
  ///
  /// In en, this message translates to:
  /// **'Please add available slots'**
  String get availableSlotsRequired;

  /// No description provided for @courseAddedSuccess.
  ///
  /// In en, this message translates to:
  /// **'Course added successfully'**
  String get courseAddedSuccess;

  /// No description provided for @saveCourse.
  ///
  /// In en, this message translates to:
  /// **'Save Course'**
  String get saveCourse;

  /// No description provided for @courseTitleAr.
  ///
  /// In en, this message translates to:
  /// **'Course Title (Arabic)'**
  String get courseTitleAr;

  /// No description provided for @courseTitleEn.
  ///
  /// In en, this message translates to:
  /// **'Course Title (English)'**
  String get courseTitleEn;

  /// No description provided for @hours.
  ///
  /// In en, this message translates to:
  /// **'Hours'**
  String get hours;

  /// No description provided for @weeklyAvailableSlots.
  ///
  /// In en, this message translates to:
  /// **'Available Slots (Weekly)'**
  String get weeklyAvailableSlots;

  /// No description provided for @noSlotsAdded.
  ///
  /// In en, this message translates to:
  /// **'No slots added'**
  String get noSlotsAdded;

  /// No description provided for @courseType.
  ///
  /// In en, this message translates to:
  /// **'Course Type'**
  String get courseType;

  /// No description provided for @typeSingle.
  ///
  /// In en, this message translates to:
  /// **'Single'**
  String get typeSingle;

  /// No description provided for @typeGroup.
  ///
  /// In en, this message translates to:
  /// **'Group'**
  String get typeGroup;

  /// No description provided for @male.
  ///
  /// In en, this message translates to:
  /// **'Male'**
  String get male;

  /// No description provided for @female.
  ///
  /// In en, this message translates to:
  /// **'Female'**
  String get female;

  /// No description provided for @other.
  ///
  /// In en, this message translates to:
  /// **'Other'**
  String get other;

  /// No description provided for @optional.
  ///
  /// In en, this message translates to:
  /// **'(Optional)'**
  String get optional;

  /// No description provided for @countryQatar.
  ///
  /// In en, this message translates to:
  /// **'Qatar'**
  String get countryQatar;

  /// No description provided for @countryEgypt.
  ///
  /// In en, this message translates to:
  /// **'Egypt'**
  String get countryEgypt;

  /// No description provided for @countrySaudi.
  ///
  /// In en, this message translates to:
  /// **'Saudi Arabia'**
  String get countrySaudi;

  /// No description provided for @countrySudan.
  ///
  /// In en, this message translates to:
  /// **'Sudan'**
  String get countrySudan;

  /// No description provided for @countryUAE.
  ///
  /// In en, this message translates to:
  /// **'United Arab Emirates'**
  String get countryUAE;

  /// No description provided for @countryKuwait.
  ///
  /// In en, this message translates to:
  /// **'Kuwait'**
  String get countryKuwait;

  /// No description provided for @countryBahrain.
  ///
  /// In en, this message translates to:
  /// **'Bahrain'**
  String get countryBahrain;

  /// No description provided for @countryOman.
  ///
  /// In en, this message translates to:
  /// **'Oman'**
  String get countryOman;

  /// No description provided for @countryYemen.
  ///
  /// In en, this message translates to:
  /// **'Yemen'**
  String get countryYemen;

  /// No description provided for @countryJordan.
  ///
  /// In en, this message translates to:
  /// **'Jordan'**
  String get countryJordan;

  /// No description provided for @countrySyria.
  ///
  /// In en, this message translates to:
  /// **'Syria'**
  String get countrySyria;

  /// No description provided for @countryLebanon.
  ///
  /// In en, this message translates to:
  /// **'Lebanon'**
  String get countryLebanon;

  /// No description provided for @countryPalestine.
  ///
  /// In en, this message translates to:
  /// **'Palestine'**
  String get countryPalestine;

  /// No description provided for @countryIraq.
  ///
  /// In en, this message translates to:
  /// **'Iraq'**
  String get countryIraq;

  /// No description provided for @countryLibya.
  ///
  /// In en, this message translates to:
  /// **'Libya'**
  String get countryLibya;

  /// No description provided for @countryTunisia.
  ///
  /// In en, this message translates to:
  /// **'Tunisia'**
  String get countryTunisia;

  /// No description provided for @countryAlgeria.
  ///
  /// In en, this message translates to:
  /// **'Algeria'**
  String get countryAlgeria;

  /// No description provided for @countryMorocco.
  ///
  /// In en, this message translates to:
  /// **'Morocco'**
  String get countryMorocco;

  /// No description provided for @countryMauritania.
  ///
  /// In en, this message translates to:
  /// **'Mauritania'**
  String get countryMauritania;

  /// No description provided for @countrySomalia.
  ///
  /// In en, this message translates to:
  /// **'Somalia'**
  String get countrySomalia;

  /// No description provided for @countryDjibouti.
  ///
  /// In en, this message translates to:
  /// **'Djibouti'**
  String get countryDjibouti;

  /// No description provided for @countryComoros.
  ///
  /// In en, this message translates to:
  /// **'Comoros'**
  String get countryComoros;

  /// No description provided for @countryTurkey.
  ///
  /// In en, this message translates to:
  /// **'Turkey'**
  String get countryTurkey;

  /// No description provided for @countryIndonesia.
  ///
  /// In en, this message translates to:
  /// **'Indonesia'**
  String get countryIndonesia;

  /// No description provided for @countryMalaysia.
  ///
  /// In en, this message translates to:
  /// **'Malaysia'**
  String get countryMalaysia;

  /// No description provided for @countryIndia.
  ///
  /// In en, this message translates to:
  /// **'India'**
  String get countryIndia;

  /// No description provided for @countryPakistan.
  ///
  /// In en, this message translates to:
  /// **'Pakistan'**
  String get countryPakistan;

  /// No description provided for @countryUS.
  ///
  /// In en, this message translates to:
  /// **'United States'**
  String get countryUS;

  /// No description provided for @countryUK.
  ///
  /// In en, this message translates to:
  /// **'United Kingdom'**
  String get countryUK;

  /// No description provided for @accountExists.
  ///
  /// In en, this message translates to:
  /// **'Account Exists'**
  String get accountExists;

  /// No description provided for @accountExistsMessage.
  ///
  /// In en, this message translates to:
  /// **'This account already exists. Please login instead.'**
  String get accountExistsMessage;

  /// No description provided for @verificationRequired.
  ///
  /// In en, this message translates to:
  /// **'Verify Account'**
  String get verificationRequired;

  /// No description provided for @continueVerificationMessage.
  ///
  /// In en, this message translates to:
  /// **'You have a pending registration. Would you like to continue verification?'**
  String get continueVerificationMessage;

  /// No description provided for @validationError.
  ///
  /// In en, this message translates to:
  /// **'Validation Error'**
  String get validationError;

  /// No description provided for @countryFrance.
  ///
  /// In en, this message translates to:
  /// **'France'**
  String get countryFrance;

  /// No description provided for @countryGermany.
  ///
  /// In en, this message translates to:
  /// **'Germany'**
  String get countryGermany;

  /// No description provided for @countrySpain.
  ///
  /// In en, this message translates to:
  /// **'Spain'**
  String get countrySpain;

  /// No description provided for @countryItaly.
  ///
  /// In en, this message translates to:
  /// **'Italy'**
  String get countryItaly;

  /// No description provided for @countryRussia.
  ///
  /// In en, this message translates to:
  /// **'Russia'**
  String get countryRussia;

  /// No description provided for @countryChina.
  ///
  /// In en, this message translates to:
  /// **'China'**
  String get countryChina;

  /// No description provided for @countryJapan.
  ///
  /// In en, this message translates to:
  /// **'Japan'**
  String get countryJapan;

  /// No description provided for @countrySouthKorea.
  ///
  /// In en, this message translates to:
  /// **'South Korea'**
  String get countrySouthKorea;

  /// No description provided for @countryCanada.
  ///
  /// In en, this message translates to:
  /// **'Canada'**
  String get countryCanada;

  /// No description provided for @countryBrazil.
  ///
  /// In en, this message translates to:
  /// **'Brazil'**
  String get countryBrazil;

  /// No description provided for @countryAustralia.
  ///
  /// In en, this message translates to:
  /// **'Australia'**
  String get countryAustralia;

  /// No description provided for @countryNigeria.
  ///
  /// In en, this message translates to:
  /// **'Nigeria'**
  String get countryNigeria;

  /// No description provided for @countrySouthAfrica.
  ///
  /// In en, this message translates to:
  /// **'South Africa'**
  String get countrySouthAfrica;

  /// No description provided for @countryMexico.
  ///
  /// In en, this message translates to:
  /// **'Mexico'**
  String get countryMexico;

  /// No description provided for @countryArgentina.
  ///
  /// In en, this message translates to:
  /// **'Argentina'**
  String get countryArgentina;

  /// No description provided for @typePackage.
  ///
  /// In en, this message translates to:
  /// **'Package'**
  String get typePackage;

  /// No description provided for @typeSubscription.
  ///
  /// In en, this message translates to:
  /// **'Subscription'**
  String get typeSubscription;

  /// No description provided for @sar.
  ///
  /// In en, this message translates to:
  /// **'SAR'**
  String get sar;

  /// No description provided for @statusDraft.
  ///
  /// In en, this message translates to:
  /// **'Draft'**
  String get statusDraft;

  /// No description provided for @statusPublished.
  ///
  /// In en, this message translates to:
  /// **'Published'**
  String get statusPublished;

  /// No description provided for @totalPrice.
  ///
  /// In en, this message translates to:
  /// **'Total Price'**
  String get totalPrice;

  /// No description provided for @statusPendingPayment.
  ///
  /// In en, this message translates to:
  /// **'Pending Payment'**
  String get statusPendingPayment;

  /// No description provided for @confirmEmailTitle.
  ///
  /// In en, this message translates to:
  /// **'Confirm Email'**
  String get confirmEmailTitle;

  /// No description provided for @addPhoneNumber.
  ///
  /// In en, this message translates to:
  /// **'Add Phone Number'**
  String get addPhoneNumber;

  /// No description provided for @uploadProfilePicture.
  ///
  /// In en, this message translates to:
  /// **'Upload Profile Picture'**
  String get uploadProfilePicture;

  /// No description provided for @updateProfile.
  ///
  /// In en, this message translates to:
  /// **'Update Profile'**
  String get updateProfile;

  /// No description provided for @updateProfileMsg.
  ///
  /// In en, this message translates to:
  /// **'This feature is available only for fully registered users'**
  String get updateProfileMsg;

  /// No description provided for @chooseEducationLevel.
  ///
  /// In en, this message translates to:
  /// **'Choose Education Level'**
  String get chooseEducationLevel;

  /// No description provided for @addLocation.
  ///
  /// In en, this message translates to:
  /// **'Add Location'**
  String get addLocation;

  /// No description provided for @confirmEmailMsg.
  ///
  /// In en, this message translates to:
  /// **'You must confirm your email to continue'**
  String get confirmEmailMsg;

  /// No description provided for @openEmail.
  ///
  /// In en, this message translates to:
  /// **'Open Email'**
  String get openEmail;

  /// No description provided for @clickConfirmLink.
  ///
  /// In en, this message translates to:
  /// **'Click Confirmation Link'**
  String get clickConfirmLink;

  /// No description provided for @subscriptionRequired.
  ///
  /// In en, this message translates to:
  /// **'Subscription Required'**
  String get subscriptionRequired;

  /// No description provided for @subscriptionMsg.
  ///
  /// In en, this message translates to:
  /// **'This feature is available for subscribers only'**
  String get subscriptionMsg;

  /// No description provided for @subscribePremium.
  ///
  /// In en, this message translates to:
  /// **'Subscribe to Premium Plan'**
  String get subscribePremium;

  /// No description provided for @getExclusiveFeatures.
  ///
  /// In en, this message translates to:
  /// **'Get Exclusive Features'**
  String get getExclusiveFeatures;

  /// No description provided for @subscribeNow.
  ///
  /// In en, this message translates to:
  /// **'Subscribe Now'**
  String get subscribeNow;

  /// No description provided for @goBack.
  ///
  /// In en, this message translates to:
  /// **'Go Back'**
  String get goBack;

  /// No description provided for @yearsExperience.
  ///
  /// In en, this message translates to:
  /// **'Years Experience'**
  String get yearsExperience;

  /// No description provided for @teacherBio.
  ///
  /// In en, this message translates to:
  /// **'Teacher Bio'**
  String get teacherBio;

  /// No description provided for @teachingDetails.
  ///
  /// In en, this message translates to:
  /// **'Teaching Details'**
  String get teachingDetails;

  /// No description provided for @specialization.
  ///
  /// In en, this message translates to:
  /// **'Specialization'**
  String get specialization;

  /// No description provided for @availableClasses.
  ///
  /// In en, this message translates to:
  /// **'Available Classes'**
  String get availableClasses;

  /// No description provided for @sendMessage.
  ///
  /// In en, this message translates to:
  /// **'Send Message'**
  String get sendMessage;

  /// No description provided for @messageSentTo.
  ///
  /// In en, this message translates to:
  /// **'Message sent to {name}'**
  String messageSentTo(String name);

  /// No description provided for @previous.
  ///
  /// In en, this message translates to:
  /// **'Previous'**
  String get previous;

  /// No description provided for @confirmBooking.
  ///
  /// In en, this message translates to:
  /// **'Confirm Booking'**
  String get confirmBooking;

  /// No description provided for @bookingNumber.
  ///
  /// In en, this message translates to:
  /// **'Booking Number'**
  String get bookingNumber;

  /// No description provided for @amountPaid.
  ///
  /// In en, this message translates to:
  /// **'Amount Paid'**
  String get amountPaid;

  /// No description provided for @cardEnding.
  ///
  /// In en, this message translates to:
  /// **'Card ending in'**
  String get cardEnding;

  /// No description provided for @noTimesAvailable.
  ///
  /// In en, this message translates to:
  /// **'No times available currently'**
  String get noTimesAvailable;

  /// No description provided for @chooseSuitableTime.
  ///
  /// In en, this message translates to:
  /// **'Choose Suitable Time'**
  String get chooseSuitableTime;

  /// No description provided for @chooseDayTimeInstruction.
  ///
  /// In en, this message translates to:
  /// **'Choose suitable day and time for the lesson'**
  String get chooseDayTimeInstruction;

  /// No description provided for @aboutApp.
  ///
  /// In en, this message translates to:
  /// **'About App'**
  String get aboutApp;

  /// No description provided for @developer.
  ///
  /// In en, this message translates to:
  /// **'Developer'**
  String get developer;

  /// No description provided for @companyName.
  ///
  /// In en, this message translates to:
  /// **'Geniuses School Technology'**
  String get companyName;

  /// No description provided for @supportEmail.
  ///
  /// In en, this message translates to:
  /// **'Support Email'**
  String get supportEmail;

  /// No description provided for @supportPhone.
  ///
  /// In en, this message translates to:
  /// **'Support Phone'**
  String get supportPhone;

  /// No description provided for @version.
  ///
  /// In en, this message translates to:
  /// **'Version'**
  String get version;

  /// No description provided for @chooseLessonType.
  ///
  /// In en, this message translates to:
  /// **'Choose Lesson Type'**
  String get chooseLessonType;

  /// No description provided for @chooseLessonTypeInstruction.
  ///
  /// In en, this message translates to:
  /// **'Choose the lesson type suitable for you'**
  String get chooseLessonTypeInstruction;

  /// No description provided for @individualLessonSubtitle.
  ///
  /// In en, this message translates to:
  /// **'One on one private lesson'**
  String get individualLessonSubtitle;

  /// No description provided for @groupLessonSubtitle.
  ///
  /// In en, this message translates to:
  /// **'{min}-{max} Students'**
  String groupLessonSubtitle(Object max, Object min);

  /// No description provided for @chooseSubject.
  ///
  /// In en, this message translates to:
  /// **'Choose Subject'**
  String get chooseSubject;

  /// No description provided for @chooseSubjectInstruction.
  ///
  /// In en, this message translates to:
  /// **'Choose the subject you want to learn'**
  String get chooseSubjectInstruction;

  /// No description provided for @chooseLevel.
  ///
  /// In en, this message translates to:
  /// **'Choose Level'**
  String get chooseLevel;

  /// No description provided for @chooseLevelInstruction.
  ///
  /// In en, this message translates to:
  /// **'Choose the educational level'**
  String get chooseLevelInstruction;

  /// No description provided for @chooseClass.
  ///
  /// In en, this message translates to:
  /// **'Choose Class'**
  String get chooseClass;

  /// No description provided for @chooseClassInstruction.
  ///
  /// In en, this message translates to:
  /// **'Choose the academic year'**
  String get chooseClassInstruction;

  /// No description provided for @noClassesAvailable.
  ///
  /// In en, this message translates to:
  /// **'No classes available'**
  String get noClassesAvailable;

  /// No description provided for @confirmYourBooking.
  ///
  /// In en, this message translates to:
  /// **'Confirm Your Booking'**
  String get confirmYourBooking;

  /// No description provided for @yourTeacher.
  ///
  /// In en, this message translates to:
  /// **'Your Teacher'**
  String get yourTeacher;

  /// No description provided for @bookingDetails.
  ///
  /// In en, this message translates to:
  /// **'Booking Details'**
  String get bookingDetails;

  /// No description provided for @priceSummary.
  ///
  /// In en, this message translates to:
  /// **'Price Summary'**
  String get priceSummary;

  /// No description provided for @hourlyRate.
  ///
  /// In en, this message translates to:
  /// **'Hourly Rate'**
  String get hourlyRate;

  /// No description provided for @cancellationPolicy.
  ///
  /// In en, this message translates to:
  /// **'You can cancel booking 24 hours before the lesson'**
  String get cancellationPolicy;

  /// No description provided for @welcomeToGeniuses School.
  ///
  /// In en, this message translates to:
  /// **'Welcome to Geniuses School'**
  String get welcomeToGeniuses School;

  /// No description provided for @alreadyHaveAccount.
  ///
  /// In en, this message translates to:
  /// **'Already have an account?'**
  String get alreadyHaveAccount;

  /// No description provided for @sessionIdNotAvailable.
  ///
  /// In en, this message translates to:
  /// **'Session ID not available'**
  String get sessionIdNotAvailable;

  /// No description provided for @joinSessionFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed to join session'**
  String get joinSessionFailed;

  /// No description provided for @proceedToPayment.
  ///
  /// In en, this message translates to:
  /// **'Proceed to Payment'**
  String get proceedToPayment;

  /// No description provided for @pleaseWait.
  ///
  /// In en, this message translates to:
  /// **'Please wait...'**
  String get pleaseWait;

  /// No description provided for @paymentSuccessWithRef.
  ///
  /// In en, this message translates to:
  /// **'Payment successful. Ref: {ref}'**
  String paymentSuccessWithRef(String ref, String amount, String currency);

  /// No description provided for @servicePrivateLessons.
  ///
  /// In en, this message translates to:
  /// **'Private Lessons'**
  String get servicePrivateLessons;

  /// No description provided for @servicePrivateLessonsDesc.
  ///
  /// In en, this message translates to:
  /// **'Various lessons in all subjects for all school stages.'**
  String get servicePrivateLessonsDesc;

  /// No description provided for @serviceTrainingCourses.
  ///
  /// In en, this message translates to:
  /// **'Training Courses'**
  String get serviceTrainingCourses;

  /// No description provided for @serviceLanguageLearning.
  ///
  /// In en, this message translates to:
  /// **'Language Learning'**
  String get serviceLanguageLearning;

  /// No description provided for @searchCourseHint.
  ///
  /// In en, this message translates to:
  /// **'Search for a course...'**
  String get searchCourseHint;

  /// No description provided for @filterCourses.
  ///
  /// In en, this message translates to:
  /// **'Filter Courses'**
  String get filterCourses;

  /// No description provided for @reset.
  ///
  /// In en, this message translates to:
  /// **'Reset'**
  String get reset;

  /// No description provided for @category.
  ///
  /// In en, this message translates to:
  /// **'Category'**
  String get category;

  /// No description provided for @maxPrice.
  ///
  /// In en, this message translates to:
  /// **'Max Price'**
  String get maxPrice;

  /// No description provided for @chooseCategory.
  ///
  /// In en, this message translates to:
  /// **'Choose Category'**
  String get chooseCategory;

  /// No description provided for @applyFilters.
  ///
  /// In en, this message translates to:
  /// **'Apply Filters'**
  String get applyFilters;

  /// No description provided for @instructor.
  ///
  /// In en, this message translates to:
  /// **'Instructor'**
  String get instructor;

  /// No description provided for @trainingHour.
  ///
  /// In en, this message translates to:
  /// **'Training Hour'**
  String get trainingHour;

  /// No description provided for @enrolledStudent.
  ///
  /// In en, this message translates to:
  /// **'Enrolled Student'**
  String get enrolledStudent;

  /// No description provided for @availableSeat.
  ///
  /// In en, this message translates to:
  /// **'Available Seat'**
  String get availableSeat;

  /// No description provided for @coursePrice.
  ///
  /// In en, this message translates to:
  /// **'Course Price'**
  String get coursePrice;

  /// No description provided for @certificateIncluded.
  ///
  /// In en, this message translates to:
  /// **'Certificate Included'**
  String get certificateIncluded;

  /// No description provided for @courseDescription.
  ///
  /// In en, this message translates to:
  /// **'Course Description'**
  String get courseDescription;

  /// No description provided for @coveredTopics.
  ///
  /// In en, this message translates to:
  /// **'Covered Topics'**
  String get coveredTopics;

  /// No description provided for @startDate.
  ///
  /// In en, this message translates to:
  /// **'Start Date'**
  String get startDate;

  /// No description provided for @enrollInCourse.
  ///
  /// In en, this message translates to:
  /// **'Enroll in Course'**
  String get enrollInCourse;

  /// No description provided for @requestEnrollment.
  ///
  /// In en, this message translates to:
  /// **'Request Enrollment'**
  String get requestEnrollment;

  /// No description provided for @enrollmentRequestSent.
  ///
  /// In en, this message translates to:
  /// **'Your request has been sent. Our team will contact you within 24 hours.'**
  String get enrollmentRequestSent;

  /// No description provided for @enrollmentRequestTitle.
  ///
  /// In en, this message translates to:
  /// **'Enrollment Request'**
  String get enrollmentRequestTitle;

  /// No description provided for @courseFull.
  ///
  /// In en, this message translates to:
  /// **'Course Full'**
  String get courseFull;

  /// No description provided for @confirmEnrollment.
  ///
  /// In en, this message translates to:
  /// **'Confirm Enrollment'**
  String get confirmEnrollment;

  /// No description provided for @totalAmount.
  ///
  /// In en, this message translates to:
  /// **'Total Amount'**
  String get totalAmount;

  /// No description provided for @enrollSuccessMessage.
  ///
  /// In en, this message translates to:
  /// **'Successfully enrolled in {courseTitle}'**
  String enrollSuccessMessage(String courseTitle);

  /// No description provided for @filterTeachers.
  ///
  /// In en, this message translates to:
  /// **'Filter Teachers'**
  String get filterTeachers;

  /// No description provided for @serviceType.
  ///
  /// In en, this message translates to:
  /// **'Service Type'**
  String get serviceType;

  /// No description provided for @minRatingLabel.
  ///
  /// In en, this message translates to:
  /// **'Minimum Rating'**
  String get minRatingLabel;

  /// No description provided for @activeFilters.
  ///
  /// In en, this message translates to:
  /// **'Active Filters'**
  String get activeFilters;

  /// No description provided for @clearAll.
  ///
  /// In en, this message translates to:
  /// **'Clear All'**
  String get clearAll;

  /// No description provided for @availableBookingTimes.
  ///
  /// In en, this message translates to:
  /// **'Available Booking Times'**
  String get availableBookingTimes;

  /// No description provided for @bookingConfirmedMsg.
  ///
  /// In en, this message translates to:
  /// **'Lesson booked with {teacherName} on {day} at {time}'**
  String bookingConfirmedMsg(String teacherName, String day, String time);

  /// No description provided for @choose.
  ///
  /// In en, this message translates to:
  /// **'Choose'**
  String get choose;

  /// No description provided for @noData.
  ///
  /// In en, this message translates to:
  /// **'No data'**
  String get noData;

  /// No description provided for @priceIndicator.
  ///
  /// In en, this message translates to:
  /// **'≤ {price} SAR/hr'**
  String priceIndicator(int price);

  /// No description provided for @ratingIndicator.
  ///
  /// In en, this message translates to:
  /// **'≥ {rating} ⭐'**
  String ratingIndicator(String rating);

  /// No description provided for @unreadNotifications.
  ///
  /// In en, this message translates to:
  /// **'{count} unread'**
  String unreadNotifications(int count);

  /// No description provided for @markAllAsRead.
  ///
  /// In en, this message translates to:
  /// **'Mark all as read'**
  String get markAllAsRead;

  /// No description provided for @notificationsMarkedRead.
  ///
  /// In en, this message translates to:
  /// **'All notifications marked as read'**
  String get notificationsMarkedRead;

  /// No description provided for @notificationDeleted.
  ///
  /// In en, this message translates to:
  /// **'Notification deleted'**
  String get notificationDeleted;

  /// No description provided for @errorLoadingNotifications.
  ///
  /// In en, this message translates to:
  /// **'Error loading notifications'**
  String get errorLoadingNotifications;

  /// No description provided for @noNotifications.
  ///
  /// In en, this message translates to:
  /// **'No notifications'**
  String get noNotifications;

  /// No description provided for @allCaughtUp.
  ///
  /// In en, this message translates to:
  /// **'You\'re all caught up!'**
  String get allCaughtUp;

  /// No description provided for @totalBalance.
  ///
  /// In en, this message translates to:
  /// **'Total Balance'**
  String get totalBalance;

  /// No description provided for @withdrawable.
  ///
  /// In en, this message translates to:
  /// **'Withdrawable'**
  String get withdrawable;

  /// No description provided for @weeklyIncome.
  ///
  /// In en, this message translates to:
  /// **'Weekly Income'**
  String get weeklyIncome;

  /// No description provided for @filterDatePlaceholder.
  ///
  /// In en, this message translates to:
  /// **'Date'**
  String get filterDatePlaceholder;

  /// No description provided for @filterStatusPlaceholder.
  ///
  /// In en, this message translates to:
  /// **'Status'**
  String get filterStatusPlaceholder;

  /// No description provided for @sessionStatusAll.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get sessionStatusAll;

  /// No description provided for @sessionStatusLive.
  ///
  /// In en, this message translates to:
  /// **'Live'**
  String get sessionStatusLive;

  /// No description provided for @sessionStatusEnded.
  ///
  /// In en, this message translates to:
  /// **'Ended'**
  String get sessionStatusEnded;

  /// No description provided for @sessionStatusCancelled.
  ///
  /// In en, this message translates to:
  /// **'Cancelled'**
  String get sessionStatusCancelled;

  /// No description provided for @sessionStatusScheduled.
  ///
  /// In en, this message translates to:
  /// **'Scheduled'**
  String get sessionStatusScheduled;

  /// No description provided for @sessionStatusWaitForTeacher.
  ///
  /// In en, this message translates to:
  /// **'Waiting for Teacher'**
  String get sessionStatusWaitForTeacher;

  /// No description provided for @untitledSession.
  ///
  /// In en, this message translates to:
  /// **'Untitled'**
  String get untitledSession;

  /// No description provided for @unspecifiedSubject.
  ///
  /// In en, this message translates to:
  /// **'Unspecified Subject'**
  String get unspecifiedSubject;

  /// No description provided for @statusLiveNow.
  ///
  /// In en, this message translates to:
  /// **'Live Now'**
  String get statusLiveNow;

  /// No description provided for @statusFinished.
  ///
  /// In en, this message translates to:
  /// **'Finished'**
  String get statusFinished;

  /// No description provided for @statusUpcoming.
  ///
  /// In en, this message translates to:
  /// **'Upcoming'**
  String get statusUpcoming;

  /// No description provided for @sessionDetailsTitle.
  ///
  /// In en, this message translates to:
  /// **'Session Details'**
  String get sessionDetailsTitle;

  /// No description provided for @sessionStatusLabel.
  ///
  /// In en, this message translates to:
  /// **'Status'**
  String get sessionStatusLabel;

  /// No description provided for @sessionDurationLabel.
  ///
  /// In en, this message translates to:
  /// **'Session Duration'**
  String get sessionDurationLabel;

  /// No description provided for @bookingTypeLabel.
  ///
  /// In en, this message translates to:
  /// **'Booking Type'**
  String get bookingTypeLabel;

  /// No description provided for @completedLabel.
  ///
  /// In en, this message translates to:
  /// **'Completed'**
  String get completedLabel;

  /// No description provided for @referenceNumberLabel.
  ///
  /// In en, this message translates to:
  /// **'Reference Number'**
  String get referenceNumberLabel;

  /// No description provided for @minutesPlaceholder.
  ///
  /// In en, this message translates to:
  /// **'-- min'**
  String get minutesPlaceholder;

  /// No description provided for @unspecified.
  ///
  /// In en, this message translates to:
  /// **'Unspecified'**
  String get unspecified;

  /// No description provided for @startSessionNow.
  ///
  /// In en, this message translates to:
  /// **'Start Session Now'**
  String get startSessionNow;

  /// No description provided for @joinSessionNow.
  ///
  /// In en, this message translates to:
  /// **'Join Session Now'**
  String get joinSessionNow;

  /// No description provided for @sessionEndedMessage.
  ///
  /// In en, this message translates to:
  /// **'Session Ended'**
  String get sessionEndedMessage;

  /// No description provided for @sessionUpcomingMessage.
  ///
  /// In en, this message translates to:
  /// **'Session Upcoming'**
  String get sessionUpcomingMessage;

  /// No description provided for @joining.
  ///
  /// In en, this message translates to:
  /// **'Joining...'**
  String get joining;

  /// No description provided for @waitSettingUp.
  ///
  /// In en, this message translates to:
  /// **'Please wait, setting up room...'**
  String get waitSettingUp;

  /// No description provided for @waitJoining.
  ///
  /// In en, this message translates to:
  /// **'Please wait, joining...'**
  String get waitJoining;

  /// No description provided for @sessionEndedDescription.
  ///
  /// In en, this message translates to:
  /// **'This session has ended and is no longer available'**
  String get sessionEndedDescription;

  /// No description provided for @sessionUpcomingDescription.
  ///
  /// In en, this message translates to:
  /// **'Join button will be available when session starts'**
  String get sessionUpcomingDescription;

  /// No description provided for @createAndEnterDescription.
  ///
  /// In en, this message translates to:
  /// **'Click to create and enter session room'**
  String get createAndEnterDescription;

  /// No description provided for @enterDescription.
  ///
  /// In en, this message translates to:
  /// **'Click to enter session room'**
  String get enterDescription;

  /// No description provided for @confirmLogout.
  ///
  /// In en, this message translates to:
  /// **'Confirm Logout'**
  String get confirmLogout;

  /// No description provided for @waitingForConnection.
  ///
  /// In en, this message translates to:
  /// **'Waiting for connection...'**
  String get waitingForConnection;

  /// No description provided for @couldNotLaunchUrl.
  ///
  /// In en, this message translates to:
  /// **'Could not launch {url}'**
  String couldNotLaunchUrl(String url);

  /// No description provided for @errorLabel.
  ///
  /// In en, this message translates to:
  /// **'Error: {error}'**
  String errorLabel(String error);

  /// No description provided for @recentTransactions.
  ///
  /// In en, this message translates to:
  /// **'Recent Transactions'**
  String get recentTransactions;

  /// No description provided for @confirmDeleteCourse.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete this course?'**
  String get confirmDeleteCourse;

  /// No description provided for @courseDeletedSuccess.
  ///
  /// In en, this message translates to:
  /// **'Course deleted successfully'**
  String get courseDeletedSuccess;

  /// No description provided for @editCourse.
  ///
  /// In en, this message translates to:
  /// **'Edit Course'**
  String get editCourse;

  /// No description provided for @courseUpdatedSuccess.
  ///
  /// In en, this message translates to:
  /// **'Course updated successfully'**
  String get courseUpdatedSuccess;

  /// No description provided for @updateCourse.
  ///
  /// In en, this message translates to:
  /// **'Update Course'**
  String get updateCourse;

  /// No description provided for @coursesAvailableCount.
  ///
  /// In en, this message translates to:
  /// **'{count} courses available'**
  String coursesAvailableCount(int count);

  /// No description provided for @errorLoadingCourses.
  ///
  /// In en, this message translates to:
  /// **'Error loading courses'**
  String get errorLoadingCourses;

  /// No description provided for @noCoursesFound.
  ///
  /// In en, this message translates to:
  /// **'No courses found'**
  String get noCoursesFound;

  /// No description provided for @adjustSearchCriteria.
  ///
  /// In en, this message translates to:
  /// **'Try adjusting search criteria'**
  String get adjustSearchCriteria;

  /// No description provided for @privateLessons.
  ///
  /// In en, this message translates to:
  /// **'Private Lessons'**
  String get privateLessons;

  /// No description provided for @abilities.
  ///
  /// In en, this message translates to:
  /// **'Abilities & Achievement'**
  String get abilities;

  /// No description provided for @languageLearning.
  ///
  /// In en, this message translates to:
  /// **'Language Learning'**
  String get languageLearning;

  /// No description provided for @textbooks.
  ///
  /// In en, this message translates to:
  /// **'Textbooks'**
  String get textbooks;

  /// No description provided for @withdraw.
  ///
  /// In en, this message translates to:
  /// **'Withdraw'**
  String get withdraw;

  /// No description provided for @noTransactions.
  ///
  /// In en, this message translates to:
  /// **'No transactions available.'**
  String get noTransactions;

  /// No description provided for @cancelRequest.
  ///
  /// In en, this message translates to:
  /// **'Cancel Request'**
  String get cancelRequest;

  /// No description provided for @confirmCancelWithdrawal.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to cancel this withdrawal request?'**
  String get confirmCancelWithdrawal;

  /// No description provided for @yesCancel.
  ///
  /// In en, this message translates to:
  /// **'Yes, Cancel'**
  String get yesCancel;

  /// No description provided for @requestCancelled.
  ///
  /// In en, this message translates to:
  /// **'Request cancelled successfully'**
  String get requestCancelled;

  /// No description provided for @withdrawProfits.
  ///
  /// In en, this message translates to:
  /// **'Withdraw Profits'**
  String get withdrawProfits;

  /// No description provided for @noBankAccounts.
  ///
  /// In en, this message translates to:
  /// **'No bank accounts'**
  String get noBankAccounts;

  /// No description provided for @addBankAccountPrompt.
  ///
  /// In en, this message translates to:
  /// **'You must add a bank account first before requesting a withdrawal. Do you want to add one now?'**
  String get addBankAccountPrompt;

  /// No description provided for @withdrawRequest.
  ///
  /// In en, this message translates to:
  /// **'Withdrawal Request'**
  String get withdrawRequest;

  /// No description provided for @availableBalance.
  ///
  /// In en, this message translates to:
  /// **'Available Balance'**
  String get availableBalance;

  /// No description provided for @selectBankAccount.
  ///
  /// In en, this message translates to:
  /// **'Select Bank Account'**
  String get selectBankAccount;

  /// No description provided for @selectBankHint.
  ///
  /// In en, this message translates to:
  /// **'Select the account to receive funds'**
  String get selectBankHint;

  /// No description provided for @withdrawalAmount.
  ///
  /// In en, this message translates to:
  /// **'Withdrawal Amount'**
  String get withdrawalAmount;

  /// No description provided for @minWithdrawalHint.
  ///
  /// In en, this message translates to:
  /// **'Minimum: 10 SAR'**
  String get minWithdrawalHint;

  /// No description provided for @enterAmount.
  ///
  /// In en, this message translates to:
  /// **'Please enter amount'**
  String get enterAmount;

  /// No description provided for @amountMustBePositive.
  ///
  /// In en, this message translates to:
  /// **'Amount must be positive'**
  String get amountMustBePositive;

  /// No description provided for @minWithdrawalError.
  ///
  /// In en, this message translates to:
  /// **'Minimum withdrawal is 10 SAR'**
  String get minWithdrawalError;

  /// No description provided for @insufficientBalance.
  ///
  /// In en, this message translates to:
  /// **'Amount exceeds available balance ({balance} SAR)'**
  String insufficientBalance(String balance);

  /// No description provided for @confirmWithdrawal.
  ///
  /// In en, this message translates to:
  /// **'Confirm Withdrawal'**
  String get confirmWithdrawal;

  /// No description provided for @withdrawalRequested.
  ///
  /// In en, this message translates to:
  /// **'Withdrawal requested successfully'**
  String get withdrawalRequested;

  /// No description provided for @statusApproved.
  ///
  /// In en, this message translates to:
  /// **'Approved'**
  String get statusApproved;

  /// No description provided for @statusCancelled.
  ///
  /// In en, this message translates to:
  /// **'Cancelled'**
  String get statusCancelled;

  /// No description provided for @errorSelectBank.
  ///
  /// In en, this message translates to:
  /// **'Please select a bank account'**
  String get errorSelectBank;

  /// No description provided for @no.
  ///
  /// In en, this message translates to:
  /// **'No'**
  String get no;

  /// No description provided for @statusConfirmed.
  ///
  /// In en, this message translates to:
  /// **'Confirmed'**
  String get statusConfirmed;

  /// No description provided for @lessonTypes.
  ///
  /// In en, this message translates to:
  /// **'Lesson Types'**
  String get lessonTypes;

  /// No description provided for @individualLessons.
  ///
  /// In en, this message translates to:
  /// **'Individual Lessons'**
  String get individualLessons;

  /// No description provided for @individualLessonsDesc.
  ///
  /// In en, this message translates to:
  /// **'One-on-one private lesson'**
  String get individualLessonsDesc;

  /// No description provided for @groupLessons.
  ///
  /// In en, this message translates to:
  /// **'Group Lessons'**
  String get groupLessons;

  /// No description provided for @groupLessonsDesc.
  ///
  /// In en, this message translates to:
  /// **'Group of students'**
  String get groupLessonsDesc;

  /// No description provided for @hourlyRateSAR.
  ///
  /// In en, this message translates to:
  /// **'Hourly Rate (SAR)'**
  String get hourlyRateSAR;

  /// No description provided for @hourlyRatePerStudentSAR.
  ///
  /// In en, this message translates to:
  /// **'Hourly Rate per Student (SAR)'**
  String get hourlyRatePerStudentSAR;

  /// No description provided for @minGroupSize.
  ///
  /// In en, this message translates to:
  /// **'Min Group Size'**
  String get minGroupSize;

  /// No description provided for @maxGroupSize.
  ///
  /// In en, this message translates to:
  /// **'Max Group Size'**
  String get maxGroupSize;

  /// No description provided for @fieldRequired.
  ///
  /// In en, this message translates to:
  /// **'Required'**
  String get fieldRequired;

  /// No description provided for @selectStudyLevel.
  ///
  /// In en, this message translates to:
  /// **'Select Study Level'**
  String get selectStudyLevel;

  /// No description provided for @selectYourClass.
  ///
  /// In en, this message translates to:
  /// **'Select your class'**
  String get selectYourClass;

  /// No description provided for @searchTeacherHint.
  ///
  /// In en, this message translates to:
  /// **'Search for a teacher...'**
  String get searchTeacherHint;

  /// No description provided for @statusInProgress.
  ///
  /// In en, this message translates to:
  /// **'In Progress'**
  String get statusInProgress;

  /// No description provided for @statusNew.
  ///
  /// In en, this message translates to:
  /// **'New'**
  String get statusNew;

  /// No description provided for @timeLabel.
  ///
  /// In en, this message translates to:
  /// **'Time:'**
  String get timeLabel;

  /// No description provided for @studentCountLabel.
  ///
  /// In en, this message translates to:
  /// **'student'**
  String get studentCountLabel;

  /// No description provided for @perHourLabel.
  ///
  /// In en, this message translates to:
  /// **'SAR / hour'**
  String get perHourLabel;

  /// No description provided for @educationalServices.
  ///
  /// In en, this message translates to:
  /// **'Educational Services'**
  String get educationalServices;

  /// No description provided for @personalInfo.
  ///
  /// In en, this message translates to:
  /// **'Personal Information'**
  String get personalInfo;

  /// No description provided for @bioTitle.
  ///
  /// In en, this message translates to:
  /// **'Bio'**
  String get bioTitle;

  /// No description provided for @bioHint.
  ///
  /// In en, this message translates to:
  /// **'Brief description about yourself'**
  String get bioHint;

  /// No description provided for @bioLabel.
  ///
  /// In en, this message translates to:
  /// **'Bio'**
  String get bioLabel;

  /// No description provided for @servicesProvided.
  ///
  /// In en, this message translates to:
  /// **'Provided Services'**
  String get servicesProvided;

  /// No description provided for @saveButton.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get saveButton;

  /// No description provided for @nextButton.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get nextButton;

  /// No description provided for @uploadDocumentsTitle.
  ///
  /// In en, this message translates to:
  /// **'Upload Required Documents'**
  String get uploadDocumentsTitle;

  /// No description provided for @uploadDocumentsDesc.
  ///
  /// In en, this message translates to:
  /// **'Please upload your graduation certificate and CV to complete registration'**
  String get uploadDocumentsDesc;

  /// No description provided for @gradCert.
  ///
  /// In en, this message translates to:
  /// **'Graduation Certificate'**
  String get gradCert;

  /// No description provided for @gradCertDesc.
  ///
  /// In en, this message translates to:
  /// **'University degree or equivalent'**
  String get gradCertDesc;

  /// No description provided for @resume.
  ///
  /// In en, this message translates to:
  /// **'Resume (CV)'**
  String get resume;

  /// No description provided for @resumeDesc.
  ///
  /// In en, this message translates to:
  /// **'CV or Academic Portfolio'**
  String get resumeDesc;

  /// No description provided for @bothFilesRequired.
  ///
  /// In en, this message translates to:
  /// **'Both files are required to complete registration'**
  String get bothFilesRequired;

  /// No description provided for @allFilesUploaded.
  ///
  /// In en, this message translates to:
  /// **'Great! All required documents uploaded'**
  String get allFilesUploaded;

  /// No description provided for @backButton.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get backButton;

  /// No description provided for @saveFinishButton.
  ///
  /// In en, this message translates to:
  /// **'Save & Finish'**
  String get saveFinishButton;

  /// No description provided for @saving.
  ///
  /// In en, this message translates to:
  /// **'Saving...'**
  String get saving;

  /// No description provided for @progress.
  ///
  /// In en, this message translates to:
  /// **'Progress'**
  String get progress;

  /// No description provided for @uploadFile.
  ///
  /// In en, this message translates to:
  /// **'Upload File'**
  String get uploadFile;

  /// No description provided for @loadLanguagesError.
  ///
  /// In en, this message translates to:
  /// **'Error loading languages'**
  String get loadLanguagesError;

  /// No description provided for @noLanguagesAdded.
  ///
  /// In en, this message translates to:
  /// **'No languages added'**
  String get noLanguagesAdded;

  /// No description provided for @addLanguagePrompt.
  ///
  /// In en, this message translates to:
  /// **'Press the add button to add languages'**
  String get addLanguagePrompt;

  /// No description provided for @addLanguage.
  ///
  /// In en, this message translates to:
  /// **'Add Language'**
  String get addLanguage;

  /// No description provided for @addLanguagesTitle.
  ///
  /// In en, this message translates to:
  /// **'Add Languages'**
  String get addLanguagesTitle;

  /// No description provided for @allLanguagesAdded.
  ///
  /// In en, this message translates to:
  /// **'All available languages are already added'**
  String get allLanguagesAdded;

  /// No description provided for @addAction.
  ///
  /// In en, this message translates to:
  /// **'Add'**
  String get addAction;

  /// No description provided for @deleteLanguageConfirm.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete this language?'**
  String get deleteLanguageConfirm;

  /// No description provided for @languageDeletedSuccess.
  ///
  /// In en, this message translates to:
  /// **'Language deleted successfully'**
  String get languageDeletedSuccess;

  /// No description provided for @languageDeletedFail.
  ///
  /// In en, this message translates to:
  /// **'Failed to delete language'**
  String get languageDeletedFail;

  /// No description provided for @languageAddedSuccess.
  ///
  /// In en, this message translates to:
  /// **'Languages updated successfully'**
  String get languageAddedSuccess;

  /// No description provided for @languageAddedFail.
  ///
  /// In en, this message translates to:
  /// **'Failed to update languages'**
  String get languageAddedFail;

  /// No description provided for @lessonsTitle.
  ///
  /// In en, this message translates to:
  /// **'Lessons'**
  String get lessonsTitle;

  /// No description provided for @noLessonsForSubject.
  ///
  /// In en, this message translates to:
  /// **'No lessons added yet for'**
  String get noLessonsForSubject;

  /// No description provided for @addLesson.
  ///
  /// In en, this message translates to:
  /// **'Add Lesson'**
  String get addLesson;

  /// No description provided for @addSubjectTitle.
  ///
  /// In en, this message translates to:
  /// **'Add Subject'**
  String get addSubjectTitle;

  /// No description provided for @subjectAddedSuccess.
  ///
  /// In en, this message translates to:
  /// **'Subject added successfully'**
  String get subjectAddedSuccess;

  /// No description provided for @loadingMessage.
  ///
  /// In en, this message translates to:
  /// **'Please wait'**
  String get loadingMessage;

  /// No description provided for @savingData.
  ///
  /// In en, this message translates to:
  /// **'Saving data...'**
  String get savingData;

  /// No description provided for @select.
  ///
  /// In en, this message translates to:
  /// **'Select'**
  String get select;

  /// No description provided for @selectNationality.
  ///
  /// In en, this message translates to:
  /// **'Select Nationality'**
  String get selectNationality;

  /// No description provided for @completeProfileTitle.
  ///
  /// In en, this message translates to:
  /// **'Complete Your Profile'**
  String get completeProfileTitle;

  /// No description provided for @confirmEmailAction.
  ///
  /// In en, this message translates to:
  /// **'Confirm Email'**
  String get confirmEmailAction;

  /// No description provided for @addPhoneAction.
  ///
  /// In en, this message translates to:
  /// **'Add Phone Number'**
  String get addPhoneAction;

  /// No description provided for @uploadPhotoAction.
  ///
  /// In en, this message translates to:
  /// **'Upload Profile Picture'**
  String get uploadPhotoAction;

  /// No description provided for @completeNowButton.
  ///
  /// In en, this message translates to:
  /// **'Complete Now'**
  String get completeNowButton;

  /// No description provided for @cancelButton.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancelButton;

  /// No description provided for @updateProfileTitle.
  ///
  /// In en, this message translates to:
  /// **'Update Profile'**
  String get updateProfileTitle;

  /// No description provided for @updateProfileMessage.
  ///
  /// In en, this message translates to:
  /// **'This feature is available only for fully registered users'**
  String get updateProfileMessage;

  /// No description provided for @addLocationAction.
  ///
  /// In en, this message translates to:
  /// **'Add Your Location'**
  String get addLocationAction;

  /// No description provided for @emailConfirmationTitle.
  ///
  /// In en, this message translates to:
  /// **'Email Confirmation'**
  String get emailConfirmationTitle;

  /// No description provided for @emailConfirmationMessage.
  ///
  /// In en, this message translates to:
  /// **'You must confirm your email to continue'**
  String get emailConfirmationMessage;

  /// No description provided for @openEmailApp.
  ///
  /// In en, this message translates to:
  /// **'Open Email App'**
  String get openEmailApp;

  /// No description provided for @clickConfirmationLink.
  ///
  /// In en, this message translates to:
  /// **'Click Confirmation Link'**
  String get clickConfirmationLink;

  /// No description provided for @subscriptionMessage.
  ///
  /// In en, this message translates to:
  /// **'This feature is available for subscribers only'**
  String get subscriptionMessage;

  /// No description provided for @exclusiveFeatures.
  ///
  /// In en, this message translates to:
  /// **'Get Exclusive Features'**
  String get exclusiveFeatures;

  /// No description provided for @happeningNow.
  ///
  /// In en, this message translates to:
  /// **'Happening Now'**
  String get happeningNow;

  /// No description provided for @newBadge.
  ///
  /// In en, this message translates to:
  /// **'New'**
  String get newBadge;

  /// No description provided for @sarPerHour.
  ///
  /// In en, this message translates to:
  /// **'SAR / Hour'**
  String get sarPerHour;

  /// No description provided for @daysLabel.
  ///
  /// In en, this message translates to:
  /// **'Days:'**
  String get daysLabel;

  /// No description provided for @paymentVerification.
  ///
  /// In en, this message translates to:
  /// **'Payment Verification'**
  String get paymentVerification;

  /// No description provided for @cancelOperation.
  ///
  /// In en, this message translates to:
  /// **'Cancel Operation'**
  String get cancelOperation;

  /// No description provided for @cancelOperationMessage.
  ///
  /// In en, this message translates to:
  /// **'Do you want to cancel the payment verification?'**
  String get cancelOperationMessage;

  /// No description provided for @paymentSuccessTitle.
  ///
  /// In en, this message translates to:
  /// **'Payment Successful'**
  String get paymentSuccessTitle;

  /// No description provided for @paymentFailedTitle.
  ///
  /// In en, this message translates to:
  /// **'Payment Failed'**
  String get paymentFailedTitle;

  /// No description provided for @paymentNotFound.
  ///
  /// In en, this message translates to:
  /// **'Payment record not found. Please check data and try again.'**
  String get paymentNotFound;

  /// No description provided for @serverError.
  ///
  /// In en, this message translates to:
  /// **'Invalid response from server. Please try again.'**
  String get serverError;

  /// No description provided for @unknownError.
  ///
  /// In en, this message translates to:
  /// **'Unknown error occurred. Please try again.'**
  String get unknownError;

  /// No description provided for @formatError.
  ///
  /// In en, this message translates to:
  /// **'Data format error. Please try again.'**
  String get formatError;

  /// No description provided for @checkConnectivity.
  ///
  /// In en, this message translates to:
  /// **'Please check your internet connection and try again.'**
  String get checkConnectivity;

  /// No description provided for @contactSupport.
  ///
  /// In en, this message translates to:
  /// **'Please contact support if the problem persists.'**
  String get contactSupport;

  /// No description provided for @platformNotSupported.
  ///
  /// In en, this message translates to:
  /// **'Sorry, 3D Secure (3DS) verification is not supported on this platform. Please use an Android or iOS device.'**
  String get platformNotSupported;

  /// No description provided for @walletLoadError.
  ///
  /// In en, this message translates to:
  /// **'Error loading wallet'**
  String get walletLoadError;

  /// No description provided for @cancelRequestTitle.
  ///
  /// In en, this message translates to:
  /// **'Cancel Request'**
  String get cancelRequestTitle;

  /// No description provided for @withdrawalCancelled.
  ///
  /// In en, this message translates to:
  /// **'Withdrawal request cancelled'**
  String get withdrawalCancelled;

  /// No description provided for @manageSubjects.
  ///
  /// In en, this message translates to:
  /// **'Manage Subjects'**
  String get manageSubjects;

  /// No description provided for @selectItem.
  ///
  /// In en, this message translates to:
  /// **'Select {item}'**
  String selectItem(Object item);

  /// No description provided for @schedule.
  ///
  /// In en, this message translates to:
  /// **'Schedule'**
  String get schedule;

  /// No description provided for @offline.
  ///
  /// In en, this message translates to:
  /// **'Offline'**
  String get offline;

  /// No description provided for @todaysLessons.
  ///
  /// In en, this message translates to:
  /// **'Today\'s Lessons'**
  String get todaysLessons;

  /// No description provided for @expectedIncome.
  ///
  /// In en, this message translates to:
  /// **'Expected Income'**
  String get expectedIncome;

  /// No description provided for @noLessonsToday.
  ///
  /// In en, this message translates to:
  /// **'No lessons today'**
  String get noLessonsToday;

  /// No description provided for @enjoyYourDay.
  ///
  /// In en, this message translates to:
  /// **'Enjoy your day!'**
  String get enjoyYourDay;

  /// No description provided for @paymentSuccessMessage.
  ///
  /// In en, this message translates to:
  /// **'Payment completed successfully'**
  String get paymentSuccessMessage;

  /// No description provided for @teachers.
  ///
  /// In en, this message translates to:
  /// **'Teachers'**
  String get teachers;

  /// No description provided for @teachersAvailable.
  ///
  /// In en, this message translates to:
  /// **'{count} teachers available'**
  String teachersAvailable(Object count);

  /// No description provided for @noTeachersFound.
  ///
  /// In en, this message translates to:
  /// **'No teachers found'**
  String get noTeachersFound;

  /// No description provided for @tryAdjustingSearch.
  ///
  /// In en, this message translates to:
  /// **'Try adjusting search criteria'**
  String get tryAdjustingSearch;

  /// No description provided for @userIdNotFound.
  ///
  /// In en, this message translates to:
  /// **'User ID not found'**
  String get userIdNotFound;

  /// No description provided for @bookingId.
  ///
  /// In en, this message translates to:
  /// **'Booking ID'**
  String get bookingId;

  /// No description provided for @errorCode.
  ///
  /// In en, this message translates to:
  /// **'Error Code'**
  String get errorCode;

  /// No description provided for @paymentId.
  ///
  /// In en, this message translates to:
  /// **'Payment ID'**
  String get paymentId;

  /// No description provided for @yes.
  ///
  /// In en, this message translates to:
  /// **'Yes'**
  String get yes;

  /// No description provided for @courseCategoriesTitle.
  ///
  /// In en, this message translates to:
  /// **'Training Course Categories'**
  String get courseCategoriesTitle;

  /// No description provided for @paymentFailedDefault.
  ///
  /// In en, this message translates to:
  /// **'Payment Failed'**
  String get paymentFailedDefault;

  /// No description provided for @bookingSuccessMessage.
  ///
  /// In en, this message translates to:
  /// **'Payment Successful!\nBooking Ref: {bookingRef}\nAmount: {amount}'**
  String bookingSuccessMessage(String bookingRef, String amount);

  /// No description provided for @bookingIdNotFound.
  ///
  /// In en, this message translates to:
  /// **'Error: Booking ID not found'**
  String get bookingIdNotFound;

  /// No description provided for @kotoby.
  ///
  /// In en, this message translates to:
  /// **'Kotoby'**
  String get kotoby;

  /// No description provided for @bookings.
  ///
  /// In en, this message translates to:
  /// **'Bookings'**
  String get bookings;

  /// No description provided for @noBookings.
  ///
  /// In en, this message translates to:
  /// **'No bookings found'**
  String get noBookings;

  /// No description provided for @cancelBooking.
  ///
  /// In en, this message translates to:
  /// **'Cancel Booking'**
  String get cancelBooking;

  /// No description provided for @confirmCancelBooking.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to cancel this booking?'**
  String get confirmCancelBooking;

  /// No description provided for @bookingCancelledSuccess.
  ///
  /// In en, this message translates to:
  /// **'Booking cancelled successfully'**
  String get bookingCancelledSuccess;

  /// No description provided for @bookingCancellationFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed to cancel booking'**
  String get bookingCancellationFailed;

  /// No description provided for @paymentSuccessWithCard.
  ///
  /// In en, this message translates to:
  /// **'Payment successful using card ending in {cardNumber}'**
  String paymentSuccessWithCard(String cardNumber);

  /// No description provided for @noSessions.
  ///
  /// In en, this message translates to:
  /// **'No sessions found'**
  String get noSessions;

  /// No description provided for @errorLoadingSessions.
  ///
  /// In en, this message translates to:
  /// **'Error loading sessions'**
  String get errorLoadingSessions;

  /// No description provided for @studentInfoLabel.
  ///
  /// In en, this message translates to:
  /// **'Student Information'**
  String get studentInfoLabel;

  /// No description provided for @teacherInfoLabel.
  ///
  /// In en, this message translates to:
  /// **'Teacher Information'**
  String get teacherInfoLabel;

  /// No description provided for @mastercard.
  ///
  /// In en, this message translates to:
  /// **'MasterCard'**
  String get mastercard;

  /// No description provided for @launchUrlError.
  ///
  /// In en, this message translates to:
  /// **'Could not launch {url}'**
  String launchUrlError(String url);

  /// No description provided for @connectionError.
  ///
  /// In en, this message translates to:
  /// **'Connection Error'**
  String get connectionError;

  /// No description provided for @selectGender.
  ///
  /// In en, this message translates to:
  /// **'Select Gender'**
  String get selectGender;

  /// No description provided for @teaching.
  ///
  /// In en, this message translates to:
  /// **'Teaching'**
  String get teaching;

  /// No description provided for @learning.
  ///
  /// In en, this message translates to:
  /// **'Learning'**
  String get learning;

  /// No description provided for @room.
  ///
  /// In en, this message translates to:
  /// **'Room'**
  String get room;

  /// No description provided for @users.
  ///
  /// In en, this message translates to:
  /// **'Users'**
  String get users;

  /// No description provided for @connectingToClassroom.
  ///
  /// In en, this message translates to:
  /// **'Connecting to classroom...'**
  String get connectingToClassroom;

  /// No description provided for @noVideoStreams.
  ///
  /// In en, this message translates to:
  /// **'No video streams available'**
  String get noVideoStreams;

  /// No description provided for @cameraOff.
  ///
  /// In en, this message translates to:
  /// **'Camera Off'**
  String get cameraOff;

  /// No description provided for @mute.
  ///
  /// In en, this message translates to:
  /// **'Mute'**
  String get mute;

  /// No description provided for @unmute.
  ///
  /// In en, this message translates to:
  /// **'Unmute'**
  String get unmute;

  /// No description provided for @startVideo.
  ///
  /// In en, this message translates to:
  /// **'Start Video'**
  String get startVideo;

  /// No description provided for @stopVideo.
  ///
  /// In en, this message translates to:
  /// **'Stop Video'**
  String get stopVideo;

  /// No description provided for @speakerOn.
  ///
  /// In en, this message translates to:
  /// **'Speaker On'**
  String get speakerOn;

  /// No description provided for @speakerOff.
  ///
  /// In en, this message translates to:
  /// **'Speaker Off'**
  String get speakerOff;

  /// No description provided for @leave.
  ///
  /// In en, this message translates to:
  /// **'Leave'**
  String get leave;

  /// No description provided for @joinClassroom.
  ///
  /// In en, this message translates to:
  /// **'Join Classroom'**
  String get joinClassroom;

  /// No description provided for @youRole.
  ///
  /// In en, this message translates to:
  /// **'You ({role})'**
  String youRole(String role);

  /// No description provided for @hand.
  ///
  /// In en, this message translates to:
  /// **'Hand'**
  String get hand;

  /// No description provided for @shareScreen.
  ///
  /// In en, this message translates to:
  /// **'Share'**
  String get shareScreen;

  /// No description provided for @muteAll.
  ///
  /// In en, this message translates to:
  /// **'Mute All'**
  String get muteAll;

  /// No description provided for @flipCamera.
  ///
  /// In en, this message translates to:
  /// **'Flip'**
  String get flipCamera;

  /// No description provided for @video.
  ///
  /// In en, this message translates to:
  /// **'Video'**
  String get video;

  /// No description provided for @card.
  ///
  /// In en, this message translates to:
  /// **'Card'**
  String get card;

  /// No description provided for @authRequired.
  ///
  /// In en, this message translates to:
  /// **'Login Required'**
  String get authRequired;

  /// No description provided for @loginToSeeProfile.
  ///
  /// In en, this message translates to:
  /// **'Please login to view and manage your profile'**
  String get loginToSeeProfile;

  /// No description provided for @providedServices.
  ///
  /// In en, this message translates to:
  /// **'Services Provided'**
  String get providedServices;

  /// No description provided for @consultationSessions.
  ///
  /// In en, this message translates to:
  /// **'Consultation Sessions'**
  String get consultationSessions;

  /// No description provided for @privateLesson.
  ///
  /// In en, this message translates to:
  /// **'Private Lesson'**
  String get privateLesson;

  /// No description provided for @certificates.
  ///
  /// In en, this message translates to:
  /// **'Certificates'**
  String get certificates;

  /// No description provided for @reviews.
  ///
  /// In en, this message translates to:
  /// **'Reviews'**
  String get reviews;

  /// No description provided for @book.
  ///
  /// In en, this message translates to:
  /// **'Book'**
  String get book;

  /// No description provided for @bookSession.
  ///
  /// In en, this message translates to:
  /// **'Book Session'**
  String get bookSession;

  /// No description provided for @lessonsLabel.
  ///
  /// In en, this message translates to:
  /// **'Lessons'**
  String get lessonsLabel;

  /// No description provided for @teacherUnderReview.
  ///
  /// In en, this message translates to:
  /// **'Account Under Review'**
  String get teacherUnderReview;

  /// No description provided for @teacherUnderReviewMessage.
  ///
  /// In en, this message translates to:
  /// **'Your account is currently under review. Please wait while we verify your information. You can contact support for more details.'**
  String get teacherUnderReviewMessage;

  /// No description provided for @contactUs.
  ///
  /// In en, this message translates to:
  /// **'Contact Us'**
  String get contactUs;

  /// No description provided for @profile_status_active.
  ///
  /// In en, this message translates to:
  /// **'Your Profile is Active'**
  String get profile_status_active;

  /// No description provided for @profile_status_inactive.
  ///
  /// In en, this message translates to:
  /// **'Your Profile is Inactive'**
  String get profile_status_inactive;

  /// No description provided for @profile_visible_to_students.
  ///
  /// In en, this message translates to:
  /// **'All students can see your profile'**
  String get profile_visible_to_students;

  /// No description provided for @profile_hidden_from_students.
  ///
  /// In en, this message translates to:
  /// **'No one can see your profile'**
  String get profile_hidden_from_students;

  /// No description provided for @activate_to_start_earning.
  ///
  /// In en, this message translates to:
  /// **'Activate your profile to start earning!'**
  String get activate_to_start_earning;

  /// No description provided for @total_earnings.
  ///
  /// In en, this message translates to:
  /// **'Total'**
  String get total_earnings;

  /// No description provided for @errorUserNotFound.
  ///
  /// In en, this message translates to:
  /// **'This account is not registered.'**
  String get errorUserNotFound;

  /// No description provided for @endSessionConfirmation.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to end this session?'**
  String get endSessionConfirmation;

  /// No description provided for @endSession.
  ///
  /// In en, this message translates to:
  /// **'End Session'**
  String get endSession;

  /// No description provided for @success.
  ///
  /// In en, this message translates to:
  /// **'Success'**
  String get success;

  /// No description provided for @chooseYourService.
  ///
  /// In en, this message translates to:
  /// **'Choose Your Service'**
  String get chooseYourService;

  /// No description provided for @uploadCertificate.
  ///
  /// In en, this message translates to:
  /// **'Upload Certificate'**
  String get uploadCertificate;

  /// No description provided for @submit.
  ///
  /// In en, this message translates to:
  /// **'Submit'**
  String get submit;

  /// No description provided for @certificateRequired.
  ///
  /// In en, this message translates to:
  /// **'Certificate is required'**
  String get certificateRequired;

  /// No description provided for @uploadCv.
  ///
  /// In en, this message translates to:
  /// **'Upload CV'**
  String get uploadCv;

  /// No description provided for @bio.
  ///
  /// In en, this message translates to:
  /// **'Bio'**
  String get bio;

  /// No description provided for @certificateLabel.
  ///
  /// In en, this message translates to:
  /// **'Certificate'**
  String get certificateLabel;

  /// No description provided for @cvLabel.
  ///
  /// In en, this message translates to:
  /// **'CV'**
  String get cvLabel;

  /// No description provided for @selectService.
  ///
  /// In en, this message translates to:
  /// **'Select Service'**
  String get selectService;

  /// No description provided for @fileTooLarge.
  ///
  /// In en, this message translates to:
  /// **'File too large (max 5MB)'**
  String get fileTooLarge;

  /// No description provided for @continueBtn.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get continueBtn;

  /// No description provided for @tutorial_earnings_desc.
  ///
  /// In en, this message translates to:
  /// **'Track your daily and monthly earnings at a glance.'**
  String get tutorial_earnings_desc;

  /// No description provided for @tutorial_sessions_desc.
  ///
  /// In en, this message translates to:
  /// **'View your upcoming lessons and manage your teaching schedule.'**
  String get tutorial_sessions_desc;

  /// No description provided for @tutorial_prices_desc.
  ///
  /// In en, this message translates to:
  /// **'Update your hourly rates for individual lessons here.'**
  String get tutorial_prices_desc;

  /// No description provided for @tutorial_services_desc.
  ///
  /// In en, this message translates to:
  /// **'Manage your services here! {specificTip} Also, remember to add your available slots and link your bank account for easy withdrawals.'**
  String tutorial_services_desc(String specificTip);

  /// No description provided for @tutorial_tip_language.
  ///
  /// In en, this message translates to:
  /// **'Add the languages you teach.'**
  String get tutorial_tip_language;

  /// No description provided for @tutorial_tip_subjects.
  ///
  /// In en, this message translates to:
  /// **'Add your specialized subjects.'**
  String get tutorial_tip_subjects;

  /// No description provided for @tutorial_tip_courses.
  ///
  /// In en, this message translates to:
  /// **'Add and manage your training courses.'**
  String get tutorial_tip_courses;

  /// No description provided for @bankAccountMemo.
  ///
  /// In en, this message translates to:
  /// **'Here you can add your bank accounts to use for withdrawing your earnings by requesting a bank transfer.'**
  String get bankAccountMemo;

  /// No description provided for @totalSessions.
  ///
  /// In en, this message translates to:
  /// **'Total Sessions'**
  String get totalSessions;

  /// No description provided for @tutorial_total_sessions_title.
  ///
  /// In en, this message translates to:
  /// **'Total Sessions'**
  String get tutorial_total_sessions_title;

  /// No description provided for @tutorial_total_sessions_desc.
  ///
  /// In en, this message translates to:
  /// **'Choose how many consecutive sessions you\'d like to book in a row. The price will multiply automatically.'**
  String get tutorial_total_sessions_desc;

  /// No description provided for @tutorial_student_home_title_notifications.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get tutorial_student_home_title_notifications;

  /// No description provided for @tutorial_student_home_desc_notifications.
  ///
  /// In en, this message translates to:
  /// **'Track your alerts, new requests, and session status here.'**
  String get tutorial_student_home_desc_notifications;

  /// No description provided for @tutorial_student_home_title_teachers.
  ///
  /// In en, this message translates to:
  /// **'Top Teachers'**
  String get tutorial_student_home_title_teachers;

  /// No description provided for @tutorial_student_home_desc_teachers.
  ///
  /// In en, this message translates to:
  /// **'Browse our top-rated teachers and book your lessons instantly.'**
  String get tutorial_student_home_desc_teachers;

  /// No description provided for @tutorial_student_home_title_services.
  ///
  /// In en, this message translates to:
  /// **'Our Services'**
  String get tutorial_student_home_title_services;

  /// No description provided for @tutorial_student_home_desc_services.
  ///
  /// In en, this message translates to:
  /// **'Explore various educational services tailored to your needs.'**
  String get tutorial_student_home_desc_services;

  /// No description provided for @tutorial_student_home_title_courses.
  ///
  /// In en, this message translates to:
  /// **'Training Courses'**
  String get tutorial_student_home_title_courses;

  /// No description provided for @tutorial_student_home_desc_courses.
  ///
  /// In en, this message translates to:
  /// **'Join specialized training courses to develop your skills.'**
  String get tutorial_student_home_desc_courses;

  /// No description provided for @tutorial_student_home_title_add_order.
  ///
  /// In en, this message translates to:
  /// **'Add Order'**
  String get tutorial_student_home_title_add_order;

  /// No description provided for @tutorial_student_home_desc_add_order.
  ///
  /// In en, this message translates to:
  /// **'Can\'t find what you\'re looking for? Create a custom teaching request here.'**
  String get tutorial_student_home_desc_add_order;

  /// No description provided for @tutorial_student_home_title_categories.
  ///
  /// In en, this message translates to:
  /// **'Course Categories'**
  String get tutorial_student_home_title_categories;

  /// No description provided for @tutorial_student_home_desc_categories.
  ///
  /// In en, this message translates to:
  /// **'Explore available course categories to find what interests you.'**
  String get tutorial_student_home_desc_categories;

  /// No description provided for @session_timing_info.
  ///
  /// In en, this message translates to:
  /// **'If you add more sessions, they will be scheduled on the same weekday and same time in the following weeks.'**
  String get session_timing_info;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
