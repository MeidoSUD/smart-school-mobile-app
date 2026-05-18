import 'package:injectable/injectable.dart';
import '../../../../core/network/api_result.dart';
import '../../data/models/attendance_model.dart';
import '../repositories/attendance_repository.dart';

@lazySingleton
class GetAttendanceUseCase {
  final AttendanceRepository _repository;

  GetAttendanceUseCase(this._repository);

  Future<ApiResult<List<AttendanceModel>>> execute({String? start, String? end}) {
    return _repository.getAttendance(start: start, end: end);
  }
}
