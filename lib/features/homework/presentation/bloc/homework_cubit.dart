import '../../../../core/network/api_result.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../domain/usecases/get_homework_usecase.dart';
import 'homework_state.dart';

@injectable
class HomeworkCubit extends Cubit<HomeworkState> {
  final GetHomeworkUseCase _getHomeworkUseCase;
  HomeworkCubit(this._getHomeworkUseCase) : super(const HomeworkState.initial());

  Future<void> loadHomework() async {
    emit(const HomeworkState.loading());
    final result = await _getHomeworkUseCase.execute();
    result.when(
      success: (homework) => emit(HomeworkState.loaded(homework)),
      failure: (failure) => emit(HomeworkState.error(failure.message)),
    );
  }
}
