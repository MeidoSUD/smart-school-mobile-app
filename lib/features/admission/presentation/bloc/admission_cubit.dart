import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/network/api_result.dart';
import '../../domain/usecases/get_application_status_usecase.dart';
import 'admission_state.dart';

@injectable
class AdmissionCubit extends Cubit<AdmissionState> {
  final GetApplicationStatusUseCase _getApplicationStatusUseCase;

  AdmissionCubit(this._getApplicationStatusUseCase)
    : super(const AdmissionState.initial());

  Future<void> loadStatus() async {
    emit(const AdmissionState.loading());
    final result = await _getApplicationStatusUseCase.execute();
    result.when(
      success: (status) => emit(AdmissionState.loaded(status)),
      failure: (failure) => emit(AdmissionState.error(failure.message)),
    );
  }
}
