import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:geniuses_school/core/constants/app_constants.dart';
import 'package:geniuses_school/core/utils/error_handler.dart';
import 'package:geniuses_school/core/utils/logger.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../app_keys.dart';
import '../../data/models/auth/student_registration_request.dart';
import '../../data/models/auth/teacher_registration_request.dart';
import '../../data/models/teacher_model.dart';
import '../../data/models/user_model.dart';
import '../../data/repositories/auth_repository.dart';

// final easyLevel = StateProvider<int>((ref) => 1);

enum AuthStatus {
  unauthenticated, // not logged in
  registered, // registered but not verified
  verified, // verified but no token yet
  authenticated, // logged in & authorized
  loading, // waiting for a request
  error, // failed
}

class AuthState {
  final UserModel? user;
  final AuthStatus status;
  final String? message;
  final List<TeacherService>? teacherServicesData;

  AuthState({
    this.user,
    this.message,
    this.status = AuthStatus.unauthenticated,
    this.teacherServicesData,
  });

  AuthState copyWith({
    UserModel? user,
    AuthStatus? status,
    String? message,
    List<TeacherService>? teacherServicesData,
  }) {
    return AuthState(
      user: user ?? this.user,
      status: status ?? this.status,
      message: message ?? this.message,
      teacherServicesData: teacherServicesData ?? this.teacherServicesData,
    );
  }
}

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>(
  (ref) => AuthNotifier(AuthRepository()),
);

class AuthNotifier extends StateNotifier<AuthState> {
  final AuthRepository _repository;
  final storage = const FlutterSecureStorage();

  AuthNotifier(this._repository) : super(AuthState());

  // set user
  void setUser(UserModel? user) {
    state = state.copyWith(user: user);
  }

  // Update user
  Future<void> updateUser({
    required int roleId,
    required UserModel updatedUser,
  }) async {
    Logger.log("Updating user in notifier...");
    Logger.log("Updated User: ${updatedUser.toJson()}");

    state = state.copyWith(status: AuthStatus.loading);

    try {
      final formData = FormData.fromMap({
        '_method': 'PUT',
        'first_name': updatedUser.first_name,
        'last_name': updatedUser.last_name,
        'nationality': updatedUser.nationality,
        'phone_number': updatedUser.phone_number,
        'bio': updatedUser.profile?.user_bio ?? '',

        'teach_individual': updatedUser.profile?.teach_individual == true
            ? 1
            : 0,
        'individual_hour_price':
            updatedUser.profile?.individual_hour_price ?? 0.0,
        'teach_group': updatedUser.profile?.teach_group == true ? 1 : 0,
        'group_hour_price': updatedUser.profile?.group_hour_price ?? 0.0,
        'max_group_size': updatedUser.profile?.max_group_size ?? 0,
        'min_group_size': updatedUser.profile?.min_group_size ?? 0,

        if (updatedUser.profile?.profile_photo != null &&
            updatedUser.profile!.profile_photo!.startsWith('/'))
          'profile_photo': await MultipartFile.fromFile(
            updatedUser.profile!.profile_photo!,
            filename: updatedUser.profile!.profile_photo!.split('/').last,
          ),

        if (updatedUser.profile?.certificate != null &&
            updatedUser.profile!.certificate!.startsWith('/'))
          'certificate': await MultipartFile.fromFile(
            updatedUser.profile!.certificate!,
            filename: updatedUser.profile!.certificate!.split('/').last,
          ),

        if (updatedUser.profile?.resume != null &&
            updatedUser.profile!.resume!.startsWith('/'))
          'resume': await MultipartFile.fromFile(
            updatedUser.profile!.resume!,
            filename: updatedUser.profile!.resume!.split('/').last,
          ),

        'services': updatedUser.profile?.teacher_service != null
            ? [updatedUser.profile!.teacher_service!['service_id']]
            : [],
      });

      final newUser = await _repository.updateUser(formData);
      // update provider state
      state = AuthState(
        user: newUser,
        status: AuthStatus.authenticated,
        message: 'User updated successfully',
      );
    } on DioException catch (e) {
      Logger.log("Update failed: ${e.response?.data}");
      state = AuthState(
        status: AuthStatus.error,
        message: ErrorHandler.getErrorMessage(e),
      );
    } catch (e) {
      Logger.log("Unexpected error: $e");
      state = AuthState(
        status: AuthStatus.error,
        message: ErrorHandler.getErrorMessage(e),
      );
    }
  }

  Future<void> login({
    String? email,
    String? phone,
    required String password,
  }) async {
    state = state.copyWith(status: AuthStatus.loading);

    try {
      Logger.log("login in auth notifier");
      final user = await _repository.login(
        email: email,
        phoneNumber: phone,
        password: password,
      );
      Logger.log("logged in auth notifier");
      state = AuthState(
        user: user,
        status: AuthStatus.authenticated,
        message: 'Login successful',
      );

      Logger.log("state set in auth notifier");
    } catch (e) {
      Logger.log("Login error: $e");
      state = AuthState(
        status: AuthStatus.error,
        message: ErrorHandler.getErrorMessage(e),
      );
    }
  }

  Future<void> verify(String code, int userId) async {
    state = state.copyWith(status: AuthStatus.loading);

    try {
      Logger.log("verify notifier here  ===> $userId");
      final user = await _repository.verifyCode(code, userId);
      Logger.log("logged in auth notifier after verification");

      await storage.delete(key: 'pending_registration');

      state = AuthState(
        user: user,
        status: AuthStatus.authenticated,
        message: 'Verification successful',
      );

      Logger.log("verififed");
    } catch (e) {
      final message = ErrorHandler.getErrorMessage(e);
      Logger.log("❌Verify code error: $e");
      state = AuthState(status: AuthStatus.error, message: message);
    }
  }

  Future<void> checkPendingRegistration() async {
    try {
      final String? pendingData = await storage.read(
        key: 'pending_registration',
      );
      if (pendingData != null) {
        final Map<String, dynamic> data = jsonDecode(pendingData);
        // We have pending registration
        // Restore minimal user state to allow OTP screen to function
        final minimalUser = UserModel(
          id: data['userId'] ?? 0,
          first_name: '',
          last_name: '',
          email: data['email'] ?? '',
          phone_number: data['phone'] ?? '',
          role_id: 0,
          gender: 'male', // default fallback for minimal user
          is_active: false, // default fallback
        );

        state = AuthState(
          user: minimalUser,
          status: AuthStatus.registered,
          message: 'Resumed pending registration',
        );
      }
    } catch (e) {
      Logger.log("Error checking pending registration: $e");
    }
  }

  Future<void> resendCode(int userId) async {
    state = state.copyWith(status: AuthStatus.loading);
    try {
      await _repository.resendCode(userId);
      state = state.copyWith(
        status: AuthStatus.authenticated, // or stay in registered
        message: 'Verification code resent',
      );
    } catch (e) {
      state = AuthState(
        status: AuthStatus.error,
        message: ErrorHandler.getErrorMessage(e),
      );
    }
  }

  void clearAuthState() {
    state = AuthState(status: AuthStatus.unauthenticated);
  }

  Future<void> initiatePasswordReset({String? phone, String? email}) async {
    state = state.copyWith(status: AuthStatus.loading);

    try {
      final user = await _repository.sendCode(phone, email: email);

      state = AuthState(
        user: user,
        status: AuthStatus.registered, // using registered as a bridge state
        message: 'OTP sent successfully',
      );

      Logger.log("otp sent for password reset");
    } catch (e) {
      final message = ErrorHandler.getErrorMessage(e);
      Logger.log("❌ Send otp code error: $message");
      state = AuthState(status: AuthStatus.error, message: message);
    }
  }

  Future<void> verifyResetCode(int userId, String code) async {
    state = state.copyWith(status: AuthStatus.loading);
    try {
      await _repository.verifyResetCode(userId, code);
      state = state.copyWith(
        status: AuthStatus.verified,
        message: 'Code verified successfully',
      );
    } catch (e) {
      state = AuthState(
        status: AuthStatus.error,
        message: ErrorHandler.getErrorMessage(e),
      );
    }
  }

  Future<void> confirmResetPassword({
    required int userId,
    required String code,
    required String newPassword,
    required String newPasswordConfirmation,
  }) async {
    final wasAuthenticated = state.status == AuthStatus.authenticated;
    state = state.copyWith(status: AuthStatus.loading);
    try {
      await _repository.confirmPassword(
        userId: userId,
        code: code,
        newPassword: newPassword,
        newPasswordConfirmation: newPasswordConfirmation,
      );
      state = state.copyWith(
        status: wasAuthenticated
            ? AuthStatus.authenticated
            : AuthStatus.unauthenticated,
        message: 'Password reset successful',
      );
    } catch (e) {
      state = AuthState(
        status: AuthStatus.error,
        message: ErrorHandler.getErrorMessage(e),
      );
    }
  }

  // Old register method
  // Future<void> register({
  //   required String firstName,
  //   required String lastName,
  //   required String email,
  //   required String phoneNumber,
  //   required String password,
  //   String? gender,
  //   String? nationality,
  //   required int roleId,
  // }) async {
  //   state = state.copyWith(status: AuthStatus.loading);

  //   try {
  //     Logger.log("registering in auth notifier");
  //     final user = await _repository.register(
  //       firstName: firstName,
  //       lastName: lastName,
  //       email: email,
  //       phoneNumber: phoneNumber,
  //       password: password,
  //       gender: gender,
  //       nationality: nationality,
  //       roleId: roleId,
  //     );
  //     Logger.log("registered in auth notifier");
  //     await storage.write(
  //       key: 'pending_registration',
  //       value: jsonEncode({
  //         'userId': user.id,
  //         'phone': phoneNumber,
  //         'email': email,
  //       }),
  //     );

  //     state = AuthState(
  //       user: user,
  //       status: AuthStatus.registered,
  //       message: 'Sent OTP successfully',
  //     );

  //     Logger.log("state set in auth notifier");
  //   } catch (e) {
  //     Logger.log("❌ Registration error: $e");
  //     state = AuthState(
  //       status: AuthStatus.error,
  //       message: ErrorHandler.getErrorMessage(e),
  //     );
  //   }
  // }

  Future<void> registerStudent(StudentRegistrationRequest request) async {
    state = state.copyWith(status: AuthStatus.loading);

    try {
      Logger.log("registering student in auth notifier");
      final user = await _repository.registerStudent(request);
      Logger.log("student registered in auth notifier");
      await storage.write(
        key: 'pending_registration',
        value: jsonEncode({
          'userId': user.id,
          'phone': request.phoneNumber,
          'email': request.email,
        }),
      );

      state = AuthState(
        user: user,
        status: AuthStatus.registered,
        message: 'Sent OTP successfully',
      );
    } catch (e) {
      Logger.log("❌ Student Registration error: $e");
      state = AuthState(
        status: AuthStatus.error,
        message: ErrorHandler.getErrorMessage(e),
      );
    }
  }

  Future<void> registerTeacher(TeacherRegistrationRequest request) async {
    state = state.copyWith(status: AuthStatus.loading);

    try {
      Logger.log("registering teacher in auth notifier");
      var user = await _repository.registerTeacher(request);

      // Ensure local state reflects teacher role for correct navigation
      if (user.role_id != AppConstants.roleTeacher) {
        user = user.copyWith(role_id: AppConstants.roleTeacher);
      }

      Logger.log("teacher registered in auth notifier");
      await storage.write(
        key: 'pending_registration',
        value: jsonEncode({
          'userId': user.id,
          'phone': request.phoneNumber,
          'email': request.email,
        }),
      );

      state = AuthState(
        user: user,
        status: AuthStatus.registered,
        message: 'Sent OTP successfully',
      );
    } catch (e) {
      Logger.log("❌ Teacher Registration error: $e");
      state = AuthState(
        status: AuthStatus.error,
        message: ErrorHandler.getErrorMessage(e),
      );
    }
  }

  // Delete Account
  Future<void> deleteAccount(BuildContext context) async {
    try {
      state = state.copyWith(status: AuthStatus.loading);
      await _repository.deleteAccount();

      // Clear state and logout
      await storage.delete(key: 'token');
      state = state.copyWith(user: null, status: AuthStatus.unauthenticated);

      if (navigatorKey.currentState != null) {
        navigatorKey.currentState!.pushNamedAndRemoveUntil(
          '/login',
          (route) => false,
        );
      }
    } catch (e) {
      Logger.log("Delete account error: $e");
      state = AuthState(
        status: AuthStatus.error,
        message: ErrorHandler.getErrorMessage(e),
      );
    }
  }

  // Logout
  Future<void> logout(BuildContext context) async {
    try {
      // Show loading indicator
      state = state.copyWith(status: AuthStatus.loading);
      Logger.log('🟢 Logout: Starting logout process...');

      // Call repository logout (attempts API call but always succeeds locally)
      await _repository.logout();
      Logger.log('🟢 Logout: Repository logout completed');
    } catch (e) {
      Logger.log('🔴 Logout error: $e');
    } finally {
      // Always clear state, regardless of success/failure
      state = state.copyWith(user: null, status: AuthStatus.unauthenticated);
      Logger.log('🟢 Logout: State cleared');

      // Use global navigator key to ensure navigation works
      // even if context becomes unmounted
      if (navigatorKey.currentState != null) {
        Logger.log('🟢 Logout: Using global navigator to navigate to login...');
        navigatorKey.currentState!.pushNamedAndRemoveUntil(
          '/login',
          (route) => false,
        );
      } else {
        Logger.log('🔴 Logout: Navigator state is null!');
      }
    }
  }

  Future<void> getUser(String token) async {
    if (token.isEmpty) {
      throw Exception("Token is required");
    }
    state = state.copyWith(status: AuthStatus.loading);
    try {
      var user = await _repository.getUser(token);

      // If teacher, fetch latest active status
      if (user.role_id == 3) {
        try {
          final isActive = await _repository.getActiveStatus();
          if (isActive != null) {
            user = user.copyWith(
              is_active: isActive,
              profile: user.profile?.copyWith(is_active: isActive),
            );
          }
        } catch (e) {
          Logger.log("Could not fetch active status: $e");
        }
      }

      state = AuthState(
        user: user,
        status: AuthStatus.authenticated,
        message: 'User fetched successfully',
      );
    } catch (e) {
      Logger.log("Get user error: $e");
      state = AuthState(
        status: AuthStatus.error,
        message: ErrorHandler.getErrorMessage(e),
      );
    }
  }

  Future<void> updateTeacherInfo({
    String? bio,
    bool? teachIndividual,
    double? individualHourPrice,
    bool? teachGroup,
    double? groupHourPrice,
    int? maxGroupSize,
    int? minGroupSize,
    List<int>? subjectIds,
    List<int>? classIds,
  }) async {
    state = state.copyWith(status: AuthStatus.loading);
    try {
      await _repository.updateTeacherInfo(
        bio: bio,
        teachIndividual: teachIndividual,
        individualHourPrice: individualHourPrice,
        teachGroup: teachGroup,
        groupHourPrice: groupHourPrice,
        maxGroupSize: maxGroupSize,
        minGroupSize: minGroupSize,
        subjects: subjectIds,
        classes: classIds,
      );
      state = state.copyWith(
        status: AuthStatus.authenticated,
        message: 'Teacher info updated successfully',
      );
    } catch (e) {
      state = AuthState(
        status: AuthStatus.error,
        message: ErrorHandler.getErrorMessage(e),
      );
    }
  }

  Future<void> changePassword({
    required String currentPassword,
    required String newPassword,
    required String newPasswordConfirmation,
  }) async {
    state = state.copyWith(status: AuthStatus.loading);

    try {
      Logger.log("changing password in auth notifier");
      await _repository.changePassword(
        currentPassword: currentPassword,
        newPassword: newPassword,
        newPasswordConfirmation: newPasswordConfirmation,
      );
      Logger.log("password changed in auth notifier");
      state = state.copyWith(
        status: AuthStatus.unauthenticated,
        message: 'Password changed successful',
      );
    } catch (e) {
      Logger.log("Change password error: $e");
      state = AuthState(
        status: AuthStatus.error,
        message: ErrorHandler.getErrorMessage(e),
      );
    }
  }

  Future<void> toggleActiveStatus() async {
    if (state.user == null) return;

    final currentStatus = state.user!.is_active;
    final newStatus = !currentStatus;

    // Optimistically update local state
    state = state.copyWith(
      user: state.user!.copyWith(
        is_active: newStatus,
        profile: state.user!.profile?.copyWith(is_active: newStatus),
      ),
    );

    try {
      final success = await _repository.updateActiveStatus(newStatus);
      if (!success) {
        // Rollback if failed
        state = state.copyWith(
          user: state.user!.copyWith(
            is_active: currentStatus,
            profile: state.user!.profile?.copyWith(is_active: currentStatus),
          ),
          status: AuthStatus.error,
          message: 'under_review', // Special signal for the UI
        );
      }
    } catch (e) {
      Logger.log("Error toggling active status: $e");

      String errorMessage = ErrorHandler.getErrorMessage(e);

      // Robust check for 422 "Profile not verified"
      bool isVerificationError = false;

      try {
        if (e is DioException && e.response?.statusCode == 422) {
          final data = e.response?.data;
          if (data is Map) {
            final errorVal = data['error']?.toString().toLowerCase();
            final messageVal = data['message']?.toString().toLowerCase();

            if (errorVal?.contains("verified") == true ||
                messageVal?.contains("verified first") == true) {
              isVerificationError = true;
            }
          }
        } else if (e.toString().toLowerCase().contains("verified first")) {
          // Fallback check on string representation
          isVerificationError = true;
        }
      } catch (logError) {
        Logger.log("Error during status parse: $logError");
      }

      if (isVerificationError) {
        errorMessage = 'under_review';
      }

      // Rollback on error
      state = state.copyWith(
        user: state.user!.copyWith(
          is_active: currentStatus,
          profile: state.user!.profile?.copyWith(is_active: currentStatus),
        ),
        status: AuthStatus.error,
        message: errorMessage,
      );
    }
  }

  Future<void> fetchTeacherServices() async {
    state = state.copyWith(status: AuthStatus.loading);
    try {
      final data = await _repository.getTeacherServices();
      final rawData = data['data'];
      state = state.copyWith(
        status: AuthStatus.authenticated,
        teacherServicesData: (rawData is List)
            ? rawData.map((e) => TeacherService.fromJson(e)).toList()
            : [],
      );
    } catch (e) {
      state = state.copyWith(
        status: AuthStatus.error,
        message: ErrorHandler.getErrorMessage(e),
      );
    }
  }

  Future<void> fetchServices() async {
    // Using default hardcoded values as requested
    final defaultServices = [
      TeacherService(id: 2, nameEn: "Language Learning", nameAr: "تعلم اللغات"),
      TeacherService(
        id: 3,
        nameEn: "Private Lessons",
        nameAr: "الدروس الخصوصية",
      ),
      TeacherService(
        id: 4,
        nameEn: "Specialized Courses",
        nameAr: "الدورات المخصصة",
      ),
    ];

    // Don't change status to avoid navigation triggers
    state = state.copyWith(teacherServicesData: defaultServices);
  }

  Future<bool> saveTeacherService(int serviceId) async {
    state = state.copyWith(status: AuthStatus.loading);
    try {
      await _repository.addTeacherService(serviceId);
      state = state.copyWith(
        status: AuthStatus.authenticated,
        message: 'Service saved successfully',
      );
      return true;
    } catch (e) {
      state = state.copyWith(
        status: AuthStatus.error,
        message: ErrorHandler.getErrorMessage(e),
      );
      return false;
    }
  }

  Future<bool> uploadTeacherCertificate(File certificate) async {
    state = state.copyWith(status: AuthStatus.loading);
    try {
      await _repository.uploadCertificate(certificate);
      state = state.copyWith(
        status: AuthStatus.authenticated,
        message: 'Certificate uploaded successfully',
      );
      return true;
    } catch (e) {
      state = state.copyWith(
        status: AuthStatus.error,
        message: ErrorHandler.getErrorMessage(e),
      );
      return false;
    }
  }
}
