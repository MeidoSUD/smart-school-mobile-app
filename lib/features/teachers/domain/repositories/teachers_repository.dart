import '../../../../core/network/api_result.dart';
import '../../data/models/teacher_model.dart';

abstract class TeachersRepository {
  Future<ApiResult<List<TeacherModel>>> getTeachers();
}
