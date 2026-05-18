import 'package:injectable/injectable.dart';
import '../../../../core/network/api_result.dart';
import '../../data/models/transport_model.dart';
import '../repositories/transport_repository.dart';

@lazySingleton
class GetTransportUseCase {
  final TransportRepository _repository;
  GetTransportUseCase(this._repository);
  Future<ApiResult<TransportModel>> execute() => _repository.getTransport();
}
