import '../../../../core/network/api_result.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../domain/usecases/get_transport_usecase.dart';
import 'transport_state.dart';

@injectable
class TransportCubit extends Cubit<TransportState> {
  final GetTransportUseCase _getTransportUseCase;
  TransportCubit(this._getTransportUseCase) : super(const TransportState.initial());

  Future<void> loadTransport() async {
    emit(const TransportState.loading());
    final result = await _getTransportUseCase.execute();
    result.when(
      success: (transport) => emit(TransportState.loaded(transport)),
      failure: (failure) => emit(TransportState.error(failure.message)),
    );
  }
}
