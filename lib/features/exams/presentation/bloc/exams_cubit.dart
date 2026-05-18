import '../../../../core/network/api_result.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../domain/usecases/get_exam_schedule_usecase.dart';
import 'exams_state.dart';

@injectable
class ExamsCubit extends Cubit<ExamsState> {
  final GetExamScheduleUseCase _getExamScheduleUseCase;
  ExamsCubit(this._getExamScheduleUseCase) : super(const ExamsState.initial());

  Future<void> loadExams() async {
    emit(const ExamsState.loading());
    final result = await _getExamScheduleUseCase.execute();
    result.when(
      success: (exams) => emit(ExamsState.loaded(exams)),
      failure: (failure) => emit(ExamsState.error(failure.message)),
    );
  }
}
