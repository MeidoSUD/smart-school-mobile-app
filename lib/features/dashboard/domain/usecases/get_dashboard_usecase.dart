import 'package:injectable/injectable.dart';
import '../../../../core/network/api_result.dart';
import '../../data/models/dashboard_model.dart';
import '../repositories/dashboard_repository.dart';

@lazySingleton
class GetDashboardUseCase {
  final DashboardRepository _repository;

  GetDashboardUseCase(this._repository);

  Future<ApiResult<DashboardModel>> execute() {
    return _repository.getDashboard();
  }
}
