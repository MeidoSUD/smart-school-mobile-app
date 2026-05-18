import '../../../../core/network/api_result.dart';
import '../../data/models/timetable_model.dart';

abstract class TimetableRepository {
  Future<ApiResult<List<TimetableModel>>> getTimetable();
}
