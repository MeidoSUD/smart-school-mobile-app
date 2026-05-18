import '../../../../core/network/api_result.dart';
import '../../data/models/subject_model.dart';

abstract class SubjectsRepository {
  Future<ApiResult<List<SubjectModel>>> getSubjects();
}
