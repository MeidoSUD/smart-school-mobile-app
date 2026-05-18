import '../../../../core/network/api_result.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../domain/usecases/get_fees_usecase.dart';
import 'fees_state.dart';

@injectable
class FeesCubit extends Cubit<FeesState> {
  final GetFeesUseCase _getFeesUseCase;

  FeesCubit(this._getFeesUseCase) : super(const FeesState.initial());

  Future<void> loadFees() async {
    emit(const FeesState.loading());
    
    final result = await _getFeesUseCase.execute();
    
    result.when(
      success: (fees) {
        emit(FeesState.loaded(fees));
      },
      failure: (failure) {
        emit(FeesState.error(failure.message));
      },
    );
  }
}
