import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/network/api_result.dart';
import '../../domain/usecases/get_visitors_usecase.dart';
import 'visitors_state.dart';

@injectable
class VisitorsCubit extends Cubit<VisitorsState> {
  final GetVisitorsUseCase _getVisitorsUseCase;

  VisitorsCubit(this._getVisitorsUseCase) : super(const VisitorsState.initial());

  Future<void> loadVisitors() async {
    emit(const VisitorsState.loading());
    
    final result = await _getVisitorsUseCase.execute();
    
    result.when(
      success: (visitors) {
        emit(VisitorsState.loaded(visitors));
      },
      failure: (failure) {
        emit(VisitorsState.error(failure.message));
      },
    );
  }
}
