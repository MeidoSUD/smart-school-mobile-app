import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/network/api_result.dart';
import '../../domain/usecases/get_hostel_info_usecase.dart';
import 'hostel_state.dart';

@injectable
class HostelCubit extends Cubit<HostelState> {
  final GetHostelInfoUseCase _getHostelInfoUseCase;

  HostelCubit(this._getHostelInfoUseCase)
    : super(const HostelState.initial());

  Future<void> loadHostelInfo() async {
    emit(const HostelState.loading());
    final result = await _getHostelInfoUseCase.execute();
    result.when(
      success: (hostels) => emit(HostelState.loaded(hostels)),
      failure: (failure) => emit(HostelState.error(failure.message)),
    );
  }
}
