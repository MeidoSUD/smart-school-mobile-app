import 'package:injectable/injectable.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/network/api_result.dart';
import '../models/lms_user_model.dart';
import '../models/login_response_model.dart';
import '../../domain/repositories/auth_repository.dart';

@Injectable(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  @override
  Future<ApiResult<LoginResponseModel>> login({
    required String username,
    required String password,
  }) async {
    const dummyUser = LmsUserModel(
      id: 1,
      role: 'student',
      firstname: 'John',
      lastname: 'Doe',
      email: 'john.doe@example.com',
    );

    if (AppConstants.useDummyData) {
      return const ApiResult.success(
        LoginResponseModel(
          token: 'dummy_token_12345',
          status: 'success',
          message: 'Login successful',
          user: dummyUser,
        ),
      );
    }
    // TODO: Implement API call
    return const ApiResult.success(LoginResponseModel(user: dummyUser));
  }


  @override
  Future<ApiResult<void>> logout() async {
    if (AppConstants.useDummyData) {
      return const ApiResult.success(null);
    }
    // TODO: Implement API call
    return const ApiResult.success(null);
  }

  @override
  Future<ApiResult<void>> changePassword({
    required String currentPassword,
    required String newPassword,
    required String confirmPassword,
  }) async {
    if (AppConstants.useDummyData) {
      return const ApiResult.success(null);
    }
    // TODO: Implement API call
    return const ApiResult.success(null);
  }
}
