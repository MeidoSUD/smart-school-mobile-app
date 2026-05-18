import '../../../../core/network/api_result.dart';
import '../../data/models/dashboard_model.dart';

abstract class DashboardRepository {
  Future<ApiResult<DashboardModel>> getDashboard();
}
