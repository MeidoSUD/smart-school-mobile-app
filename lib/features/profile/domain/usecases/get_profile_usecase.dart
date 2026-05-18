import 'package:injectable/injectable.dart';
import '../../../../core/network/api_result.dart';
import '../repositories/profile_repository.dart';

@lazySingleton
class GetProfileUseCase {
  final ProfileRepository _repository;

  GetProfileUseCase(this._repository);

  Future<ApiResult<Map<String, dynamic>>> execute() {
    return _repository.getProfile();
  }
}
