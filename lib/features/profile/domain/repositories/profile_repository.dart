import '../../../../core/network/api_result.dart';

abstract class ProfileRepository {
  Future<ApiResult<Map<String, dynamic>>> getProfile();
}
