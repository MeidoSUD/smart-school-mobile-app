import 'dart:io';

import 'package:geniuses_school/data/models/user_model.dart';
import 'package:geniuses_school/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../auth/LoginRegisterButton.dart';
import '../auth/NationalityFieldWidget.dart';
import '../auth/PhoneNumberFieldWidget.dart';
import '../common/TextFieldWidget.dart';
import 'profile_image_picker.dart';
import 'teacher_preferences_form.dart';

class EditProfileFormPage extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final UserModel? user;
  final File? pickedImage;
  final Function(ImageSource) onPickImage;
  final TextEditingController firstNameController;
  final TextEditingController lastNameController;
  final TextEditingController phoneController;
  final String? selectedCode;
  final Function(String?) onCodeChanged;
  final String? selectedNationality;
  final Function(String?) onNationalityChanged;
  final TextEditingController bioController;
  final List<Map<String, dynamic>> teacherServices;
  final Map<String, dynamic>? selectedService;
  final Function(Map<String, dynamic>?) onServiceSelected;
  final bool teachSingleLesson;
  final TextEditingController singleLessonPriceController;
  final Function(bool) onTeachSingleChanged;
  final bool isUpdating;
  final VoidCallback onNextOrSave;
  final String? scrollTo;

  const EditProfileFormPage({
    super.key,
    required this.formKey,
    required this.user,
    required this.pickedImage,
    required this.onPickImage,
    required this.firstNameController,
    required this.lastNameController,
    required this.phoneController,
    required this.selectedCode,
    required this.onCodeChanged,
    required this.selectedNationality,
    required this.onNationalityChanged,
    required this.bioController,
    required this.teacherServices,
    required this.selectedService,
    required this.onServiceSelected,
    required this.teachSingleLesson,
    required this.singleLessonPriceController,
    required this.onTeachSingleChanged,
    required this.isUpdating,
    required this.onNextOrSave,
    this.scrollTo,
  });

  @override
  State<EditProfileFormPage> createState() => _EditProfileFormPageState();
}

class _EditProfileFormPageState extends State<EditProfileFormPage> {
  final _scrollController = ScrollController();
  final _pricingKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    if (widget.scrollTo == 'pricing') {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _scrollToPricing();
      });
    }
  }

  void _scrollToPricing() {
    final context = _pricingKey.currentContext;
    if (context != null) {
      Scrollable.ensureVisible(
        context,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isTablet = MediaQuery.of(context).size.width > 600;

    return CustomScrollView(
      controller: _scrollController,
      slivers: [
        SliverFillRemaining(
          hasScrollBody: false,
          child: Container(
            constraints: BoxConstraints(
              maxWidth: isTablet ? 600 : double.infinity,
            ),
            margin: isTablet
                ? const EdgeInsets.symmetric(horizontal: 32)
                : EdgeInsets.zero,
            child: Form(
              key: widget.formKey,
              child: Padding(
                padding: EdgeInsets.only(
                  left: 20,
                  right: 20,
                  top: 20,
                  bottom: MediaQuery.of(context).viewInsets.bottom + 20,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Profile Image Section
                    Center(
                      child: ProfileImagePicker(
                        user: widget.user,
                        pickedImage: widget.pickedImage,
                        onPickImage: widget.onPickImage,
                      ),
                    ),
                    const SizedBox(height: 32),

                    // Personal Information Card
                    _buildSectionCard(
                      context,
                      title: AppLocalizations.of(context)!.personalInfo,
                      icon: Icons.person_outline,
                      child: Column(
                        children: [
                          _buildSectionLabel(
                            context,
                            AppLocalizations.of(context)!.firstName,
                          ),
                          const SizedBox(height: 8),
                          TextFieldWidget(
                            label: AppLocalizations.of(context)!.firstName,
                            controller: widget.firstNameController,
                            prefixIcon: Icons.person,
                            validator: (v) => v!.isEmpty
                                ? AppLocalizations.of(context)!.requiredField
                                : null,
                          ),
                          const SizedBox(height: 20),
                          _buildSectionLabel(
                            context,
                            AppLocalizations.of(context)!.lastName,
                          ),
                          const SizedBox(height: 8),
                          TextFieldWidget(
                            label: AppLocalizations.of(context)!.lastName,
                            controller: widget.lastNameController,
                            prefixIcon: Icons.person_outline,
                            validator: (v) => v!.isEmpty
                                ? AppLocalizations.of(context)!.requiredField
                                : null,
                          ),
                          if (widget.user!.role_id == 3) ...[
                            const SizedBox(height: 20),
                            _buildSectionLabel(
                              context,
                              AppLocalizations.of(context)!.phoneNumber,
                            ),
                            const SizedBox(height: 8),
                            PhoneNumberFieldWidget(
                              controller: widget.phoneController,
                              selectedCode: widget.selectedCode,
                              validator: (v) => v == null || v.isEmpty
                                  ? AppLocalizations.of(
                                      context,
                                    )!.enterPhoneNumberError
                                  : null,
                              onCodeChanged: widget.onCodeChanged,
                            ),
                            const SizedBox(height: 20),
                            _buildSectionLabel(
                              context,
                              "${AppLocalizations.of(context)!.nationality} ${AppLocalizations.of(context)!.optional}",
                            ),
                            const SizedBox(height: 8),
                            NationalityFieldWidget(
                              selectedNationality: widget.selectedNationality,
                              onChanged: widget.onNationalityChanged,
                            ),
                          ],
                        ],
                      ),
                    ),

                    // Teacher-specific sections
                    if (widget.user!.role_id == 3) ...[
                      const SizedBox(height: 20),

                      // Bio Section
                      _buildSectionCard(
                        context,
                        title: AppLocalizations.of(context)!.bioTitle,
                        icon: Icons.description_outlined,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              AppLocalizations.of(context)!.bioHint,
                              style: theme.textTheme.bodySmall?.copyWith(
                                color: Colors.grey.shade600,
                              ),
                            ),
                            const SizedBox(height: 12),
                            TextFieldWidget(
                              label: AppLocalizations.of(context)!.bioLabel,
                              controller: widget.bioController,
                              maxLines: 4,
                              prefixIcon: Icons.edit_note,
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 20),

                      // Lesson Preferences Section
                      if (widget.selectedService?['service_id'] == 3 ||
                          widget.selectedService?['service_id'] == 2)
                        TeacherPreferencesForm(
                          key: _pricingKey,
                          teachSingleLesson: widget.teachSingleLesson,
                          singleLessonPriceController:
                              widget.singleLessonPriceController,
                          onTeachSingleChanged: widget.onTeachSingleChanged,
                        ),
                    ],

                    const SizedBox(height: 2),

                    // Action Button
                    LoginRigisterButton(
                      text: AppLocalizations.of(context)!.saveButton,
                      onPressed: widget.isUpdating ? null : widget.onNextOrSave,
                    ),

                    const SizedBox(height: 12),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSectionCard(
    BuildContext context, {
    required String title,
    required IconData icon,
    required Widget child,
  }) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: theme.primaryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(icon, color: theme.primaryColor, size: 24),
              ),
              const SizedBox(width: 12),
              Text(
                title,
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: theme.primaryColor,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          child,
        ],
      ),
    );
  }

  Widget _buildSectionLabel(BuildContext context, String label) {
    return Text(
      label,
      style: Theme.of(context).textTheme.titleSmall?.copyWith(
        fontWeight: FontWeight.w600,
        color: Colors.grey.shade700,
      ),
    );
  }
}
