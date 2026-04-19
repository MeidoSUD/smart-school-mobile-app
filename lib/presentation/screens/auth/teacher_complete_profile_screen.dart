import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:file_picker/file_picker.dart';
import '../../../l10n/app_localizations.dart';
import '../../state/auth_provider.dart';
import '../../widgets/common/ballsWidget.dart';

class TeacherCompleteProfileScreen extends ConsumerStatefulWidget {
  const TeacherCompleteProfileScreen({super.key});

  @override
  ConsumerState<TeacherCompleteProfileScreen> createState() =>
      _TeacherCompleteProfileScreenState();
}

class _TeacherCompleteProfileScreenState
    extends ConsumerState<TeacherCompleteProfileScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  int? _selectedServiceId;
  File? _certificateFile;
  bool _isUploading = false;

  @override
  void initState() {
    super.initState();
    // Fetch services on init
    Future.microtask(
      () => ref.read(authProvider.notifier).fetchTeacherServices(),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _nextPage() {
    _pageController.nextPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _previousPage() {
    _pageController.previousPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  Future<void> _pickCertificate() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'jpg', 'jpeg', 'png'],
    );

    if (result != null && result.files.single.path != null) {
      setState(() {
        _certificateFile = File(result.files.single.path!);
      });
    }
  }

  Future<void> _handleServiceSelection(int serviceId) async {
    setState(() => _selectedServiceId = serviceId);
    final success = await ref
        .read(authProvider.notifier)
        .saveTeacherService(serviceId);
    if (success) {
      _nextPage();
    }
  }

  Future<void> _handleCertificateUpload() async {
    if (_certificateFile == null) return;

    setState(() => _isUploading = true);
    final success = await ref
        .read(authProvider.notifier)
        .uploadTeacherCertificate(_certificateFile!);
    setState(() => _isUploading = false);

    if (success) {
      _showSuccessDialog();
    }
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Row(
          children: [
            const Icon(Icons.check_circle, color: Colors.green, size: 28),
            const SizedBox(width: 10),
            Text(AppLocalizations.of(context)!.success),
          ],
        ),
        content: Text(AppLocalizations.of(context)!.teacherUnderReviewMessage),
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.of(
                context,
              ).pushNamedAndRemoveUntil('/home', (route) => false);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).primaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: Text(
              AppLocalizations.of(context)!.ok,
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authProvider);
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            BallsWidget(
              size: 100,
              alignment: const Alignment(1.5, -0.8),
              opacity: 0.1,
              color: theme.primaryColor,
            ),
            Column(
              children: [
                _buildHeader(l10n, theme),
                Expanded(
                  child: PageView(
                    controller: _pageController,
                    physics: const NeverScrollableScrollPhysics(),
                    onPageChanged: (page) =>
                        setState(() => _currentPage = page),
                    children: [
                      _buildServiceSelection(l10n, authState, theme),
                      _buildCertificateUpload(l10n, authState, theme),
                    ],
                  ),
                ),
              ],
            ),
            if (authState.status == AuthStatus.loading || _isUploading)
              Container(
                color: Colors.black26,
                child: const Center(child: CircularProgressIndicator()),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(AppLocalizations l10n, ThemeData theme) {
    return Padding(
      padding: EdgeInsets.all(24.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              if (_currentPage > 0)
                IconButton(
                  onPressed: _previousPage,
                  icon: const Icon(Icons.arrow_back_ios),
                  color: theme.primaryColor,
                ),
              Text(
                l10n.completeProfile,
                style: TextStyle(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.bold,
                  color: theme.primaryColor,
                ),
              ),
            ],
          ),
          SizedBox(height: 8.h),
          Text(
            _currentPage == 0 ? l10n.chooseYourService : l10n.uploadCertificate,
            style: TextStyle(fontSize: 16.sp, color: Colors.grey[600]),
          ),
          SizedBox(height: 20.h),
          _buildProgressIndicator(theme),
        ],
      ),
    );
  }

  Widget _buildProgressIndicator(ThemeData theme) {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 4.h,
            decoration: BoxDecoration(
              color: theme.primaryColor,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
        ),
        SizedBox(width: 8.w),
        Expanded(
          child: Container(
            height: 4.h,
            decoration: BoxDecoration(
              color: _currentPage >= 1 ? theme.primaryColor : Colors.grey[200],
              borderRadius: BorderRadius.circular(2),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildServiceSelection(
    AppLocalizations l10n,
    AuthState authState,
    ThemeData theme,
  ) {
    final services = authState.teacherServicesData;

    if (services == null) {
      return const Center(child: CircularProgressIndicator());
    }

    final servicesList = services;
    final isArabic = Localizations.localeOf(context).languageCode == 'ar';

    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      itemCount: servicesList.length,
      itemBuilder: (context, index) {
        final service = servicesList[index];
        final id = service.id;
        final name = isArabic ? (service.nameAr ?? "") : (service.nameEn ?? "");

        return _buildServiceCard(id, name, theme);
      },
    );
  }

  Widget _buildServiceCard(int id, String name, ThemeData theme) {
    IconData icon;
    String description;

    // Map icons and descriptions based on service name or ID
    if (id == 1) {
      icon = Icons.school_outlined;
      description = "Lessons for students";
    } else if (id == 2) {
      icon = Icons.language_outlined;
      description = "Teach languages";
    } else {
      icon = Icons.model_training_outlined;
      description = "Professional training";
    }

    return GestureDetector(
      onTap: () => _handleServiceSelection(id),
      child: Container(
        margin: EdgeInsets.only(bottom: 16.h),
        padding: EdgeInsets.all(20.r),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: _selectedServiceId == id
                ? theme.primaryColor
                : Colors.grey[200]!,
            width: 2,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(12.r),
              decoration: BoxDecoration(
                color: theme.primaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Icon(icon, color: theme.primaryColor, size: 30),
            ),
            SizedBox(width: 20.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    description,
                    style: TextStyle(fontSize: 14.sp, color: Colors.grey[600]),
                  ),
                ],
              ),
            ),
            Icon(Icons.arrow_forward_ios, color: Colors.grey[400], size: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildCertificateUpload(
    AppLocalizations l10n,
    AuthState authState,
    ThemeData theme,
  ) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(height: 20.h),
          GestureDetector(
            onTap: _pickCertificate,
            child: Container(
              height: 200.h,
              decoration: BoxDecoration(
                color: Colors.grey[50],
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: theme.primaryColor.withOpacity(0.3),
                  width: 2,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    _certificateFile != null
                        ? Icons.file_present
                        : Icons.cloud_upload_outlined,
                    color: theme.primaryColor,
                    size: 50,
                  ),
                  SizedBox(height: 12.h),
                  Text(
                    _certificateFile != null
                        ? _certificateFile!.path.split('/').last
                        : l10n.uploadFile,
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                      color: theme.primaryColor,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
          const Spacer(),
          ElevatedButton(
            onPressed: _certificateFile == null || _isUploading
                ? null
                : _handleCertificateUpload,
            style: ElevatedButton.styleFrom(
              backgroundColor: theme.primaryColor,
              padding: EdgeInsets.symmetric(vertical: 16.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              elevation: 0,
            ),
            child: Text(
              l10n.submit,
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          SizedBox(height: 40.h),
        ],
      ),
    );
  }
}
