import 'package:injectable/injectable.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/network/api_result.dart';
import '../models/calendar_event_model.dart';
import '../../domain/repositories/calendar_repository.dart';

@Injectable(as: CalendarRepository)
class CalendarRepositoryImpl implements CalendarRepository {
  @override
  Future<ApiResult<List<CalendarEventModel>>> getCalendarEvents() async {
    if (AppConstants.useDummyData) {
      return ApiResult.success([
        const CalendarEventModel(id: 1, title: 'School Holiday', description: 'National Day', date: '2024-02-01', time: 'All Day'),
        const CalendarEventModel(id: 2, title: 'Parent Meeting', description: 'Monthly parent-teacher meeting', date: '2024-02-05', time: '10:00 AM'),
        const CalendarEventModel(id: 3, title: 'Sports Day', description: 'Annual sports competition', date: '2024-02-10', time: '08:00 AM'),
      ]);
    }
    // TODO: Implement API call
    return const ApiResult.success([]);
  }
}
