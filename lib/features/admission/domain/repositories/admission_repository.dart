import '../../../../core/network/api_result.dart';

abstract class AdmissionRepository {
  Future<ApiResult<void>> submitApplication(Map<String, dynamic> data);
  Future<ApiResult<Map<String, dynamic>>> getApplicationStatus();
}
