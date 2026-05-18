import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/network/api_result.dart';
import '../../domain/usecases/get_leaves_usecase.dart';
import 'leave_state.dart';

@injectable
class LeaveCubit extends Cubit<LeaveState> {
  final GetLeavesUseCase _getLeavesUseCase;

  LeaveCubit(this._getLeavesUseCase) : super(const LeaveState.initial());

  Future<void> loadLeaves() async {
    emit(const LeaveState.loading());
    
    final result = await _getLeavesUseCase.execute();
    
    result.when(
      success: (leaves) {
        emit(LeaveState.loaded(leaves));
      },
      failure: (failure) {
        emit(LeaveState.error(failure.message));
      },
    );
  }
}
