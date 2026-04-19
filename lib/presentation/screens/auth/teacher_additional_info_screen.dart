import 'dart:io';

import 'package:geniuses_school/core/utils/dialog_utils.dart';
import 'package:geniuses_school/core/utils/error_mapper.dart';
import 'package:geniuses_school/l10n/app_localizations.dart';
import 'package:geniuses_school/presentation/state/auth_provider.dart';
import 'package:geniuses_school/presentation/widgets/auth/LoginRegisterButton.dart';
import 'package:geniuses_school/presentation/widgets/common/ballsWidget.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../data/models/auth/teacher_registration_request.dart';
import '../../../data/models/teacher_model.dart';
import '../otp/otp_confirm_screen.dart';

class TeacherAdditionalInfoScreen extends ConsumerStatefulWidget {
  final Map<String, dynamic> basicInfo;

  const TeacherAdditionalInfoScreen({super.key, required this.basicInfo});

  @override
  ConsumerState<TeacherAdditionalInfoScreen> createState() =>
      _TeacherAdditionalInfoScreenState();
}

class _TeacherAdditionalInfoScreenState
    extends ConsumerState<TeacherAdditionalInfoScreen> {
  final _bioController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  int? _selectedServiceId;
  File? _certificateFile;
  File? _cvFile;

  // Hardcoded services as requested
  final List<TeacherService> _services = [
    TeacherService(id: 2, nameEn: "Language Learning", nameAr: "تعلم اللغات"),
    TeacherService(id: 3, nameEn: "Private Lessons", nameAr: "الدروس الخصوصية"),
    TeacherService(
      id: 4,
      nameEn: "Specialized Courses",
      nameAr: "الدورات المخصصة",
    ),
  ];

  @override
  void initState() {
    super.initState();
    // No need to fetch services anymore
  }

  // Future<void> _fetchServices() async { ... } removed

  @override
  void dispose() {
    _bioController.dispose();
    super.dispose();
  }

  Future<void> _pickFile({required bool isCertificate}) async {
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: isCertificate
            ? ['pdf', 'jpg', 'jpeg', 'png', 'doc', 'docx']
            : ['pdf', 'doc', 'docx'],
      );

      if (result != null && result.files.single.path != null) {
        final file = File(result.files.single.path!);
        final sizeInBytes = await file.length();
        final sizeInMb = sizeInBytes / (1024 * 1024);

        if (sizeInMb > 5) {
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(AppLocalizations.of(context)!.fileTooLarge),
                backgroundColor: Colors.red,
              ),
            );
          }
          return;
        }

        setState(() {
          if (isCertificate) {
            _certificateFile = file;
          } else {
            _cvFile = file;
          }
        });
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(AppLocalizations.of(context)!.pickFileError)),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authProvider);
    final theme = Theme.of(context);
    final isArabic = Localizations.localeOf(context).languageCode == 'ar';
    // Use local hardcoded services
    final services = _services;

    ref.listen<AuthState>(authProvider, (previous, next) {
      if (!mounted) return;

      if (previous?.status != AuthStatus.registered &&
          next.status == AuthStatus.registered) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => OtpConfirmScreen(
              phoneNumber: widget.basicInfo['phoneNumber'],
              type: 'register',
            ),
          ),
        );
      }

      if (previous?.status != AuthStatus.error &&
          next.status == AuthStatus.error) {
        final errorMessage = next.message ?? "An unknown error occurred";
        DialogUtils.showFriendlyErrorDialog(
          context,
          message: ErrorMapper.translate(context, errorMessage),
        );
      }
    });

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            BallsWidget(
              size: 200,
              alignment: const Alignment(-1.5, -0.8),
              opacity: 0.1,
              color: theme.primaryColor,
            ),
            BallsWidget(
              size: 150,
              alignment: const Alignment(1.8, 0.5),
              opacity: 0.1,
              color: theme.primaryColor,
            ),
            SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(height: 16.h),
                  Row(
                    children: [
                      IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: const Icon(Icons.arrow_back),
                        style: IconButton.styleFrom(
                          backgroundColor: Colors.white,
                          elevation: 2,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16.h),

                  // Title Section
                  Text(
                    AppLocalizations.of(context)!.completeProfile,
                    style: TextStyle(
                      fontSize: 32.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                      height: 1.2,
                    ),
                    textAlign: TextAlign.start,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    AppLocalizations.of(context)!.teacherDescription,
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: Colors.grey.shade600,
                    ),
                    textAlign: TextAlign.start,
                  ),
                  const SizedBox(height: 32),

                  // Form Card
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 30,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(24.r),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            // Bio
                            Text(
                              AppLocalizations.of(context)!.bio,
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w600,
                                color: Colors.grey.shade700,
                              ),
                            ),
                            const SizedBox(height: 8),
                            TextFormField(
                              controller: _bioController,
                              maxLines: 4,
                              decoration: InputDecoration(
                                hintText: AppLocalizations.of(context)!.bioHint,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide(
                                    color: Colors.grey.shade300,
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide(
                                    color: Colors.grey.shade300,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide(
                                    color: theme.primaryColor,
                                  ),
                                ),
                                filled: true,
                                fillColor: Colors.grey.shade50,
                              ),
                            ),
                            const SizedBox(height: 24),

                            // Service
                            Text(
                              AppLocalizations.of(context)!.selectService,
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w600,
                                color: Colors.grey.shade700,
                              ),
                            ),
                            const SizedBox(height: 8),
                            DropdownButtonFormField<int>(
                              initialValue: _selectedServiceId,
                              items: services.map((s) {
                                return DropdownMenuItem<int>(
                                  value: s.id,
                                  child: Text(
                                    isArabic ? s.nameAr ?? '' : s.nameEn ?? '',
                                  ),
                                );
                              }).toList(),
                              onChanged: (val) {
                                setState(() {
                                  _selectedServiceId = val;
                                });
                              },
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(
                                  horizontal: 16.w,
                                  vertical: 16.h,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide(
                                    color: Colors.grey.shade300,
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide(
                                    color: Colors.grey.shade300,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide(
                                    color: theme.primaryColor,
                                  ),
                                ),
                                filled: true,
                                fillColor: Colors.grey.shade50,
                                hintText: AppLocalizations.of(
                                  context,
                                )!.selectService,
                              ),
                            ),
                            const SizedBox(height: 24),

                            // Certificate (Required)
                            Text(
                              "${AppLocalizations.of(context)!.certificateLabel} *",
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w600,
                                color: Colors.grey.shade700,
                              ),
                            ),
                            const SizedBox(height: 8),
                            _buildFilePicker(
                              file: _certificateFile,
                              onTap: () => _pickFile(isCertificate: true),
                              label: AppLocalizations.of(
                                context,
                              )!.uploadCertificate,
                              theme: theme,
                            ),
                            const SizedBox(height: 24),

                            // CV (Optional)
                            Text(
                              AppLocalizations.of(context)!.cvLabel,
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w600,
                                color: Colors.grey.shade700,
                              ),
                            ),
                            const SizedBox(height: 8),
                            _buildFilePicker(
                              file: _cvFile,
                              onTap: () => _pickFile(isCertificate: false),
                              label: AppLocalizations.of(context)!.uploadCv,
                              theme: theme,
                            ),
                            const SizedBox(height: 32),

                            // Submit Button
                            LoginRigisterButton(
                              text: authState.status == AuthStatus.loading
                                  ? AppLocalizations.of(context)!.registering
                                  : AppLocalizations.of(
                                      context,
                                    )!.registerButton,
                              onPressed: authState.status == AuthStatus.loading
                                  ? null
                                  : () {
                                      if (_formKey.currentState!.validate()) {
                                        if (_certificateFile == null) {
                                          ScaffoldMessenger.of(
                                            context,
                                          ).showSnackBar(
                                            SnackBar(
                                              content: Text(
                                                AppLocalizations.of(
                                                  context,
                                                )!.certificateRequired,
                                              ),
                                              backgroundColor: Colors.red,
                                              behavior:
                                                  SnackBarBehavior.floating,
                                            ),
                                          );
                                          return;
                                        }

                                        ref
                                            .read(authProvider.notifier)
                                            .registerTeacher(
                                              TeacherRegistrationRequest(
                                                firstName: widget
                                                    .basicInfo['firstName'],
                                                lastName: widget
                                                    .basicInfo['lastName'],
                                                email:
                                                    widget.basicInfo['email'],
                                                phoneNumber: widget
                                                    .basicInfo['phoneNumber'],
                                                password: widget
                                                    .basicInfo['password'],
                                                gender:
                                                    widget.basicInfo['gender'],
                                                nationality: widget
                                                    .basicInfo['nationality'],
                                                serviceId: _selectedServiceId,
                                                bio: _bioController.text,
                                                certificate: _certificateFile,
                                                cv: _cvFile,
                                              ),
                                            );
                                      }
                                    },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 32.h),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilePicker({
    required File? file,
    required VoidCallback onTap,
    required String label,
    required ThemeData theme,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          border: Border.all(
            color: file != null ? theme.primaryColor : Colors.grey.shade300,
          ),
          borderRadius: BorderRadius.circular(12),
          color: file != null
              ? theme.primaryColor.withOpacity(0.05)
              : Colors.grey.shade50,
        ),
        child: Row(
          children: [
            Icon(
              file != null ? Icons.check_circle : Icons.cloud_upload_outlined,
              color: file != null ? theme.primaryColor : Colors.grey,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                file != null ? file.path.split('/').last : label,
                style: TextStyle(
                  color: file != null
                      ? theme.primaryColor
                      : Colors.grey.shade600,
                  fontWeight: file != null
                      ? FontWeight.bold
                      : FontWeight.normal,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            if (file != null)
              Icon(Icons.edit, size: 16, color: theme.primaryColor),
          ],
        ),
      ),
    );
  }
}
