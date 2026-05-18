import '../../../../core/network/api_result.dart';
import '../../data/models/homework_model.dart';

abstract class HomeworkRepository {
  Future<ApiResult<List<HomeworkModel>>> getHomework();
  Future<ApiResult<HomeworkModel>> getHomeworkDetail(int id, int status);
  Future<ApiResult<void>> uploadHomework({required int homeworkId, String? message, String? filePath});
}
