import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/network/api_result.dart';
import '../../domain/usecases/get_online_exams_usecase.dart';
import 'online_exam_state.dart';

@injectable
class OnlineExamCubit extends Cubit<OnlineExamState> {
  final GetOnlineExamsUseCase _getOnlineExamsUseCase;

  OnlineExamCubit(this._getOnlineExamsUseCase)
    : super(const OnlineExamState.initial());

  Future<void> loadExam() async {
    emit(const OnlineExamState.loading());
    final result = await _getOnlineExamsUseCase.execute();
    result.when(
      success: (exams) => emit(OnlineExamState.loaded(exams)),
      failure: (failure) => emit(OnlineExamState.error(failure.message)),
    );
  }
}
