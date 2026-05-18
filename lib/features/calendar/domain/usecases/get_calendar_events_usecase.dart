import 'package:injectable/injectable.dart';
import '../../../../core/network/api_result.dart';
import '../../data/models/calendar_event_model.dart';
import '../repositories/calendar_repository.dart';

@lazySingleton
class GetCalendarEventsUseCase {
  final CalendarRepository _repository;

  GetCalendarEventsUseCase(this._repository);

  Future<ApiResult<List<CalendarEventModel>>> execute() {
    return _repository.getCalendarEvents();
  }
}
