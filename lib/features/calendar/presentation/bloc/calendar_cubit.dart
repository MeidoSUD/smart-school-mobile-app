import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/network/api_result.dart';
import '../../domain/usecases/get_calendar_events_usecase.dart';
import 'calendar_state.dart';

@injectable
class CalendarCubit extends Cubit<CalendarState> {
  final GetCalendarEventsUseCase _getCalendarEventsUseCase;

  CalendarCubit(this._getCalendarEventsUseCase) : super(const CalendarState.initial());

  Future<void> loadEvents() async {
    emit(const CalendarState.loading());
    
    final result = await _getCalendarEventsUseCase.execute();
    
    result.when(
      success: (events) {
        emit(CalendarState.loaded(events));
      },
      failure: (failure) {
        emit(CalendarState.error(failure.message));
      },
    );
  }
}
