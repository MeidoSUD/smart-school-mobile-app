import '../../../../core/network/api_result.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../domain/usecases/get_subjects_usecase.dart';
import 'subjects_state.dart';

@injectable
class SubjectsCubit extends Cubit<SubjectsState> {
  final GetSubjectsUseCase _getSubjectsUseCase;
  SubjectsCubit(this._getSubjectsUseCase) : super(const SubjectsState.initial());

  Future<void> loadSubjects() async {
    emit(const SubjectsState.loading());
    final result = await _getSubjectsUseCase.execute();
    result.when(
      success: (subjects) => emit(SubjectsState.loaded(subjects)),
      failure: (failure) => emit(SubjectsState.error(failure.message)),
    );
  }
}
