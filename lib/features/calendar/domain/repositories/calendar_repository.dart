import '../../../../core/network/api_result.dart';
import '../../data/models/calendar_event_model.dart';

abstract class CalendarRepository {
  Future<ApiResult<List<CalendarEventModel>>> getCalendarEvents();
}
