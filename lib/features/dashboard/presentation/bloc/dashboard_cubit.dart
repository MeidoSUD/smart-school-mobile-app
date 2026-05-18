import '../../../../core/network/api_result.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../domain/usecases/get_dashboard_usecase.dart';
import 'dashboard_state.dart';

@injectable
class DashboardCubit extends Cubit<DashboardState> {
  final GetDashboardUseCase _getDashboardUseCase;

  DashboardCubit(this._getDashboardUseCase)
    : super(const DashboardState.initial());

  Future<void> loadDashboard() async {
    emit(const DashboardState.loading());

    final result = await _getDashboardUseCase.execute();

    result.when(
      success: (dashboard) {
        emit(DashboardState.loaded(dashboard));
      },
      failure: (failure) {
        emit(DashboardState.error(failure.message));
      },
    );
  }
}
