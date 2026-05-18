import '../../../../core/network/api_result.dart';
import '../../data/models/login_response_model.dart';

abstract class AuthRepository {
  Future<ApiResult<LoginResponseModel>> login({
    required String username,
    required String password,
  });

  Future<ApiResult<void>> logout();

  Future<ApiResult<void>> changePassword({
    required String currentPassword,
    required String newPassword,
    required String confirmPassword,
  });
}
