import 'dart:io';

import 'package:file_picker/file_picker.dart';

import 'package:geniuses_school/core/utils/logger.dart';
import 'package:geniuses_school/data/models/user_profile_model.dart';
import 'package:geniuses_school/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import '../../../data/models/user_model.dart';
import '../../state/auth_provider.dart';
import '../../widgets/common/ballsWidget.dart';
import '../../widgets/edit_profile_widgets/edit_profile_documents_page.dart';
import '../../widgets/edit_profile_widgets/edit_profile_form_page.dart';
import '../../widgets/edit_profile_widgets/loading_overlay_widget.dart';

class EditProfileScreen extends ConsumerStatefulWidget {
  const EditProfileScreen({super.key});

  @override
  ConsumerState<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends ConsumerState<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  final _pageController = PageController();

  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _bioController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _singleLessonPriceController = TextEditingController();

  String? _selectedCode = "+966";
  String? _selectedNationality;
  String? _selectedGender;
  int? _selectedRole;

  bool _teachSingleLesson = false;
  bool _isUpdating = false;

  File? _pickedImage;
  final ImagePicker _picker = ImagePicker();

  // Two separate certificates
  dynamic _graduationCertificate;
  dynamic _cvCertificate;

  List<Map<String, dynamic>> _teacherServices = [];

  Map<String, dynamic>? selectedService;

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _pickedImage = File(pickedFile.path);
      });
    }
  }

  Future<void> _pickCertificate() async {
    final l10n = AppLocalizations.of(context)!;
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf', 'jpg', 'jpeg', 'png'],
      );
      if (result != null && result.files.single.path != null) {
        final file = File(result.files.single.path!);

        // Verify file exists
        if (await file.exists()) {
          setState(() {
            _graduationCertificate = file;
          });
        } else {
          // Show error - file doesn't exist
          if (mounted) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(l10n.fileReadError)));
          }
        }
      }
    } catch (e) {
      debugPrint('Error picking certificate: $e');
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(l10n.pickFileError)));
      }
    }
  }

  Future<void> _pickResume() async {
    final l10n = AppLocalizations.of(context)!;
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf', 'jpg', 'jpeg', 'png'],
      );
      if (result != null && result.files.single.path != null) {
        final file = File(result.files.single.path!);

        // Verify file exists
        if (await file.exists()) {
          setState(() {
            _cvCertificate = file;
          });
        } else {
          // Show error - file doesn't exist
          if (mounted) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(l10n.fileReadError)));
          }
        }
      }
    } catch (e) {
      debugPrint('Error picking certificate: $e');
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(l10n.pickFileError)));
      }
    }
  }

  Future<void> _performUpdate(UserModel user) async {
    final l10n = AppLocalizations.of(context)!;
    setState(() {
      _isUpdating = true;
    });

    try {
      // Prepare certificates list
      // List<String> certificates = [];
      // if (_graduationCertificate != null) {
      //   certificates.add(_graduationCertificate!.path);
      // }
      // if (_cvCertificate != null) {
      //   certificates.add(_cvCertificate!.path);
      // }
      Logger.log("##> certicates : $_graduationCertificate, $_cvCertificate");
      await ref
          .read(authProvider.notifier)
          .updateUser(
            roleId: user.role_id,
            updatedUser: user.copyWith(
              first_name: _firstNameController.text,
              last_name: _lastNameController.text,
              phone_number: "${_selectedCode ?? ""}${_phoneController.text}",
              nationality: _selectedNationality,
              profile:
                  (user.profile ??
                          UserProfileModel(
                            verified: user.profile?.verified ?? false,
                          ))
                      .copyWith(
                        profile_photo: _pickedImage != null
                            ? _pickedImage!.path
                            : user.profile?.profile_photo,
                        certificate: _graduationCertificate is File
                            ? _graduationCertificate.path
                            : _graduationCertificate,
                        resume: _cvCertificate is File
                            ? _cvCertificate.path
                            : _cvCertificate,
                        teacher_service: selectedService,
                        user_bio: _bioController.text,

                        is_active: user.profile?.is_active ?? true,
                        teach_individual: _teachSingleLesson,
                        individual_hour_price:
                            _singleLessonPriceController.text.isNotEmpty
                            ? double.parse(_singleLessonPriceController.text)
                            : 0.0,
                        teach_group: false,
                        group_hour_price: 0.0,
                        max_group_size: 0,
                        min_group_size: 0,
                      ),
            ),
          );

      setState(() {
        _isUpdating = false;
      });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(l10n.saveSuccess, textAlign: TextAlign.center),
            backgroundColor: Colors.green,
            duration: const Duration(seconds: 2),
          ),
        );

        // Navigate back or close
        Navigator.of(context).pop();
      }
    } catch (error) {
      setState(() {
        _isUpdating = false;
      });

      if (mounted) {
        Logger.log("Error updating profile: $error");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(l10n.saveFailed(error.toString())),
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 10),
          ),
        );
      }
    }
  }

  @override
  void initState() {
    super.initState();
    final authState = ref.read(authProvider);

    Logger.log(
      "teacher services init: ${authState.user?.profile?.teacher_service}",
    );
    _firstNameController.text = authState.user!.first_name;
    _lastNameController.text = authState.user!.last_name;
    // Parse phone number to separate country code if possible
    String fullPhone = authState.user!.phone_number;
    final codes = ['+966', '+20', '+971', '+974', '+1'];
    String? matchedCode;
    for (final code in codes) {
      if (fullPhone.startsWith(code)) {
        matchedCode = code;
        break;
      }
    }

    if (matchedCode != null) {
      _selectedCode = matchedCode;
      _phoneController.text = fullPhone
          .substring(matchedCode.length)
          .replaceFirst("-", "");
    } else {
      _phoneController.text = fullPhone;
    }
    _bioController.text = authState.user!.profile?.user_bio ?? "";

    _teachSingleLesson = authState.user?.profile?.teach_individual ?? false;
    _singleLessonPriceController.text =
        authState.user?.profile?.individual_hour_price != 0.0
        ? (authState.user?.profile?.individual_hour_price.toString() ?? "")
        : "";
    _selectedNationality = authState.user?.nationality;
    _cvCertificate = authState.user?.profile?.resume;
    _graduationCertificate = authState.user?.profile?.certificate;
    selectedService = authState.user?.profile?.teacher_service != null
        ? Map<String, dynamic>.from(authState.user!.profile!.teacher_service!)
        : <String, dynamic>{};
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Initialize services with localized strings if needed,
    // or just assume the names are static for now but at least structure is here.
    // Since names are hardcoded in the original, I'll keep them as is BUT
    // update the UI to potentially use l10n if the keys match.
    // For now, I will keep the original structure but move it here to align with best practices.

    final l10n = AppLocalizations.of(context)!;
    _teacherServices = [
      {
        "service_id": 3,
        "key_name": "private_lesson",
        "name_en": l10n.servicePrivateLessons,
        "name": l10n.servicePrivateLessons,
        "description_en": l10n.servicePrivateLessonsDesc,
        "description_ar": l10n.servicePrivateLessonsDesc,
        "image": " services/3aI4poDOvvm4CynL9Bj6BlAgf4qrYc1vaoz4BeQX.png",
        "status": 1,
        "verified": true,
      },
      {
        "service_id": 4,
        "key_name": "training_course",
        "name_en": l10n.serviceTrainingCourses,
        "name": l10n.serviceTrainingCourses,
        "description_en": l10n
            .servicePrivateLessonsDesc, // Using generic desc or add specific if needed
        "description_ar": l10n.servicePrivateLessonsDesc,
        "image": " services/3aI4poDOvvm4CynL9Bj6BlAgf4qrYc1vaoz4BeQX.png",
        "status": 1,
        "verified": true,
      },

      {
        "service_id": 2,
        "key_name": "language_learning",
        "name_en": l10n.serviceLanguageLearning,
        "name": l10n.serviceLanguageLearning,
        "description_en": l10n.servicePrivateLessonsDesc,
        "description_ar": l10n.servicePrivateLessonsDesc,
        "image": " services/3aI4poDOvvm4CynL9Bj6BlAgf4qrYc1vaoz4BeQX.png",
        "status": 1,
        "verified": true,
      },
    ];
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authProvider);
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;

    final user = authState.user;
    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    final scrollTo = args?['scrollTo'] as String?;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: theme.primaryColor,
        foregroundColor: Colors.white,
        title: Text(
          l10n.editProfile,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            BallsWidget(
              size: 100,
              alignment: const Alignment(1.2, 0.2),
              opacity: 0.2,
              color: theme.primaryColor,
            ),
            BallsWidget(
              size: 100,
              alignment: const Alignment(-1.2, 0.9),
              opacity: 0.2,
              color: theme.primaryColor,
            ),

            PageView(
              controller: _pageController,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                // ---------------- Page 1 ----------------
                // ---------------- Page 1 ----------------
                EditProfileFormPage(
                  scrollTo: scrollTo,
                  formKey: _formKey,
                  user: user,
                  pickedImage: _pickedImage,
                  onPickImage: (source) => _pickImage(source),
                  firstNameController: _firstNameController,
                  lastNameController: _lastNameController,
                  phoneController: _phoneController,
                  selectedCode: _selectedCode,
                  onCodeChanged: (code) {
                    setState(() {
                      _selectedCode = code;
                    });
                  },
                  selectedNationality: _selectedNationality,
                  onNationalityChanged: (n) {
                    setState(() {
                      _selectedNationality = n;
                    });
                  },
                  bioController: _bioController,
                  teacherServices: _teacherServices,
                  selectedService: selectedService,
                  onServiceSelected: (service) {
                    setState(() {
                      selectedService = service;
                    });
                  },
                  teachSingleLesson: _teachSingleLesson,
                  singleLessonPriceController: _singleLessonPriceController,
                  onTeachSingleChanged: (value) {
                    setState(() {
                      _teachSingleLesson = value;
                      if (!_teachSingleLesson) {
                        _singleLessonPriceController.clear();
                      }
                    });
                  },
                  isUpdating: _isUpdating,
                  onNextOrSave: () {
                    if (_formKey.currentState!.validate()) {
                      _performUpdate(user!);
                    }
                  },
                ),

                // ---------------- Page 2 ----------------
                // ---------------- Page 2 ----------------
                EditProfileDocumentsPage(
                  graduationCertificate: _graduationCertificate,
                  onPickCertificate: _pickCertificate,
                  onRemoveCertificate: () {},
                  cvCertificate: _cvCertificate,
                  onPickResume: _pickResume,
                  onRemoveResume: () {},
                  isUpdating: _isUpdating,
                  onBack: () {
                    _pageController.previousPage(
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeInOut,
                    );
                  },
                  onSave: () => _performUpdate(user!),
                ),
              ],
            ),

            // Loading overlay
            LoadingOverlayWidget(isUpdating: _isUpdating),
          ],
        ),
      ),
    );
  }

  bool _checkIFSelected(int id, List<Map<String, dynamic>>? services) {
    if (services == null || services.isEmpty) return false;
    for (var service in services) {
      if (service['id'] == id) {
        return true;
      }
    }
    return false;
  }

  String _getServiceTitle(int id, List<Map<String, dynamic>>? services) {
    final service = services!.firstWhere(
      (s) => s['id'] == id,
      orElse: () => {},
    );
    return service['title'] ?? 'Unknown';
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _phoneController.dispose();
    _bioController.dispose();
    _descriptionController.dispose();
    _singleLessonPriceController.dispose();
    _pageController.dispose();

    super.dispose();
  }
}
