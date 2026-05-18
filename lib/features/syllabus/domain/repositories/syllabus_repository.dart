import '../../../../core/network/api_result.dart';
import '../../data/models/syllabus_model.dart';

abstract class SyllabusRepository {
  Future<ApiResult<List<SyllabusModel>>> getSyllabus();
}
