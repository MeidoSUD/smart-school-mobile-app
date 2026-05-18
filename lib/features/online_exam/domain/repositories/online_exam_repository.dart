import '../../../../core/network/api_result.dart';
import '../../data/models/online_exam_model.dart';

abstract class OnlineExamRepository {
  Future<ApiResult<List<OnlineExamModel>>> getOnlineExams();
}
