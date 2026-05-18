import '../../../../core/network/api_result.dart';
import '../../data/models/exam_model.dart';

abstract class ExamsRepository {
  Future<ApiResult<List<ExamModel>>> getExamSchedule();
}
