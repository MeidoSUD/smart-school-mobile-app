import 'package:injectable/injectable.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/network/api_result.dart';
import '../models/leave_model.dart';
import '../../domain/repositories/leave_repository.dart';

@Injectable(as: LeaveRepository)
class LeaveRepositoryImpl implements LeaveRepository {
  @override
  Future<ApiResult<List<LeaveModel>>> getLeaves() async {
    if (AppConstants.useDummyData) {
      return ApiResult.success([
        const LeaveModel(id: 1, fromDate: '2024-01-10', toDate: '2024-01-12', reason: 'Family Event', status: 'approved', appliedDate: '2024-01-05'),
        const LeaveModel(id: 2, fromDate: '2024-01-20', toDate: '2024-01-21', reason: 'Medical Appointment', status: 'pending', appliedDate: '2024-01-15'),
      ]);
    }
    // TODO: Implement API call
    return const ApiResult.success([]);
  }
}
