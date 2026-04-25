// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appName => 'Smart School';

  @override
  String get login => 'Login';

  @override
  String get username => 'Username';

  @override
  String get password => 'Password';

  @override
  String get loginToContinue => 'Login to continue';

  @override
  String get pleaseEnterUsername => 'Please enter username';

  @override
  String get pleaseEnterPassword => 'Please enter password';

  @override
  String get demoAccount => 'Demo Account';

  @override
  String get loginAsDemo => 'Login with Demo Account';

  @override
  String get noAccount => 'Don\'t have an account?';

  @override
  String get applyAdmission => 'Apply for Admission';

  @override
  String get switchLanguage => 'Switch Language';
}
