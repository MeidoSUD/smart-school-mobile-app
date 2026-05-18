import 'package:injectable/injectable.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/network/api_result.dart';
import '../../domain/repositories/profile_repository.dart';

@Injectable(as: ProfileRepository)
class ProfileRepositoryImpl implements ProfileRepository {
  @override
  Future<ApiResult<Map<String, dynamic>>> getProfile() async {
    if (AppConstants.useDummyData) {
      return ApiResult.success({
        'id': 1,
        'name': 'Ahmed Mohammed',
        'email': 'ahmed@school.com',
        'phone': '+966501234567',
        'role': 'student',
        'class': 'Grade 10',
        'section': 'A',
      });
    }
    // TODO: Implement API call
    return const ApiResult.success({});
  }
}
