import '../../../../core/network/api_result.dart';
import '../../data/models/fee_model.dart';

abstract class FeesRepository {
  Future<ApiResult<List<FeeModel>>> getFees();
}
