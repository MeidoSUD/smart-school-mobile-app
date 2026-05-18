import 'package:injectable/injectable.dart';
import '../../../../core/network/api_result.dart';
import '../repositories/admission_repository.dart';

@lazySingleton
class GetApplicationStatusUseCase {
  final AdmissionRepository _repository;

  GetApplicationStatusUseCase(this._repository);

  Future<ApiResult<Map<String, dynamic>>> execute() {
    return _repository.getApplicationStatus();
  }
}
