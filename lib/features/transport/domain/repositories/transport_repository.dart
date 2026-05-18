import '../../../../core/network/api_result.dart';
import '../../data/models/transport_model.dart';

abstract class TransportRepository {
  Future<ApiResult<TransportModel>> getTransport();
}
