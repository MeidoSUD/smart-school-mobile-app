import '../../../../core/network/api_result.dart';
import '../../data/models/visitor_model.dart';

abstract class VisitorsRepository {
  Future<ApiResult<List<VisitorModel>>> getVisitors();
}
