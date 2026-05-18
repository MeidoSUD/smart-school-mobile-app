import '../../../../core/network/api_result.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../domain/usecases/get_teachers_usecase.dart';
import 'teachers_state.dart';

@injectable
class TeachersCubit extends Cubit<TeachersState> {
  final GetTeachersUseCase _getTeachersUseCase;
  TeachersCubit(this._getTeachersUseCase) : super(const TeachersState.initial());

  Future<void> loadTeachers() async {
    emit(const TeachersState.loading());
    final result = await _getTeachersUseCase.execute();
    result.when(
      success: (teachers) => emit(TeachersState.loaded(teachers)),
      failure: (failure) => emit(TeachersState.error(failure.message)),
    );
  }
}
