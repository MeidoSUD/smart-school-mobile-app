import '../../../../core/network/api_result.dart';
import '../../data/models/leave_model.dart';

abstract class LeaveRepository {
  Future<ApiResult<List<LeaveModel>>> getLeaves();
}
