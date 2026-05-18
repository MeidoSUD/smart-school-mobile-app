import 'package:injectable/injectable.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/network/api_result.dart';
import '../../domain/repositories/admission_repository.dart';

@Injectable(as: AdmissionRepository)
class AdmissionRepositoryImpl implements AdmissionRepository {
  @override
  Future<ApiResult<void>> submitApplication(Map<String, dynamic> data) async {
    if (AppConstants.useDummyData) {
      return const ApiResult.success(null);
    }
    // TODO: Implement API call
    return const ApiResult.success(null);
  }

  @override
  Future<ApiResult<Map<String, dynamic>>> getApplicationStatus() async {
    if (AppConstants.useDummyData) {
      return ApiResult.success({
        'status': 'pending',
        'message': 'Your application is under review',
        'submittedDate': '2024-01-10',
      });
    }
    // TODO: Implement API call
    return const ApiResult.success({});
  }
}
