import 'package:injectable/injectable.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/network/api_result.dart';
import '../models/timetable_model.dart';
import '../../domain/repositories/timetable_repository.dart';

@Injectable(as: TimetableRepository)
class TimetableRepositoryImpl implements TimetableRepository {
  @override
  Future<ApiResult<List<TimetableModel>>> getTimetable() async {
    if (AppConstants.useDummyData) {
      return ApiResult.success([
        const TimetableModel(id: 1, day: 'Monday', subject: 'Mathematics', time: '08:00 - 09:00', room: 'Room 101'),
        const TimetableModel(id: 2, day: 'Monday', subject: 'Science', time: '09:00 - 10:00', room: 'Lab 2'),
        const TimetableModel(id: 3, day: 'Monday', subject: 'English', time: '10:00 - 11:00', room: 'Room 102'),
        const TimetableModel(id: 4, day: 'Tuesday', subject: 'History', time: '08:00 - 09:00', room: 'Room 103'),
        const TimetableModel(id: 5, day: 'Tuesday', subject: 'Mathematics', time: '09:00 - 10:00', room: 'Room 101'),
      ]);
    }
    // TODO: Implement API call
    return const ApiResult.success([]);
  }
}
