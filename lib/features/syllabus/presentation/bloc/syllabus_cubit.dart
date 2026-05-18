import '../../../../core/network/api_result.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../domain/usecases/get_syllabus_usecase.dart';
import 'syllabus_state.dart';

@injectable
class SyllabusCubit extends Cubit<SyllabusState> {
  final GetSyllabusUseCase _getSyllabusUseCase;
  SyllabusCubit(this._getSyllabusUseCase) : super(const SyllabusState.initial());

  Future<void> loadSyllabus() async {
    emit(const SyllabusState.loading());
    final result = await _getSyllabusUseCase.execute();
    result.when(
      success: (syllabus) => emit(SyllabusState.loaded(syllabus)),
      failure: (failure) => emit(SyllabusState.error(failure.message)),
    );
  }
}
