import 'dart:io';

import 'package:geniuses_school/core/routes/app_routes.dart';
import 'package:geniuses_school/core/utils/logger.dart';
import 'package:geniuses_school/data/models/user_model.dart';
import 'package:geniuses_school/l10n/app_localizations.dart';
import 'package:geniuses_school/presentation/state/auth_provider.dart';
import 'package:geniuses_school/presentation/widgets/common/setting_item_widget.dart';
import 'package:geniuses_school/presentation/widgets/profile/language_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  File? _pickedImage;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage(ImageSource source) async {
    final authNotifier = ref.read(authProvider.notifier);
    final user = ref.read(authProvider);
    final pickedFile = await _picker.pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _pickedImage = File(pickedFile.path);
      });

      //  if (user != null) {
      //   final updatedUser = user.copyWith(
      //     profile: user!.profile!.copyWith(
      //       profile_photo: pickedFile.path
      //     )
      //   );
      //   await authNotifier.updateUser(updatedUser:  updatedUser, certificates: []);
      // }
    }
  }

  Widget _buildProfileImage(UserModel? user) {
    final authState = ref.read(authProvider);
    final theme = Theme.of(context);
    final double screenWidth = MediaQuery.sizeOf(context).width;
    // Responsive radius: ~16% of screen width, clamped between 50 and 75
    // Responsive radius: ~12% of screen width, clamped between 30 and 80 (increased for tablet)
    final double radius = (screenWidth * 0.12).clamp(30.0, 80.0);

    ImageProvider? imageProvider;
    if (_pickedImage != null) {
      imageProvider = FileImage(_pickedImage!);
    } else if (authState.user?.profile?.profile_photo != null) {
      imageProvider = NetworkImage(authState.user!.profile!.profile_photo!);
    }

    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        Container(
          padding: const EdgeInsets.all(4), // White border effect
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: CircleAvatar(
            radius: radius,
            backgroundColor: Colors.grey.shade100,
            backgroundImage: imageProvider,
            child: imageProvider == null
                ? Icon(
                    Icons.person,
                    size: radius * 0.6,
                    color: Colors.grey.shade400,
                  )
                : null,
          ),
        ),
        Positioned(
          bottom: 0,
          right: 0,
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: theme.primaryColor,
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white, width: 2),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 6,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: const Icon(
              Icons.camera_alt_rounded,
              size: 16,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authProvider);
    final l10n = AppLocalizations.of(context)!;
    final user = authState.user;
    final theme = Theme.of(context);
    final isTablet = 1.sw >= 600;

    if (user == null) {
      return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: isTablet ? 500 : double.infinity,
            ),
            child: Padding(
              padding: const EdgeInsets.all(32.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: theme.primaryColor.withValues(alpha: 0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.person_outline_rounded,
                      size: isTablet ? 100 : 80,
                      color: theme.primaryColor,
                    ),
                  ),
                  const SizedBox(height: 32),
                  Text(
                    l10n.authRequired,
                    style: TextStyle(
                      fontSize: isTablet ? 24.sp : 24.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    l10n.loginToSeeProfile,
                    style: TextStyle(
                      fontSize: isTablet ? 16.sp : 16.sp,
                      color: Colors.grey.shade600,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 48),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () => Navigator.pushNamed(context, '/login'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: theme.primaryColor,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      child: Text(
                        l10n.login,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: isTablet ? 20 : 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextButton(
                    onPressed: () => Navigator.pushNamed(context, '/roles'),
                    child: Text(
                      l10n.dontHaveAccount,
                      style: TextStyle(
                        color: theme.primaryColor,
                        fontWeight: FontWeight.w600,
                        fontSize: isTablet ? 16 : 14,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }

    return SafeArea(
      child: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: isTablet ? 600 : double.infinity,
          ),
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.9,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: Center(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Row(
                              children: [
                                Stack(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: InkWell(
                                        onTap: () {
                                          Logger.log("picked");
                                        },
                                        child: _buildProfileImage(user),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: Wrap(
                                    crossAxisAlignment:
                                        WrapCrossAlignment.center,
                                    children: [
                                      if (user.profile != null) ...[
                                        Text(
                                          "${user.first_name} ${user.last_name}",
                                          style: TextStyle(
                                            fontWeight: FontWeight.w800,
                                            fontSize: isTablet ? 24 : 20,
                                            color: Colors.black87,
                                          ),
                                        ),
                                        SizedBox(
                                          width: user.profile!.verified!
                                              ? 8
                                              : 0,
                                        ),
                                        user.profile!.verified!
                                            ? Icon(
                                                Icons.verified,
                                                color: theme.primaryColor,
                                                size: isTablet ? 28 : 24,
                                              )
                                            : const SizedBox.shrink(),
                                      ] else ...[
                                        Text(
                                          "${user.first_name} ${user.last_name}",
                                          style: TextStyle(
                                            fontWeight: FontWeight.w800,
                                            fontSize: isTablet ? 24 : 20,
                                            color: Colors.black87,
                                          ),
                                        ),
                                      ],
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 20),
                          Container(
                            width: double.infinity,
                            height: 1, // Thinner divider looks more "Pro"
                            decoration: BoxDecoration(
                              color: Colors.grey.withOpacity(0.2),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  SettingItemWidget(
                    title: l10n.editProfile,
                    icon: Icons.edit,
                    onPressed: () {
                      user.role_id != 3 && user.role_id != 4
                          ? Navigator.pushNamed(context, '/roles')
                          : Navigator.pushNamed(context, '/edit-profile');
                    },
                  ),
                  SettingItemWidget(
                    title: l10n.changePassword,
                    icon: Icons.lock_outline,
                    onPressed: () {
                      Navigator.pushNamed(context, AppRoutes.changePassword);
                    },
                  ),

                  SettingItemWidget(
                    title: l10n.changeLanguage,
                    icon: Icons.language,
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        backgroundColor: Colors.transparent,
                        builder: (context) => const LanguageBottomSheet(),
                      );
                    },
                  ),

                  // Teacher Specific Logic
                  if (user.role_id == 3 &&
                      user.profile?.services != null &&
                      user.profile!.services!.isNotEmpty) ...[
                    () {
                      final service = user.profile!.services!.first;
                      final serviceId = service.serviceId;

                      return Column(
                        children: [
                          // Private Lesson (3) or Language Study (2) -> Show Schedule
                          if (serviceId == 3 || serviceId == 2)
                            SettingItemWidget(
                              onPressed: () => Navigator.pushNamed(
                                context,
                                '/schedule-manage',
                              ),
                              title: l10n.manageTimes,
                              icon: Icons.schedule,
                            ),

                          // Private Lesson (3) -> Show Subjects
                          if (serviceId == 3)
                            SettingItemWidget(
                              onPressed: () => Navigator.pushNamed(
                                context,
                                '/levels-manage',
                              ),
                              title: l10n.manageLevelsSubjects,
                              icon: Icons.class_,
                            ),

                          // Course (4) -> Show Course Management
                          if (serviceId == 4)
                            SettingItemWidget(
                              onPressed: () => Navigator.pushNamed(
                                context,
                                '/courses-manage',
                              ),
                              title: l10n.manageCourses,
                              icon: Icons.class_outlined,
                            ),

                          // Language Study (2) -> Show Languages
                          if (serviceId == 2)
                            SettingItemWidget(
                              onPressed: () => Navigator.pushNamed(
                                context,
                                AppRoutes.languagesManage,
                              ),
                              title: l10n.manageLanguages,
                              icon: Icons.language,
                            ),

                          // All teachers show Wallet
                          SettingItemWidget(
                            onPressed: () =>
                                Navigator.pushNamed(context, '/profit-manage'),
                            title: l10n.myWallet,
                            icon: Icons.account_balance_wallet,
                          ),

                          // Teacher Bank Account
                          SettingItemWidget(
                            onPressed: () =>
                                Navigator.pushNamed(context, '/payment-manage'),
                            title: l10n.manageBankAccount,
                            icon: Icons.payment_sharp,
                          ),
                        ],
                      );
                    }(),
                  ],

                  // Student Specific Logic
                  if (user.role_id != 3) ...[
                    SettingItemWidget(
                      onPressed: () =>
                          Navigator.pushNamed(context, '/bookings'),
                      title: l10n.myBookings,
                      icon: Icons.schedule,
                    ),
                    SettingItemWidget(
                      onPressed: () =>
                          Navigator.pushNamed(context, AppRoutes.studentOrders),
                      title: l10n.myOrders,
                      icon: Icons.shopping_cart,
                    ),
                    // SettingItemWidget(
                    //   onPressed: () =>
                    //       Navigator.pushNamed(context, '/payment-manage'),
                    //   title: l10n.managePaymentMethods,
                    //   icon: Icons.payment_sharp,
                    // ),
                  ],
                  SettingItemWidget(
                    onPressed: () {
                      Navigator.pushNamed(context, '/notifications');
                    },
                    title: l10n.notifications,
                    icon: Icons.notifications,
                  ),
                  SettingItemWidget(
                    onPressed: () {
                      Navigator.pushNamed(context, '/about');
                    },
                    title: l10n.aboutApp,
                    icon: Icons.info_outline,
                  ),
                  SettingItemWidget(
                    onPressed: () async {
                      final shouldDelete = await showDialog<bool>(
                        context: context,
                        builder: (dialogContext) => AlertDialog(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          title: Text(l10n.deleteAccount),
                          content: Text(l10n.deleteAccountConfirmation),
                          actions: [
                            TextButton(
                              onPressed: () =>
                                  Navigator.pop(dialogContext, false),
                              child: Text(l10n.cancel),
                            ),
                            ElevatedButton(
                              onPressed: () =>
                                  Navigator.pop(dialogContext, true),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red,
                              ),
                              child: Text(
                                l10n.delete,
                                style: const TextStyle(color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                      );

                      if (shouldDelete == true) {
                        await ref
                            .read(authProvider.notifier)
                            .deleteAccount(context);
                      }
                    },
                    title: l10n.deleteAccount,
                    icon: Icons.delete_forever,
                    color: Colors.red,
                  ),
                  SettingItemWidget(
                    onPressed: () async {
                      // Show confirmation dialog
                      final shouldLogout = await showDialog<bool>(
                        context: context,
                        barrierDismissible: false,
                        builder: (dialogContext) => AlertDialog(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          title: Text(l10n.logout),
                          content: Text(l10n.logoutConfirmation),
                          actions: [
                            TextButton(
                              onPressed: () =>
                                  Navigator.pop(dialogContext, false),
                              child: Text(l10n.cancel),
                            ),
                            ElevatedButton(
                              onPressed: () =>
                                  Navigator.pop(dialogContext, true),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Theme.of(
                                  dialogContext,
                                ).primaryColor,
                              ),
                              child: Text(
                                l10n.logout,
                                style: const TextStyle(color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                      );

                      if (shouldLogout == true) {
                        // No need to close dialog manually or check context.mounted
                        // The global navigator key will handle navigation
                        await ref.read(authProvider.notifier).logout(context);
                      }
                    },
                    title: authState.status == AuthStatus.loading
                        ? l10n.loggingOut
                        : l10n.logout,
                    icon: Icons.logout,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
