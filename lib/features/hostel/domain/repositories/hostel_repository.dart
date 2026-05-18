import '../../../../core/network/api_result.dart';
import '../../data/models/hostel_model.dart';

abstract class HostelRepository {
  Future<ApiResult<List<HostelModel>>> getHostelInfo();
}
