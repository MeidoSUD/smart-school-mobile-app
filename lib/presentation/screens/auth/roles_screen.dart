import 'package:geniuses_school/core/constants/app_assets.dart';
import 'package:geniuses_school/core/constants/app_constants.dart';
import 'package:geniuses_school/core/utils/logger.dart';
import 'package:geniuses_school/data/models/user_model.dart';
import 'package:geniuses_school/l10n/app_localizations.dart';
import 'package:geniuses_school/presentation/state/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RolesScreen extends ConsumerStatefulWidget {
  const RolesScreen({super.key});

  @override
  ConsumerState<RolesScreen> createState() => _RolesScreenState();
}

class _RolesScreenState extends ConsumerState<RolesScreen> {
  int? _selectedRole; // 3 for teacher, 4 for student
  final _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final mediaQuery = MediaQuery.of(context);
    final authState = ref.read(authProvider);
    final data = authState.user;
    final isTablet = 1.sw >= 600;
    final maxWidth = isTablet ? 800.0 : double.infinity;

    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      body: SafeArea(
        child: Stack(
          children: [
            // Main Content
            Center(
              child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: maxWidth),
                child: CustomScrollView(
                  controller: _scrollController,
                  physics: const BouncingScrollPhysics(),
                  slivers: [
                    SliverFillRemaining(
                      hasScrollBody: false,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: isTablet ? 40.0 : 24.0,
                        ),
                        child: Column(
                          children: [
                            const SizedBox(height: 40),

                            // Logo
                            Container(
                              padding: const EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(24),
                                boxShadow: [
                                  BoxShadow(
                                    color: theme.primaryColor.withOpacity(0.1),
                                    blurRadius: 30,
                                    offset: const Offset(0, 10),
                                  ),
                                ],
                              ),
                              child: Image.asset(
                                AppAssets.logo,
                                height: isTablet ? 70 : 50,
                              ),
                            ),
                            const SizedBox(height: 48),

                            // Title
                            Text(
                              AppLocalizations.of(context)!.chooseYourRole,
                              style: TextStyle(
                                fontSize: isTablet ? 32.sp : 32.sp,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 12),
                            Text(
                              AppLocalizations.of(context)!.howToUseApp,
                              style: TextStyle(
                                fontSize: isTablet ? 16.sp : 16.sp,
                                color: Colors.grey.shade600,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 48),

                            // Role Cards
                            Expanded(
                              child: isTablet
                                  ? Row(
                                      children: [
                                        Expanded(
                                          child: _RoleCard(
                                            isSelected:
                                                _selectedRole ==
                                                AppConstants.roleStudent,
                                            imageUrl: AppAssets.studentRole,
                                            title: AppLocalizations.of(
                                              context,
                                            )!.student,
                                            description: AppLocalizations.of(
                                              context,
                                            )!.studentDescription,
                                            primaryColor: theme.primaryColor,
                                            onTap: () {
                                              final roleId =
                                                  AppConstants.roleStudent;
                                              setState(
                                                () => _selectedRole = roleId,
                                              );
                                              ref
                                                  .read(authProvider.notifier)
                                                  .setUser(
                                                    (data ??
                                                            UserModel(
                                                              id: 0,
                                                              first_name: '',
                                                              last_name: '',
                                                              email: '',
                                                              phone_number: '',
                                                              gender: 'male',
                                                              role_id: roleId,
                                                              is_active: true,
                                                            ))
                                                        .copyWith(
                                                          role_id: roleId,
                                                        ),
                                                  );
                                              Logger.log(
                                                "Student role selected: $roleId",
                                              );
                                            },
                                          ),
                                        ),
                                        const SizedBox(width: 24),
                                        Expanded(
                                          child: _RoleCard(
                                            isSelected:
                                                _selectedRole ==
                                                AppConstants.roleTeacher,
                                            imageUrl: AppAssets.teacherRole,
                                            title: AppLocalizations.of(
                                              context,
                                            )!.teacher,
                                            description: AppLocalizations.of(
                                              context,
                                            )!.teacherDescription,
                                            primaryColor: theme.primaryColor,
                                            onTap: () {
                                              final roleId =
                                                  AppConstants.roleTeacher;
                                              setState(
                                                () => _selectedRole = roleId,
                                              );
                                              ref
                                                  .read(authProvider.notifier)
                                                  .setUser(
                                                    (data ??
                                                            UserModel(
                                                              id: 0,
                                                              first_name: '',
                                                              last_name: '',
                                                              email: '',
                                                              phone_number: '',
                                                              gender: 'male',
                                                              role_id: roleId,
                                                              is_active: true,
                                                            ))
                                                        .copyWith(
                                                          role_id: roleId,
                                                        ),
                                                  );
                                              Logger.log(
                                                "Teacher role selected: $roleId",
                                              );
                                            },
                                          ),
                                        ),
                                      ],
                                    )
                                  : Column(
                                      children: [
                                        // Student Card
                                        Expanded(
                                          child: _RoleCard(
                                            isSelected:
                                                _selectedRole ==
                                                AppConstants.roleStudent,
                                            imageUrl: AppAssets.studentRole,
                                            title: AppLocalizations.of(
                                              context,
                                            )!.student,
                                            description: AppLocalizations.of(
                                              context,
                                            )!.studentDescription,
                                            primaryColor: theme.primaryColor,
                                            onTap: () {
                                              final roleId =
                                                  AppConstants.roleStudent;
                                              setState(
                                                () => _selectedRole = roleId,
                                              );
                                              ref
                                                  .read(authProvider.notifier)
                                                  .setUser(
                                                    (data ??
                                                            UserModel(
                                                              id: 0,
                                                              first_name: '',
                                                              last_name: '',
                                                              email: '',
                                                              phone_number: '',
                                                              gender: 'male',
                                                              role_id: roleId,
                                                              is_active: true,
                                                            ))
                                                        .copyWith(
                                                          role_id: roleId,
                                                        ),
                                                  );
                                              Logger.log(
                                                "Student role selected: $roleId",
                                              );
                                            },
                                          ),
                                        ),
                                        const SizedBox(height: 20),
                                        // Teacher Card
                                        Expanded(
                                          child: _RoleCard(
                                            isSelected:
                                                _selectedRole ==
                                                AppConstants.roleTeacher,
                                            imageUrl: AppAssets.teacherRole,
                                            title: AppLocalizations.of(
                                              context,
                                            )!.teacher,
                                            description: AppLocalizations.of(
                                              context,
                                            )!.teacherDescription,
                                            primaryColor: theme.primaryColor,
                                            onTap: () {
                                              final roleId =
                                                  AppConstants.roleTeacher;
                                              setState(
                                                () => _selectedRole = roleId,
                                              );
                                              ref
                                                  .read(authProvider.notifier)
                                                  .setUser(
                                                    (data ??
                                                            UserModel(
                                                              id: 0,
                                                              first_name: '',
                                                              last_name: '',
                                                              email: '',
                                                              phone_number: '',
                                                              gender: 'male',
                                                              role_id: roleId,
                                                              is_active: true,
                                                            ))
                                                        .copyWith(
                                                          role_id: roleId,
                                                        ),
                                                  );
                                              Logger.log(
                                                "Teacher role selected: $roleId",
                                              );
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                            ),

                            // Bottom spacing to account for the floating button
                            SizedBox(height: _selectedRole != null ? 100 : 40),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Animated Continue Button (slides up from bottom)
            AnimatedPositioned(
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeOutCubic,
              bottom: _selectedRole != null ? 0 : -100,
              left: 0,
              right: 0,
              child: Container(
                padding: EdgeInsets.fromLTRB(
                  isTablet ? 40.0 : 24.0,
                  16,
                  isTablet ? 40.0 : 24.0,
                  mediaQuery.viewInsets.bottom > 0 ? 32 : 40,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 20,
                      offset: const Offset(0, -5),
                    ),
                  ],
                ),
                child: Center(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(maxWidth: maxWidth),
                    child: SizedBox(
                      width: double.infinity,
                      height: 56,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(
                            context,
                            '/register',
                            arguments: {'roleId': _selectedRole},
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: theme.primaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          elevation: 2,
                        ),
                        child: Text(
                          AppLocalizations.of(context)!.continueText,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _RoleCard extends StatelessWidget {
  final bool isSelected;
  final String imageUrl;
  final String title;
  final String description;
  final Color primaryColor;
  final VoidCallback onTap;

  const _RoleCard({
    required this.isSelected,
    required this.imageUrl,
    required this.title,
    required this.description,
    required this.primaryColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isTablet = 1.sw >= 600;

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: isSelected ? primaryColor : Colors.grey.shade200,
            width: isSelected ? 3 : 1,
          ),
          boxShadow: [
            BoxShadow(
              color: isSelected
                  ? primaryColor.withOpacity(0.2)
                  : Colors.black.withOpacity(0.05),
              blurRadius: isSelected ? 20 : 10,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Stack(
          children: [
            // Selection Checkmark
            if (isSelected)
              Positioned(
                top: 16,
                left: 16,
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: primaryColor,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.check, color: Colors.white, size: 20),
                ),
              ),

            // Content
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Image
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? primaryColor.withOpacity(0.1)
                          : Colors.grey.shade50,
                      shape: BoxShape.circle,
                    ),
                    child: Image.asset(
                      imageUrl,
                      height: 80.h,
                      fit: BoxFit.contain,
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Title
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: isTablet ? 20.sp : 24.sp,
                      fontWeight: FontWeight.bold,
                      color: isSelected ? primaryColor : Colors.black87,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),

                  // Description
                  Text(
                    description,
                    style: TextStyle(
                      fontSize: isTablet ? 14.sp : 14.sp,
                      color: Colors.grey.shade600,
                      height: 1.5,
                    ),
                    textAlign: TextAlign.center,
                    maxLines: isTablet ? null : 2,
                    overflow: isTablet
                        ? TextOverflow.visible
                        : TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
