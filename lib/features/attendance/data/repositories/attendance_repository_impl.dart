import 'package:injectable/injectable.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/network/api_result.dart';
import '../models/attendance_model.dart';
import '../../domain/repositories/attendance_repository.dart';

@Injectable(as: AttendanceRepository)
class AttendanceRepositoryImpl implements AttendanceRepository {
  @override
  Future<ApiResult<List<AttendanceModel>>> getAttendance({String? start, String? end}) async {
    if (AppConstants.useDummyData) {
      return ApiResult.success([
        const AttendanceModel(id: 1, date: '2024-01-15', status: 'present', remark: 'On time'),
        const AttendanceModel(id: 2, date: '2024-01-14', status: 'present', remark: ''),
        const AttendanceModel(id: 3, date: '2024-01-13', status: 'absent', remark: 'Sick leave'),
        const AttendanceModel(id: 4, date: '2024-01-12', status: 'present', remark: ''),
        const AttendanceModel(id: 5, date: '2024-01-11', status: 'late', remark: '30 min late'),
      ]);
    }
    // TODO: Implement API call
    return const ApiResult.success([]);
  }
}
