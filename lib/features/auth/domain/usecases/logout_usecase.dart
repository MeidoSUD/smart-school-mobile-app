import 'package:injectable/injectable.dart';
import '../../../../core/network/api_result.dart';
import '../repositories/auth_repository.dart';

@lazySingleton
class LogoutUseCase {
  final AuthRepository _repository;

  LogoutUseCase(this._repository);

  Future<ApiResult<void>> execute() {
    return _repository.logout();
  }
}
