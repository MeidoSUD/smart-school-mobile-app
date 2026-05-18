import 'package:injectable/injectable.dart';
import '../../../../core/network/api_result.dart';
import '../../data/models/login_response_model.dart';
import '../repositories/auth_repository.dart';

@lazySingleton
class LoginUseCase {
  final AuthRepository _repository;

  LoginUseCase(this._repository);

  Future<ApiResult<LoginResponseModel>> execute({
    required String username,
    required String password,
  }) {
    return _repository.login(username: username, password: password);
  }
}
