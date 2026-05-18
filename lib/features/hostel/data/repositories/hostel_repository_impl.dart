import 'package:injectable/injectable.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/network/api_result.dart';
import '../models/hostel_model.dart';
import '../../domain/repositories/hostel_repository.dart';

@Injectable(as: HostelRepository)
class HostelRepositoryImpl implements HostelRepository {
  @override
  Future<ApiResult<List<HostelModel>>> getHostelInfo() async {
    if (AppConstants.useDummyData) {
      return ApiResult.success([
        const HostelModel(name: 'Boys Hostel A', roomNumber: '101', block: 'A', bedNumber: 'B1'),
        const HostelModel(name: 'Girls Hostel B', roomNumber: '201', block: 'B', bedNumber: 'B2'),
      ]);
    }
    // TODO: Implement API call
    return const ApiResult.success([]);
  }
}
