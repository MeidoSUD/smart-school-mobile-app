import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../core/constants/api_endpoints.dart';
import '../../core/utils/logger.dart';
import '../models/auth/student_registration_request.dart';
import '../models/auth/teacher_registration_request.dart';
import '../models/teacher_model.dart';
import '../models/user_model.dart';
import '../services/api_service.dart';

class AuthRepository {
  final ApiService _api = ApiService();
  final storage = const FlutterSecureStorage();

  Future<UserModel> login({
    String? email,
    String? phoneNumber,
    required String password,
    String? fcmToken,
  }) async {
    try {
      final data = {
        if (email != null) "email": email,
        if (phoneNumber != null) "phone_number": phoneNumber,
        "password": password,
        if (fcmToken != null) "fcm_token": fcmToken,
      };

      final response = await _api.post(
        ApiEndpoints.login,
        data,
        Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
        ),
      );

      final responseData = response.data;
      Logger.log("Login response data: $responseData");
      if (responseData == null) throw Exception("No data returned from server");

      final userModel = UserModel.fromJson(
        responseData as Map<String, dynamic>,
      );
      if (userModel.token != null && userModel.token!.isNotEmpty) {
        await storage.write(key: 'token', value: userModel.token);
      }
      return userModel;
    } catch (e) {
      rethrow;
    }
  }

  Future<UserModel> verifyCode(String code, int userId) async {
    try {
      final response = await _api.post(
        ApiEndpoints.verify,
        {"user_id": userId, "code": code},
        Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
        ),
      );

      final responseData = response.data;
      Logger.log("Verify code response data: $responseData");
      if (responseData == null) throw Exception("No data returned from server");

      final userModel = UserModel.fromJson(
        responseData as Map<String, dynamic>,
      );
      if (userModel.token != null && userModel.token!.isNotEmpty) {
        await storage.write(key: 'token', value: userModel.token);
      }

      return userModel;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> resendCode(int userId) async {
    try {
      await _api.post(
        ApiEndpoints.resendCode,
        {"user_id": userId},
        Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
        ),
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<UserModel> sendCode(String? phone, {String? email}) async {
    try {
      final response = await _api.post(
        ApiEndpoints.sendCode,
        {
          if (phone != null) "phone_number": phone,
          if (email != null) "email": email,
        },
        Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
        ),
      );

      final fullData = response.data as Map<String, dynamic>;
      Logger.log("Send code response data: $fullData");

      return UserModel.fromJson(fullData);
    } catch (e) {
      rethrow;
    }
  }

  // Old register method - commented out for reference
  // Future<UserModel> register({
  //   required String firstName,
  //   required String lastName,
  //   required String email,
  //   required String phoneNumber,
  //   required String password,
  //   String? gender,
  //   String? nationality,
  //   required int roleId,
  // }) async {
  //   try {
  //     final response = await _api.post(
  //       ApiEndpoints.register,
  //       {
  //         "email": email,
  //         "first_name": firstName,
  //         "last_name": lastName,
  //         "phone_number": phoneNumber,
  //         "password": password,
  //         "password_confirmation": password,
  //         if (gender != null) "gender": gender,
  //         if (nationality != null) "nationality": nationality,
  //         "role_id": roleId,
  //       },
  //       Options(
  //         headers: {
  //           'Content-Type': 'application/json',
  //           'Accept': 'application/json',
  //         },
  //       ),
  //     );

  //     final responseData = response.data;
  //     Logger.log("Register response data: $responseData");
  //     if (responseData == null) throw Exception("No data returned from server");

  //     final userModel = UserModel.fromJson(
  //       responseData as Map<String, dynamic>,
  //     );
  //     if (userModel.token != null && userModel.token!.isNotEmpty) {
  //       await storage.write(key: 'token', value: userModel.token);
  //     }
  //     return userModel;
  //   } catch (e) {
  //     rethrow;
  //   }
  // }

  Future<UserModel> registerStudent(StudentRegistrationRequest request) async {
    try {
      final response = await _api.post(
        ApiEndpoints.registerStudent,
        request.toMap(),
        Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
        ),
      );

      final responseData = response.data;
      Logger.log("Register Student response data: $responseData");
      if (responseData == null) throw Exception("No data returned from server");

      final userModel = UserModel.fromJson(
        responseData as Map<String, dynamic>,
      );
      if (userModel.token != null && userModel.token!.isNotEmpty) {
        await storage.write(key: 'token', value: userModel.token);
      }
      return userModel;
    } catch (e) {
      rethrow;
    }
  }

  Future<UserModel> registerTeacher(TeacherRegistrationRequest request) async {
    try {
      final mapData = request.toMap();

      if (request.certificate != null) {
        mapData['certificate'] = await MultipartFile.fromFile(
          request.certificate!.path,
          filename: request.certificate!.path.split('/').last,
        );
      }

      if (request.cv != null) {
        mapData['cv'] = await MultipartFile.fromFile(
          request.cv!.path,
          filename: request.cv!.path.split('/').last,
        );
      }

      final formData = FormData.fromMap(mapData);

      final response = await _api.post(
        ApiEndpoints.registerTeacher,
        formData,
        Options(
          headers: {
            'Content-Type': 'multipart/form-data',
            'Accept': 'application/json',
          },
        ),
      );

      final responseData = response.data;
      Logger.log("Register Teacher response data: $responseData");
      if (responseData == null) throw Exception("No data returned from server");

      final userModel = UserModel.fromJson(
        responseData as Map<String, dynamic>,
      );
      if (userModel.token != null && userModel.token!.isNotEmpty) {
        await storage.write(key: 'token', value: userModel.token);
      }
      return userModel;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> verifyResetCode(int userId, String code) async {
    try {
      await _api.post(
        ApiEndpoints.verifyResetCode,
        {"user_id": userId, "code": code},
        Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
        ),
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<void> confirmPassword({
    required int userId,
    required String code,
    required String newPassword,
    required String newPasswordConfirmation,
  }) async {
    try {
      await _api.post(
        ApiEndpoints.confirmPassword,
        {
          "user_id": userId,
          "code": code,
          "new_password": newPassword,
          "new_password_confirmation": newPasswordConfirmation,
        },
        Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
        ),
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<void> changePassword({
    required String currentPassword,
    required String newPassword,
    required String newPasswordConfirmation,
  }) async {
    final token = await storage.read(key: 'token');
    try {
      await _api.post(
        ApiEndpoints.changePassword,
        {
          "current_password": currentPassword,
          "new_password": newPassword,
          "new_password_confirmation": newPasswordConfirmation,
        },
        Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
          },
        ),
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<UserModel> getUser(String token) async {
    try {
      final response = await _api.get(
        ApiEndpoints.getUser,
        Options(
          headers: {
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
          },
        ),
      );

      final data = response.data['data'] as Map<String, dynamic>? ?? {};
      return UserModel.fromJson({...data, "token": token});
    } catch (e) {
      rethrow;
    }
  }

  Future<void> logout() async {
    final token = await storage.read(key: 'token');

    // Always delete token first, before making any API calls
    await storage.delete(key: 'token');

    if (token != null) {
      try {
        await _api.post(
          ApiEndpoints.logout,
          {},
          Options(
            headers: {
              'Accept': 'application/json',
              'Authorization': 'Bearer $token',
            },
          ),
        );
      } catch (e) {
        // Silently fail - token is already deleted, which is what matters
        Logger.log('Logout API call failed: $e');
      }
    }
  }

  Future<Map<String, dynamic>> getProfile() async {
    final token = await storage.read(key: 'token');
    try {
      final response = await _api.get(
        ApiEndpoints.getProfile,
        Options(
          headers: {
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
          },
        ),
      );
      return response.data['data'] as Map<String, dynamic>;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> createProfile(FormData formData) async {
    final token = await storage.read(key: 'token');
    try {
      await _api.post(
        ApiEndpoints.createProfile,
        formData,
        Options(
          headers: {
            'Content-Type': 'multipart/form-data',
            'Authorization': 'Bearer $token',
          },
        ),
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<UserModel> updateUser(FormData formData) async {
    final token = await storage.read(key: 'token');
    try {
      final response = await _api.post(
        ApiEndpoints.updateProfile,
        formData,
        Options(
          headers: {
            'content-type': 'multipart/form-data',
            'Authorization': 'Bearer $token',
          },
        ),
      );

      final userData = response.data['data'] as Map<String, dynamic>? ?? {};
      return UserModel.fromJson({...userData, "token": token});
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteAccount() async {
    final token = await storage.read(key: 'token');
    try {
      await _api.delete(
        ApiEndpoints.deleteAccount,
        Options(
          headers: {
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
          },
        ),
      );
    } catch (e) {
      rethrow;
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
    List<int>? subjects,
    List<int>? classes,
  }) async {
    final token = await storage.read(key: 'token');
    try {
      await _api.post(
        ApiEndpoints.teacherInfo,
        {
          if (bio != null) "bio": bio,
          if (teachIndividual != null) "teach_individual": teachIndividual,
          if (individualHourPrice != null)
            "individual_hour_price": individualHourPrice,
          if (teachGroup != null) "teach_group": teachGroup,
          if (groupHourPrice != null) "group_hour_price": groupHourPrice,
          if (maxGroupSize != null) "max_group_size": maxGroupSize,
          if (minGroupSize != null) "min_group_size": minGroupSize,
          if (subjects != null) "subjects": subjects,
          if (classes != null) "classes": classes,
        },
        Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
          },
        ),
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> updateActiveStatus(bool isActive) async {
    final token = await storage.read(key: 'token');
    try {
      final response = await _api.put(
        ApiEndpoints.teacherActiveStatus,
        {"is_active": isActive},
        Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
          },
        ),
      );
      return response.data['success'] == true;
    } catch (e) {
      rethrow;
    }
  }

  Future<bool?> getActiveStatus() async {
    final token = await storage.read(key: 'token');
    try {
      final response = await _api.get(
        ApiEndpoints.teacherActiveStatus,
        Options(
          headers: {
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
          },
        ),
      );

      final data = response.data;
      if (data == null) return null;

      if (data['is_active'] != null) {
        return data['is_active'] == 1 || data['is_active'] == true;
      }

      if (data['data'] != null && data['data']['is_active'] != null) {
        return data['data']['is_active'] == 1 ||
            data['data']['is_active'] == true;
      }

      if (data['profile'] != null && data['profile']['is_active'] != null) {
        return data['profile']['is_active'] == 1 ||
            data['profile']['is_active'] == true;
      }

      return null;
    } catch (e) {
      Logger.log("Error fetching active status: $e");
      return null;
    }
  }

  Future<Map<String, dynamic>> getTeacherServices() async {
    final token = await storage.read(key: 'token');
    try {
      final response = await _api.get(
        ApiEndpoints.teacherGetServices,
        Options(
          headers: {
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
          },
        ),
      );
      return response.data as Map<String, dynamic>;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<TeacherService>> getServices() async {
    try {
      final response = await _api.get(
        ApiEndpoints.getServices,
        Options(headers: {'Accept': 'application/json'}),
      );

      final data = response.data;
      if (data is List) {
        return data.map((e) => TeacherService.fromJson(e)).toList();
      } else if (data is Map &&
          data.containsKey('data') &&
          data['data'] is List) {
        return (data['data'] as List)
            .map((e) => TeacherService.fromJson(e))
            .toList();
      }
      return [];
    } catch (e) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> addTeacherService(int serviceId) async {
    final token = await storage.read(key: 'token');
    try {
      final response = await _api.post(
        ApiEndpoints.addTeacherService,
        {"service_id": serviceId},
        Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
          },
        ),
      );
      return response.data as Map<String, dynamic>;
    } catch (e) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> uploadCertificate(File certificate) async {
    final token = await storage.read(key: 'token');
    try {
      final formData = FormData.fromMap({
        'certificate': await MultipartFile.fromFile(
          certificate.path,
          filename: certificate.path.split('/').last,
        ),
      });

      final response = await _api.post(
        ApiEndpoints.uploadTeacherCertificate,
        formData,
        Options(
          headers: {
            'Content-Type': 'multipart/form-data',
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
          },
        ),
      );
      return response.data as Map<String, dynamic>;
    } catch (e) {
      rethrow;
    }
  }
}
