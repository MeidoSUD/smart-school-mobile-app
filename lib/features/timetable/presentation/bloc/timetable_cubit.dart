import '../../../../core/network/api_result.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../domain/usecases/get_timetable_usecase.dart';
import 'timetable_state.dart';

@injectable
class TimetableCubit extends Cubit<TimetableState> {
  final GetTimetableUseCase _getTimetableUseCase;
  TimetableCubit(this._getTimetableUseCase) : super(const TimetableState.initial());

  Future<void> loadTimetable() async {
    emit(const TimetableState.loading());
    final result = await _getTimetableUseCase.execute();
    result.when(
      success: (timetable) => emit(TimetableState.loaded(timetable)),
      failure: (failure) => emit(TimetableState.error(failure.message)),
    );
  }
}
