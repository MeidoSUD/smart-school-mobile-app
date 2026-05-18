import '../../../../core/network/api_result.dart';
import '../../data/models/attendance_model.dart';

abstract class AttendanceRepository {
  Future<ApiResult<List<AttendanceModel>>> getAttendance({String? start, String? end});
}
