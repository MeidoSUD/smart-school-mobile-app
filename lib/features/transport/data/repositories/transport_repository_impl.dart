import 'package:injectable/injectable.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/network/api_result.dart';
import '../models/transport_model.dart';
import '../../domain/repositories/transport_repository.dart';

@Injectable(as: TransportRepository)
class TransportRepositoryImpl implements TransportRepository {
  @override
  Future<ApiResult<TransportModel>> getTransport() async {
    if (AppConstants.useDummyData) {
      return ApiResult.success(
        const TransportModel(route: 'Route A', driverName: 'Ali Hassan', driverPhone: '+966501111111', busNumber: 'BUS-001', pickupTime: '07:00 AM', pickupPoint: 'Main Gate'),
      );
    }
    // TODO: Implement API call
    return const ApiResult.success(TransportModel());
  }
}
